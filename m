Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DDCC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 22:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344342AbhK3WJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 17:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344372AbhK3WJA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 17:09:00 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC4DC061746
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 14:05:40 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id n26so22071962pff.3
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 14:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wGY9Qtepd9kdKVKdHiCeg9BeR5SCSmUarfkkqOrpq3U=;
        b=SGMpfCT2CZlQrtv1TsbLQEygNyzKWEEakhANPotTpFJmcllwvnXJAvtbMhhKaSG2yC
         Jr8hIZXJfojk41DHZz/Cit4zyDMVFj/BrLPIqRqjTyUBU6oVFzEDvFZ8bRb5iCli7jHX
         DCGU2JL/jLW3ns1Ubiu5yZtT7AsVb91yaxeKYl3sozxzCczzK71i1GGibCYkndCkJSvi
         jKHmFgZhfeUJ5KUKduA6muV1cCzDv6vKNZj4uvedzrKUg0mqw1w/WhQvV5lD0QiE6hWc
         /GkNKIPuwRHpKsWu7b1Y5zLvvfd/RNvAduMLvt/I30YvtWmHqQc3Wub+qLcTvZAg0Jab
         kQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=wGY9Qtepd9kdKVKdHiCeg9BeR5SCSmUarfkkqOrpq3U=;
        b=nXssYfFHdFJtJaZm/nyrJMw0YyhMV1H4Vkhrk9lV/z31SUO1CTUynME3V9BRK7QL4H
         6sZDU6MVa/HtKLHRcLubi6YNCxjOUkG5kQzrRXTouYjfAjKTELU4/20L8bm+bZqu1bp1
         71uqhvmoGG8i1zDUjzttzLx/YFiwq4ay6HTBahsFV1x7UqdMU2EaCbJ0Mg38+nPp+OX6
         jI8h/zzWdNOPdG7wVssXjgKNAvHTEf5FSUNHOd3DpWoGwKYheWfRsjEYF2ojCtpDL53i
         36WB2Kfjrx4sK/jY1JA9Q6EmYzFcDJLY6V5lFR3buP30sbvaaSqCvt3VootyA5YjT+XS
         RuEw==
X-Gm-Message-State: AOAM5311VXezTNMZSsVDx7MI0yXbHb+G+bKcTgBt67+sr5jYXtpdqSS7
        U+vWlBxGnfFCuE3Fw1k0xCBMQg==
X-Google-Smtp-Source: ABdhPJzSUMezuNv7bpkjEn/XI8YUQ1CK6GKX/FQzONMzc6cBNbORc+UgSt8pse8mcWlt+7+158L+3Q==
X-Received: by 2002:a63:80c8:: with SMTP id j191mr1581944pgd.143.1638309939902;
        Tue, 30 Nov 2021 14:05:39 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:5174:44bd:79e9:4429])
        by smtp.gmail.com with ESMTPSA id i185sm21338927pfg.80.2021.11.30.14.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:05:39 -0800 (PST)
Date:   Tue, 30 Nov 2021 14:05:34 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, chooglen@google.com, avarab@gmail.com
Subject: Re: [PATCH v4] branch: add flags and config to inherit tracking
Message-ID: <YaagLkQOUia7RsYq@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        chooglen@google.com, avarab@gmail.com
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <7ad7507f183332cb2b5fdf2eb76fbbc9dd7199ef.1637085915.git.steadmon@google.com>
 <xmqqbl2hw10h.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqbl2hw10h.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.11.18 14:29, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > I've addressed Glen's feedback from V3. However, this brings up a new
> > issue that was not obvious before: "branch.<name>.merge" can be
> > specified more than once. On the other hand, the existing tracking setup
> > code supports only a single merge entry. For now I'm defaulting to use
> > the first merge entry listed in the branch struct, but I'm curious what
> > people think the best solution would be. This may be another point in
> > favor of Ævar's suggestion to reuse the copy-branch-config machinery.
> 
> Or we can extend "existing tracking setup code" to support multiple
> merge sources.
> 
> How does the "git pull" machinery react to them, by the way?  I
> think the original intention is to support pulling multiple branches
> from the (single) remote configured for the branch with a single
> invocation of "git pull", creating an octopus merge, but does it
> still work, or nobody uses such a crazy curiosity anymore and it was
> once broken and left in non-working state ever since?  What I am
> dreaming here is if we can safely ignore all but one of them, taking
> the usual "last-one-wins" rule, after some transition period.

It does still work and creates an octopus merge. Tested as follows:

$ git clone https://github.com/gitster/git
$ cd git
$ git config pull.rebase false
$ git checkout -b test-branch v2.30.0
$ cat >>.git/config <<EOF
[branch "test-branch"]
	remote = origin
	merge = refs/heads/master
	merge = refs/heads/ab/ambiguous-object-name
	merge = refs/heads/js/scalar
EOF
$ git pull
Fast-forwarding to: 4ef9e1ce4ac4ad79f99f5c5712146254b4cca530
Trying simple merge with 352f8e8fcba4726340c946200149e6285c514fc0
Trying simple merge with abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Simple merge did not work, trying automatic merge.
Auto-merging Makefile
Auto-merging contrib/buildsystems/CMakeLists.txt
Merge made by the 'octopus' strategy.
[...]

$ git cat-file commit HEAD
tree 78bd62c62edfc6e51beb956e548b92b97210ddd4
parent 4ef9e1ce4ac4ad79f99f5c5712146254b4cca530
parent 352f8e8fcba4726340c946200149e6285c514fc0
parent abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
author Josh Steadmon <josh@steadmon.net> 1638309707 -0800
committer Josh Steadmon <josh@steadmon.net> 1638309707 -0800

Merge branches 'ab/ambiguous-object-name', 'js/scalar' and 'master' of https://github.com/gitster/git into test-branch



> > +int parse_opt_tracking_mode(const struct option *opt, const char *arg, int unset) {
> > +	if (unset)
> > +		*(enum branch_track *)opt->value = BRANCH_TRACK_NEVER;
> > +	else if (!arg || !strcmp(arg, "direct"))
> > +		*(enum branch_track *)opt->value = BRANCH_TRACK_EXPLICIT;
> > +	else if (!strcmp(arg, "inherit"))
> > +		*(enum branch_track *)opt->value = BRANCH_TRACK_INHERIT;
> > +	else
> > +		return error(_("option `--track' expects \"direct\" or \"inherit\""));
> 
> According to recent discussion in another thread,
> 
> 	error(_("option '--%s` expects '%s' or '%s'"),
> 		"track", "direct", "inherit");
> 
> would be more translater friendly, as these three words are not
> subject to translation?  I am not sure if it is really worth it,
> though.

I don't really feel strongly either way, so I switched to the more
translatable version. I was originally following some other examples in
the file, where it seemed that most strings that would require more than
one field expansion were just hardcoded instead.
