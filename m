Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D130C48BD1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F30C613E1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhFJQeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 12:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFJQeY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 12:34:24 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7A8C061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 09:32:14 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id u11so2751678oiv.1
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=kUKFB2QVUqPVMgfhMyLs24Gs2/eze/dLCaQOZs3DGGE=;
        b=aCeTNI/hx4YRi+ND0gtoQqsZcQXNLOJ/JKBUB5s4KQY4lw68IbknAyskZKz1XFFn6t
         HSRLvPA2js4gLtSIf7ISZyRubV43GN0asXtUrQAOm9/+cn2dk0JQrFRP7ugG6GemO8Rm
         pZJNp3Ew4qXfaN4vJj4N1FwrvwtvLT4TrBS4oD8YkszMuJzsf/2X42C/FXe80Egr90++
         Gllq7VIc2IdPttnSJBPI5aAK/czk1EwWNwo/Lj/6q0Ht19jGSc1fzDB2nv/a9wyyeg4d
         lwbPTaYV2Znyk5s0o897EUa/4Nzk3msdg8mbZRTBKFK7Zq2ZL2VeTp0Gy8b+z5OB/PMH
         mdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=kUKFB2QVUqPVMgfhMyLs24Gs2/eze/dLCaQOZs3DGGE=;
        b=horlPIyxaATJQQToVUb8NfJAIx9KJu1lAIj2bTIxZakIyR5BOnLeM3p52Ut9NPrfNf
         ezswFOTweAE8ERW3vJ6LyByfKODM8+twIn41H0upojy+Z5DSeJJPEmx0bwDNK/PfXjoB
         A2gthv7Nf6GZw3x9MIXgyQRarP3yhoWxP+1uKTALZEoSjTawjm+YqcY5SyMK6OEat6uT
         1588KuoHIEg9hZl/m75ujLQ9U0nD9YDEmw+ZUKJvAXQrMLOIFOM/LwiV63+u00tkxTKB
         ZRM5oSVPLfaj5wI8Orw8X+74Ev2eBJjC+YiyOzJ+Y9fF2/iS6pv8x6by+ZG8UsJzKpWe
         gQRQ==
X-Gm-Message-State: AOAM533N3/Z+JblETTsqUofBc+cacTCFqEFieApxTXW8oscqOH704InS
        y8hG254fckoiEM61/Ax2Mlo=
X-Google-Smtp-Source: ABdhPJysx8s+6Ecn/7jIyJEQOuB9S4msHx//og6Axa072nY4Ot7t8B69ItoXoqrG5CWcyRfe9d4OCw==
X-Received: by 2002:aca:c082:: with SMTP id q124mr4091127oif.118.1623342733383;
        Thu, 10 Jun 2021 09:32:13 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id f12sm507029otc.79.2021.06.10.09.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 09:32:12 -0700 (PDT)
Date:   Thu, 10 Jun 2021 11:32:11 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Message-ID: <60c23e8b7f672_b25b1208d2@natae.notmuch>
In-Reply-To: <49da6d73-c49f-d75e-0eb2-b12bd529fcfa@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-5-felipe.contreras@gmail.com>
 <b4b9264d-1c17-1a62-f0ec-2791ab20adeb@gmail.com>
 <60c21d9ce8848_b25b120884@natae.notmuch>
 <49da6d73-c49f-d75e-0eb2-b12bd529fcfa@gmail.com>
Subject: Re: [PATCH 4/7] checkout: fix merge.conflictstyle handling
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> On 10/06/2021 15:11, Felipe Contreras wrote:
> > Phillip Wood wrote:
> >> On 09/06/2021 20:28, Felipe Contreras wrote:
> >>> Currently both merge.conflictStyle and `git commit --merge
> >>> --conflict=diff3` don't work together, since the former wrongly
> >>> overrides the later.
> >>>
> >>> The way merge configurations are handled is not correct.
> >>> It should be possible to do git_config(merge_recursive_config, ...) just
> >>> like we can with git_diff_basic_config and others.
> >>
> >> It would be helpful to explain what the problem with
> >> merge_recursive_config() actually is rather than just saying "it should
> >> be possible ..."
> > 
> > The problem is that you can't do this:
> > 
> >    git_config(merge_recursive_config, NULL);
> > 
> > As it was explained.
> 
> You do not explain why you cannot do that

  % git grep merge_recursive_config
  static void merge_recursive_config(struct merge_options *opt)

For starters it's a static function.

Second, clearly the type of functions git_config() receives are not
`void (*)(struct merge_options *)`.

I mean, I do see value in explaning as much detail as needed in the
commit message, but it shouldn't be a lesson on git's codebase:
git_config() is a standard thing, and it's even mentioned in the user
manual.

https://git-scm.com/docs/user-manual#birdview-on-the-source-code

> > That is the problem. I don't know how that's not clear.
> > 
> >>> Therefore builtins like `git merge` can't call this function at the
> >>> right time.
> >>   >
> >>> We shuffle the functions a little bit so at least merge_recursive_config
> >>> doesn't call git_xmerge_config directly and thus override previous
> >>> configurations.
> >>
> >> Rather than papering of the problem, how difficult would it be to add a
> >> field to ll_merge_options and pass the conflict style with that rather
> >> than fiddling with the order that we set a global variable.
> > 
> > Probably not that difficult, but then we also need a parser that
> > converts from "diff3" to whatever values we decide in that new field. We
> > would need a new parse_config_conflict_style() function.
> > And that function will be only used by `git checkout` and nothing else.
> > So I don't think there's much value in it.
> 
> It would allow us to add a --conflict option to all the mergey commands 
> in the future and would be much easier to reason about than the approach 
> of juggling where we call git_xmerge_config().

Feel free to write a patch for that.

> This patch requires us to audit all the code paths that end up in
> merge_recursive_config() to make sure they now call
> git_xmerge_config() themselves. You don't seem to have done that as
> you don't know if am/apply are affected or not.

That is a separate issue, that I already mentioned...

> > That problem whoever, is orthogonal to this series.
> > 
> >> Does this change affect 'am/apply -3'? - Do they still read the config
> >> setting properly?
> > 
> > Good question. I'll have to add more tests to make sure that works
> > properly.

here.

-- 
Felipe Contreras
