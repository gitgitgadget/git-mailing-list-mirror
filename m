Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B15C63797
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 23:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjBCXXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 18:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjBCXXu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 18:23:50 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776AFA58DC
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 15:23:47 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id n6so6595458edo.9
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 15:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wj7nxpqbORoWXgKXiDDlC/dI2+jyuhxeXNPC7Or10Zw=;
        b=BbiSGgSKFMRUXZ/2EcLl43ZdyxmYsFkXkOnckoyHcFY2hWO8QP1Ua+NFRTe/JR5ZOu
         vTiKsayneH33tb12YaAmY+aFwjPaDUhPossPnL5312JedAPzbwZWYOagc+zJEqON1aC4
         hhtetgZFZMft4t1l3fdllTJDy6wgX8Pr4IpiX2WHOn3d95rcD6qAhOx2tjN4Tzc/u2Gh
         j3JzLui78kHBAscDZAe4tbVq81YJUxzCRE8JUy7n0dQJmI0+/SMHjCXfeS9dVnnXxnB6
         xOYqpTwq/V0Lyeh6LBLfeGlZ6aPi8p3mlF+gdZQiIMsNvpRpEGHemsB2skGCSFNn4C7l
         hoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wj7nxpqbORoWXgKXiDDlC/dI2+jyuhxeXNPC7Or10Zw=;
        b=U6bKVtQmEetEr/R8DlKM+Qo0VQnX3r14/V1AdR0enrPtKvS2NuKOlf16YOmxScRWgP
         NSpAg8mz4Gg6bM5LWI/VV5iTRITF0+THPK4z+tS/TAX4SzGL8oBYsDSl21BLVeW4chlj
         0mNOC0KSl56RfLJB9k/jzxfXkYKpozYM/T0V/6mmRY8nQjCjRfXTa2w+i+3hWCm8+oam
         bxR0ayelY/KKfNehAYUWjOikgd+I0ya56ZpMtPnIA5PQazrt5OlyAK+7weAq9ST8hOGf
         L0xtCpUIge3XtE/5d98Qti3N1U1xD+JKZvUoGF8LOgtqwT5l8/Errxj1BHYJz0dnld8C
         DQMg==
X-Gm-Message-State: AO0yUKXkJExsAVwzUHtLY4SVpqxe32rYQFZeXhvmbT9HVBn5H+hGclpT
        jwZ2pJ2c3xbcKL1sFL+Ue6nb4mBNmprrT0f1DUM=
X-Google-Smtp-Source: AK7set9hal6Gut2Wqczo+ilvitcHBGDXOpt964JuEGBkW4Z4Hxof+qgs/f4gtdEpS4IdFj4AJH6Trw==
X-Received: by 2002:a05:6402:448c:b0:4a0:e31a:434 with SMTP id er12-20020a056402448c00b004a0e31a0434mr12120944edb.27.1675466625681;
        Fri, 03 Feb 2023 15:23:45 -0800 (PST)
Received: from titov.fritz.box ([216.24.213.52])
        by smtp.gmail.com with ESMTPSA id u4-20020aa7db84000000b0049f88f00f70sm1787917edt.7.2023.02.03.15.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 15:23:45 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Paolo Bonzini <pbonzini@redhat.com>,
        Johannes Sixt <j6t@kdbg.org>, Tassilo Horn <tsdh@gnu.org>
Subject: [PATCH v1 3/3] userdiff: support Java sealed classes
Date:   Sat,  4 Feb 2023 00:23:39 +0100
Message-Id: <20230203232339.216592-4-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230203232339.216592-1-rybak.a.v@gmail.com>
References: <20230203232339.216592-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A new kind of class was added in Java 17 -- sealed classes.[1]  This
feature includes several new keywords that may appear in a declaration
of a class.  New modifiers before name of the class: "sealed" and
"non-sealed", and a clause after name of the class marked by keyword
"permits".

The current set of regular expressions in userdiff.c already allows the
modifier "sealed" and the "permits" clause, but not the modifier
"non-sealed", which is the first hyphenated keyword in Java.[2]  Allow
hyphen in the words that precede the name of type to match the
"non-sealed" modifier.

In new input file "java-sealed" for the test t4018-diff-funcname.sh, use
a Java code comment for the marker "RIGHT".  This workaround is needed,
because the name of the sealed class appears on the line of code that
has the "ChangeMe" marker.

[1] Detailed description in "JEP 409: Sealed Classes"
    https://openjdk.org/jeps/409
[2] "JEP draft: Keyword Management for the Java Language"
    https://openjdk.org/jeps/8223002

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t4018/java-non-sealed                                | 8 ++++++++
 t/t4018/java-sealed                                    | 7 +++++++
 t/t4018/java-sealed-permits                            | 6 ++++++
 t/t4018/java-sealed-type-parameters                    | 6 ++++++
 t/t4018/java-sealed-type-parameters-implements-permits | 6 ++++++
 t/t4018/java-sealed-type-parameters-permits            | 6 ++++++
 userdiff.c                                             | 2 +-
 7 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 t/t4018/java-non-sealed
 create mode 100644 t/t4018/java-sealed
 create mode 100644 t/t4018/java-sealed-permits
 create mode 100644 t/t4018/java-sealed-type-parameters
 create mode 100644 t/t4018/java-sealed-type-parameters-implements-permits
 create mode 100644 t/t4018/java-sealed-type-parameters-permits

diff --git a/t/t4018/java-non-sealed b/t/t4018/java-non-sealed
new file mode 100644
index 0000000000..f68ffd4ff3
--- /dev/null
+++ b/t/t4018/java-non-sealed
@@ -0,0 +1,8 @@
+public sealed abstract class SealedClass {
+    public static non-sealed class RIGHT extends SealedClass {
+        static int ONE;
+        static int TWO;
+        static int THREE;
+        private int ChangeMe;
+    }
+}
diff --git a/t/t4018/java-sealed b/t/t4018/java-sealed
new file mode 100644
index 0000000000..e722fee803
--- /dev/null
+++ b/t/t4018/java-sealed
@@ -0,0 +1,7 @@
+public sealed abstract class Sealed { // RIGHT
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    public final class ChangeMe extends Sealed {
+    }
+}
diff --git a/t/t4018/java-sealed-permits b/t/t4018/java-sealed-permits
new file mode 100644
index 0000000000..8573f2a7e8
--- /dev/null
+++ b/t/t4018/java-sealed-permits
@@ -0,0 +1,6 @@
+public sealed abstract class RIGHT permits PermittedA, PermittedB {
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    private int ChangeMe;
+}
diff --git a/t/t4018/java-sealed-type-parameters b/t/t4018/java-sealed-type-parameters
new file mode 100644
index 0000000000..ec31115961
--- /dev/null
+++ b/t/t4018/java-sealed-type-parameters
@@ -0,0 +1,6 @@
+public sealed abstract class RIGHT<A, B> {
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    private int ChangeMe;
+}
diff --git a/t/t4018/java-sealed-type-parameters-implements-permits b/t/t4018/java-sealed-type-parameters-implements-permits
new file mode 100644
index 0000000000..9fd4dd5633
--- /dev/null
+++ b/t/t4018/java-sealed-type-parameters-implements-permits
@@ -0,0 +1,6 @@
+public sealed abstract class RIGHT<A, B> implements List<A> permits PermittedA, PermittedB {
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    private int ChangeMe;
+}
diff --git a/t/t4018/java-sealed-type-parameters-permits b/t/t4018/java-sealed-type-parameters-permits
new file mode 100644
index 0000000000..6af2352e46
--- /dev/null
+++ b/t/t4018/java-sealed-type-parameters-permits
@@ -0,0 +1,6 @@
+public sealed abstract class RIGHT<A, B> permits PermittedA, PermittedB {
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    private int ChangeMe;
+}
diff --git a/userdiff.c b/userdiff.c
index f92b3029aa..040deb7439 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -171,7 +171,7 @@ PATTERNS("html",
 PATTERNS("java",
 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
 	 /* Class, enum, and interface declarations */
-	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface|record)[ \t]+[A-Za-z][A-Za-z0-9_$]*([ \t]+|[<(]).*)$\n"
+	 "^[ \t]*(([a-z-]+[ \t]+)*(class|enum|interface|record)[ \t]+[A-Za-z][A-Za-z0-9_$]*([ \t]+|[<(]).*)$\n"
 	 /* Method definitions; note that constructor signatures are not */
 	 /* matched because they are indistinguishable from method calls. */
 	 "^[ \t]*(([A-Za-z_<>&][][?&<>.,A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
-- 
2.39.1

