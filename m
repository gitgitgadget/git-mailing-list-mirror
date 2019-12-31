Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C54C2D0C3
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 00:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBBA206DB
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 00:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuD7ZXg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfLaAKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 19:10:00 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38292 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfLaAKA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 19:10:00 -0500
Received: by mail-pg1-f196.google.com with SMTP id a33so18770659pgm.5
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 16:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NPVOlgcDeFREgztCK5gxfQBXkcjwipFedDvloMMZbfI=;
        b=EuD7ZXg5hQ4Tydf7gWPAYwKtTEHoDf7ibmRRqej18G8L6XG03xStpYIaoIkcabC3ys
         oXhYCDWphideagYMc65lwTVne7Fk19Zk5KhoMbHNBd67FkdTSOcKftzpzVapBbnc5gZg
         LrqSSU8wJxUdo/kEaCYhIsObf4TDu2mahz+O+NX15qTvvx/SLKudrBCcolC7MQiqEuVh
         TPijeInkqSMYUWM97O4WeyD8XTt13Vbed9ftB/Y6vueIOrYZ7gfv2KoraEz3r1NZQ0TP
         h//rflfN+3SJ7ciI4LEbcRy/AfIE4nxA14Iz+/SlHSUH65LrGvjMSSAkL7Cp24cc86vL
         DJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NPVOlgcDeFREgztCK5gxfQBXkcjwipFedDvloMMZbfI=;
        b=l0nXkCGUkq70HcHvfcgxjku1zdoDvCjgzz7RDpMs3jMQ8UiKzwwPdmsqtRoFuhWUa9
         mo1XuM5ml4WeW2U8f19wEafjoNCZU01RDDCgoGqsAdam/JtffMsHRvOy127Asv5IsBUM
         kgQEIIEusghAfKgt577gHLcAEsUsaFjAisxoBzPdAbdzUBUlhkHgvcT6EqbK6vigq0pZ
         pbn42KunTtNd0pzocfx+zg6dZ7E7SXUX5l06tsIx1RaYJxXRD30zDmDSDfKwSir4aNMp
         K2XvIyA9UiTAwjiU9howqSLGSm3MvJKreucMdj2OQg2HOJUjjjZj1/b9LJOcbtwlpweW
         ux2Q==
X-Gm-Message-State: APjAAAVcURlbqZ2jkoFhleqMMzu8mpkzBM1rO3jngDk7fWWd3pooRuHd
        JKOYV+uZPJQpWPMivI0rJED3cdth
X-Google-Smtp-Source: APXvYqx7cJdX5MCkpDLbC574LTZ71TpdSUkwVlFjd/o2deDuK4RfveFQELnMa8BdQfIb6m868YSjWA==
X-Received: by 2002:a63:e30a:: with SMTP id f10mr73398681pgh.331.1577750999388;
        Mon, 30 Dec 2019 16:09:59 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id e10sm54819096pfj.7.2019.12.30.16.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 16:09:58 -0800 (PST)
Date:   Mon, 30 Dec 2019 16:09:57 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] revision: allow missing promisor objects on CLI
Message-ID: <20191231000957.GB13606@google.com>
References: <20191228003430.241283-1-jonathantanmy@google.com>
 <20191230234453.255082-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230234453.255082-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> Commit 4cf67869b2 ("list-objects.c: don't segfault for missing cmdline
> objects", 2018-12-06) prevented some segmentation faults from occurring
> by tightening handling of missing objects provided through the CLI: if
> --ignore-missing is set, then it is OK (and the missing object ignored,
> just like one would if encountered in traversal).
>
> However, in the case that --ignore-missing is not set but
> --exclude-promisor-objects is set, there is still no distinction between
> the case wherein the missing object is a promisor object and the case
> wherein it is not. This is unnecessarily restrictive, since if a missing
> promisor object is encountered in traversal, it is ignored; likewise it
> should be ignored if provided through the CLI. Therefore, distinguish
> between these 2 cases. (As a bonus, the code is now simpler.)

nit about tenses, not worth a reroll on its own: "As a bonus, this
makes the code simpler" (since commit messages describe the status quo
before the patch in the present tense).

[...]
> --- a/revision.c
> +++ b/revision.c
> @@ -370,8 +370,18 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
>  		if (!repo_parse_commit(revs->repo, c))
>  			object = (struct object *) c;
>  		else
> +			/*
> +			 * There is something wrong with the commit.
> +			 * repo_parse_commit() will have already printed an
> +			 * error message. For our purposes, treat as missing.
> +			 */
>  			object = NULL;
>  	} else {
> +		/*
> +		 * There is something wrong with the object. parse_object()

If we got here, we are in the !commit case, which is not inherently wrong,
right?  Is the intent something like the following?

	if (oid_object_info(...) == OBJ_COMMIT && !repo_parse_commit(...)) {
		... good ...
	} else if (parse_object(...)) {
		... good ...
	} else {
		/*
		 * An error occured while parsing the object.
		 * parse_commit or parse_object has already printed an
		 * error message.  For our purposes, it's safe to
		 * assume the object as missing.
		 */
		object = NULL;
	}

This might be easiest to understand as a separate mini-function.
Something like

 /*
  * Like parse_object, but optimized by reading commits from the
  * commit graph.
  *
  * If the repository has commit graphs, repo_parse_commit() avoids
  * reading the object buffer, so use it whenever possible.
  */
 static struct object *parse_object_probably_commit(
		struct repository *r, const struct object_id *oid)
 {
	struct commit *c;

	if (oid_object_info(r, oid, NULL) != OBJ_COMMIT)
		return parse_object(r, oid);

	c = lookup_commit(r, oid);
	if (repo_parse_commit(r, c))
		return NULL;
	return (struct object *) c;
 }

 static struct object *get_reference(struct rev_info *revs, ...)
 {
	struct object *object = parse_object_probably_commit(revs->repo, oid);
	if (!object)
		/*
		 * An error occured while parsing the object.
		 * parse_object_probably_commit has already printed an
		 * error message.  For our purposes, it's safe to
		 * assume the object as missing.
		 */
		;

By the way, why doesn't parse_object itself check the commit graph for
commit objects?

[...]
> @@ -1907,7 +1917,18 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
>  		verify_non_filename(revs->prefix, arg);
>  	object = get_reference(revs, arg, &oid, flags ^ local_flags);
>  	if (!object)
> -		return revs->ignore_missing ? 0 : -1;
> +		/*
> +		 * If this object is corrupt, get_reference() prints an error
> +		 * message and treats it as missing.

By "and treats it as missing" does this mean "and we should treat it
as missing"?  (Forgive my ignorance.)

Why do we treat corrupt objects as missing?  Is this for graceful
degredation when trying to recover data from a corrupt repository?

Thanks,
Jonathan
