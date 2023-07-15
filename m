Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5B3C001B0
	for <git@archiver.kernel.org>; Sat, 15 Jul 2023 18:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjGOSYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jul 2023 14:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjGOSYy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2023 14:24:54 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609AE30E2
        for <git@vger.kernel.org>; Sat, 15 Jul 2023 11:24:51 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-66c729f5618so3125420b3a.1
        for <git@vger.kernel.org>; Sat, 15 Jul 2023 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689445491; x=1692037491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FUa4JcBUMNwA3i4VaQLmu6eBwFIfy+VvuI7KHmGiFmA=;
        b=Ll8YJ9QPSyxKl9mLELTEMvxYMuZae5mHcfMxTwhJnFhKkmcaT+L3ciwP39tYhrHdNF
         9f3rpeUmwC38gy4wiTqE06KrWQtdn92PPuzJ9wRsYbERxWpgBShWeiMlNGnlcaV5vH9g
         BOJWERAO9oaot/XPaOuRDCbfz838+R1qtLZyg6gmdxTTNAYyUH74cKfkWYkKAMlBtYG/
         5KjHhYiGrj7SrB40hUsmrEnkwDtJVBL6sb0GW3BVoVaoHoiVPucfYicRM7mxHBLKnT5U
         dMJ/DHd+bZLSCu7lCUL0drzJH71/wUsXY42v0vvH/rkf5Uf1JdBfuhwlXaohjpNycsEA
         h7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689445491; x=1692037491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUa4JcBUMNwA3i4VaQLmu6eBwFIfy+VvuI7KHmGiFmA=;
        b=LOnqs3CSlSeC5MgrpMdnzvrngp2zXrr4EqvqGjnt84+9BmR1a22w1kwNdP9yCwuqOe
         rhyCuDKjeXIqCj5UdYrzW2B4Q4IcmJW1/xTNqMfe/HvD9VtW5MKCnduOVY36qwYXvgfx
         u8iNwFYVtTqpcjQMnUZ3HsNDYsOnShNfY1FQ5UNHfB59GCNJfzpAPyal4NT9VJyZLInP
         QOpnVuPdY1u3gWnecfE7XzJcbPYruSpNj/2e6rxRsdjcqusv1O9KcGRQ0FUJ6QVvuRYb
         UKmBQik9OOgitBh+KMuycqDJakpLc9CRYPev7FXPdz3h/oo5FqOvS0IYPQc7Sxwz+Ulp
         VxFQ==
X-Gm-Message-State: ABy/qLZHrNFlGjOtU37shZSYvSHqCa4uPx6ookN5w6EGM2W5cmCs9Gfz
        978uQOYoNDjF0fzmKdrqATLvFzavVT5DKg==
X-Google-Smtp-Source: APBJJlFr8fyOv8v9JmqZg/P9YbUngYOX5jElZ+5n++GdnEfX9vEu/+B7KEJ9+JEGbVyBxxiS67KmlQ==
X-Received: by 2002:a05:6a00:22c6:b0:668:79d6:34df with SMTP id f6-20020a056a0022c600b0066879d634dfmr11177070pfj.23.1689445490701;
        Sat, 15 Jul 2023 11:24:50 -0700 (PDT)
Received: from five231003 ([49.37.157.85])
        by smtp.gmail.com with ESMTPSA id i3-20020aa78b43000000b005d22639b577sm9089711pfd.165.2023.07.15.11.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 11:24:50 -0700 (PDT)
Date:   Sat, 15 Jul 2023 23:54:39 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v2 2/3] ref-filter: add new "describe" atom
Message-ID: <ZLLkZ4Vx2quwWwRz@five231003>
References: <20230705175942.21090-1-five231003@gmail.com>
 <20230714194249.66862-1-five231003@gmail.com>
 <20230714194249.66862-3-five231003@gmail.com>
 <xmqqilamnrcr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqilamnrcr.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 14, 2023 at 01:57:40PM -0700, Junio C Hamano wrote:
> Kousik Sanagavarapu <five231003@gmail.com> writes:
> 
> > +		struct {
> > +			enum { D_BARE, D_TAGS, D_ABBREV,
> > +			       D_EXCLUDE, D_MATCH } option;
> > +			const char **args;
> > +		} describe;
> 
> As you parse this into a strvec that has command line options for
> the "git describe" invocation, I do not see the point of having the
> "enum option" in this struct.  The describe->option member seems to
> be unused throughout this patch.
> 
> In fact, a single "const char **describe_args" should be able to
> replace the structure, no?

I kept the enum because I thought it could act as an index for the
describe_opts array. Now that I think about it,

diff --git a/ref-filter.c b/ref-filter.c
index fe4830dbea..df7cb39be2 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -219,9 +219,7 @@ static struct used_atom {
 			enum { EO_RAW, EO_TRIM, EO_LOCALPART } option;
 		} email_option;
 		struct {
-			enum { D_BARE, D_TAGS, D_ABBREV,
-			       D_EXCLUDE, D_MATCH } option;
-			const char **args;
+			const char **decsribe_args;
 		} describe;
 		struct refname_atom refname;
 		char *head;
@@ -533,13 +531,16 @@ static int describe_atom_parser(struct ref_format *format UNUSED,
 				struct used_atom *atom,
 				const char *arg, struct strbuf *err)
 {
-	const char *describe_opts[] = {
-		"",
-		"tags",
-		"abbrev",
-		"match",
-		"exclude",
-		NULL
+	struct {
+		char *optname;
+		enum { D_BARE, D_TAGS, D_ABBREV,
+		       D_MATCH, D_EXCLUDE } option;
+	} describe_opts[] = {
+		{ "", D_BARE },
+		{ "tags", D_TAGS },
+		{ "abbrev", D_ABBREV },
+		{ "match", D_MATCH },
+		{ "exclude", D_EXCLUDE }
 	};
 
 	struct strvec args = STRVEC_INIT;

conveys it better or is it too much unnecessary stuff to and should we
just do

	struct {
		const char **describe_args;
	} describe;

leaving the describe_opts array as is and changing the how the switch is
written.

> > +static int describe_atom_parser(struct ref_format *format UNUSED,
> > +				struct used_atom *atom,
> > +				const char *arg, struct strbuf *err)
> > +{
> > +	const char *describe_opts[] = {
> > +		"",
> > +		"tags",
> > +		"abbrev",
> > +		"match",
> > +		"exclude",
> > +		NULL
> > +	};
> > +
> > +	struct strvec args = STRVEC_INIT;
> > +	for (;;) {
> > +		int found = 0;
> > +		const char *argval;
> > +		size_t arglen = 0;
> > +		int optval = 0;
> > +		int opt;
> > +
> > +		if (!arg)
> > +			break;
> > +
> > +		for (opt = D_BARE; !found && describe_opts[opt]; opt++) {
> > +			switch(opt) {
> > +			case D_BARE:
> > +				/*
> > +				 * Do nothing. This is the bare describe
> > +				 * atom and we already handle this above.
> > +				 */
> > +				break;
> > +			case D_TAGS:
> > +				if (match_atom_bool_arg(arg, describe_opts[opt],
> > +							&arg, &optval)) {
> > +					if (!optval)
> > +						strvec_pushf(&args, "--no-%s",
> > +							     describe_opts[opt]);
> > +					else
> > +						strvec_pushf(&args, "--%s",
> > +							     describe_opts[opt]);
> > +					found = 1;
> > +				}
> 
> As match_atom_bool_arg() and ...
> 
> > +				break;
> > +			case D_ABBREV:
> > +				if (match_atom_arg_value(arg, describe_opts[opt],
> > +							 &arg, &argval, &arglen)) {
> > +					char *endptr;
> > +					int ret = 0;
> > +
> > +					if (!arglen)
> > +						ret = -1;
> > +					if (strtol(argval, &endptr, 10) < 0)
> > +						ret = -1;
> > +					if (endptr - argval != arglen)
> > +						ret = -1;
> > +
> > +					if (ret)
> > +						return strbuf_addf_ret(err, ret,
> > +								_("positive value expected describe:abbrev=%s"), argval);
> > +					strvec_pushf(&args, "--%s=%.*s",
> > +						     describe_opts[opt],
> > +						     (int)arglen, argval);
> > +					found = 1;
> > +				}
> 
> ... match_atom_arg_value() are both silent when they return false,
> we do not see any diagnosis when these two case arms set the "found"
> flag.  Shouldn't we have a corresponding "else" clause to these "if
> (match_atom_blah())" blocks to issue an error message or something?

Yeah, I'll add this.

> [...] 
> Now, is the code from here ...
> 
> > +		if (deref)
> > +			name++;
> > +
> > +		if (!skip_prefix(name, "describe", &name) ||
> > +		    (*name && *name != ':'))
> > +			    continue;
> > +		if (!*name)
> > +			name = NULL;
> > +		else
> > +			name++;
> 
> ... down to here doing anything useful?  After all, you already have
> all you need to describe the commit in atom->u.describe_args to run
> "git describe" with, no?  In fact, after computing "name" with the
> above code with some complexity, nobody even looks at it.
> 
> Perhaps the above was copied from some other grab_* functions; the
> reason why they were relevant there needs to be understood, and it
> also has to be considered if the same reason to have the code here
> applies to this codepath.

Sorry you had to read through this. I'll remove these if constructs,
because as you said, they do nothing since we already parse everything
we need and also check for the type and the deref.

There is not test for "%(*describe)", but I'll add one in v3 if you
think it is necessary (if we are doing this, should we also do one for
multiple options?).

Thanks
