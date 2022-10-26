Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1BBC38A02
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 02:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiJZCrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 22:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiJZCre (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 22:47:34 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0294F57BFD
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 19:47:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id f27so7207565eje.1
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 19:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DbhJlGwZPEkMQxloqkTAJeoDM5Mg6b6yOdsxuWGt0CU=;
        b=X5mAtJLFHW4Ia8smQn09KfuHF6oQn95A9AhuvcM/OijMVoj9LP+wsfTg/VWjQ6Nxmg
         Q3pSOFz4/L1P0ZTkfoR3xILYHDVugepDxiRN0Rxj+Vqhb3hOQhRQphCldbm5tn7vZOkZ
         2ip7ZQtxbTw8KUrCQmEiyxolLx3YR/bFGxUCfBZhzeWxCv5guFbVJ7aLbGQryOQnov9N
         OEfQg3W628S6d+KnvDmq4vc3JotoIwLgArAx9Nfb4RBmkt/xPtPpq5Eg0J/c5h9dfefA
         44vNsdqFo6ITu5STOdhj7X3eiKD09iMaVJZoimjkQk9ZpQA1z4fAd2HKypMRhL0QR0We
         V7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbhJlGwZPEkMQxloqkTAJeoDM5Mg6b6yOdsxuWGt0CU=;
        b=7hoauKPXeAXlgzWgH7Id19e7GnoiFVz/9QLcDA/G6mNAjnb1+QEFZ5XHOqEwXpkugb
         q2B9OQ+9kNcWKFDaGZLxOzj2L5bzo9r26zdmtn7mt5elsgZqAMOHism7PpzK3PBo5Ed+
         CXFdDQXIrKbUu1Zkc0mRtBULn03GqZtb/ufdnGkRcKDdFo4v8ruzp9LaTDyhfkJyq95X
         GTx1/ZgPhTTWNWcxaAle6mPchsiFpc18uJ9v2DnX4RIIGtw2R3/4KJHXeuhCctAEfsQy
         it041qYE1xPcpQ+DRxqVHcK6e/y/OOCrajPgy9FovNqfwSoDyMHKuiorhRoNnn6KorRT
         gg6Q==
X-Gm-Message-State: ACrzQf32ksXjPGNp9d6dSEg09ldUZgA+O7R2e7KTvuNINF84PjZE9Gao
        kPvz8WRS63ZpfEfdGg6sSIE=
X-Google-Smtp-Source: AMsMyM4n/72qjb8xnt1yUSuHIM4XltiVm/cW5fzidEVf1rO8zUWnn1pc0vkEStv/tQkwS05y8kvUCg==
X-Received: by 2002:a17:907:2da5:b0:78e:1208:8783 with SMTP id gt37-20020a1709072da500b0078e12088783mr35700911ejc.743.1666752451008;
        Tue, 25 Oct 2022 19:47:31 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906328d00b00730b3bdd8d7sm2280653ejw.179.2022.10.25.19.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 19:47:30 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1onWS1-008OgX-1q;
        Wed, 26 Oct 2022 04:47:29 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 4/4] Documentation: add lint-fsck-msgids
Date:   Wed, 26 Oct 2022 04:43:32 +0200
References: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
 <20221025224224.2352979-1-gitster@pobox.com>
 <20221025224224.2352979-5-gitster@pobox.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221025224224.2352979-5-gitster@pobox.com>
Message-ID: <221026.867d0ncncu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 25 2022, Junio C Hamano wrote:

> During the initial development of the fsck-msgids.txt feature, it
> has become apparent that it is very much error prone to make sure
> the description in the documentation file are sorted and correctly
> match what is in the fsck.h header file.

I have local fixes for the same issues in the list of advice in our
docs, some of it's missing, wrong, out of date etc.

I tried to quickly adapt the generation script I had for that, which
works nicely, and by line count much shorter than the lint :)

Having to exhaustively list every *.c file that uses fsck.h is a bit of
a bother, but we have the same with the other generated *.h's, so it
shouldn't be too bad.

And this way, if we get it wrong we get a compile error:
=09
	$ git -P diff; make
	diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
	index 7af76ff99a5..f0b4308a6e7 100644
	--- a/Documentation/fsck-msgids.txt
	+++ b/Documentation/fsck-msgids.txt
	@@ -1,6 +1,3 @@
	-`badDate`::
	-       (ERROR) Invalid date format in an author/committer line.
	-
	 `badDateOverflow`::
	        (ERROR) Invalid date value in an author/committer line.
=09=20
	    CC fsck.o
	fsck.c:31:9: error: excess elements in array initializer [-Werror]
	   31 |         { NULL, NULL, NULL, -1 }
	      |         ^
	fsck.c:31:9: note: (near initialization for =E2=80=98msg_id_info=E2=80=99)
	fsck.c: In function =E2=80=98fsck_ident=E2=80=99:
	fsck.c:810:51: error: =E2=80=98FSCK_MSG_BAD_DATE=E2=80=99 undeclared (firs=
t use in this function); did you mean =E2=80=98FSCK_MSG_BAD_NAME=E2=80=99?
	  810 |                 return report(options, oid, type, FSCK_MSG_BAD_DAT=
E, "invalid author/committer line - bad date");
	      |                                                   ^~~~~~~~~~~~~~~~~
	      |                                                   FSCK_MSG_BAD_NAME
	fsck.c:810:51: note: each undeclared identifier is reported only once for =
each function it appears in
	cc1: all warnings being treated as errors
	make: *** [Makefile:2617: fsck.o] Error 1

So, if you're interested:

 Makefile               | 12 ++++++++++++
 fsck.h                 |  8 +-------
 generate-fsckmsgids.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 85f03c6aed1..21bbc3dfb9f 100644
--- a/Makefile
+++ b/Makefile
@@ -860,6 +860,7 @@ REFTABLE_TEST_LIB =3D reftable/libreftable_test.a
 GENERATED_H +=3D command-list.h
 GENERATED_H +=3D config-list.h
 GENERATED_H +=3D hook-list.h
+GENERATED_H +=3D fsck-msgids.h
=20
 .PHONY: generated-hdrs
 generated-hdrs: $(GENERATED_H)
@@ -2289,6 +2290,14 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
=20
+# Unfortunately our dependency management of generated headers used
+# from within other headers suck, so we'll need to list every user of
+# fsck.h here, but not too bad...
+FSCK_MSGIDS_H_BUILTINS =3D fsck index-pack mktag receive-pack unpack-objec=
ts
+$(foreach f,$(FSCK_MSGIDS_H_BUILTINS:%=3Dbuiltin/%),$f.sp $f.s $f.o): fsck=
-msgids.h
+FSCK_MSGIDS_H_LIBS =3D fetch-pack fsck
+$(foreach f,$(FSCK_MSGIDS_H_LIBS),$f.sp $f.s $f.o): fsck-msgids.h
+
 help.sp help.s help.o: command-list.h
 builtin/bugreport.sp builtin/bugreport.s builtin/bugreport.o: hook-list.h
=20
@@ -2333,6 +2342,9 @@ command-list.h: $(wildcard Documentation/git*.txt)
 hook-list.h: generate-hooklist.sh Documentation/githooks.txt
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-hooklist.sh >$@
=20
+fsck-msgids.h: generate-fsckmsgids.sh Documentation/fsck-msgids.txt
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-fsckmsgids.sh >$@
+
 SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):\
 	$(localedir_SQ):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
 	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(PAGER_ENV):\
diff --git a/fsck.h b/fsck.h
index 6fbce68ad67..1a9d68482ea 100644
--- a/fsck.h
+++ b/fsck.h
@@ -2,6 +2,7 @@
 #define GIT_FSCK_H
=20
 #include "oidset.h"
+#include "fsck-msgids.h"
=20
 enum fsck_msg_type {
 	/* for internal use only */
@@ -79,13 +80,6 @@ enum fsck_msg_type {
 	/* ignored (elevated when requested) */ \
 	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
=20
-#define MSG_ID(id, msg_type) FSCK_MSG_##id,
-enum fsck_msg_id {
-	FOREACH_FSCK_MSG_ID(MSG_ID)
-	FSCK_MSG_MAX
-};
-#undef MSG_ID
-
 struct fsck_options;
 struct object;
=20
diff --git a/generate-fsckmsgids.sh b/generate-fsckmsgids.sh
new file mode 100755
index 00000000000..bbf236159aa
--- /dev/null
+++ b/generate-fsckmsgids.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+HT=3D'	'
+
+fsck_list () {
+	sed -n \
+		-e "/::$/ {
+			s/::\$//;
+			s/^\`//;
+			s/\`$//;
+			p;
+		}" \
+	    <Documentation/fsck-msgids.txt
+}
+
+txt2label () {
+	sed \
+		-e 's/\([^_]\)\([[:upper:]]\)/\1_\2/g' \
+		-e 's/^/FSCK_MSG_/' |
+		tr '[:lower:]' '[:upper:]'
+}
+
+fsck_labels () {
+	fsck_list |
+	txt2label
+}
+
+listify () {
+	sed \
+		-e "2,\$s/^/$HT/" \
+		-e 's/$/,/'
+}
+
+cat <<EOF
+/* Automatically generated by generate-fsck-msgids.sh */
+
+enum fsck_msg_id {
+	/* Auto-generated from Documentation/fsck-msgids.txt */
+	$(fsck_labels | listify)
+	FSCK_MSG_MAX
+};
+EOF
