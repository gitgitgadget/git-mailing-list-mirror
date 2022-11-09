Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38589C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 23:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiKIXwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 18:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiKIXwI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 18:52:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D7A642B
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 15:52:07 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s12so610274edd.5
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 15:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=flza0uiKwIAulemoLmUUlD24I3b/ywUBDVhHcYYxJRs=;
        b=a2euq17yR23sq/nC1zlz5Q9Dxz4Fg9qbino88BlB5EGFuc6HG9wOkU9PYbJJ1Le/07
         nXYawlCsufzetr36wa+2+F3MKfEXW7QWIF1JwqeGEX1K+pZYUE2S6iupY89PhWj2oaU2
         j1iFTeMplvwXHcfZ5gkzoM4cJEk27vCCAk4242R8R51ApZOnpevefpYo7MGsRnvm0KaG
         uUbiYZ2yauPDFYS8YDEogs6B+O6iIlcGs2doaTYIL8c44XYEFjDFZ9GGSO5KuaU4nfen
         P4J8J1p7ax125H94JYFCT/qqn1mk0oTNuJEBNu3NkLVe9rON0f4WQdmqM8GsMs18CXCN
         7jIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=flza0uiKwIAulemoLmUUlD24I3b/ywUBDVhHcYYxJRs=;
        b=wcbCgymqjff8U9uKZrlfo6J2MQWYSC0vFQNxu9Cln7528uoe4T1FCpn1lXf8vu+Qa4
         AJrBsLpuSAmGptFaf0QYGF6wrom8f6HDAa6NJJyP5z3+EETLfMt0Ayu1SUf6cFPYGQ8X
         +56fRlZeqGmO1Sb9dM+PGnZ9UA2TKIV9Xl3cADA/5931uOSdfX9KXkXyneAYKegBAWnd
         pdwyAMRTesfVjQHlkN5tNkOFLhxf0+ChE6TxguDz1sjUuIBPJlDvOehizaAII6nYGylP
         0KUUqBdh/VR5Msd2DchDe0nol4pbn6hlyKaqz4TEGEVX5LAfLKp6ApgU6PH4029+Awr1
         ugvw==
X-Gm-Message-State: ACrzQf28Z5c+8WD07xmZlSUriPQS+LvXo0mOU/GrxUNUOeYqIwmK/GpL
        DjP9g5aM7o6vd4EgZmsc+R8=
X-Google-Smtp-Source: AMsMyM6kYTuiWXilJ+uh9R5/0eTpDctcYXgrph6GbSWbzsbKvWYaowywIjQ4GyXkzPisu9usAlCdoA==
X-Received: by 2002:a05:6402:3645:b0:45f:e918:9f35 with SMTP id em5-20020a056402364500b0045fe9189f35mr59548518edb.118.1668037925432;
        Wed, 09 Nov 2022 15:52:05 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id en6-20020a056402528600b0044e937ddcabsm7651059edb.77.2022.11.09.15.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 15:52:05 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osurU-001CI5-1c;
        Thu, 10 Nov 2022 00:52:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <git@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: fix cygwin build failure
Date:   Thu, 10 Nov 2022 00:18:01 +0100
References: <0dec6e1e-207c-be13-ae95-294d9b1e8831@ramsayjones.plus.com>
 <Y2wwfQWrs+KYpWNv@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2wwfQWrs+KYpWNv@nand.local>
Message-ID: <221110.868rkjpty3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 09 2022, Taylor Blau wrote:

> Hi Ramsay,
>
> On Wed, Nov 09, 2022 at 10:46:05PM +0000, Ramsay Jones wrote:
>> Commit 1c97a5043f (Makefile: define "TEST_{PROGRAM,OBJS}" variables
>> earlier, 2022-10-31) breaks the cygwin build, like so:
>
> It seems reasonable to me, and I'd like to pick it up rather quickly (on
> top of =C3=86var's branch), especially if this is going to break things
> downstream in Git for Windows.
>
> =C3=86var: this sort of change is a little tricky to review without more =
diff
> context ;-). Do you have any objections to me slotting this on top of
> your branch?

Yes, I've reviewed this, sorry about missing this edge case. This fix &
analysis looks solid to me (it's still just in "seen", right?)

FWIW I think a more thorough fix for it would be to future-proof this
sort of IMMEDIATE expansion by defining such core variables earlier:

-- >8 --
Subject: [PATCH] Makefile & make "uname" and "$X" available earlier

In [1] I broke the build on Cygwin, because by moving "all::
$(TEST_PROGRAMS)" earlier in the file (around line 800) it was
declared before around line ~1300, where we include
"config.mak.uname", and that's where we'll set "X =3D .exe" on Cygwin
and Windows.

Moving the "all" line down[2] is a more narrow fix for this, but this
attempts to make this sort of thing safer in the future. We'll now
load a "config.mak.uname-early" (really within the first 100 lines of
code, but there's a giant comment at the top).

This ensures that in the future any Makefile rules that have
"IMMEDIATE" expansion (e.g. the RHS of a "rule" will work as expected
if they use $(X), not just if they use the "DEFERRED" expansion (which
e.g. "=3D" assignment uses). See [3] in the GNU make documentation for
details.

1. 1c97a5043f8 (Makefile: define "TEST_{PROGRAM,OBJS}" variables
   earlier, 2022-10-31)
2. https://lore.kernel.org/git/0dec6e1e-207c-be13-ae95-294d9b1e8831@ramsayj=
ones.plus.com/
3. https://www.gnu.org/software/make/manual/html_node/Reading-Makefiles.html

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 Makefile               |  9 ++++++---
 config.mak.uname       |  7 -------
 config.mak.uname-early | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 10 deletions(-)
 create mode 100644 config.mak.uname-early

diff --git a/Makefile b/Makefile
index 4927379184c..e31678e0547 100644
--- a/Makefile
+++ b/Makefile
@@ -621,6 +621,12 @@ TEST_OBJS =3D
 TEST_PROGRAMS_NEED_X =3D
 THIRD_PARTY_SOURCES =3D
=20
+# Binary suffix, set to .exe for Windows builds
+X =3D
+# Make $(uname_*) variables available, and possibly change $X to
+# ".exe" (on Windows)
+include config.mak.uname-early
+
 # Having this variable in your environment would break pipelines because
 # you cause "cd" to echo its destination to stdout.  It can also take
 # scripts to unexpected places.  If you like CDPATH, define it for your
@@ -714,9 +720,6 @@ PROGRAM_OBJS +=3D shell.o
 .PHONY: program-objs
 program-objs: $(PROGRAM_OBJS)
=20
-# Binary suffix, set to .exe for Windows builds
-X =3D
-
 PROGRAMS +=3D $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
=20
 TEST_BUILTINS_OBJS +=3D test-advise.o
diff --git a/config.mak.uname b/config.mak.uname
index d63629fe807..616fa9052e2 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -16,10 +16,6 @@ ifneq ($(findstring MINGW,$(uname_S)),)
 endif
=20
 ifdef MSVC
-	# avoid the MingW and Cygwin configuration sections
-	uname_S :=3D Windows
-	uname_O :=3D Windows
-
 	# Generate and include makefile variables that point to the
 	# currently installed set of MSVC command line tools.
 compat/vcbuild/MSVC-DEFS-GEN: compat/vcbuild/find_vs_env.bat
@@ -238,7 +234,6 @@ ifeq ($(uname_O),Cygwin)
 	NEEDS_LIBICONV =3D YesPlease
 	NO_FAST_WORKING_DIRECTORY =3D UnfortunatelyYes
 	NO_ST_BLOCKS_IN_STRUCT_STAT =3D YesPlease
-	X =3D .exe
 	UNRELIABLE_FSTAT =3D UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES =3D UnfortunatelyNeedsTo
 	MMAP_PREVENTS_DELETE =3D UnfortunatelyYes
@@ -523,7 +518,6 @@ ifndef DEBUG
 else
 	BASIC_CFLAGS +=3D -MDd -DDEBUG -D_DEBUG
 endif
-	X =3D .exe
=20
 compat/msvc.o: compat/msvc.c compat/mingw.c GIT-CFLAGS
 endif
@@ -676,7 +670,6 @@ ifeq ($(uname_S),MINGW)
 	PTHREAD_LIBS =3D
 	RC =3D windres -O coff
 	NATIVE_CRLF =3D YesPlease
-	X =3D .exe
 ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	htmldir =3D doc/git/html/
 	prefix =3D
diff --git a/config.mak.uname-early b/config.mak.uname-early
new file mode 100644
index 00000000000..000d490a506
--- /dev/null
+++ b/config.mak.uname-early
@@ -0,0 +1,33 @@
+# This is mainly used by config.mak.uname-early, but we load it much
+# earlier to get access to $(X).
+
+uname_S :=3D $(shell sh -c 'uname -s 2>/dev/null || echo not')
+uname_M :=3D $(shell sh -c 'uname -m 2>/dev/null || echo not')
+uname_O :=3D $(shell sh -c 'uname -o 2>/dev/null || echo not')
+uname_R :=3D $(shell sh -c 'uname -r 2>/dev/null || echo not')
+uname_P :=3D $(shell sh -c 'uname -p 2>/dev/null || echo not')
+uname_V :=3D $(shell sh -c 'uname -v 2>/dev/null || echo not')
+
+ifneq ($(findstring MINGW,$(uname_S)),)
+	uname_S :=3D MINGW
+endif
+
+ifdef MSVC
+	# avoid the MingW and Cygwin configuration sections in
+	# config.mak.uname
+	uname_S :=3D Windows
+	uname_O :=3D Windows
+endif
+
+
+ifeq ($(uname_S),MINGW)
+	X =3D .exe
+else
+ifeq ($(uname_S),Windows)
+	X =3D .exe
+else
+ifeq ($(uname_O),Cygwin)
+	X =3D .exe
+endif
+endif
+endif
--=20
2.38.0.1467.g709fbdff1a9

