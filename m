Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FF4C636D6
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 23:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjBGXnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 18:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBGXnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 18:43:09 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1602BEC5
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 15:43:08 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id l12so9423869edb.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 15:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sh/5RfxuA5CtofeNDLPSVDYesgwiWwnSV2BK7dWzn8Y=;
        b=iexCTW3YlK6gR2dXToXQFK53J+5b3sIxYqpXKm3vO2VxIQfbziCUfR7ZDmMtBa2XI6
         MdLM/ZhgWTo4xdllU15xebRe3fMU2NqWjaw0XzLPuOEJe7CDk96pwxpqt5t1LHs24Ahn
         YR0diqLJvs7JAbkglmvdjp7Nhhhy1fYbvVyzIOUWkk/FYbz9FrK0sJUabh93UCzR5Btn
         m1JHbiGfBZrCo2AvTGl7SaNE4hmSLPHdXCML0FJebfgA8fF53AzepCGqdptE0PiBphnr
         4N+WApb9T8RxfsHIOLfC/6KNsge7LZ6ePL+gPE+S3kNnLy/UBy4ZPXutUXRrcKfQylnp
         w2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sh/5RfxuA5CtofeNDLPSVDYesgwiWwnSV2BK7dWzn8Y=;
        b=N9cHdry0cNLlyTbYbft8KCZ4JiX24SXTZrbHq2MyqKwjA5t2A35XCiEG0h+WD5Asrq
         bTxwPyCh40b7LciDIBugh1l+yvW2CZL+FD0TIoHi4rVsNvXN0sd8amLHiAyICsXq86oM
         QAAi6uqDvZQW+HDqOJlbwLIPUI8HZV9rH40QffUr20wVrfyDsbIeiQ67DvKUQL7cts60
         sbgpc6YZD4XP0sWuZtEIV0Rt03OqlBwOtBvUhzY+mlymUeMI/kjnjdWRynho2WKBpr+c
         vPtW3iOrGcm+awURZbLKQpsBq2ivxyy4ANED3z7jK1U9OEejRbYn12eXquuB2146zgj9
         jlkg==
X-Gm-Message-State: AO0yUKWqe9KluZDi8F0z6ageLWGhNoZNZ83dRltq6BMKj3GfVZrwsb40
        HnGLk97HUsqXUwYxDajqhtdKdjBFv7EtHJZ3Z+E=
X-Google-Smtp-Source: AK7set+4SSIc2AsoCEexAHWcuMK0JBDLBHaE6wpOgUy9PpS3b9bxH+yKReAwPuCKB5u5UT7kcjBLvA==
X-Received: by 2002:a05:6402:540f:b0:4aa:b228:eb72 with SMTP id ev15-20020a056402540f00b004aab228eb72mr843815edb.17.1675813386799;
        Tue, 07 Feb 2023 15:43:06 -0800 (PST)
Received: from titov.fritz.box ([181.214.173.18])
        by smtp.gmail.com with ESMTPSA id x91-20020a50bae4000000b0049b58744f93sm5346198ede.81.2023.02.07.15.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 15:43:06 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Paolo Bonzini <pbonzini@redhat.com>,
        Tassilo Horn <tsdh@gnu.org>
Subject: [PATCH v3 2/3] userdiff: support Java record types
Date:   Wed,  8 Feb 2023 00:42:58 +0100
Message-Id: <20230207234259.452141-3-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207234259.452141-1-rybak.a.v@gmail.com>
References: <64601c4b-9ced-672f-a5fd-9a9b3b65859d@kdbg.org>
 <20230207234259.452141-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A new kind of class was added in Java 16 -- records.[1]  The syntax of
records is similar to regular classes with one important distinction:
the name of the record class is followed by a mandatory list of
components.  The list is enclosed in parentheses, it may be empty, and
it may immediately follow the name of the class or type parameters, if
any, with or without separating whitespace.  For example:

    public record Example(int i, String s) {
    }

    public record WithTypeParameters<A, B>(A a, B b, String s) {
    }

    record SpaceBeforeComponents (String comp1, int comp2) {
    }

Support records in the builtin userdiff pattern for Java.  Add "record"
to the alternatives of keywords for kinds of class.

Allowing matching various possibilities for the type parameters and/or
list of the components of a record has already been covered by the
preceding patch.

[1] detailed description is available in "JEP 395: Records"
    https://openjdk.org/jeps/395

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t4018/java-record                         | 6 ++++++
 t/t4018/java-record-space-before-components | 6 ++++++
 t/t4018/java-record-type-parameters         | 6 ++++++
 userdiff.c                                  | 4 ++--
 4 files changed, 20 insertions(+), 2 deletions(-)
 create mode 100644 t/t4018/java-record
 create mode 100644 t/t4018/java-record-space-before-components
 create mode 100644 t/t4018/java-record-type-parameters

diff --git a/t/t4018/java-record b/t/t4018/java-record
new file mode 100644
index 0000000000..97aa819dd8
--- /dev/null
+++ b/t/t4018/java-record
@@ -0,0 +1,6 @@
+public record RIGHT(int comp1, double comp2, String comp3) {
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    static int ChangeMe;
+}
diff --git a/t/t4018/java-record-space-before-components b/t/t4018/java-record-space-before-components
new file mode 100644
index 0000000000..9827f22583
--- /dev/null
+++ b/t/t4018/java-record-space-before-components
@@ -0,0 +1,6 @@
+public record RIGHT (String components, String after, String space) {
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    static int ChangeMe;
+}
diff --git a/t/t4018/java-record-type-parameters b/t/t4018/java-record-type-parameters
new file mode 100644
index 0000000000..f62a035cc8
--- /dev/null
+++ b/t/t4018/java-record-type-parameters
@@ -0,0 +1,6 @@
+public record RIGHT<A, N extends Number>(A comp1, N comp2, int comp3) {
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    static int ChangeMe;
+}
diff --git a/userdiff.c b/userdiff.c
index bc5f3ed4c3..37ac98e177 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -170,8 +170,8 @@ PATTERNS("html",
 	 "[^<>= \t]+"),
 PATTERNS("java",
 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
-	 /* Class, enum, and interface declarations */
-	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+.*)$\n"
+	 /* Class, enum, interface, and record declarations */
+	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface|record)[ \t]+.*)$\n"
 	 /* Method definitions; note that constructor signatures are not */
 	 /* matched because they are indistinguishable from method calls. */
 	 "^[ \t]*(([A-Za-z_<>&][][?&<>.,A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
-- 
2.39.1

