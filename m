Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05910C54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 19:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D736C2078E
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 19:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bae3ZaXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgDZTcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 15:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726166AbgDZTcJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Apr 2020 15:32:09 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2702C061A0F
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 12:32:08 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e25so15323405ljg.5
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I6O3Oljg/0bnI/FKjlBlajJH6Q8tBeS1ZvSsNN/lpoM=;
        b=Bae3ZaXyONpwlmVoiTpEnxRcv7xyHdSe46SqBdw+Wif3Coky07tJRCpC9uISs3f7Ii
         oLLxRbt2snHgxJQiWCc9cDqmDcePChQeBN2xb36Akt6W1Il15u1RY0J3I2n2x7nuLhqj
         Q56+Dd/o/XdS/VxT75RNUyie0yD/oh7YAlRPOkiaGp4k2MZ8u0hgm0DvugLIdOupPcH3
         hqgLKIAtGOxq47ZobxRMnaXi1JEMljpX2S2K1RWzqTn2P/ttI/mZFqdIw9N9KQjNOvqr
         1ZEP+Yj004830+uKzQcQZG40kGA0XDkmiKTAzkE/0PAC1jgoMqb1JGot+Oo4LNez24tR
         ulGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=I6O3Oljg/0bnI/FKjlBlajJH6Q8tBeS1ZvSsNN/lpoM=;
        b=mJWGQ6rhoGMfaPsQRLtP6+QZNrNE/Vf8q3D22F+L8Mb2F339plXAKmndaUiQ2ICXjQ
         AdwHucde0rUQ2do4r2BK6nVqXON24Kz78YldNXouXYheYSHlru8fBxUb0GX7IWdHFFJ8
         bluIdsA3IOaHe+q/jclyzLjGFgLy8ZgnnAL2tV7/vYT8Y6n5xeUPLv8/RT64TbIXd1Og
         SK28E6d/15MQYK+zJ0Xl65h3Fcb5EGbK9o2kKU0FYTiuo1rWBfMGjluM0KTe8D+rgWgH
         Yv+jfdUT+L89VfgZd+xgK8I8unp5wVRPCwvVdSgnZaKSf+I2bceWv4clwbCztbkqgVpN
         zr6Q==
X-Gm-Message-State: AGi0PuZRqkeSunt/hmkQUqMC0fNPZAy0cfKpDhr3waXViAvP3Dg+697A
        zTwFMncWdb6vzpjhN/O4S1o=
X-Google-Smtp-Source: APiQypL9xRGvHLLcByBmRGX1Eja5QwOkQy3hqYysAJJCoN45WY+/Lxmp89ZhnYhu7UWG1IJ0M7Q6/A==
X-Received: by 2002:a2e:9a93:: with SMTP id p19mr11395953lji.77.1587929527012;
        Sun, 26 Apr 2020 12:32:07 -0700 (PDT)
Received: from ?IPv6:2a02:a31a:a043:8cf0:ca8:e44f:8895:44f4? ([2a02:a31a:a043:8cf0:ca8:e44f:8895:44f4])
        by smtp.gmail.com with ESMTPSA id l7sm10213962lfg.79.2020.04.26.12.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2020 12:32:06 -0700 (PDT)
Subject: Re: [PATCH] config: use GIT_CONFIG in git config sequence
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, mattr94@gmail.com, bwilliams.eng@gmail.com
References: <20200425235716.1822560-1-maxmati4@gmail.com>
 <xmqq5zdn9k3r.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Mateusz_Nowoty=c5=84ski?= <maxmati4@gmail.com>
Autocrypt: addr=maxmati4@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5c1005a7-273e-fab0-0d0d-78bd0d3d13f6@gmail.com>
Date:   Sun, 26 Apr 2020 21:32:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq5zdn9k3r.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 25, 2020 at 05:16:56PM -0700, Junio C Hamano wrote:


> Mateusz Nowotyński <maxmati4@gmail.com> writes:


>


> > Currently, there is no way to use config file other then
~/.gitconfig.

> > This can cause a problem, for example, when running tests of
software that

> > depends on git. In such a case user's gitconfig may contain settings
that

> > are incompatible with tests.


>


> While I can remotely imagine how an environment variable that


> overrides everything might be useful at times, we already use


> GIT_CONFIG environment for a different purpose, so even if such a


> feature were desirable, the name is already taken, and you'd want to


> hunt for another one.  Also, I do not think I'll take this patch if


> the justification were solely the above, as it is a solved problem,


> together with the use of GIT_CONFIG_NOSYSTEM and GIT_ATTR_NOSYSTEM.


Agreed that we shouldn't reuse GIT_CONFIG but as you said, before huntig


for new name we should decide if we want this at all. As far as I know


GIT_CONFIG_NOSYSTEM only allows to ignore system wide config file stored


in /etc not one in the user home directory (~/.gitconfig). Is there any
way

to achive it that I'm not aware of (other then overwriting HOME
variable)?

Or maybe you would like more to add something like GIT_CONFIG_NOUSER to


just ignore this file?


>


> Tests of a software that depends on git, and perhaps other things,


> will be affected in things under the testing user's home directory,


> and not just ~/.gitconfig file.  Providing stable environment to run


> in to your tests is a useful thing to do, but it is not a viable or


> a particularly smart strategy for doing so to tweak each and every


> software that your software may depend on, and your software itself,


> with a custom change like this patch.


Problem that we are facing is that if developer has git configured to


sign commits using, for example, yubikey he has to touch it on each


commit that makes tests unusable.


> You can prepare a pretend-home directory for the use of your tests


> and point the environment variable $HOME to it while running your


> tests.  See how we do this in our test suite for inspiration---it


> all happens in t/test-lib.sh, I think.


>


This is what we do currently but the problem with this solution is that


it breaks other software that also uses HOME as base path for their


data. For example asdf version manager.


> Thanks.


>


Regards,


Mateusz
