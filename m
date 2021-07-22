Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD4EC63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 08:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 793DE61285
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 08:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhGVHnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 03:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhGVHnh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 03:43:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6808AC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 01:24:12 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dp20so7174109ejc.7
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 01:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ZO01F9IR4UibNM3vx+PA1hGUTR8b6/bDrcSfn7MeOfE=;
        b=i+uoUrWsWnaFRoUywuaAeFh61u4CUROijo36dpcu2/opI6lERrIGdBT0aD6w5oFEn1
         AO5UE9UeZUaYuIhPNTPnbVmR4tNcYu2Yh2nTKkaE5QFvbDE6N+1Yt98jQDw2A/LhC5Cx
         q0VUBmujJi+w8K2GyXAEtLY5CO/ALuLy3ppiD8zgQZJsw9dOF/MD8ltISZ5hzIkZSAi5
         ngFNnjAyKMUOPSOXdzj+ItjEVyGeqnOUE2W3srV6y0Pc2NHaNmrY6AyePTnblnPv9pWx
         TaxWqd2rGOA74gOcWGE5i7HkkQx0kzA15ne5QJxInvy1uxhZjlEF96L98xvYNh2peG5I
         nnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ZO01F9IR4UibNM3vx+PA1hGUTR8b6/bDrcSfn7MeOfE=;
        b=sHWeWeFpf861/UPW2SAyOzlxEyYuY+fTpCjaYwduk2LMyE1DI8YIlGbx6gmKuaxu1s
         DukV40pOvo50km0tVrWCgAOiG6nJ2CHs3AMJNtFxP6Ya0CK29R0DOkrjWLrr7XM7Sl0C
         uxR9HQiwyIqOo9HbrGheXDP2MaYLQ8pEhWXiHAt6FYYL0GnyD9Qf7c24RTgrY/cQGRUa
         YkXNVYAIZlOvQp55X+eQMjFfssKSwBMefgaRsW39PTWwZHeTnJAlyM4sS+MBeAFGLaxH
         ZAel4twUNZ+r+0Iwu5wfCevUtB5MYFghmOQoZkzsXn7rFkTT9SWddpE0ZMbFtk1DDCS0
         Jxfg==
X-Gm-Message-State: AOAM531Jch/emelD7NtVyiRoEG3qagsfgA11yS3Q88UvOHlRswBYzhmg
        F45h5v3K0qGIA7OYd3n1hI2wD4jrFZYV+Q==
X-Google-Smtp-Source: ABdhPJzTiSROadyXrFP5tWeGJXtx4OMEcvKCGt1MxAyconRXKNP3NXu7B9f/oqnN+qsE5BmdLceHxw==
X-Received: by 2002:a17:907:1003:: with SMTP id ox3mr42189891ejb.123.1626942250736;
        Thu, 22 Jul 2021 01:24:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v13sm9125819ejh.62.2021.07.22.01.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 01:24:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 5/5] [GSOC] ref-filter: add %(rest) atom
Date:   Thu, 22 Jul 2021 10:11:02 +0200
References: <pull.1000.git.1626939557.gitgitgadget@gmail.com>
 <75eb2f6740eb5845afcb7d31956cc5b3e3957f97.1626939557.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <75eb2f6740eb5845afcb7d31956cc5b3e3957f97.1626939557.git.gitgitgadget@gmail.com>
Message-ID: <874kcmvjr6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 22 2021, ZheNing Hu via GitGitGadget wrote:


> +		} else if (atom_type == ATOM_REST) {
> +			if (ref->rest)
> +				v->s = xstrdup(ref->rest);
> +			else
> +				v->s = xstrdup("");
> +			continue;
>  		} else
>  			continue;

Another light reading nit, maybe more readable as:

    } else if (atom_type == ATOM_REST && ref->rest) {
        ...
    } else if (atom_type == ATOM_REST) {
        ...
    }
    continue;

But we can't do that "continue" at the end because there's two cases
where we don't continue, I wondered if elimanting that special case
would make it easier, patch below. Probably not worth it & feel free to
ignore:

 ref-filter.c | 63 +++++++++++++++++++++++++-----------------------------------
 1 file changed, 26 insertions(+), 37 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 81e77b13ad2..189244fed6f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1890,18 +1890,26 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			name++;
 		}
 
-		if (atom_type == ATOM_REFNAME)
+		if (atom_type == ATOM_REFNAME) {
 			refname = get_refname(atom, ref);
-		else if (atom_type == ATOM_WORKTREEPATH) {
-			if (ref->kind == FILTER_REFS_BRANCHES)
-				v->s = get_worktree_path(atom, ref);
+			if (!deref)
+				v->s = xstrdup(refname);
 			else
-				v->s = xstrdup("");
-			continue;
-		}
-		else if (atom_type == ATOM_SYMREF)
+				v->s = xstrfmt("%s^{}", refname);
+			free((char *)refname);
+		} else if (atom_type == ATOM_WORKTREEPATH &&
+			   ref->kind == FILTER_REFS_BRANCHES) {
+			v->s = get_worktree_path(atom, ref);
+		} else if (atom_type == ATOM_WORKTREEPATH) {
+			v->s = xstrdup("");
+		} else if (atom_type == ATOM_SYMREF) {
 			refname = get_symref(atom, ref);
-		else if (atom_type == ATOM_UPSTREAM) {
+			if (!deref)
+				v->s = xstrdup(refname);
+			else
+				v->s = xstrfmt("%s^{}", refname);
+			free((char *)refname);
+		} else if (atom_type == ATOM_UPSTREAM) {
 			const char *branch_name;
 			/* only local branches may have an upstream */
 			if (!skip_prefix(ref->refname, "refs/heads/",
@@ -1916,7 +1924,6 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 				fill_remote_ref_details(atom, refname, branch, &v->s);
 			else
 				v->s = xstrdup("");
-			continue;
 		} else if (atom_type == ATOM_PUSH && atom->u.remote_ref.push) {
 			const char *branch_name;
 			v->s = xstrdup("");
@@ -1935,10 +1942,8 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			/* We will definitely re-init v->s on the next line. */
 			free((char *)v->s);
 			fill_remote_ref_details(atom, refname, branch, &v->s);
-			continue;
 		} else if (atom_type == ATOM_COLOR) {
 			v->s = xstrdup(atom->u.color);
-			continue;
 		} else if (atom_type == ATOM_FLAG) {
 			char buf[256], *cp = buf;
 			if (ref->flag & REF_ISSYMREF)
@@ -1951,24 +1956,20 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 				*cp = '\0';
 				v->s = xstrdup(buf + 1);
 			}
-			continue;
 		} else if (!deref && atom_type == ATOM_OBJECTNAME) {
 			   v->s = xstrdup(do_grab_oid("objectname", &ref->objectname, atom));
-			   continue;
+		} else if (atom_type == ATOM_HEAD &&
+			   atom->u.head &&
+			   !strcmp(ref->refname, atom->u.head)) {
+			v->s = xstrdup("*");
 		} else if (atom_type == ATOM_HEAD) {
-			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
-				v->s = xstrdup("*");
-			else
-				v->s = xstrdup(" ");
-			continue;
+			v->s = xstrdup(" ");
 		} else if (atom_type == ATOM_ALIGN) {
 			v->handler = align_atom_handler;
 			v->s = xstrdup("");
-			continue;
 		} else if (atom_type == ATOM_END) {
 			v->handler = end_atom_handler;
 			v->s = xstrdup("");
-			continue;
 		} else if (atom_type == ATOM_IF) {
 			const char *s;
 			if (skip_prefix(name, "if:", &s))
@@ -1976,29 +1977,17 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			else
 				v->s = xstrdup("");
 			v->handler = if_atom_handler;
-			continue;
 		} else if (atom_type == ATOM_THEN) {
 			v->handler = then_atom_handler;
 			v->s = xstrdup("");
-			continue;
 		} else if (atom_type == ATOM_ELSE) {
 			v->handler = else_atom_handler;
 			v->s = xstrdup("");
-			continue;
+		} else if (atom_type == ATOM_REST && ref->rest) {
+			v->s = xstrdup(ref->rest);
 		} else if (atom_type == ATOM_REST) {
-			if (ref->rest)
-				v->s = xstrdup(ref->rest);
-			else
-				v->s = xstrdup("");
-			continue;
-		} else
-			continue;
-
-		if (!deref)
-			v->s = xstrdup(refname);
-		else
-			v->s = xstrfmt("%s^{}", refname);
-		free((char *)refname);
+			v->s = xstrdup("");
+		}
 	}
 
 	for (i = 0; i < used_atom_cnt; i++) {
