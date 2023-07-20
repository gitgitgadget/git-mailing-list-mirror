Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FD8EB64DA
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 16:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjGTQxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 12:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjGTQw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 12:52:58 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A7892
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 09:52:57 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b9b427b4fcso817806a34.3
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 09:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689871977; x=1690476777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Kr8Ody8NqUPFBQ1fPO8TkABOyC1WrohOdPGyjgK3rs=;
        b=g8YtdGEF8FTyqrqR5dgtm0CSnsk5r+7FNxLBCAWc/3uCuHRYuH9i7TehDSWPquvttY
         XXCYPVx+87HSjdv7sT+6DZejl8pK9uv7L5auSFy+sm7QykVvnYpe7bPZLQJ5cMXyH8W6
         I/ttDLad4hrfiOImAfLgijDPLKxFMQaf8HL0FxKOiZVb1TwiafARlc3DYbm9/FW5JAzn
         YElLC5bPRQ0GJNRU8ghX6Nd0A9Om1749WRd596UV++67cGme4zOL6lWEt+lV1M56k+wl
         hH2TzAiUJTWwL/evRlkiKm/Y89XUak9cWX0UTmNtIeA/GSrGNmxKwqZa2nef7zqbVO0x
         O8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689871977; x=1690476777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Kr8Ody8NqUPFBQ1fPO8TkABOyC1WrohOdPGyjgK3rs=;
        b=ifjHNl4k7jD79/DbwBbMlFK91yRwVTbwbEVCAkHAEO8GW4orY36if/8HOFWOP6ew/i
         39ptfg5fg8tcT6OOIolRrMbL7M4byhjexkWpcA8HP32/0DaXvT6DHKgwZxMULyIVZMWJ
         xfvTzCM0R+HLVQa4JTi1ebiXMX//q7cp+o9GinLeUp2C/ctcULiZ92vgtcQmzLFzPUo5
         dDTKPj0Mb3UBvyrQwXV5ba8qg/DLEQ51qetZqYoSNvHOIEN2aKk1TxPHjcwrVKxmO6bq
         K8GadUNMVkc5d1LVKOPjcOZDdlDtUbArTt1DEHBKOuUng48a6hLR6ltWFjSFuTwKWc9k
         mF5A==
X-Gm-Message-State: ABy/qLYNRodRV8VTV36I2+tEQxTWfNA0JInUrC6U3gHj+dOUeS5EqDDP
        xNK7nqkJYddt+NFT2TvKLJDViJ18MNagbihD
X-Google-Smtp-Source: APBJJlH1IpKAxefrjnePoByHZy/9sWTqJFipyKFXaRtM+GcpGzKjZfChMAAGLtfjtCD0QCrMgFJcTA==
X-Received: by 2002:a05:6358:c02:b0:133:a55:7e26 with SMTP id f2-20020a0563580c0200b001330a557e26mr10454129rwj.7.1689871976585;
        Thu, 20 Jul 2023 09:52:56 -0700 (PDT)
Received: from five231003 ([49.37.157.181])
        by smtp.gmail.com with ESMTPSA id t10-20020a63954a000000b005634bd81331sm1430511pgn.72.2023.07.20.09.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 09:52:56 -0700 (PDT)
Date:   Thu, 20 Jul 2023 22:22:44 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Siddharth Singh <siddhartth@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 1/2] ref-filter: add multiple-option parsing functions
Message-ID: <ZLlmXNt2crTEIXLg@five231003>
References: <20230714194249.66862-1-five231003@gmail.com>
 <20230719162424.70781-1-five231003@gmail.com>
 <20230719162424.70781-2-five231003@gmail.com>
 <xmqqjzuv5vvg.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzuv5vvg.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 19, 2023 at 04:23:15PM -0700, Junio C Hamano wrote:
> Kousik Sanagavarapu <five231003@gmail.com> writes:
> 
> >  ref-filter.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> 
> New helper functions that do not have any caller and no
> documentation to explain how they are supposed to be called
> (i.e. the expectation on the callers---what values they need to feed
> as parameters when they call these helpers, and the expectation by
> the callers---what they expect to get out of the helpers once they
> return) makes it impossible to evaluate if they are any good [*].
> 
> 	Side note.  Those of you who are keen to add unit tests to
> 	the system (Cc:ed) , do you think a patch line this one that
> 	adds a new helper function to the system, would benefit from
> 	being able to add a few unit tests for these otherwise
> 	unused helper functions?
> 
> 	The calls to the new functions that the unit test framework
> 	would make should serve as a good piece of interface
> 	documentation, showing what the callers are supposed to pass
> 	and what they expect, I guess.
> 
> 	So whatever framework we choose, it should allow adding a
> 	test or two to this patch easily, without being too
> 	intrusive.  Would that be a good and concrete evaluation
> 	criterion?
> 
> Anyway, because of that, I had to read [2/2] first and then come
> back here to review this one.
> 
> The following is my attempt to write down the contract between the
> callers and this new helper function---please give something like
> that to the final version.  The the example below is there just to
> illustrate the level of information that would be desired to help
> future readers and programmers.  Do not take the contents as-written
> as truth---I may have (deliberately) mixed in incorrect descriptions
> ;-).

I'll spot them---if there are any ;).

> 
> /*
>  * The string "to_parse" is expected to be a comma-separated list
>  * of "key" or "key=val".  If your atom allows "key1" and "key2"
>  * (possibly with their values) as options, make two calls to this
>  * funtion, passing "key1" in candiate and then passing "key2" in
>  * candidate.
>  *
>  * The function Returns true ONLY when the to_parse string begins
>  * with the candidate key, possibly followed by its value (valueless
>  * key-only entries are allowed in the comman-separated list).
>  * Otherwise, *end, *valuestart and *valuelen are LEFT INTACT and
>  * the function returns false.
>  *
>  * *valuestart will point at the byte after '=' (i.e. the beginning
>  * of the value), and the number of bytes in the value will be set
>  * to *valuelen.
>  * A key-only entry results in *valuestart set to NULL and *valuelen
>  * set to 0.
>  * *end will point at the next key[=val] in the comma-separated list
>  * or NULL when the list ran out.
>  */
> 
> > +static int match_atom_arg_value(const char *to_parse, const char *candidate,
> > +				const char **end, const char **valuestart,
> > +				size_t *valuelen)
> > +{
> > +	const char *atom;
> > +
> > +	if (!(skip_prefix(to_parse, candidate, &atom)))
> > +		return 0;
> > +	if (valuestart) {
> 
> As far as I saw, no callers pass NULL to valuestart.  Getting rid of
> this if() statement and always entering its body would clarify what
> is going on, I think.
> 
> > +		if (*atom == '=') {
> > +			*valuestart = atom + 1;
> > +			*valuelen = strcspn(*valuestart, ",\0");
> > +			atom = *valuestart + *valuelen;
> > +		} else {
> > +			if (*atom != ',' && *atom != '\0')
> > +				return 0;
> > +			*valuestart = NULL;
> > +			*valuelen = 0;
> > +		}
> > +	}
> > +	if (*atom == ',') {
> > +		*end = atom + 1;
> > +		return 1;
> > +	}
> > +	if (*atom == '\0') {
> > +		*end = atom;
> > +		return 1;
> > +	}
> > +	return 0;
> > +}
> 
> /*
>  * Write something similar to document the contract between the caller
>  * and this function here.
>  */
> > +static int match_atom_bool_arg(const char *to_parse, const char *candidate,
> > +				const char **end, int *val)
> > +{

I'll make these changes in the re-rolled version. I've also read your
reply to this email with the changes in `match_atom_arg_value()`. I'll
add them too.

Going off in a tangent here---In yesterday's review club which discussed
the %(decorate:<options>) patch[1], Glen suggested the possibility of
having a single kind of a framework (used this word very loosely here)
for parsing these multiple options since we are beginning to see them so
often (might also help new formats which maybe added in the future). The
fact that this wasn't done already says something about its difficulty
as Jacob mentioned yesterday. The difficulty being we don't exactly know
which options to parse as they differ from format to format.

Christian, Hariom and I had a similar discussion about refactoring these
helper functions that are already there in pretty (`match_placeholder_*()`)
so that they can be used here.

One example of this usage of functions from pretty is done when making
ref-filter support trailers.

[1]: https://lore.kernel.org/git/20230715160730.4046-1-andy.koppe@gmail.com/

Thanks
