Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0179C4BA3D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 10:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B539824680
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 10:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLW7pZ5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgB0KGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 05:06:04 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:45369 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbgB0KGC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 05:06:02 -0500
Received: by mail-wr1-f50.google.com with SMTP id v2so2485765wrp.12
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 02:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZfjNdBvQXpFTbK3oPjbWjrV1f+R15VFJow8PnMMBkDM=;
        b=oLW7pZ5J2bGdTbjWgpxOxBfnPhxuY0oFmWGfiElSyoVTcbz1+jAOq3XxPIc171oIo4
         gCI1UyVeF6B5SBKX03PQ+pgAAv5SEcWgNe8FI7KHtJSlPCGy/k5Q07GwSClYXnJXPpwP
         QLapoLX304EgQX8DLXiCLMvmwhGdHId/lGvfq7+ozu3TIPHGs3cmFNnbLPe5NXfvLrDk
         8rzdRyHt1OEUDfRazsqutWT6OJTjTopUSLT/kb7uPvBTw6RlVg64cz+qJzOywVACVKty
         pI0B+9670iRS4J6Du7mdMl55jQpB5wttuXO/EKCks4huhfIJyVOWP2nMxM0CyJlK1T3G
         bSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZfjNdBvQXpFTbK3oPjbWjrV1f+R15VFJow8PnMMBkDM=;
        b=XSHzZ3PCfuYKS49lRiTVKuyEl7VItTiTUfkPkmDfJT0FvK748J0gXI34GwmC0knCcR
         sKnhZ51EGxBlwhb1yGIE+tAum59X0zP2+GVz+7+WlITIbplw8F8SW++wuSMRnoqhWFOl
         kilSdfkA0PWkqUTOqjs4YxXDh6Y9ts6rVoBPEG8xcHA2jqLAkUbVIz7SpASayBlmqF5l
         UuKgwdcj/ateTs1jLpEwxPyXtqKo1khRpZMbmxxYWp1OML74zdM1cs1phxpX7LqhYJm6
         mNuoWbjmmj8sfr9VLUtb/6JAz4mi1K7lshB/zMta5w7QhsW4M3+u+SPx+uRk3+1y3gMB
         44sg==
X-Gm-Message-State: APjAAAU1zP7RU6JxWDrHrLOaariHnnlnwqJ6dTzcJ/KlMP/bCTKBXyMY
        JElPXYg4kuWjIztPdNpnUS4=
X-Google-Smtp-Source: APXvYqzRbFpkWYYamrrhboMDOv3Z/3QIW/jS9iDdZ7rYIu+IRJAEMgZ1Uk+y3XDGpHUCp+NyO4viEQ==
X-Received: by 2002:adf:a3ca:: with SMTP id m10mr4074364wrb.148.1582797960830;
        Thu, 27 Feb 2020 02:06:00 -0800 (PST)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id j20sm7760554wmj.46.2020.02.27.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 02:05:59 -0800 (PST)
Date:   Thu, 27 Feb 2020 11:05:57 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Nested submodule status bug
Message-ID: <20200227100557.ydouc4n3jphzbits@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Thu, 27 Feb 2020 11:03:34 +0100
References: <20200214224242.knmzkwx7ls4sote7@doriath>
 <0123F1ED-C421-4C1F-896B-E54C9D345A34@gmail.com>
 <20200226172338.unembhjhog36sqj7@mithrim>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200226172338.unembhjhog36sqj7@mithrim>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Damien Robert, Wed 26 Feb 2020 at 18:23:41 (+0100) :
> 2) Now add the following alias:
>   subs="! git -C baz status"
> 
> 3) And run it
>   git subs
> 
> To get:
> ~~~
> On branch master
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 	../2
> 
> nothing added to commit but untracked files present (use "git add" to track)
> ~~~

Ok, so using GIT_TRACE and GIT_TRACE_STATUS and doing some debugging I
understand the cause of the bug. When using the alias,
the GIT_DIR environment is set to the bar module:
    GIT_DIR=/tmp/test/foo/.git/modules/bar
and is exported.

That's explain why in `baz` the status report the status of the `bar`
directory.
