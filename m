Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A0BC636CD
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 23:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjBGXnK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 18:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjBGXnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 18:43:08 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4912618AB4
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 15:43:07 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id q19so18346979edd.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 15:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BLFt0zcHRIjKEnapqb2muIO1OhPrUabIFt7ghKd7n4=;
        b=ZJL0TNxZt7dbm2S1ybo2hwswPNa2/MKATDTu1gAqoEsGjKiXUIiM/e/3lcURzfOaUa
         KXq3IYTKhLH7qeCgBMB7mJi4OYH4hM0s7ZKpB6zDcJdRNFlW1df1qN9o7ahQrqPDdOC4
         ug2cMLdI3pfcPTtfVoARh6+X0SYyIwkMjuksFBabIOf7GAYvaAx8BKsIRhVHFU944MEX
         /R3pOot3sdQaleQdEHUSyZrj3k8Uxkun7pt9EAnRqKJKt76dIKI9jlnmIi4m/q/xEAkM
         N/ZXAYxD48eLvbRO4bCWsYny2HNTVmH5f2RPUUuFHgr3IuPXZjkVEey895H4c8HY1EsO
         32Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BLFt0zcHRIjKEnapqb2muIO1OhPrUabIFt7ghKd7n4=;
        b=NYt37aOCseRzI4Qi9Q79BVCP2MZVGbpYMnXMDyGgmAZgEykKRyc+k2C8jjqCosCGQ1
         UIkBjq9H7T5Aq0RxKq2nWRGOWdwnq57jiIQKUymNwzp0TsYjT3jUEFWTM3ij65GBai11
         eFB9ACg9Npr65ZBDuonNlMbX0WRXEJkP8cPPBj2uxv8DQCSVV2FH0rkBHRwZaHC3slf5
         syu0u0HIDmQFS3NQQPrf13aaopbmG0/Al23QOo0UjfxJpVmGrRHKFRoGsNZMF0aKhqWl
         +THNWZgdLk3BQPZaw/mZM1nRQMUDad+0fvx18Dv/dAODq7g4HElmJeW9WcSoWOR2sTgq
         kVzw==
X-Gm-Message-State: AO0yUKWuNWOCbZI/dpeY055tppR8ck1wS4hii9DQJwt29Zo+8BojxqHp
        gDjZCCLX05utsRrS45hc8CzAKQ7IgJBnLoJrQsc=
X-Google-Smtp-Source: AK7set8mSo9ZSxwaoFTgCHc+Qs14kuFy4CKsaKjVTEm+IMj2veH5bV3Ex1lvVPb96KwzgWp3/rp4nA==
X-Received: by 2002:a50:ce4e:0:b0:4aa:c355:bc92 with SMTP id k14-20020a50ce4e000000b004aac355bc92mr5211620edj.32.1675813385647;
        Tue, 07 Feb 2023 15:43:05 -0800 (PST)
Received: from titov.fritz.box ([181.214.173.18])
        by smtp.gmail.com with ESMTPSA id x91-20020a50bae4000000b0049b58744f93sm5346198ede.81.2023.02.07.15.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 15:43:05 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Paolo Bonzini <pbonzini@redhat.com>,
        Tassilo Horn <tsdh@gnu.org>
Subject: [PATCH v3 1/3] userdiff: support Java type parameters
Date:   Wed,  8 Feb 2023 00:42:57 +0100
Message-Id: <20230207234259.452141-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207234259.452141-1-rybak.a.v@gmail.com>
References: <64601c4b-9ced-672f-a5fd-9a9b3b65859d@kdbg.org>
 <20230207234259.452141-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A class or interface in Java can have type parameters following the name
in the declared type, surrounded by angle brackets (paired less than and
greater than signs).[2]   The type parameters -- `A` and `B` in the
examples -- may follow the class name immediately:

    public class ParameterizedClass<A, B> {
    }

or may be separated by whitespace:

    public class SpaceBeforeTypeParameters <A, B> {
    }

A part of the builtin userdiff pattern for Java matches declarations of
classes, enums, and interfaces.  The regular expression requires at
least one whitespace character after the name of the declared type.
This disallows matching for opening angle bracket of type parameters
immediately after the name of the type.  Mandatory whitespace after the
name of the type also disallows using the pattern in repositories with a
fairly common code style that puts braces for the body of a class on
separate lines:

    class WithLineBreakBeforeOpeningBrace
    {
    }

Support matching Java code in more diverse code styles and declarations
of classes and interfaces with type parameters immediately following the
name of the type in the builtin userdiff pattern for Java.  Do so by
just matching anything until the end of the line after the keywords for
the kind of type being declared.

[1] Since Java 5 released in 2004.
[2] Detailed description is available in the Java Language
    Specification, sections "Type Variables" and "Parameterized Types":
    https://docs.oracle.com/javase/specs/jls/se17/html/jls-4.html#jls-4.4

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t4018/java-class-brace-on-separate-line       | 6 ++++++
 t/t4018/java-class-space-before-type-parameters | 6 ++++++
 t/t4018/java-class-type-parameters              | 6 ++++++
 t/t4018/java-class-type-parameters-implements   | 6 ++++++
 t/t4018/java-interface-type-parameters          | 6 ++++++
 t/t4018/java-interface-type-parameters-extends  | 6 ++++++
 userdiff.c                                      | 2 +-
 7 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 t/t4018/java-class-brace-on-separate-line
 create mode 100644 t/t4018/java-class-space-before-type-parameters
 create mode 100644 t/t4018/java-class-type-parameters
 create mode 100644 t/t4018/java-class-type-parameters-implements
 create mode 100644 t/t4018/java-interface-type-parameters
 create mode 100644 t/t4018/java-interface-type-parameters-extends

diff --git a/t/t4018/java-class-brace-on-separate-line b/t/t4018/java-class-brace-on-separate-line
new file mode 100644
index 0000000000..8795acd4cf
--- /dev/null
+++ b/t/t4018/java-class-brace-on-separate-line
@@ -0,0 +1,6 @@
+class RIGHT
+{
+    static int ONE;
+    static int TWO;
+    static int ChangeMe;
+}
diff --git a/t/t4018/java-class-space-before-type-parameters b/t/t4018/java-class-space-before-type-parameters
new file mode 100644
index 0000000000..0bdef1dfbe
--- /dev/null
+++ b/t/t4018/java-class-space-before-type-parameters
@@ -0,0 +1,6 @@
+class RIGHT <TYPE, PARAMS, AFTER, SPACE> {
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    private A ChangeMe;
+}
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
index d71b82feb7..bc5f3ed4c3 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -171,7 +171,7 @@ PATTERNS("html",
 PATTERNS("java",
 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
 	 /* Class, enum, and interface declarations */
-	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+[A-Za-z][A-Za-z0-9_$]*[ \t]+.*)$\n"
+	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+.*)$\n"
 	 /* Method definitions; note that constructor signatures are not */
 	 /* matched because they are indistinguishable from method calls. */
 	 "^[ \t]*(([A-Za-z_<>&][][?&<>.,A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
-- 
2.39.1

