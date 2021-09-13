Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784C8C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF2B60E97
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243292AbhIMP3i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbhIMP3c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:29:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B86C05B9E9
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:31:55 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c21so6856113edj.0
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=+SBkPZKIHovnK2yOwHpJ7GAKOKntR2sA+V6q3MofsD0=;
        b=qS+KBH/heSKtEoYilwfjG99jTw7SjMt8T29WBcj3cxYAzsgEClYfuqy3Daf6m3IF9a
         bmNHQE1h0NxNTJoCEoivg2I0nmmmv0PI6x+o8LxI3Y29L7Hqti+zJYtWNiQfmaRSA4ZU
         6Wij/BYwh0o7iH1ezCqyDVRRwWu+G6vi7sJ4VJsM7YSwwJyf1JtE5LkWzQRV9l2fAoZY
         b3edASxbCFbhke3cvq8p9ZV2R1N6GvEmlUqkF2wpS47UazM8F/wiC8WJByqHCQMx25oa
         N58WW2bjWBNwq7NWI5bbp38eI/LkXYHQYwhz+u2AFiv0KFQEPjkLlh4WAQmmwzAdyBPf
         D6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=+SBkPZKIHovnK2yOwHpJ7GAKOKntR2sA+V6q3MofsD0=;
        b=XHeVI04LChpw7Zisy/Y1YE/CTBm/EbhIZ23W3RGEnPLHg4Kaxnm0qyQ/cIsHODbmrz
         V2vbL+AdmKVyeEd8vV4araZnbMI7JKItUaKMpWYdsNUdeWEabA6YGwkroYbpTXlSgysY
         EnNdWcJbwvAM7eXJIsv6CxYYUiFPRnWxcOuvKsZFU91et5MQWp9bHHSVigQ+fILe2DnO
         ILS4oBQnKkvskMiRhczeygjfoyuHjotIzxm338O+gn3ioxX5CyFHwvs9cytnlj1y6UyL
         bgfEgvDO4xpTmmcppiZbW+TkfPUaHaidY9upuynaaW/9ExfdMbhKQjXjxPoF2v4hxLs1
         WFIQ==
X-Gm-Message-State: AOAM532ARW07Oum+Ev9hDuMxYxS+ocXLYrm5h0jQEJvZnxKy0ogrCLoF
        3dFjM5oq3xZ9wznq/Be5lM8GnSpkCy4C1w==
X-Google-Smtp-Source: ABdhPJz56rJeS16isCqIS3jKboyeK8qeHbSdt5W0nDBjh+OuAbSKV6govJ5o93DKU1K/37POlAvf2Q==
X-Received: by 2002:a05:6402:198:: with SMTP id r24mr13583689edv.93.1631543514063;
        Mon, 13 Sep 2021 07:31:54 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id di4sm4024196edb.34.2021.09.13.07.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 07:31:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 00/15] [RFC] Upstreaming the Scalar command
Date:   Mon, 13 Sep 2021 16:20:40 +0200
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
 <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
 <87r1dydp4m.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <87r1dydp4m.fsf@evledraar.gmail.com>
Message-ID: <87ilz44kdk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 09 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Sep 08 2021, Johannes Schindelin via GitGitGadget wrote:
>
>> Changes since v2:
>>
>>  * Adjusted the description of the list command in the manual page , as
>>    suggested by Bagas.
>>  * Addressed two style nits in cmd_run().
>>  * The documentation of git reconfigure -a was improved.
>>
>> Changes since v1:
>>
>>  * A couple typos were fixed
>>  * The code parsing the output of ls-remote was made more readable
>>  * The indentation used in scalar.txt now consistently uses tabs
>>  * We no longer hard-code core.bare =3D false when registering with Scal=
ar
>
> In the summary I had on v1->v2 points 1-3 are for v2->v3, respectively,
> outstanding, addressed, outstanding:
>
>     https://lore.kernel.org/git/877dfupl7o.fsf@evledraar.gmail.com/
>
> In addition the discussion ending here:
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2109082112270.55@tvgsbejvaq=
bjf.bet/
>
> For that point: I think it's fair enough not to properly handle the
> cleanup case in "scalar clone", but perhaps add a note in the commit
> message that unlike "git clone" this is known not to clean after itself
> properly on ctrl+c?

Seeing [1] about the planned re-roll I have the above a shot a few days
ago, see the original discussion at [2] (indirectly linked above).

The dependency graph isn't quite there yet, but I basically had it
working (some twiddling around adding a new top-level command name
needed). Result:
=20=20=20=20
     .gitignore             |  1 +
     Documentation/Makefile |  4 ++++
     Makefile               | 27 +++++++++++++++++++++++++++
     3 files changed, 32 insertions(+)

And by comparison, your v3:
=20=20=20=20
     Makefile                  |  8 +++++
     contrib/scalar/.gitignore |  5 +++
     contrib/scalar/Makefile   | 57 ++++++++++++++++++++++++++++++++++
     contrib/scalar/t/Makefile | 78 +++++++++++++++++++++++++++++++++++++++=
++++++++
     4 files changed, 148 insertions(+)

So that's a very pleasing reduction in complexity.

The WIP change for that is below, some oddities like the
s/scalarscalar/scalar/ (couldn't find the bit that generated that
built-in blurb at the time).

But for one the automatic lint integration in Documentation/ found one
nit, and "make test" etc. all work with this automatically.

All guarded behind a CONTRIB_SCALAR flag, so the end result isn't in any
way different.

Again, as pointed out in [2] the proposal isn't in any way to change
what an end user sees, just to make our build system less
complex. Stretching dependency graphs across Makefiles is a pain.

So just as an example I was improving the "sparse" and "hdr-check"
targets today, with this dropped into the main Makefile under a flag
stuff like that will Just Work, if it's under its own Makefile
infrastructure it'll need to be treated specially for every such change,
ditto "make TAGS" etc.

1. http://lore.kernel.org/git/nycvar.QRO.7.76.6.2109131531210.55@tvgsbejvaq=
bjf.bet;
2. https://lore.kernel.org/git/87mtoxwt63.fsf@evledraar.gmail.com/

diff --git a/.gitignore b/.gitignore
index 311841f9bed..491cb2177af 100644
--- a/.gitignore
+++ b/.gitignore
@@ -216,6 +216,7 @@
 /configure
 /.vscode/
 /tags
+/scalar
 /TAGS
 /cscope*
 /compile_commands.json
diff --git a/Documentation/Makefile b/Documentation/Makefile
index f5605b7767f..f0a03faf40f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -19,6 +19,10 @@ MAN1_TXT +=3D git.txt
 MAN1_TXT +=3D gitk.txt
 MAN1_TXT +=3D gitweb.txt
=20
+ifdef CONTRIB_SCALAR
+MAN1_TXT +=3D scalar.txt
+endif
+
 # man5 / man7 guides (note: new guides should also be added to command-lis=
t.txt)
 MAN5_TXT +=3D gitattributes.txt
 MAN5_TXT +=3D githooks.txt
diff --git a/Makefile b/Makefile
index 429c276058d..7407df45b2a 100644
--- a/Makefile
+++ b/Makefile
@@ -584,6 +584,7 @@ FUZZ_OBJS =3D
 FUZZ_PROGRAMS =3D
 GIT_OBJS =3D
 LIB_OBJS =3D
+NONGIT_PROGRAM_OBJS =3D
 OBJECTS =3D
 PROGRAM_OBJS =3D
 PROGRAMS =3D
@@ -691,10 +692,17 @@ PROGRAM_OBJS +=3D shell.o
 .PHONY: program-objs
 program-objs: $(PROGRAM_OBJS)
=20
+ifdef CONTRIB_SCALAR
+NONGIT_PROGRAM_OBJS +=3D scalar.o
+endif
+.PHONY: nongit-program-objs
+nongit-program-objs: $(NONGIT_PROGRAM_OBJS)
+
 # Binary suffix, set to .exe for Windows builds
 X =3D
=20
 PROGRAMS +=3D $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
+PROGRAMS +=3D $(patsubst %.o,%$X,$(NONGIT_PROGRAM_OBJS))
=20
 TEST_BUILTINS_OBJS +=3D test-advise.o
 TEST_BUILTINS_OBJS +=3D test-bitmap.o
@@ -800,6 +808,9 @@ BINDIR_PROGRAMS_NEED_X +=3D git-receive-pack
 BINDIR_PROGRAMS_NEED_X +=3D git-shell
 BINDIR_PROGRAMS_NEED_X +=3D git-upload-archive
 BINDIR_PROGRAMS_NEED_X +=3D git-upload-pack
+ifdef CONTRIB_SCALAR
+BINDIR_PROGRAMS_NEED_X +=3D scalar
+endif
=20
 BINDIR_PROGRAMS_NO_X +=3D git-cvsserver
=20
@@ -1247,6 +1258,10 @@ else
 ALL_COMMANDS_TO_INSTALL +=3D git-receive-pack$(X)
 ALL_COMMANDS_TO_INSTALL +=3D git-upload-archive$(X)
 ALL_COMMANDS_TO_INSTALL +=3D git-upload-pack$(X)
+
+ifdef CONTRIB_SCALAR
+ALL_COMMANDS_TO_INSTALL +=3D scalar$(X)
+endif
 endif
=20
 ALL_CFLAGS =3D $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS)
@@ -2459,6 +2474,7 @@ git-objs: $(GIT_OBJS)
=20
 OBJECTS +=3D $(GIT_OBJS)
 OBJECTS +=3D $(PROGRAM_OBJS)
+OBJECTS +=3D $(NONGIT_PROGRAM_OBJS)
 OBJECTS +=3D $(TEST_OBJS)
 OBJECTS +=3D $(XDIFF_OBJS)
 OBJECTS +=3D $(FUZZ_OBJS)
@@ -2582,6 +2598,9 @@ compat/nedmalloc/nedmalloc.sp compat/nedmalloc/nedmal=
loc.o: EXTRA_CPPFLAGS =3D \
 compat/nedmalloc/nedmalloc.sp: SP_EXTRA_FLAGS +=3D -Wno-non-pointer-null
 endif
=20
+ifdef CONTRIB_SCALAR
+# TODO: Implicit rule for git-scalar here
+endif
 git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(=
LIBS)
=20
@@ -2596,6 +2615,11 @@ git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GI=
TLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
=20
+ifdef CONTRIB_SCALAR
+scalar: scalar.o $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(=
LIBS)
+endif
+
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	$(QUIET_LNCP)$(RM) $@ && \
 	ln $< $@ 2>/dev/null || \
@@ -2800,6 +2824,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo SHELL_PATH=3D\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@+
 	@echo TEST_SHELL_PATH=3D\''$(subst ','\'',$(TEST_SHELL_PATH_SQ))'\' >>$@+
 	@echo PERL_PATH=3D\''$(subst ','\'',$(PERL_PATH_SQ))'\' >>$@+
+	@echo CONTRIB_SCALAR=3D\''$(subst ','\'',$(subst ','\'',$(CONTRIB_SCALAR)=
))'\' >>$@+
 	@echo DIFF=3D\''$(subst ','\'',$(subst ','\'',$(DIFF)))'\' >>$@+
 	@echo PYTHON_PATH=3D\''$(subst ','\'',$(PYTHON_PATH_SQ))'\' >>$@+
 	@echo TAR=3D\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@+
@@ -2881,6 +2906,8 @@ bin-wrappers/%: wrap-for-bin.sh
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
 	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubs=
t git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
+	sed -e 's|scalarscalar|scalar|' <$@ >$@+ && \
+	mv $@+ $@ && \
 	chmod +x $@
