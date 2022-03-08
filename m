Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D84C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 20:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349785AbiCHUFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 15:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbiCHUFX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 15:05:23 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3F73AA41
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 12:04:26 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id k5-20020a17090a3cc500b001befa0d3102so2491354pjd.1
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 12:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BTLa68u6oD1PNpaIOXJPCDihx01OMNgUJD0B6BmhmPo=;
        b=lI9o8RGgMbOgegv52MYoWq5kI0kVDav8xkdaf+9/ZBQhmCphMzYAwRh1WWmki8RjfE
         VrssZ+aO10c8eCG0Q2EZn2tiSAPBkOvABK1sjwuBU1kc+ACfnqaeKfcHHPDcdHn4ofLP
         e8EVFBYvz3rWrFSQENgJwveDBlZwoYTjhlJOmyC674PvKt8yRn/Itbair1RBqRpMrpjl
         B4UL0CfvR7ZPkqtrzQQ3IwYUSYc1W6/WyFmBkbsDgUuARdh0G6DqBzVLXYKzNXzfkW5i
         C9gv/s+28cw2uJ43xLsoToC1/hLe6iTyGL0zoKLFVifM6a+8OxV4Rqj8QKvepYu6NjCX
         x1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BTLa68u6oD1PNpaIOXJPCDihx01OMNgUJD0B6BmhmPo=;
        b=XWaV1CDgfVixLLQRmc4nM7LgW01Hmk11/Ge1d1dsZuimK0busFaUGQVUS88oLMt+h5
         XkxCUMKffSNsU21EUlu+QJA1tidK1rK0waWmt7A/BoB6FJZtyuqLHl8eVf8Jv5/gAkfD
         sZRcotaRtMMMfyGDfSTtsk3HBRGw7piV5kfAuGOyDfHK/DD2EqCWRn+4IYp4v8T4ychg
         JYlwpq5K4iymWksZIjarWMMrGNgOa3sJIMqULqMijqdq34YEvNEmwg8gi8bIWLlSyUso
         l5LdtJl9a2U03TaWzAAWw+llStueUH6ohLstOwWAss3dKQNDEiLK9fKFYhyzM2a3zNen
         hhhQ==
X-Gm-Message-State: AOAM531iXt4Xipk7ZSZ3x6W6rPla9udbzjPRX72+hCbqeXB577po79Wr
        k8VYYnzfAa6mNS5We7cv1usfOQ==
X-Google-Smtp-Source: ABdhPJy+UVTVdhycuPAt458DWrj6GJxEhRYae3RoKt16qXrCiRDSlCnAF9d5q3RtId+F+hPbvG+sAA==
X-Received: by 2002:a17:90a:2ec2:b0:1bc:8bdd:8cfc with SMTP id h2-20020a17090a2ec200b001bc8bdd8cfcmr6588618pjs.237.1646769865315;
        Tue, 08 Mar 2022 12:04:25 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:7bb4:8168:2ecc:faea])
        by smtp.gmail.com with ESMTPSA id mp10-20020a17090b190a00b001bf8453aea8sm3565142pjb.42.2022.03.08.12.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:04:24 -0800 (PST)
Date:   Tue, 8 Mar 2022 12:04:18 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 2/3] introduce submodule.hasSuperproject record
Message-ID: <Yie2wvbviWxhia2e@google.com>
References: <20220203215914.683922-1-emilyshaffer@google.com>
 <20220301002613.1459916-1-emilyshaffer@google.com>
 <20220301002613.1459916-3-emilyshaffer@google.com>
 <xmqqbkyqupg6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbkyqupg6.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 28, 2022 at 11:00:57PM -0800, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > +	/*
> > +	 * Note location of superproject's gitdir. Because the submodule already
> > +	 * has a gitdir and local config, we can store this pointer from
> > +	 * worktree config to worktree config, if the submodule has
> > +	 * extensions.worktreeConfig set.
> > +	 */
> 
> Probably the comment is a bit stale.  There is no longer a pointer
> or location of superproject's gitdir recorded anywhere.

Thanks. I considered replacing it with a new comment about "now we'll
note that it's got a superproject", but I think that's clear enough from
the config set line, so I deleted the comment entirely.

> 
> > +	strbuf_addf(&config_path, "%s/config", real_new_git_dir);
> > +	git_configset_init(&sub_cs);
> > +	git_configset_add_file(&sub_cs, config_path.buf);
> > +
> > +	git_config_set_in_file(config_path.buf, "submodule.hasSuperproject",
> > +			       "true");
> > +
> > +	git_configset_clear(&sub_cs);
> > +	strbuf_release(&config_path);
> > +	strbuf_release(&sb);
> >  	free(old_git_dir);
> >  	free(real_old_git_dir);
> >  	free(real_new_git_dir);
> > diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> > index 40cf8d89aa..833fa01961 100755
> > --- a/t/t7400-submodule-basic.sh
> > +++ b/t/t7400-submodule-basic.sh
> > @@ -115,6 +115,10 @@ inspect() {
> >  	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
> >  	git -C "$sub_dir" update-index --refresh &&
> >  	git -C "$sub_dir" diff-files --exit-code &&
> > +
> > +	# Ensure that submodule.hasSuperproject is set.
> > +	git -C "$sub_dir" config "submodule.hasSuperproject"
> 
> Are we sufficiently happy to see the variable is set to anything, or
> do we require it to be set to boolean true?
> 
> If the former, the above is fine, with trailing && added.
> 
> If the latter, then something like
> 
> 	val=$(git config --type=bool "submodule.hasSuperproject") &&
> 	test "$val" = true &&
> 
> would be more appropriate, but I wonder something like
> 
> test_config_is () {
> 	local var expect val
> 	var="$1" expect="$2"
> 	shift 2
>         val=$(git "$@" config --type=bool "$var") &&
> 	test "$val" = "$expect"
> }
> 
> would be in order.  That would allow us to write
> 
> 	test_config_is submodule.hasSuperproject true -C "$sub_dir" &&
> 

This seemed neat, so I started to look into implementing it, and found
`test_cmp_config()` which takes additional args to pass to `git config`
- so I should be able to achieve this same thing with
`test_config_is -C "$sub_dir" --type=bool true submodule.hasSuperproject`.

> >  	git -C "$sub_dir" clean -n -d -x >untracked
> >  }
> >  
> > diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> > index 11cccbb333..422c3cc343 100755
> > --- a/t/t7406-submodule-update.sh
> > +++ b/t/t7406-submodule-update.sh
> > @@ -1061,4 +1061,12 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
> >  	)
> >  '
> >  
> > +test_expect_success 'submodule update adds submodule.hasSuperproject to older repos' '
> > +	(cd super &&
> > +	 git -C submodule config --unset submodule.hasSuperproject &&
> 
> Are we testing that submodule.hasSuperproject is set, and that
> it can successfully be unset?  "config --unset no.such.var" will
> exit with non-zero status.
> 
> > +	 git submodule update &&
> > +	 git -C submodule config submodule.hasSuperproject
> 
> Ditto.

Ah, thanks.
