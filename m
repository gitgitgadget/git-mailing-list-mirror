Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95362CD6115
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 08:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344742AbjJKI1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 04:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjJKI12 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 04:27:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CEA93
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 01:27:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a5836ab12so2414916276.2
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 01:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697012845; x=1697617645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gDFIJbnVzlh+SNbpSxZrHJZC7jJZ2V/dm7fWCiypn+8=;
        b=a+JeSS/Xi/JvHsibOyBHZF5R5DyhOaYnLKmDbx7nshnfwc0zMczvr2DG+xU8f3vGwA
         6wT7djqxNV8ohVbDXvEnZBs9bfx524cIMCOV6MXBTdPF82oKb2hqSN21XkKe4sRl6mp9
         DtFuCIE2lV0biNzAKSwIp+MK9B7EIFz1ckT0cDcaOlZgH7kJMv3dG6T1HjU8erdEjm9j
         kegNswAHfnTvxugoysCRXNnWB1y8YqHrvEBrXi+hfmnT/wXIO4c/b5vINK/AFnACtnfV
         WIPVtL3k4OUzeLIOVfsISe6shRfOvxKyATgDyMuLSH3IlQKLqieWPugiEIvkePZ7+2ZD
         v+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697012845; x=1697617645;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDFIJbnVzlh+SNbpSxZrHJZC7jJZ2V/dm7fWCiypn+8=;
        b=QoIwubTCVe2CQKwRTrIp6kUCH3JXWImg8d8czZCCGOCxlH3aw3wkej3laPZDxTchcZ
         64DVThfwmxnDop+F0YUxSoAIDLvXEa1+Wu/cQM/Sff/4roONUC6rU9z/x2jXDo5goauT
         m8nuDyYEr21E+3JhnTVAs7/RD4M69u8qlo4z2MY1gPjis+LvubPsJ67/NgtO0fcW5OKv
         /qulKCpf9cuUvrNFav6Hj05Kwbty976eBBMH7mYQY6BJIFgjDiJQchTMzR3t8XIhz7Fb
         UdxDLEBkxIZDzKffeqJctypD/mSO9y4fSEMr7mmRk19Q07J58CQ1PCSOnjV9OD5/qO5Q
         o/Xg==
X-Gm-Message-State: AOJu0YzIKYX/x/giDDJysEQwzm9IOYFIyNJFQ8EBH33iF5ywWpwgcrH6
        D8cteWwAAV2ahzYDo6CBqYoElfT1g+fhuMcbJHweoi9cD9GuM53KdisuDm7vm/J4rKakcElzfxA
        N9k2EX3CrgapLzQuHCir7hk2O09kKlpXqWD5vkc+QDyBJWnDndwUwAhVS5ar1Owejan8+
X-Google-Smtp-Source: AGHT+IEXXJQ3kAwh/VsBFim2u6s45RN4fzqqVVaflQPbja6C8zZpiHAk09WGv/5iHLWwyNMmVFTR1OLQw2awKFmI
X-Received: from siddhu.muc.corp.google.com ([2a00:79e0:9c:0:6bc7:72bc:46f9:acd1])
 (user=siddhartth job=sendgmr) by 2002:a25:2403:0:b0:d9a:3a14:a5a2 with SMTP
 id k3-20020a252403000000b00d9a3a14a5a2mr101451ybk.13.1697012845428; Wed, 11
 Oct 2023 01:27:25 -0700 (PDT)
Date:   Wed, 11 Oct 2023 10:27:08 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231011082716.901048-1-siddhartth@google.com>
Subject: [PATCH] t-progress.c : unit tests for progress.c
From:   Siddharth Singh <siddhartth@google.com>
To:     git@vger.kernel.org
Cc:     nasamuffin@google.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests are directly inspired from the tests inside
t/t0500-progress-display.sh

The existing shell tests for the Git progress library only test the output =
of the library, not the correctness of the progress struct fields. Unit tes=
ts can fill this gap and improve confidence that the library works as expec=
ted. For example, unit tests can verify that the progress struct fields are=
 updated correctly when the library is used.

Change-Id: I190522f29fdab9291af71b7788eeee2c0f26282d
Signed-off-by: Siddharth Singh <siddhartth@google.com>
---

Dear Git Community,
As you may be aware, my colleague Josh is proposing a unit testing framewor=
k[1] on the mailing list. I attempted to use the latest version of that ser=
ies to convert t/helper/test-progress.c to unit tests. However, while writi=
ng the tests, I realized that the way progress.c is implemented makes it ve=
ry difficult to test it in units.

Firstly, most unit tests are typically written as a method that takes the e=
xpected output and the actual output of the unit being tested, and compares=
 them for equality. However, because it's intended to print user-facing out=
put on an interactive terminal, progress.c prints everything out to stderr,=
 which makes it difficult to unit test.

As written, a unit test for throughput progress printing would have to capt=
ure stdout from the library and compare it to the expected output, which is=
 difficult to implement and unusual for unit tests anyway.

There are a few ways to work around this issue in my opinion. One way is to=
 modify the library that does not print to output stream and returns the da=
ta to the caller:

static void display(struct progress *progress, uint64_t n, char *done){
=E2=80=A6
}

becomes

struct strbuf display(struct progress *progress,uint64_t n,char *done){
=E2=80=A6
}

Another way is to capture the output from the library into a file instead o=
f stdout and then read it from the file and compare it to the expected outp=
ut, However, this is a difficult task, and I recommend against it.

We may need to make some changes to the way these libraries are implemented=
 in order to make them unit testable in the future.

Therefore, i want to ask if it's worth investing time in developing a solut=
ion?


I look forward to hearing your thoughts on this.
[1] https://lore.kernel.org/git/cover.1692297001.git.steadmon@google.com/



 Makefile                  |   1 +
 t/unit-tests/.gitignore   |   1 +
 t/unit-tests/t-progress.c | 229 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 231 insertions(+)
 create mode 100644 t/unit-tests/t-progress.c

diff --git a/Makefile b/Makefile
index 4016da6e39..eabbfe32cf 100644
--- a/Makefile
+++ b/Makefile
@@ -1335,6 +1335,7 @@ THIRD_PARTY_SOURCES +=3D sha1dc/%
=20
 UNIT_TEST_PROGRAMS +=3D t-basic
 UNIT_TEST_PROGRAMS +=3D t-strbuf
+UNIT_TEST_PROGRAMS +=3D t-progress
 UNIT_TEST_PROGS =3D $(patsubst %,$(UNIT_TEST_DIR)/%$X,$(UNIT_TEST_PROGRAMS=
))
 UNIT_TEST_OBJS =3D $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS)=
)
 UNIT_TEST_OBJS +=3D $(UNIT_TEST_DIR)/test-lib.o
diff --git a/t/unit-tests/.gitignore b/t/unit-tests/.gitignore
index e292d58348..cf5eb4803e 100644
--- a/t/unit-tests/.gitignore
+++ b/t/unit-tests/.gitignore
@@ -1,2 +1,3 @@
 /t-basic
 /t-strbuf
+/t-progress
diff --git a/t/unit-tests/t-progress.c b/t/unit-tests/t-progress.c
new file mode 100644
index 0000000000..437d6acf16
--- /dev/null
+++ b/t/unit-tests/t-progress.c
@@ -0,0 +1,229 @@
+#include "test-lib.h"
+#include "progress.c"
+
+
+static void t_simple_progress()
+{
+	int total =3D 4;
+	struct progress *progress =3D NULL;
+	int i;
+	progress =3D start_progress("Working hard", total);
+	for (i =3D 1; i <=3D total; i++) {
+		display_progress(progress, i);
+		check_uint(i, =3D=3D, progress->last_value);
+		check_str(progress->title, "Working hard");
+		check_int(progress->last_percent, =3D=3D, i * 100 / total);
+	}
+	return;
+}
+
+static void t_simple_progress_percent_text()
+{
+	int total =3D 4;
+	struct progress *progress =3D NULL;
+	int i;
+	char *expected[] =3D {
+		"  0% (0/4)",
+		" 25% (1/4)",
+		" 50% (2/4)",
+		" 75% (3/4)",
+		"100% (4/4)"
+		};
+	char *instructions[] =3D {
+		"progress",
+		"progress",
+		"progress",
+		"progress",
+		"progress"
+	};
+	int value[] =3D {
+		0,
+		1,
+		2,
+		3,
+		4
+	};
+	progress =3D start_progress("Working hard", total);
+	for (i =3D 0; i < 5; i++) {
+		if(strcmp(instructions[i], "progress")=3D=3D0){
+			display_progress(progress, value[i]);
+			check_str(progress->title, "Working hard");
+			check_str(progress->counters_sb.buf, expected[i]);
+			check_uint(i * (100 / total), =3D=3D, progress->last_percent);
+		}
+	}
+	return;
+}
+
+static void t_progress_display_breaks_long_lines_1()
+{
+	int total =3D 100000;
+	struct progress *progress =3D NULL;
+	int i;
+	char *expected[4] =3D {
+		"  0% (100/100000)",
+		"  1% (1000/100000)",
+		" 10% (10000/100000)",
+		"100% (100000/100000)"
+	};
+	char *instructions[] =3D {
+		"progress",
+		"progress",
+		"progress",
+		"progress"
+	};
+	int value[] =3D {
+		100,
+		1000,
+		10000,
+		100000
+	};
+	progress =3D start_progress(
+		"Working hard.......2.........3.........4.........5.........6",
+		total);
+	for (i =3D 0; i < 4; i++) {
+		if(strcmp(instructions[i], "progress")=3D=3D0){
+			display_progress(progress, value[i]);
+		}
+		check_str(progress->title, "Working hard.......2.........3.........4....=
.....5.........6");
+		check_str(progress->counters_sb.buf, expected[i]);
+	}
+	return;
+}
+
+static void t_progress_display_breaks_long_lines_2()
+{
+	int total =3D 100000;
+	struct progress *progress =3D NULL;
+	int i;
+	char *expected[] =3D {
+		"",
+		"  0% (1/100000)",
+		"",
+		"  0% (2/100000)",
+		" 10% (10000/100000)",
+		"100% (100000/100000)"
+	};
+	char *instructions[] =3D {
+		"update",
+		"progress",
+		"update",
+		"progress",
+		"progress",
+		"progress"
+	};
+	int value[] =3D {
+		-1,
+		1,
+		-1,
+		2,
+		10000,
+		100000
+	};
+	progress =3D start_progress(
+		"Working hard.......2.........3.........4.........5.........6",
+		total);
+	for (i =3D 0; i < 5; i++) {
+		if(strcmp(instructions[i], "progress")=3D=3D0){
+			display_progress(progress, value[i]);
+			check_str(progress->title, "Working hard.......2.........3.........4...=
......5.........6");
+			check_str(progress->counters_sb.buf, expected[i]);
+		}else if(strcmp(instructions[i], "update")=3D=3D0){
+			progress_test_force_update();
+		}
+	}
+	return;
+}
+
+static void t_progress_display_breaks_long_lines_3()
+{
+	int total =3D 100000;
+	struct progress *progress =3D NULL;
+	int i;
+	char *expected[4] =3D {
+		" 25% (25000/100000)",
+		" 50% (50000/100000)",
+		" 75% (75000/100000)",
+		"100% (100000/100000)"
+	};
+	char *instructions[] =3D {
+		"progress",
+		"progress",
+		"progress",
+		"progress"
+	};
+	int value[] =3D {
+		25000,
+		50000,
+		75000,
+		100000
+	};
+	progress =3D start_progress(
+		"Working hard.......2.........3.........4.........5.........6",
+		total);
+	for (i =3D 0; i < 4; i++) {
+		if(strcmp(instructions[i], "progress")=3D=3D0){
+			display_progress(progress, value[i]);
+			check_str(progress->title, "Working hard.......2.........3.........4...=
......5.........6");
+			check_str(progress->counters_sb.buf, expected[i]);
+		}else if(strcmp(instructions[i], "update")=3D=3D0){
+			progress_test_force_update();
+		}
+	}
+	return;
+}
+
+
+static void t_progress_shortens_crazy_caller()
+{
+	int total =3D 1000;
+	struct progress *progress =3D NULL;
+	int i;
+	char *expected[4] =3D {
+		" 10% (100/1000)",
+		" 20% (200/1000)",
+		"  0% (1/1000)",
+		"100% (1000/1000)"
+	};
+	char *instructions[] =3D {
+		"progress",
+		"progress",
+		"progress",
+		"progress"
+	};
+	int value[] =3D {
+		100,
+		200,
+		1,
+		1000
+	};
+	progress =3D start_progress(
+		"Working hard.......2.........3.........4.........5.........6",
+		total);
+	for (i =3D 0; i < 4; i++) {
+		if(strcmp(instructions[i], "progress")=3D=3D0){
+			display_progress(progress, value[i]);
+			check_str(progress->title, "Working hard.......2.........3.........4...=
......5.........6");
+			check_str(progress->counters_sb.buf, expected[i]);
+		}else if(strcmp(instructions[i], "update")=3D=3D0){
+			progress_test_force_update();
+		}
+	}
+	return;
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	TEST(t_simple_progress(), "Simple progress upto 3 units");
+	TEST(t_simple_progress_percent_text(),
+	     "Simple progress with percent output");
+	TEST(t_progress_display_breaks_long_lines_1(),
+	     "progress display breaks long lines #1");
+	TEST(t_progress_display_breaks_long_lines_2(),
+	     "progress display breaks long lines #2");
+	TEST(t_progress_display_breaks_long_lines_3(),
+	     "progress display breaks long lines #3");
+	TEST(t_progress_shortens_crazy_caller(),
+	     "progress shortens - crazy caller");
+	return test_done();
+}
--=20
2.40.GIT

