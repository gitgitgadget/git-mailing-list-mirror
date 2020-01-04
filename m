Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DD7C00523
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 00:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9186E20866
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 00:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKvRe11u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgADApT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:45:19 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36717 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgADApT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 19:45:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id a6so18863521plm.3
        for <git@vger.kernel.org>; Fri, 03 Jan 2020 16:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RB4EV5PlecATGMZvcJEx9wwztnXGudbNV5yGbjbpOhs=;
        b=AKvRe11uETOeXnp4fm/KK4jwR/P8UyYWujutFnWi5Vv7veo4IexX7xE1i185Oo1bM0
         wkJHXFiuNP/7pQdA/1930zZ56ThH9SqYZs6RIRwcvzAjWIO2h4wtWqDO48tNQLhliXpx
         lvadg65/DaPEqaFQCJVCaAw1D2LVV3oW/xA0XqsS/DBIzr2bP1y7cJJbI5f/osKk0wc0
         fJcsM6BVlRRHYlnG36PtLJwSACUWIXS0xTm4+5xxwbGOgX1k5+0k10Pbz8bzymQ8mUNX
         B2z9mIXHxR42Ufh3veRDCAVqUWye9Yi2Oo2+qSc6GJavSQ9cv23k1PBoh7rYFQ3TpvXt
         EAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RB4EV5PlecATGMZvcJEx9wwztnXGudbNV5yGbjbpOhs=;
        b=aDVxJi4oajUFc9FN793RS/PuzZxQzkqmJ78Y9iJNxz243/EWQIcsjmJGakAjfFz/dA
         Y5xryqLaxsoNaankYMuYL8Qob3NlItuI3RDcexIB5/JYhYm5Vf8wERny70UeIK8h32R8
         g2qhewbNIQa154NskkHZelOlIjhXg51lXByEdih1Oz5ZeZfSn2p3W+NGJxQsmgfMnaAX
         Gv2Kcoo4M8+GQuYhD5KVxak7rnfx2ffj9MAKhyAFYZ4LqTJ1Cz/n6RAGMccfkPb7tabS
         oXzrmof5IfSYHUQAGaBlhnqGfGSo94rASKYFE6qB+9hEqOg1xt+/vWgTZ75QacE4GCAm
         USJQ==
X-Gm-Message-State: APjAAAUCNvfjfN7p5cn99DmRzqHWzqRPWI4sGrJS0nVus+s12h/QNRRR
        X3VFtLww7uph4HiH2elKh+0=
X-Google-Smtp-Source: APXvYqxVu6ZhkB9rDvfyDSNJchB6JdfF67twruZQ3Nppm88nCDLAa/R10WNq5vXntw2JDYfKxw7DSQ==
X-Received: by 2002:a17:90a:31cc:: with SMTP id j12mr29443052pjf.103.1578098718302;
        Fri, 03 Jan 2020 16:45:18 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id x8sm69817294pfd.76.2020.01.03.16.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:45:17 -0800 (PST)
Date:   Fri, 3 Jan 2020 16:45:16 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     marcandre.lureau@redhat.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] RFC: commit: add a commit.all-ignore-submodules config
 option
Message-ID: <20200104004516.GB130883@google.com>
References: <20200103120613.1063828-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200103120613.1063828-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Marc-André Lureau wrote:

> One of my most frequent mistake is to commit undesired submodules
> changes when doing "commit -a", and I have seen a number of people doing
> the same mistake in various projects. I wish there would be a config to
> change this default behaviour.

Can you say more about the overall workflow this is part of?  What
causes the submodules to change state in the first place here?

[...]
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
[...]
> @@ -1475,6 +1478,11 @@ static int git_commit_config(const char *k, const char *v, void *cb)
>  		return 0;
>  	}
>  
> +	if (!strcmp(k, "commit.all-ignore-submodules")) {
> +		commit_all_ignore_submodules = git_config_bool(k, v);
> +		return 0;
> +	}

nit, less important than the comment above: no other config items use
this naming scheme.  We'd have to come up with a different name if we
want to pursue this.

If I want to disable this setting for a particular "git commit"
invocation, how do I do that?  Typically when adding new settings, we
add them first as command-line options and then as a separate followup
can introduce configuration to change the defaults.

To summarize: I'm interested in hearing more about the overall
workflow so we can make the standard behavior without any special
configuration work better for it, too.

Thanks and hope that helps,
Jonathan
