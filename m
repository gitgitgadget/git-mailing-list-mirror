Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08915C61DA4
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 13:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjBDNnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 08:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjBDNnl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 08:43:41 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A4A206BF
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 05:43:40 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id u8so3139022ilq.13
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 05:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EN/S+kOokx9ej9SmTZ3eWReSzA3P4QNkmWICRr4Kteo=;
        b=qi7TfP1z1sFdbn2gup8yG2wtwnMlQmpKlGlN2q942BWJOU1SJP6ZljvrYBknYM8N06
         C25RhVbjX8i2uaET/AgFdtqqJ/AXfcLz8/e37S9vWKYvHKp/JAVo9Y5tBeKU1wYe7tQY
         +IsYfsdsqDAlbp05uwQD9YlbJuzluLuKkPB9JNQ/nCfi32b2VXtgGmmcJoRl0fTfzI4V
         EHw763LNXSzzsHFsyV1tgMqyybc8kmb7Oe7hYXEpvyveQmMMTviLU+5ntLIBKq5RMlAA
         HR4uI+HoKd7/1V5+brKehGrNhhexSPzi+RwDTG9qFIA9LpfL0a7d8LSbGXFaLlsIduYV
         4coA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EN/S+kOokx9ej9SmTZ3eWReSzA3P4QNkmWICRr4Kteo=;
        b=4wmYMFnqqlNDYCuT5uVt3bpDeWPssrmw4yOaAPkmdeU8h+xCbdh0z4GXBYB8NutokD
         7TmLauXmuQYF8dafSYS1T5P+E1zXrilv2MV9PsQoQ7eGTfcBJMhKFWcDN4K0PcI14iO3
         mJoYPHD/3IAY0XJQ9AXnP/ZlOJT5Xx+NXpnkpSWH70Pe2r0OZVCene22jASrn8xzyV5l
         1w1+hvWVCXX8Enh9WymIb1VdKHi6i7HTTuzaJw/QvEzekHNpy0rZViDzOUlvWiCPfXBz
         nI2+8oEddilY4to4eb5Au4vnEqd4APrubL0iaMrqmXM2HRHDcgYkDopTGA6CH3xQecOU
         sL1w==
X-Gm-Message-State: AO0yUKVziVIVuaO61CXFeMq6DDrI9XqJFrHii9O0WdL/UR9QW4TFKBPX
        TUsFSIFz3S6J4KcBY4OtWVc=
X-Google-Smtp-Source: AK7set8d05FPXlSvUkutUDu2YlcpyPWKK8bLaLf8SyI1E2qajZGd1eEZ3VO+h93RAnsH/I6kti/Gsw==
X-Received: by 2002:a92:cec5:0:b0:311:ad48:ff1b with SMTP id z5-20020a92cec5000000b00311ad48ff1bmr6666438ilq.3.1675518219654;
        Sat, 04 Feb 2023 05:43:39 -0800 (PST)
Received: from titov.fritz.box ([191.101.157.6])
        by smtp.gmail.com with ESMTPSA id q8-20020a027b08000000b003af4300d670sm1802449jac.27.2023.02.04.05.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 05:43:39 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     Tassilo Horn <tsdh@gnu.org>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Paolo Bonzini <pbonzini@redhat.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 3/3] userdiff: support Java sealed classes
Date:   Sat,  4 Feb 2023 14:43:29 +0100
Message-Id: <20230204134329.251451-4-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230204134329.251451-1-rybak.a.v@gmail.com>
References: <877cwxvl3a.fsf@gnu.org>
 <20230204134329.251451-1-rybak.a.v@gmail.com>
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

