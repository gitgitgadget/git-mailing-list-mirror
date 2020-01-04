Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33ECC00523
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 00:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759DE21734
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 00:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cykpAYz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgADAs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:48:29 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35521 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgADAs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 19:48:29 -0500
Received: by mail-pj1-f68.google.com with SMTP id s7so5332424pjc.0
        for <git@vger.kernel.org>; Fri, 03 Jan 2020 16:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cW27PUinhITbH5W0DDOKQnfy9AVD3T74uDxyOOn8OQo=;
        b=cykpAYz9PAeTxIJiJ2EQpEhsHVY4qb+qPThnWBIjsFmhYFnEr37UfYkRvAVFhFtfHf
         UdmhoR/sjKQ+JUMAgvs6/UvCPWJwMrv3ch3K+StltCE9nadhOzbQHx9cSeUT2taBXuAG
         L+yGSqWdkO63NHbd/P2w/8vGQjjsFoAlndtfBGauMLfDFggb7XrbDKYrUDh2azReKz+b
         OVol1Ux0SrfQbRwEaClXE+6i82wu5wLWnK8JAYP5IJLaBcEL/KJiqd6dQMJcZhdEDAAD
         oSqFKB3GbxpqcTNGTACDstOqj+LjJxdgTIL/37icC3IcPEV3pJtIepfK8NUd7/wAVHRA
         iW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cW27PUinhITbH5W0DDOKQnfy9AVD3T74uDxyOOn8OQo=;
        b=GF6z5S0PT5zgiw/k4ja1QOD0Zdk5g77JdXXGgVd47tPqxvjub7wHUmzqDpHCEsvV0s
         doZeiCBNsQ/VThABUzEM8TWfuZ4/EQF8rsHbTm2MrtPp+5tkj+NWMMFzD3Vb0PdT4wJ1
         3h2gXZgiPvcyDpc8SqzyeT3rQNbiE6Kp+LeqUwlGC7ItwTsWgEdkrjKH54BZ3PJUaUcg
         yrPEEQ/uZsPfrDUNp6pQeo3GZR+VWCu3tbhXCydWxEfcBu7/dAorV6VY6NsvUik2iDvn
         NaRr/vfY/ncUpY54+LjW/0sBZwiXCJfGgODRGWv//hMUqujTrAZpC9GzXSFIZvAmMg6X
         4cJQ==
X-Gm-Message-State: APjAAAWbGB8vFEqtroTdbwYKQCzBH/lNhFmGFqK3dL9F0GZ8jhsLf+jH
        f/Hkk8Vhia07g7nJRHmaf9Q=
X-Google-Smtp-Source: APXvYqzIt1YvYsoSsCTyWJZOtX0m5kr4iPZPGevZwAeFJSDH7DvP8ifOrbqntPtQ3ZfMZ061grq1Pg==
X-Received: by 2002:a17:902:244:: with SMTP id 62mr55065977plc.168.1578098908287;
        Fri, 03 Jan 2020 16:48:28 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id g26sm60311284pfo.130.2020.01.03.16.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:48:28 -0800 (PST)
Date:   Fri, 3 Jan 2020 16:48:26 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?RnJhbsOnb2lz?= WAUQUIER <wokier@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git checkout -
Message-ID: <20200104004826.GC130883@google.com>
References: <CAFS-fjvhAB5EcfHhfp6HYN57W11tkHOc8K8T3oey8qceutuYsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFS-fjvhAB5EcfHhfp6HYN57W11tkHOc8K8T3oey8qceutuYsg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

François WAUQUIER wrote:

> $ git checkout -
>
> I often use this command to go back to previous branch from my history.
> It is quite natural as it uses the same syntax as “cd -“
>
> But i found out it is not documented in
> https://git-scm.com/docs/git-checkout/2.24.0
> I report this to help others to discover this time saving command.

Thanks for reporting!

Ideas for what the documentation should say about it?  (Bonus points
if it comes in the form of a patch against Documentation/git-checkout.txt.
;-)  See [1] for more about how that works.)

Sincerely,
Jonathan

[1] https://www.kernel.org/pub/software/scm/git/docs/SubmittingPatches.html
