Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8262AC636CD
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 23:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjBGXnW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 18:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBGXnK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 18:43:10 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ADB13DC1
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 15:43:09 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id eq11so18313981edb.6
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 15:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LIWKiW7QQxRLQ9r+sdkAt5JGoFAgN4QRG4LmIfEqy0=;
        b=f1XmQxiFOpPwnlUPgh52INwQRmqHukDphNFEIi72U1jbktjuhfBCSVbQlKhNToc/RN
         4jN8rSL/NPBNwELk2oxislaGa1LyZzoqE2Et9jpFiHhz7fTWV+9uqz+2oUn2wgQQ7d4F
         KAe0Ho3+ZxGGqDQUa/EELbJYPXK5x2sokMpwvt/54Pc0irxIL5p9b4zsdDJHA/MXer51
         89rFDG1e1HYu1pVgs3KekgpLs5/8mQ08w9YRSwVWL9e2X/wih+1Pie5QMKcLib4TDzqz
         0sN1BvcUE1yZ76W+NH5gvEudg2vmdfxe8HY5c//xwGC3L7mi2kt6GS24r/sOwmioLMv5
         2LeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LIWKiW7QQxRLQ9r+sdkAt5JGoFAgN4QRG4LmIfEqy0=;
        b=TM2zKN5ghvUwBHZE7IuuNwVNr5LhiaGdbuI9d5UwxwvABjQ/3kdW/lvyEzX4FO5Cme
         b341cbanjhUfzfb7O9xpaZo7qIFZr8OSAzyUNi//t1foQkFLInH7AoO6Bq+uOU9RFnL/
         yVNu+6T+PJpY7xFou2rlUjWyvN9D18d/1VCnx/AmOZNfx7tcmD60++n4tg1XqvG89l4P
         oJVpceyF7iK7M+ZwoYgVMmwrftXi97UPYxzO1sou41rdGKHE9yK6jboSmIVQC1iKTr/z
         wC19HbnK7lBpHdGcOiitJ7GumauoWNR+QCVFmfuVBAQxmyzEIdjCXhNhuooxE1MzLFgP
         de7Q==
X-Gm-Message-State: AO0yUKWoUreo9s3/XLC5E5x//8SsnRfc6O/GYYq+hDRJO4zcnMhVm/CM
        sU+nr7ZubgV1CpFalqJoDCg=
X-Google-Smtp-Source: AK7set9YpSAs/qvMWd5RGMuLIkHT0WprNeYQqru70U5rvI9uEcY+90nJ3L0qePA0Wpn6oWmRFz106w==
X-Received: by 2002:a50:d7cd:0:b0:4a0:af87:b3ab with SMTP id m13-20020a50d7cd000000b004a0af87b3abmr5212214edj.36.1675813387636;
        Tue, 07 Feb 2023 15:43:07 -0800 (PST)
Received: from titov.fritz.box ([181.214.173.18])
        by smtp.gmail.com with ESMTPSA id x91-20020a50bae4000000b0049b58744f93sm5346198ede.81.2023.02.07.15.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 15:43:07 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Paolo Bonzini <pbonzini@redhat.com>,
        Tassilo Horn <tsdh@gnu.org>
Subject: [PATCH v3 3/3] userdiff: support Java sealed classes
Date:   Wed,  8 Feb 2023 00:42:59 +0100
Message-Id: <20230207234259.452141-4-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207234259.452141-1-rybak.a.v@gmail.com>
References: <64601c4b-9ced-672f-a5fd-9a9b3b65859d@kdbg.org>
 <20230207234259.452141-1-rybak.a.v@gmail.com>
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
index 0000000000..069087c1c6
--- /dev/null
+++ b/t/t4018/java-non-sealed
@@ -0,0 +1,8 @@
+public abstract sealed class SealedClass {
+    public static non-sealed class RIGHT extends SealedClass {
+        static int ONE;
+        static int TWO;
+        static int THREE;
+        private int ChangeMe;
+    }
+}
diff --git a/t/t4018/java-sealed b/t/t4018/java-sealed
new file mode 100644
index 0000000000..785fbc62bc
--- /dev/null
+++ b/t/t4018/java-sealed
@@ -0,0 +1,7 @@
+public abstract sealed class Sealed { // RIGHT
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    public final class ChangeMe extends Sealed {
+    }
+}
diff --git a/t/t4018/java-sealed-permits b/t/t4018/java-sealed-permits
new file mode 100644
index 0000000000..18dd4894cf
--- /dev/null
+++ b/t/t4018/java-sealed-permits
@@ -0,0 +1,6 @@
+public abstract sealed class RIGHT permits PermittedA, PermittedB {
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    private int ChangeMe;
+}
diff --git a/t/t4018/java-sealed-type-parameters b/t/t4018/java-sealed-type-parameters
new file mode 100644
index 0000000000..e6530c47c3
--- /dev/null
+++ b/t/t4018/java-sealed-type-parameters
@@ -0,0 +1,6 @@
+public abstract sealed class RIGHT<A, B> {
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    private int ChangeMe;
+}
diff --git a/t/t4018/java-sealed-type-parameters-implements-permits b/t/t4018/java-sealed-type-parameters-implements-permits
new file mode 100644
index 0000000000..bd6e6d3582
--- /dev/null
+++ b/t/t4018/java-sealed-type-parameters-implements-permits
@@ -0,0 +1,6 @@
+public abstract sealed class RIGHT<A, B> implements List<A> permits PermittedA, PermittedB {
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    private int ChangeMe;
+}
diff --git a/t/t4018/java-sealed-type-parameters-permits b/t/t4018/java-sealed-type-parameters-permits
new file mode 100644
index 0000000000..25a0da6442
--- /dev/null
+++ b/t/t4018/java-sealed-type-parameters-permits
@@ -0,0 +1,6 @@
+public abstract sealed class RIGHT<A, B> permits PermittedA, PermittedB {
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    private int ChangeMe;
+}
diff --git a/userdiff.c b/userdiff.c
index 37ac98e177..94cca1a2a8 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -171,7 +171,7 @@ PATTERNS("html",
 PATTERNS("java",
 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
 	 /* Class, enum, interface, and record declarations */
-	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface|record)[ \t]+.*)$\n"
+	 "^[ \t]*(([a-z-]+[ \t]+)*(class|enum|interface|record)[ \t]+.*)$\n"
 	 /* Method definitions; note that constructor signatures are not */
 	 /* matched because they are indistinguishable from method calls. */
 	 "^[ \t]*(([A-Za-z_<>&][][?&<>.,A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
-- 
2.39.1

