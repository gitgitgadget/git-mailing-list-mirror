Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0802FC433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 09:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344446AbiDAJUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 05:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242965AbiDAJUd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 05:20:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709754DF6D
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 02:18:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id j15so4504563eje.9
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 02:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=5dY+eKwz0/dNIawQxXjd0MeeQO+C2CkdP+316ofmSaA=;
        b=o3wmKRYIZmL1JpTXAUjhyJYGa+8Y/mNqgWAV/dXaIPNUPE1JkBR/r6+zeTrqIEexod
         28/fFVjsdU787jz3jo6rgQAMBbXrxI4t+Sh/CRkt8azHOn93AOmB1IoWFjRH4ZcaTW/g
         KBhFWq1fH0MPK01iCaTx/7pX1ULXskj2uHZ6TexvI6r1bS/0389KQO9Wv9WhAJMuzbZq
         LADNZJUAw5QSV917OQYSV4NhO5xeWwTXC4k0eTSXLKnQkQFgfUd3doxqdKg9W98zK2AI
         wvqIvYtA5BhyUm+3qNVHyzG9zLo9U0Nn0vt4ZKXlBKI7eyW7zq6A9TsXHijSOAkXkj3J
         dCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=5dY+eKwz0/dNIawQxXjd0MeeQO+C2CkdP+316ofmSaA=;
        b=MpFiNuqtA0kXbhkpvA0HCj/1+Rdjj0ViVQ1p9o6IGmdAZ82p47bDix7YQWLVruSda9
         83FKJKGV4c8RT2lejVBGzDQura4fpf1a4Y1opBITrI6cHO2np27tb0wfzP8UulwPsOVJ
         dWwciBA5wjfC9KM68Roiu+sjG2ggvcQ7zqlgxknVkJqP2JALy7lQkuX9Ml0WvCOFSqW/
         IMwNH9V+bQGhEceMxkOmVd2HZ9oZQrZOq1je3dORHkns2UHYDbfA8Vzd3kyhPkZHhZpQ
         rNqPq/u8g5x2b9ZFWCeSzTZdLkX2HEJsNlsDu2gO29nWARfn0hTx1ISNUz3t+VE8oThx
         BYcA==
X-Gm-Message-State: AOAM531mLkNKzrxX0RkV+BZUrfqCjnDlvx9M5pYyEz+An5rrznEtkZ1N
        9CcelXS2t4XnDzEz9U1cx4lqiC6WhYg=
X-Google-Smtp-Source: ABdhPJyKR4UOq4gzUHNT+L99PelIo3kgWTcHh3i2sD0nt6ltaLjWpJfeLykLFoI8GhbVzj31ST1SXw==
X-Received: by 2002:a17:907:c16:b0:6db:682:c8c9 with SMTP id ga22-20020a1709070c1600b006db0682c8c9mr8802768ejc.153.1648804720917;
        Fri, 01 Apr 2022 02:18:40 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id jg15-20020a170907970f00b006e0466dcc42sm797510ejc.134.2022.04.01.02.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 02:18:40 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1naDQV-000ymm-Pb;
        Fri, 01 Apr 2022 11:18:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Garrit Franke <garrit@slashdev.space>, git@vger.kernel.org
Subject: using iwyu (include-what-you-use) to analyze includes (was: [PATCH]
 bisect.c: remove unused includes)
Date:   Fri, 01 Apr 2022 10:07:34 +0200
References: <20220331194436.58005-1-garrit@slashdev.space>
 <xmqqlewpzu7t.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqlewpzu7t.fsf@gitster.g>
Message-ID: <220401.8635ixp3f4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 31 2022, Junio C Hamano wrote:

[Changed $subject to make this easier to find]

> Garrit Franke <garrit@slashdev.space> writes:
>
>> Clean up includes no longer needed by bisect.c.
>>
>> Signed-off-by: Garrit Franke <garrit@slashdev.space>
>> ---
>>  bisect.c | 9 ---------
>>  1 file changed, 9 deletions(-)
>>
>> diff --git a/bisect.c b/bisect.c
>> index 9e6a2b7f20..e07e2d215d 100644
>> --- a/bisect.c
>> +++ b/bisect.c
>> @@ -1,21 +1,12 @@
>> -#include "cache.h"
>
> cf. Documentation/CodingGuidelines
>
> The first #include must be <git-compat-util.h>, or <cache.h> or
> <builtin.h>, which are well known to include <git-compat-util.h>
> first.
>
> Including <git-compat-util.h> indirectly by <config.h> ->
> <hashmap.h> -> <hash.h> -> <git-compat-util.h> does not count.

Also: Some built-ins don't include builtin.h as they should, a fix (or
even basic CI check) for that would be most welcome.

	git grep -C2 -n -F -e builtin.h -e cache.h -e git-compat-util.h -- builtin

I.e. we have this saying a lot of those are redundant:
	
	Documentation/CodingGuidelines- - The first #include in C files, except in platform specific compat/
	Documentation/CodingGuidelines-   implementations, must be either "git-compat-util.h", "cache.h" or
	Documentation/CodingGuidelines:   "builtin.h".  You do not have to include more than one of these.

But maybe it's not worth it, anyway...

>>  #include "config.h"
>> -#include "commit.h"
>
> Other headers may indirectly include <commit.h> as their
> implementation detail, but what matters is that *we* in this source
> file use what <commit.h> gives us ourselves, like the concrete shape
> of "struct commit_list".  This change is not wanted.
>
> I'll stop here.  There may be truly leftover "unused" includes among
> those removed by the remainder of this patch, but I suspect that
> some are like <commit.h> above, i.e. we directly use it, and because
> we do not want to be broken by some header file's implementation
> detail changing, we MUST include it ourselves.
>
> I think this should give us a useful guideline to sift through the
> rest, and an updated patch to remove truly unused ones are very much
> welcome.  We may actually find some we are not directly including
> ourselves but we should (e.g. I do not see <string-list.h> included
> by us, but we clearly use structures and functions declared there,
> and probably is depending, wrongly, on some header file we include
> happens to indirectly include it).

... For anyone interested in pursuing this, I think using the excellent
include-what-you-use tool would be a nice start.

We could even eventually add it to our CI if the false positive rate
isn't bad (I haven't checked much):
https://github.com/include-what-you-use/include-what-you-use

E.g. in this case (I manually omitted the rest of the output, there's
probably a iwyu option to omit it, but I didn't see how do that from
skimming the docs):

	$ sudo apt install iwyu # YMMV
	$ make bisect.o CC=include-what-you-use CFLAGS="-Xiwyu --verbose=1" 2>&1 | grep -v -E -e '^#include <' -e '^#include "(cache|git-compat-util|gettext)\.h"'
	    CC bisect.o
	
	(bisect.h has correct #includes/fwd-decls)
	
	bisect.c should add these lines:
	#include "hash.h"              // for oideq, object_id, oidcmp, oidcpy, GIT_...
	#include "object.h"            // for object, repo_clear_commit_marks
	#include "path.h"              // for GIT_PATH_FUNC, git_pathdup
	#include "pretty.h"            // for CMIT_FMT_UNSPECIFIED, format_commit_me...
	#include "repository.h"        // for repository (ptr only), the_repository
	#include "strbuf.h"            // for strbuf_release, strbuf, strbuf_getline_lf
	#include "string-list.h"       // for string_list_append, string_list_clear
	
	bisect.c should remove these lines:
	- #include "hash-lookup.h"  // lines 9-9
	- struct commit_weight;  // lines 76-76

Then if I patch it as:
	
	diff --git a/bisect.c b/bisect.c
	index 9e6a2b7f201..512430e3cc8 100644
	--- a/bisect.c
	+++ b/bisect.c
	@@ -6,7 +6,6 @@
	 #include "refs.h"
	 #include "list-objects.h"
	 #include "quote.h"
	-#include "hash-lookup.h"
	 #include "run-command.h"
	 #include "log-tree.h"
	 #include "bisect.h"
	@@ -16,6 +15,13 @@
	 #include "commit-reach.h"
	 #include "object-store.h"
	 #include "dir.h"
	+#include "hash.h"
	+#include "object.h"
	+#include "path.h"
	+#include "pretty.h"
	+#include "repository.h"
	+#include "strbuf.h"
	+#include "string-list.h"
	 
	 static struct oid_array good_revs;
	 static struct oid_array skipped_revs;

It's happier, but probably needs to be told to ignore define_commit_slab() somehow:

	$ make bisect.o CC=include-what-you-use CFLAGS="-Xiwyu --verbose=1" 2>&1 | grep -v -E -e '^#include <' -e '^#include "(cache|git-compat-util|gettext)\.h"'
	    CC bisect.o
	
	(bisect.h has correct #includes/fwd-decls)
	
	bisect.c should add these lines:
	
	bisect.c should remove these lines:
	- struct commit_weight;  // lines 82-82

That still needs to be massaged a bit, e.g. we should probably omit
hash.h and anything else in cache.h and git-compat-util.h.

Or maybe not & we should make those headers even lighter. It is rather
annoying that changing some of those things leads to a complete
re-build, but there's a trade-off there where we probably want things
like gettext.h and other used-almost-everywhere headers in included by
those.

So take all the above with a huge grain of salt. I haven't used iwyu
much, but it seems to be something that'll help us go in the direction
Junio noted above.

I think starting with:

	make -k git-objs <the CC etc. params above>

And tackling the "should remove these lines" issues first would be a
good start, e.g. for serve.c it says:
	
	serve.c should remove these lines:
	- #include "cache.h"  // lines 1-1
	- #include "strvec.h"  // lines 6-6

We don't want that first one, but it's right about the second one. It's
been orphaned since f0a35c9ce52 (serve: drop "keys" strvec, 2021-09-15),
I skimmed some of the rist and they all seem like good
suggestions. E.g. lockfile.h for builtin/apply.c, which isn't needed
since 6d058c88264 (apply: move lockfile into `apply_state`, 2017-10-05).
