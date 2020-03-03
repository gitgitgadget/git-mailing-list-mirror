Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2667FC3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E508620848
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 22:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuJLLXdf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgCCWEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:04:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33335 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCCWEN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 17:04:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id a25so3335176wmm.0
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 14:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WbSPP3OvZq0Ru+0RvKoWpi2202AG57BTh6lBeZgfCjE=;
        b=ZuJLLXdf4XPwhKdiME/mxbAnIirwTtps0qZxyIgIbrwhiy9NYlpBp2mSM9sY9o49d6
         ezfIxJN7UKdmjTq9eOKaMlwIdA0/hee8s9c0pOpe+pk5FpFNRGbLjWGjaE4ZCk6nQZoQ
         lfvcVWkHAltBlx1WZXTR+GAOTj3ElZqcAYJfNyJ9MmeXsCBYGJytrtW2SMhBhkJzY7cz
         FzJg7Zh/J1XfmYKoLavKsS9jWW6uNkLw6JBWBmwwRxKz3LwTw7Pv4WgQNrftWs3PQhHn
         UkAK1tDF5OagSdrtbajZeyKhmr1NxVuW6AaPzSsJ/ZoWQ4ZcoPr7X6kaR44KW4ovBFYT
         pRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WbSPP3OvZq0Ru+0RvKoWpi2202AG57BTh6lBeZgfCjE=;
        b=TnEHnYz89q+OEm8XuU+nrPW90txyAsBf6j72rWCUZd5coKRlS7lmfMRdUa8+kmbsqg
         s1KyT03cKi9k+YIGTVF61V+IDE4aKz9YzVOugyymncQZ/nOWfd7PHYJ3x7WsHMMkYn0n
         57R20oKHeZjiciCnDAc50g+YqqLhKiDHzphqgxkPUYCYqeinlDMowkWTeQsdeNea1v7M
         WOpV0l0VuLkKSvCuYXe/hjNVhjdjZpo48Jj/Vc3IpjU4Djfp7B3/WiwCm8gr46iANDpr
         gFr+YRUQ9JhVF7wdSaV5cklCRCsg0xvUMlKuc1Z0b/XMU9859M1ufVcDcuA2686tXUIM
         DvQA==
X-Gm-Message-State: ANhLgQ10gUlbv6hfJhMOt+CXHEYATh23vM8X4ILXH8MbNVG9nDpN2VFX
        GB2VFQG/IR+Eh0KV0huEYPxUnsATtxg=
X-Google-Smtp-Source: ADFU+vuhUYOPZ8JintuDuoBeqUVrSsjfyZsSjAzKmqHwTZi+j+MbNllExUhbSFOiU7ICfybv11CnJw==
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr578580wma.177.1583273051495;
        Tue, 03 Mar 2020 14:04:11 -0800 (PST)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id t1sm39228516wrs.41.2020.03.03.14.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 14:04:11 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
Date:   Tue, 3 Mar 2020 23:04:09 +0100
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 3/5] doc: explain how to deactivate recurse.submodule
 completely
Message-ID: <20200303220409.xebesh3ygbuwgwgo@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Tue, 03 Mar 2020 23:03:25 +0100
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
 <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com>
 <20200303170740.1879432-4-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200303170740.1879432-4-damien.olivier.robert+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Damien Robert, Tue 03 Mar 2020 at 18:07:38 (+0100) :
> +	When set to true, it can be deactivated by calling
> +	`--no-recurse-submodules`. Note that some Git commands without this
> +	option may call some of the above commands affected by
> +	`submodule.recurse`; for instance `git remote update` will call
> +	`git fetch` but does not have a `--no-recurse-submodules` option.
> +	since `submodule.recurse`. In this case a solution is to temporary
        ^^^^^^^^^^^^^^^^^^^^^^^^^^
Sorry this is a leftover from a previous formulation, I'll clean that up.

> +	change the configuration value by using `git -c submodule.recurse=0`.
