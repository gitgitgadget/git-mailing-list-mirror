Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D97EC2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 08:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F5586141F
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 08:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhFYI7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 04:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFYI7d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 04:59:33 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69808C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 01:57:11 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s15so12353868edt.13
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 01:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=71AR0adomIkYjD/W7ufPKpgyVonSBAJLsEXHf+l6eow=;
        b=LCQyp13xMv82ZLpluAaCydtGqjbO6JKPUP6V9KDCsQt5dDM/DwPSEDD1HKT7OKTnXO
         geqiTUvCf2d2/BwiGxnwk68CkYzvb21YzmkQ16Sj5mqXM9gHDAVC7kpp8mVrCvPSphD6
         mTIXmFpyoVMMNp04rosn75w2e0TTCRgFv+NvvdPP0ymy/WAKm1r8bKO9XaZTs6Eb586G
         0Ogm9S/TRiYqsdXEdK7bzngKtRSP1wGfi2AWJP48WRjwVpFb8IF/GwjHWsaU0isdkosa
         LMPMD0kUidAD9ErwBOY4AsBaSB82WPdvyjN7qvHTPG3NFPKCzT6K5S+dqEP3qNcG3FFV
         Fcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=71AR0adomIkYjD/W7ufPKpgyVonSBAJLsEXHf+l6eow=;
        b=PW9itwjhPT8MIPTNEFThrfAGDUIGTVEw+Q78EW15lBCAW/etbhf70y8cEV9DBh3om9
         pGwbsnxmFRePjaIUqUcku0Pc6I+o+2J3CDAKsn5FbAo9Co2Qt1i6je2A2SbZpPsZXyeb
         bTTpt2UYPbA6DCt/GTU0qVhJgjd+CEEWYdAGS2+CkrHEgKCD9JJjrp0WcpWN+UpXn6I3
         57W4hBorLewTGaEiPY3ps9O/6ErNrXD6sD2fJ/C6O9eMOELzPr86wcFUoX1RZt1V/E+l
         eFbOEaup+sMZiY6ouMiyLWwG1w6U3vzS/wXSerYMX/AKoGfPziAFNOgoNOOSWmuUBbem
         VL9A==
X-Gm-Message-State: AOAM530+/tHJpWKKjqbeOIsJh0LfsJJ7axw1MvZRi6RHZOHkkQ60Eben
        ++lJPNOv9NKU2QXUdGb+KmU=
X-Google-Smtp-Source: ABdhPJyuexELqM6fV5v9sL+Vv33cafI2m1Qo8hVSXgX2JPHKEU+aNrc8gwpj+1QLyc8hTkgG427lLg==
X-Received: by 2002:a05:6402:845:: with SMTP id b5mr12908520edz.266.1624611429712;
        Fri, 25 Jun 2021 01:57:09 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v8sm3414422edc.59.2021.06.25.01.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 01:57:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Why the Makefile is so eager to re-build & re-link
Date:   Fri, 25 Jun 2021 10:34:20 +0200
References: <874kdn1j6i.fsf@evledraar.gmail.com>
 <YNSh0CskelTwuZq0@coredump.intra.peff.net>
 <fb23a23e-13be-14a8-4fbe-5ca2b4bcdb52@kdbg.org>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <fb23a23e-13be-14a8-4fbe-5ca2b4bcdb52@kdbg.org>
Message-ID: <87r1gqxqxn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 24 2021, Johannes Sixt wrote:

> Am 24.06.21 um 17:16 schrieb Jeff King:
>> On Thu, Jun 24, 2021 at 03:16:48PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>>  * {command,config}-list.h (and in-flight, my hook-list.h): Every time
>>>    you touch a Documentation/git-*.txt we need to re-generate these, and
>>>    since their mtime changes we re-compile and re-link all the way up to
>>>    libgit and our other tools.
>>>
>>>    I think the best solution here is to make the generate-*.sh
>>>    shellscripts faster (just one takes ~300ms of nested shellscripting,
>>>    just to grep out the first few lines of every git-*.txt, in e.g. Perl
>>>    or a smarter awk script this would be <5ms).
>>=20
>> Yeah, I think Eric mentioned he had looked into doing this in perl, but
>> we weren't entirely happy with the dependency. Here's another really odd
>> thing I noticed:
>>=20
>>   $ time sh ./generate-cmdlist.sh command-list.txt >one
>>   real	0m1.323s
>>   user	0m1.531s
>>   sys	0m0.834s
>>=20
>>   $ time sh -x ./generate-cmdlist.sh command-list.txt >two
>>   [a bunch of trace output]
>>   real	0m0.513s
>>   user	0m0.754s
>>   sys	0m0.168s
>>=20
>>   $ cmp one two
>>   [no output]
>>=20
>> Er, what? Running with "-x" makes it almost 3 times faster to generate
>> the same output? I'd have said this is an anomaly, but it's repeatable
>> (and swapping the order produces the same output, so it's not some weird
>> priming thing). And then to top it all off, redirecting the trace is
>> slow again:
>>=20
>>   $ time sh -x ./generate-cmdlist.sh command-list.txt >two 2>/dev/null
>>   real	0m1.363s
>>   user	0m1.538s
>>   sys	0m0.902s
>>=20
>> A little mini-mystery that I think I may leave unsolved for now.
>
> Strange, really. Reminds me of the case that the `read` built-in must
> read input byte by byte if stdin is not connected to a (searchable) file.
>
> I have two patches that speed up generate-cmdlist.sh a bit:
>
> generate-cmdlist.sh: replace for loop by printf's auto-repeat feature
> (https://github.com/j6t/git/commit/b6d05f653bede727bc001f299b57969f62d3bc=
03)
> generate-cmdlist.sh: spawn fewer processes
> (https://github.com/j6t/git/commit/fd8721ee8fae06d7b584fa5166f32bf5521ca3=
04)
>
> that I can submit (give me some time, though) or interested parties
> could pick up.

Interesting, but I think rather than micro-optimizing the O(n) loop it
makes more sense to turn it into a series of O(1) in -j parallel,
i.e. actually use the make dependency graph for this as I suggested in:
https://lore.kernel.org/git/87wnqiyejg.fsf@evledraar.gmail.com/

Something like the hacky throwaway patch that follows. Now when you
touch a file in Documentation/git-*.txt you re-make just that file
chain, which gets assembled into the command-list.h:
=09
	$ touch Documentation/git-add.txt; time make -k -j $(nproc) git 2>&1
	GIT_VERSION =3D 2.32.0.94.g87ef2a6b7ed.dirty
	    GEN build/Documentation/git-add.txt.cmdlist.in
	    CC version.o
	    GEN build/Documentation/git-add.txt.cmdlist
	    GEN command-list.h
	    CC help.o
	    AR libgit.a
	    LINK git

Those build/* files are, respectively, the relevant line corresponding
to the *.txt file from command-list.txt:

    $ cat build/Documentation/git-add.txt.cmdlist.in
    git-add                                 mainporcelain           worktree

And then the line we want in command-list.h at the end:

    $ cat build/Documentation/git-add.txt.cmdlist
        { "git-add", N_("Add file contents to the index"), 0 | CAT_mainporc=
elain | CAT_worktree },

The build process in then just a matter of keeping those files
up-to-date, and having "make" create the command-list.h is just a matter
of:

    cat build/Documentation/*.cmdlist

Well, with the categories still being an O(n) affair, but the cost of
generating those is trivial.

I think that aside from optimizing for speed it just makes things
clearer, if you modify e.g. git-add.txt you see a clear chain of output
from make about how we generate output from that, and then make the
command-list.h.

Now we'd just show a mysterious command-list.h entry. Whenever you have
"make" create one file from many it becomes hard to see at a glance
what's going on.

I'd be curious to see what how that performs e.g. on Windows, on Linux I
get e.g. (warm cache):
=09
	$ touch Documentation/git-a*.txt; time make -k -j $(nproc) command-list.h =
2>&1
	    GEN build/Documentation/git-apply.txt.cmdlist.in
	    GEN build/Documentation/git-annotate.txt.cmdlist.in
	    GEN build/Documentation/git-am.txt.cmdlist.in
	    GEN build/Documentation/git-add.txt.cmdlist.in
	    GEN build/Documentation/git-archimport.txt.cmdlist.in
	    GEN build/Documentation/git-archive.txt.cmdlist.in
	    GEN build/Documentation/git-apply.txt.cmdlist
	    GEN build/Documentation/git-annotate.txt.cmdlist
	    GEN build/Documentation/git-am.txt.cmdlist
	    GEN build/Documentation/git-add.txt.cmdlist
	    GEN build/Documentation/git-archimport.txt.cmdlist
	    GEN build/Documentation/git-archive.txt.cmdlist
	    GEN command-list.h
=09
	real    0m0.214s
	user    0m0.196s
	sys     0m0.071s
=09
Doing the same on master takes around 600ms for me at best:
=09
	$ touch Documentation/git-a*.txt; time make -k -j $(nproc) command-list.h =
2>&1
	    GEN command-list.h
=09
	real    0m0.611s
	user    0m0.756s
	sys     0m0.112s

It's even faster when I have to make all of them (my -j is =3D 8), or
around 450ms after a "touch Documentation/git-*.txt".

We have ~170 lines we process in command-list.txt, I'd think on Windows
you'd get much better results, instead of optimizing those number of
"sort | uniq" to the same number of "sort -u" the common case is just
running 1-5 of those, as that's all the *.txt files you changed, then
just "cat-ing" the full set.

diff --git a/.gitignore b/.gitignore
index 311841f9bed..9b365395496 100644
--- a/.gitignore
+++ b/.gitignore
@@ -13,6 +13,7 @@
 /GIT-USER-AGENT
 /GIT-VERSION-FILE
 /bin-wrappers/
+/build/
 /git
 /git-add
 /git-add--interactive
diff --git a/Makefile b/Makefile
index c3565fc0f8f..5e845bd0f69 100644
--- a/Makefile
+++ b/Makefile
@@ -2231,12 +2231,30 @@ config-list.h: Documentation/*config.txt Documentat=
ion/config/*.txt
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh \
 		>$@+ && mv $@+ $@
=20
-command-list.h: generate-cmdlist.sh command-list.txt
+build/Documentation:
+	$(QUIET_GEN)mkdir -p build/Documentation
+.PRECIOUS: build/Documentation/git%.txt.cmdlist.in
+build/Documentation/git%.txt.cmdlist.in: Documentation/git%.txt
+	$(QUIET_GEN)if ! grep -w $(patsubst build/Documentation/%.txt.cmdlist.in,=
%,$@) command-list.txt >$@; \
+	then \
+		# For e.g. git-init-db, which has a *.txt file, but no \
+		# command-list.h entry \
+		>$@; \
+	fi
+build/Documentation/git%.txt.cmdlist: build/Documentation/git%.txt.cmdlist=
.in
+	$(QUIET_GEN)./generate-cmdlist.sh --tail $< >$@
=20
-command-list.h: $(wildcard Documentation/git*.txt)
-	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
+COMMAND_LIST_H_FILES =3D $(filter-out Documentation/git.txt,$(wildcard Doc=
umentation/git*.txt))
+
+COMMAND_LIST_GEN =3D $(patsubst Documentation/%.txt,build/Documentation/%.=
txt.cmdlist,$(COMMAND_LIST_H_FILES))
+command-list.h: build/Documentation generate-cmdlist.sh command-list.txt $=
(COMMAND_LIST_GEN)
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh --header \
 		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
-		command-list.txt >$@+ && mv $@+ $@
+		command-list.txt >$@+ && \
+	echo "static struct cmdname_help command_list[] =3D {" >>$@+ && \
+	cat build/Documentation/*.txt.cmdlist >>$@+ && \
+	echo "};" >>$@+ && \
+	mv $@+ $@
=20
 SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 9dbbb08e70a..f80266d5138 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -1,5 +1,8 @@
 #!/bin/sh
=20
+mode=3D$1
+shift
+
 die () {
 	echo "$@" >&2
 	exit 1
@@ -61,8 +64,6 @@ define_category_names () {
 }
=20
 print_command_list () {
-	echo "static struct cmdname_help command_list[] =3D {"
-
 	command_list "$1" |
 	while read cmd rest
 	do
@@ -73,6 +74,9 @@ print_command_list () {
 		done
 		echo " },"
 	done
+}
+
+end_print_command_list () {
 	echo "};"
 }
=20
@@ -84,6 +88,12 @@ do
 	shift
 done
=20
+if test "$mode" =3D "--tail"
+then
+	print_command_list "$1"
+	exit 0
+fi
+
 echo "/* Automatically generated by generate-cmdlist.sh */
 struct cmdname_help {
 	const char *name;
@@ -94,5 +104,3 @@ struct cmdname_help {
 define_categories "$1"
 echo
 define_category_names "$1"
-echo
-print_command_list "$1"
