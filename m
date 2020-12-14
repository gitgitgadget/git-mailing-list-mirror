Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646A0C2BB48
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 12:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20891206FB
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 12:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406164AbgLNMj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 07:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395114AbgLNMjn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 07:39:43 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355B8C0613D3
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 04:39:03 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id w1so17546295ejf.11
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 04:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=bQIooA1O1XgKc5ZtuD1oQOUUhKCIovdrMxy3gUeKdrg=;
        b=EeggMwznwouoDwta6O1VvV/Auj41d4akhnj4xn8Xda+tmiCLlc6rF4FhBQnynsZ3Ha
         ptYQH4TU4FNpkH65Ju5bGtbSEdytUoKz39+RjmS+zpnTwGIRpovrKEDKX+TVqXvp2kNn
         lN4YCy1zKEpZzosYzaRD+T6UXJjjpFJ1CaxlC0yTJ5szU/LIPa/5i+VH8l5dSeKZ2w1K
         dBy5y9EGMU+zS1AkYew0Znw/aJJWl5TPEzHRRClyplw70yGEMwzv/1jzgBPHRkMKzCUe
         vZnj1qBZHmznH1jo4kiFFPfTxxjadEKGzOsOKmX/fDGyzNcxnpjQTImu3d24lN0vZmYT
         kdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=bQIooA1O1XgKc5ZtuD1oQOUUhKCIovdrMxy3gUeKdrg=;
        b=MZ52dgZUxXNo+YBmOoaf6HhF/wG70LWAHaC/2v6nAgHb2pNfirG2HXPKy+7ocbYTu8
         U+qhDqzloubld+wS/YL7lX6beRpvBzK24PYFGKEi2LMUzw3E/bEhWjgDXtwZvEcN7CRU
         IZb5niOCMI/OSfOjeVVxUvkrE6oHAP2xgNxh2f7b6fTkY3gB33YYIob4qiqvtuxSgf7e
         IBfqe2znQL2kFnHJhVNNU++Qaugj3fUcPalvytenlzh0HRYUesdhCTVjkoKi9NoXx3tK
         u64AdwLIDPieKagYsWlg74VuahdqPPBg46jW+YFa8FilIWfH2dmWpD8vXRHb/ly6tsE+
         qRgA==
X-Gm-Message-State: AOAM531fjbZhRj4PkkPNtL2FspEI1dHyrA+PLq3tto1Nmb+lUXBn+Y8R
        AyRClcjznAfsn0XEqnO1HTB9ZrAytxZOSg==
X-Google-Smtp-Source: ABdhPJyMLmQDT2ULJjHdqgkBQzatu58XonkZtLnAYtd7B9vS9XSErEbVkgy6Xz9EJmpqMadpN9Z/Xw==
X-Received: by 2002:a17:906:2984:: with SMTP id x4mr4749916eje.239.1607949541605;
        Mon, 14 Dec 2020 04:39:01 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id cf17sm15194554edb.16.2020.12.14.04.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 04:39:01 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] mailmap: support hashed entries in mailmaps
References: <20201213010539.544101-1-sandals@crustytoothpaste.net>
 <20201213010539.544101-2-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <20201213010539.544101-2-sandals@crustytoothpaste.net>
Date:   Mon, 14 Dec 2020 12:54:13 +0100
Message-ID: <87eejswql6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 13 2020, brian m. carlson wrote:

> Many people, through the course of their lives, will change either a
> name or an email address.  For this reason, we have the mailmap, to map
> from a user's former name or email address to their current, canonical
> forms.  Normally, this works well as it is.
>
> However, sometimes people change a name or an email address and wish to
> wholly disassociate themselves from that former name or email address.
> For example, a person may have left a company which engaged in a deeply
> unethical act with which the person does not want to be associated, or
> they may have changed their name to disassociate themselves from an
> abusive family or partner.  In such a case, using the former name or
> address in any way may be undesirable and the person may wish to replace
> it as completely as possible.
>
> [...]
>
> Note that it is, of course, possible to perform a lookup on all commit
> objects to determine the actual entry which matches the hashed form of
> the data.

The commit message & cover letter are subtly different in a way that I
didn't even notice at first glance. E.g. I assume based on the cover
letter that one part of this this is a proposed solution do the whole
"deadname" problem. It would be nice if v2 were more explicit and
attempted to explicitly summarize the use-cases in the commit message.

But for now I'll attempt to read between the lines from having read
both.

I don't understand why either the problem of "I don't want to see my old
name again" or "I want to hide from other abusive people" (as an aside:
but not so much that you'd still take the risk of submitting a patch to
.mailmap?) require a hashing solution, as opposed to just some encoding
in the .mailmap file such as base64.

You can still trivially get the same information in the end, on git.git
running --pretty=format:"%aN %aE %an %ae" takes under a second. A part
of your commit message seems to address this:

> However, a project for which this feature is valuable may
> simply insert entries for many contributors in order to make discovery
> of "interesting" entries significantly less convenient.

But I don't get how that's helped at all by a sha256 hash. Since you can
trivially re-expand these again using log/check-mailmap the hashing
offers no extra protection beyond a trivial layer of obscurity in those
cases. You'd get the same safety in numbers by having everything a large
un-hashed .mailmap file, would you not?

I think the underlying use-case is legitimate, but I read it as
primarily a social signaling feature by a trivial addition of
obscurity. Someone called X would like not to be called Y anymore, or
not be found in a search engine or "git grep" when searching for "Y".

So I'd think purely from the perspective of the feature's appearance to
users matching its underlying security we'd be better served with
support for encoding of some sort. E.g. URL encoding, Base64, or even
just string_reverse() (ROT13 is out as not working for non-ASCII names).

The encoding versions of this have the added bonus of expanding the
use-case beyond what you're suggesting. If you're trying to map e.g. a
non-UTF-8 E-Mail address (in your project due to some encoding error)
you'd be able to put it into .mailmap without making the project
maintainers deal with invalid non-UTF-8 encoding in the file (the
existing support is sufficient to map names in most such cases).

Another reason I'd prefer some encoding solution is because .mailmap
isn't just used by git itself. Since the format got added it's become
how a lot of downstream systems do this mapping. E.g. I worked once on a
change management system that mapped lots of user actions across
different systems, and piggy-backed on .mailmap files in git to resolve
E-Mail addresses even in cases where the originating data wasn't within
git.

Now because of the trivialness of the format it's easy to e.g. import it
into a DB table and do a JOIN against it (or the same after converting
it from some trivial encoding). Use-cases like that would become a full
history walk for each project to extract the real E-Mails (or a re
implementation of the SHA256 trick in some sub-SELECT in the database).

Those are all solvable problems that are rather trivial in the end. I
just wonder if we're not making things needlessly hard to achieve the
stated aims. And to be fair, most of those aims I inferred (and might
have incorrectly inferred), since as noted above the patch itself
doesn't discuss the tradeoffs of potential alternate solutions).

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  mailmap.c          | 39 +++++++++++++++++++++++++++++++++++++--
>  t/t4203-mailmap.sh | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 2 deletions(-)
>
> [...]
>
>  int map_user(struct string_list *map,
>  	     const char **email, size_t *emaillen,
>  	     const char **name, size_t *namelen)
> @@ -324,7 +359,7 @@ int map_user(struct string_list *map,
>  		 (int)*namelen, debug_str(*name),
>  		 (int)*emaillen, debug_str(*email));
>  
> -	item = lookup_prefix(map, *email, *emaillen);
> +	item = lookup_one(map, *email, *emaillen);
>  	if (item != NULL) {
>  		me = (struct mailmap_entry *)item->util;
>  		if (me->namemap.nr) {
> @@ -334,7 +369,7 @@ int map_user(struct string_list *map,
>  			 * simple entry.
>  			 */
>  			struct string_list_item *subitem;
> -			subitem = lookup_prefix(&me->namemap, *name, *namelen);
> +			subitem = lookup_one(&me->namemap, *name, *namelen);
>  			if (subitem)
>  				item = subitem;
>  		}

If you turn on DEBUG_MAILMAP=1 at the top of the file and run e.g. an
unbounded --pretty=format=:%aE you can see we'll call map_user() in a
loop for each commit shown. What I'm suggesting above can be read as
"can't we have some solution that achieves the same aims, but which we
can handle purely in add_mapping()?". Both for our case, and for
external parsers/re-implementations.

In any case it would be interesting if v2 amended
t/perf/p4205-log-pretty-formats.sh to test e.g. the impact of linux.git
with all-sha256 entries to see what the cost in the tight loop could be.
