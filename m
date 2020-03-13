Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAE5C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 15:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F3B2072C
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 15:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c60+NdUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgCMPtW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:49:22 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36265 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgCMPtV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 11:49:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id g12so11082582ljj.3
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 08:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1EUhP/NR6YbSMFxtiwuD0naA8GZM+v+ezx1CE83BMIU=;
        b=c60+NdUsK4Q+I0NNTWUkX0QnCBXMAWxy6ZIVIQ0nr9WW0ICh+zrj115XAUXx6xTGgb
         OPWx3ZtthkMOt0bpjZMAnxyIGffadL3RTDUahIjWYJPCcOjdEdn5W+/uQjf4AAe2phJ/
         Rgqz83V5/TXb/kVTGId3XvXUC++S0GC2Pr2tcTf8KU8lb4On2B86qpq+3h18KgPEMTtr
         Ih1AGq4e/jPZYk0udM/IQQOpKXr9NO4cJW0QwQ5vg6khhCtTz3ixldh8+Rm2GY8NDalP
         9jn67rMHdrUgH3MbZedadH3Cxbt157khHZcgdGkbKosuKD8QNI+bQAldSnLK0O546YWe
         kwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1EUhP/NR6YbSMFxtiwuD0naA8GZM+v+ezx1CE83BMIU=;
        b=VsBYbgKbWWHqUbsG+1VZ7G5ePkQswXRvLJAnwO+JHJaBeyVG9ebkc63j0XIl+cOYYo
         tIO0gljvY/Hxp7lV/qY6vW42vcHX28hoNjytKlaRkxVK5REmJwNfxEq/+soZNupviGvL
         FEje/8i1Dgvq43upACxgr7QIUENzTEBNBMY/uyS2XYjFvUc7t3T9GXmht76XotiekH5g
         TgweVNrUlBXWT0j0tp7OZQRLrsL6Aiy+MFlrR+SNWtW1ItMdEdNVlHFOpRB5DMPDRVwm
         k23GP8sVl0ino+GNRUs/xaC5Bid7S715cMMgPyks3sA4korI0Qwrqh9lr0LZjXRkfkM7
         8f+Q==
X-Gm-Message-State: ANhLgQ3Xcf5PO4gpigx82xIklz2AFCm774d8I4t5kulU0SbE9INliMeS
        uFdulsPd3Eo+uX+mJTDJYZWqmTOK
X-Google-Smtp-Source: ADFU+vvyoCKfqHEscG3oItF9McnbhZQt3VCQa/R4Hm0P1wHviVcMoNs9AZV5WoNBIDBS+R9ah9Yl+A==
X-Received: by 2002:a2e:87d7:: with SMTP id v23mr8108629ljj.10.1584114557191;
        Fri, 13 Mar 2020 08:49:17 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id o16sm4015649ljp.53.2020.03.13.08.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 08:49:16 -0700 (PDT)
Subject: Re: What is so broken with pull
To:     noloader@gmail.com
References: <CAH8yC8knZEmKyYc7TwmXRCd24nK9YgDo3EYfvH58QWP61ZHpwQ@mail.gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Message-ID: <4aed477e-dadb-8077-c648-2b11c893f0ee@gmail.com>
Date:   Fri, 13 Mar 2020 16:49:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAH8yC8knZEmKyYc7TwmXRCd24nK9YgDo3EYfvH58QWP61ZHpwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Jeffrey,

On 2020-03-13 16:26, Jeffrey Walton wrote:
> $ git pull
> There is no tracking information for the current branch.
> Please specify which branch you want to merge with.
> See git-pull(1) for details.
>
>     git pull <remote> <branch>
>
> If you wish to set tracking information for this branch you can do so with:
>
>     git branch --set-upstream-to=<remote>/<branch> android
>
> $ git branch --set-upstream-to=https://github.com/noloader/openssl/android
> android
> error: the requested upstream branch
> 'https://github.com/noloader/openssl/android' does not exist
> hint:
> hint: If you are planning on basing your work on an upstream
> hint: branch that already exists at the remote, you may need to
> hint: run "git fetch" to retrieve it.
> hint:
> hint: If you are planning to push out a new local branch that
> hint: will track its remote counterpart, you may want to use
> hint: "git push -u" to set the upstream config as you push.

It seems you are trying to set the upstream branch to the branch 'android' of
the Github repository https://github.com/noloader/openssl.  Option
--set-upstream-to expects a remote branch, not a URL.  You could try:

    $ git branch --set-upstream-to=origin/android android

In the hint printed by git pull, <remote> referes to the name of the remote, not
its URL.  You can check configuration of remote names and URLs in a repository
using command "git remote -v".
