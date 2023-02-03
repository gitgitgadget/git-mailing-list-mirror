Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2D1C61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 23:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjBCXXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 18:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjBCXXt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 18:23:49 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCC0A56C9
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 15:23:45 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cw4so6552415edb.13
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 15:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2gJN58XYrIXV6frkqmIifi2QOO4FjIp8US0PDm+Bnc=;
        b=VEG9ewht7/XOQbkbMH8x1Htq4YDApkfSHXIYKvHUbyDDKiODS38PdEZVDH+zT1/c3R
         XCHkKY5+ypZvJ1Ot8lAszcosTn0NDTzUT7ADQOhMRZtL6zNP73oJ7NQc5PNwLbmoiCYJ
         MdeawHAeRG5u68lNZX6s5pohfqnXhyjZXFcvrkkO/l3TjU3vM3HRqjZwCWRkJP2RzrN9
         Q3eSTx+Nfn4nSgqnStOn8dPIuIs+AOqUvev6AcNUmpp6W5KlAkuSxedaTjduGE32UHfO
         G+wtIkRYjmlpy6LvqKc3BPMnCi34fAshMvHMvWUtn4DGyuY6M/pAdsptkP5TFeIJcDLk
         dDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2gJN58XYrIXV6frkqmIifi2QOO4FjIp8US0PDm+Bnc=;
        b=zWltOSovSjH0VISVtz7j1Dr2ssfl1++wR2SjhO1tBsE8BJ1Wid/kI0B74O5ehKN8I0
         xy7Uk2Ik6NQ3mCOD5bq/Q193qkMGaRBAZGAD1Y5OtCc5JlNckA0TxBxgdIAwDsEbeH1j
         WTO2nfpIxZe0SjZtlSKL4s5LmX8CPIPuN6kLR3olIFEMEenNMmvRqR3Zv66rCyJwB+aG
         FGKAaVcily3tBem7dYxRsRCMcQhHPh+UcgTQD2JDgHr4FeWfBVRorQFItUw3ofreaJv/
         /mjBCweFfLQiPH9zKz1FKXx3E0ANyTdwOtxIW3vZ+7GRV6hYVDVlI3V0FE+kCYIGFD3O
         D7Ow==
X-Gm-Message-State: AO0yUKVWhymVk5FDUv+sIdaGcjYtvU1A8nGbKKVDJS+AFkmcOFfJuseC
        yHYITxuEnpmZ6WPUTprIwOCI0LrLMgdalb2YBzA=
X-Google-Smtp-Source: AK7set9rMvuhzMWsXeR47fKKh5gjuBFhxBuyJtENAI7oeQctZC2HvIXLIlXiL9vRh/B1utPDF2A3Hw==
X-Received: by 2002:a05:6402:1c87:b0:499:376e:6b35 with SMTP id cy7-20020a0564021c8700b00499376e6b35mr9804676edb.25.1675466623418;
        Fri, 03 Feb 2023 15:23:43 -0800 (PST)
Received: from titov.fritz.box ([216.24.213.52])
        by smtp.gmail.com with ESMTPSA id u4-20020aa7db84000000b0049f88f00f70sm1787917edt.7.2023.02.03.15.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 15:23:42 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Paolo Bonzini <pbonzini@redhat.com>,
        Johannes Sixt <j6t@kdbg.org>, Tassilo Horn <tsdh@gnu.org>
Subject: [PATCH v1 1/3] userdiff: support Java type parameters
Date:   Sat,  4 Feb 2023 00:23:37 +0100
Message-Id: <20230203232339.216592-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230203232339.216592-1-rybak.a.v@gmail.com>
References: <20230203232339.216592-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A class or interface in Java [1] can have type parameters immediately
following the name in the declaration, surrounded by angle brackets
(paired less than and greater than signs).[2]  Example of a class with
type parameters "A" and "N":

    public class ParameterizedClass<A, N> {
        private A field1;
        private N field2;
    }

Support matching a parameterized class or interface declaration with
type parameters immediately following the name of the type in the
builtin userdiff pattern for Java.  Do so by just allowing matching the
first character after the name of the type to "<".

An alternative approach could be to match both the opening and the
closing angle brackets and matching the content between them in various
ways.  Just use the simpler regex for now.

[1] Since Java 5 released in 2004.
[2] Detailed description is available in the Java Language
    Specification, sections "Type Variables" and "Parameterized Types":
    https://docs.oracle.com/javase/specs/jls/se17/html/jls-4.html#jls-4.4

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t4018/java-class-type-parameters             | 6 ++++++
 t/t4018/java-class-type-parameters-implements  | 6 ++++++
 t/t4018/java-interface-type-parameters         | 6 ++++++
 t/t4018/java-interface-type-parameters-extends | 6 ++++++
 userdiff.c                                     | 2 +-
 5 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 t/t4018/java-class-type-parameters
 create mode 100644 t/t4018/java-class-type-parameters-implements
 create mode 100644 t/t4018/java-interface-type-parameters
 create mode 100644 t/t4018/java-interface-type-parameters-extends

diff --git a/t/t4018/java-class-type-parameters b/t/t4018/java-class-type-parameters
new file mode 100644
index 0000000000..579aa7af21
--- /dev/null
+++ b/t/t4018/java-class-type-parameters
@@ -0,0 +1,6 @@
+class RIGHT<A, B> {
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    private A ChangeMe;
+}
diff --git a/t/t4018/java-class-type-parameters-implements b/t/t4018/java-class-type-parameters-implements
new file mode 100644
index 0000000000..b8038b1866
--- /dev/null
+++ b/t/t4018/java-class-type-parameters-implements
@@ -0,0 +1,6 @@
+class RIGHT<A, B> implements List<A> {
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    private A ChangeMe;
+}
diff --git a/t/t4018/java-interface-type-parameters b/t/t4018/java-interface-type-parameters
new file mode 100644
index 0000000000..a4baa1ae68
--- /dev/null
+++ b/t/t4018/java-interface-type-parameters
@@ -0,0 +1,6 @@
+interface RIGHT<A, B> {
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    public B foo(A ChangeMe);
+}
diff --git a/t/t4018/java-interface-type-parameters-extends b/t/t4018/java-interface-type-parameters-extends
new file mode 100644
index 0000000000..31d7fb3244
--- /dev/null
+++ b/t/t4018/java-interface-type-parameters-extends
@@ -0,0 +1,6 @@
+interface RIGHT<A, B> extends Function<A, B> {
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    public B foo(A ChangeMe);
+}
diff --git a/userdiff.c b/userdiff.c
index d71b82feb7..759e22ffff 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -171,7 +171,7 @@ PATTERNS("html",
 PATTERNS("java",
 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
 	 /* Class, enum, and interface declarations */
-	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+[A-Za-z][A-Za-z0-9_$]*[ \t]+.*)$\n"
+	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+[A-Za-z][A-Za-z0-9_$]*([ \t]+|<).*)$\n"
 	 /* Method definitions; note that constructor signatures are not */
 	 /* matched because they are indistinguishable from method calls. */
 	 "^[ \t]*(([A-Za-z_<>&][][?&<>.,A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
-- 
2.39.1

