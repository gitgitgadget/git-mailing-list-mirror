Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 362AE20281
	for <e@80x24.org>; Wed, 24 May 2017 02:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761320AbdEXCaL (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 22:30:11 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36303 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbdEXCaK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 22:30:10 -0400
Received: by mail-pg0-f66.google.com with SMTP id h64so15306422pge.3
        for <git@vger.kernel.org>; Tue, 23 May 2017 19:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A3UcH8PHr3SsXSfnOdxcak1vE/CGzaOTxy89YR+hARI=;
        b=oousGRIfuKTgOihz9zH3ukNIFcukdccBv21B8Ow7jJ+1JoL2aXwVBaLus1bdwoA/+z
         RR2egDzv9v3Tw6Mg/AwFbIqTvahjH0yyrgy7ZQyuP5ZmpfQJBgY3jI4vvGZ9a++BDFMy
         uZkVlrW8oVYNuGVnn52R4EvCy/KAQNHEKtZcLZ4Fb6uumgI4k6Cc1mu4N709GNTxK5gp
         mGApautV98e7D8TdwyGGKfjvHReTbqfjd9Ob+hcST6h8AU/G4Pakezpz9cKOpGRa1no6
         6yB7KLVTfVZIo07b3Nmd3FMYNtXWv8BZHBGk0FqZsG4QHPLHHyFQGoEXXxvDtIgXlPVB
         GptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=A3UcH8PHr3SsXSfnOdxcak1vE/CGzaOTxy89YR+hARI=;
        b=QUi3tO4YWA8lnfiNCfrx9qdJJrs/EqDvT3aCzzYpkp6q7KtVOh6LiV9BWKnHDvpnZ7
         Hi6Lg4CgmVQBUmrXPqvnL7ATJ0PJ5yoYWH8lGEOabiJ1boLrzHaM1J1izpLugltVwCI5
         a0Ud7AOAO++qZc1EugxF71J5eAuI9ehVPSZ+O4a+f4FMz17nBKl+KOSa5p/AHeArwM8k
         JUvAIh9i+YGwQUZ6upoIpBsxoOKbjrtUPcGjr7XNj41BkkNujq6orDHd2qd133GBe3GJ
         L2PjgIm5LJz0hM1G5iFmxfkrVvl6UszR6PcSJpm2DxVilbKBfoNP+5krdqnPRABCCzAE
         jmxA==
X-Gm-Message-State: AODbwcCOZCa3ntoU+sTsn2RWgXGWHo1X4W+dZaZz2Hlh0cWYI0HI8QPq
        v6BtoKuN1XDYnA==
X-Received: by 10.99.125.12 with SMTP id y12mr7384240pgc.5.1495593009497;
        Tue, 23 May 2017 19:30:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:167:7063:293b:a24d])
        by smtp.gmail.com with ESMTPSA id 134sm4196130pgh.43.2017.05.23.19.30.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 19:30:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 05/15] handle_revision_arg: add handle_dotdot() helper
References: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
        <20170519125200.mtpchnyg26re5u4h@sigill.intra.peff.net>
Date:   Wed, 24 May 2017 11:30:07 +0900
In-Reply-To: <20170519125200.mtpchnyg26re5u4h@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 19 May 2017 08:52:00 -0400")
Message-ID: <xmqqinkrhtqo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The handle_revision_arg function is rather long, and a big
> chunk of it is handling the range operators. Let's pull that
> out to a separate helper. While we're doing so, we can clean
> up a few of the rough edges that made the flow hard to
> follow:
>
>   - instead of manually restoring *dotdot (that we overwrote
>     with a NUL), do the real work in a sub-helper, which
>     makes it clear that the munge/restore lines are a
>     matched pair
>
>   - eliminate a goto which wasn't actually used for control
>     flow, but only to avoid duplicating a few lines
>     (instead, those lines are pushed into another helper
>     function)
>
>   - use early returns instead of deep nesting
>
>   - consistently name all variables for the left-hand side
>     of the range as "a" (rather than "this" or "from") and
>     the right-hand side as "b" (rather than "next", or using
>     the unadorned "sha1" or "flags" from the main function).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  revision.c | 177 +++++++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 102 insertions(+), 75 deletions(-)

Nicely done.  Together with [PATCH 04/15] the resulting code wrt ".."
is much easier to follow.

> diff --git a/revision.c b/revision.c
> index dec06ff8b..eb45501fd 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1429,10 +1429,109 @@ static void prepare_show_merge(struct rev_info *revs)
>  	revs->limited = 1;
>  }
>  
> +static int dotdot_missing(const char *arg, char *dotdot,
> +			  struct rev_info *revs, int symmetric)
> +{
> +	if (revs->ignore_missing)
> +		return 0;
> +	/* de-munge so we report the full argument */
> +	*dotdot = '.';
> +	die(symmetric
> +	    ? "Invalid symmetric difference expression %s"
> +	    : "Invalid revision range %s", arg);
> +}
> +
> +static int handle_dotdot_1(const char *arg, char *dotdot,
> +			   struct rev_info *revs, int flags,
> +			   int cant_be_filename)
> +{
> +	const char *a_name, *b_name;
> +	struct object_id a_oid, b_oid;
> +	struct object *a_obj, *b_obj;
> +	unsigned int a_flags, b_flags;
> +	int symmetric = 0;
> +	unsigned int flags_exclude = flags ^ (UNINTERESTING | BOTTOM);
> +
> +	a_name = arg;
> +	if (!*a_name)
> +		a_name = "HEAD";
> +
> +	b_name = dotdot + 2;
> +	if (*b_name == '.') {
> +		symmetric = 1;
> +		b_name++;
> +	}
> +	if (!*b_name)
> +		b_name = "HEAD";
> +
> +	if (get_sha1_committish(a_name, a_oid.hash) ||
> +	    get_sha1_committish(b_name, b_oid.hash))
> +		return -1;
> +
> +	if (!cant_be_filename) {
> +		*dotdot = '.';
> +		verify_non_filename(revs->prefix, arg);
> +		*dotdot = '\0';
> +	}
> +
> +	a_obj = parse_object(a_oid.hash);
> +	b_obj = parse_object(b_oid.hash);
> +	if (!a_obj || !b_obj)
> +		return dotdot_missing(arg, dotdot, revs, symmetric);
> +
> +	if (!symmetric) {
> +		/* just A..B */
> +		b_flags = flags;
> +		a_flags = flags_exclude;
> +	} else {
> +		/* A...B -- find merge bases between the two */
> +		struct commit *a, *b;
> +		struct commit_list *exclude;
> +
> +		a = lookup_commit_reference(a_obj->oid.hash);
> +		b = lookup_commit_reference(b_obj->oid.hash);
> +		if (!a || !b)
> +			return dotdot_missing(arg, dotdot, revs, symmetric);
> +
> +		exclude = get_merge_bases(a, b);
> +		add_rev_cmdline_list(revs, exclude, REV_CMD_MERGE_BASE,
> +				     flags_exclude);
> +		add_pending_commit_list(revs, exclude, flags_exclude);
> +		free_commit_list(exclude);
> +
> +		b_flags = flags;
> +		a_flags = flags | SYMMETRIC_LEFT;
> +	}
> +
> +	a_obj->flags |= a_flags;
> +	b_obj->flags |= b_flags;
> +	add_rev_cmdline(revs, a_obj, a_name, REV_CMD_LEFT, a_flags);
> +	add_rev_cmdline(revs, b_obj, b_name, REV_CMD_RIGHT, b_flags);
> +	add_pending_object(revs, a_obj, a_name);
> +	add_pending_object(revs, b_obj, b_name);
> +	return 0;
> +}
> +
> +static int handle_dotdot(const char *arg,
> +			 struct rev_info *revs, int flags,
> +			 int cant_be_filename)
> +{
> +	char *dotdot = strstr(arg, "..");
> +	int ret;
> +
> +	if (!dotdot)
> +		return -1;
> +
> +	*dotdot = '\0';
> +	ret = handle_dotdot_1(arg, dotdot, revs, flags, cant_be_filename);
> +	*dotdot = '.';
> +
> +	return ret;
> +}
> +
>  int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsigned revarg_opt)
>  {
>  	struct object_context oc;
> -	char *dotdot;
>  	char *mark;
>  	struct object *object;
>  	unsigned char sha1[20];
> @@ -1451,80 +1550,8 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
>  		return -1;
>  	}
>  
> -	dotdot = strstr(arg, "..");
> -	if (dotdot) {
> -		unsigned char from_sha1[20];
> -		const char *next = dotdot + 2;
> -		const char *this = arg;
> -		int symmetric = *next == '.';
> -		unsigned int flags_exclude = flags ^ (UNINTERESTING | BOTTOM);
> -		unsigned int a_flags;
> -
> -		*dotdot = 0;
> -		next += symmetric;
> -
> -		if (!*next)
> -			next = "HEAD";
> -		if (dotdot == arg)
> -			this = "HEAD";
> -		if (!get_sha1_committish(this, from_sha1) &&
> -		    !get_sha1_committish(next, sha1)) {
> -			struct object *a_obj, *b_obj;
> -
> -			if (!cant_be_filename) {
> -				*dotdot = '.';
> -				verify_non_filename(revs->prefix, arg);
> -				*dotdot = '\0';
> -			}
> -
> -			a_obj = parse_object(from_sha1);
> -			b_obj = parse_object(sha1);
> -			if (!a_obj || !b_obj) {
> -			missing:
> -				*dotdot = '.';
> -				if (revs->ignore_missing)
> -					return 0;
> -				die(symmetric
> -				    ? "Invalid symmetric difference expression %s"
> -				    : "Invalid revision range %s", arg);
> -			}
> -
> -			if (!symmetric) {
> -				/* just A..B */
> -				a_flags = flags_exclude;
> -			} else {
> -				/* A...B -- find merge bases between the two */
> -				struct commit *a, *b;
> -				struct commit_list *exclude;
> -
> -				a = lookup_commit_reference(a_obj->oid.hash);
> -				b = lookup_commit_reference(b_obj->oid.hash);
> -				if (!a || !b)
> -					goto missing;
> -				exclude = get_merge_bases(a, b);
> -				add_rev_cmdline_list(revs, exclude,
> -						     REV_CMD_MERGE_BASE,
> -						     flags_exclude);
> -				add_pending_commit_list(revs, exclude,
> -							flags_exclude);
> -				free_commit_list(exclude);
> -
> -				a_flags = flags | SYMMETRIC_LEFT;
> -			}
> -
> -			a_obj->flags |= a_flags;
> -			b_obj->flags |= flags;
> -			add_rev_cmdline(revs, a_obj, this,
> -					REV_CMD_LEFT, a_flags);
> -			add_rev_cmdline(revs, b_obj, next,
> -					REV_CMD_RIGHT, flags);
> -			add_pending_object(revs, a_obj, this);
> -			add_pending_object(revs, b_obj, next);
> -			*dotdot = '.';
> -			return 0;
> -		}
> -		*dotdot = '.';
> -	}
> +	if (!handle_dotdot(arg, revs, flags, revarg_opt))
> +		return 0;
>  
>  	mark = strstr(arg, "^@");
>  	if (mark && !mark[2]) {
