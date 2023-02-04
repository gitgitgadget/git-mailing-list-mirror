Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322D0C636CC
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 13:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjBDNns (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 08:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbjBDNnk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 08:43:40 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E31B21283
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 05:43:38 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id u7so3161353ilg.4
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 05:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbZq5firGddkAkNT9+2+N3pL53e1DAOsm6pG0PlKNhQ=;
        b=mKzM99Tz22yzy7EGK2yBNck3GMYbAVhaiohBfpkG3lHdwkyGUL3FvcNdW5w+YAX7Zb
         9bVkryzyGySjar8UsY6Bu3ocjt9CRIo2KYy5IJD1jW9+dYlBKFbHveSZQ9WInqNqOi2H
         O+vgOc+3nKvgfpiAvuAvaeIGosLfBvkIKI3nyy6lg13chUpcfps7UcA+LNBKsV+QtNIz
         9rF4AySGySy0koiXdrk3eckwbdMosKfFpihi/p8Bcxz2i+EPYhk9YCpJJHIvl3xgqLCm
         BtWd8+ouU/8UkKnMXll4AxUOoplu1Srox5PPW7rbL9GoY93+bvfNdv2FC7o6EInsVTNa
         oHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbZq5firGddkAkNT9+2+N3pL53e1DAOsm6pG0PlKNhQ=;
        b=Y62j5SLlCZauoLrkffaH1ztG2GoICRZjG8JRexEZPUOxzAGb4bnzhShD2Zg3r5++58
         aCMI+jdZzusmX5a3jQkyV6YPXL+kROP/x52cG4rJfz2xXAH5hgAe6J5RXafso74wfYLB
         EEpvZYJfecIV387X6B/9CRC0mhiJ+E9meEp8X6a+Wfp0irTrRv0yBv5NnnZ/rjus6piX
         UTe5xBQPPSrCHBjOiFZxQHjfhfTZmfF8wb7qAoT8f1p74v+eVAWFEKrXmMgEJGRrqeQj
         glT0u9kl/u7Nzqvqjled7jRb1kHkbXtS/wFau4Le+nYxjfuRT5tgT2EgmiqhGmG0yeDy
         zRqw==
X-Gm-Message-State: AO0yUKVU1VzFRVTqc/ZLCtx2oXgjm8Ds6aIyO+jD0TYATVCvHsgXLgu+
        h7Ii0C2cHiJlGLNQzzIZ8Is=
X-Google-Smtp-Source: AK7set+2+i3PEM1wn8PgK1YCwhDQtXNJBx1i5y7ckQQJTfijgr97c0fBazWkbvJtgaunxiYDtgHp2w==
X-Received: by 2002:a92:c645:0:b0:311:ad48:ff20 with SMTP id 5-20020a92c645000000b00311ad48ff20mr5536835ill.8.1675518217871;
        Sat, 04 Feb 2023 05:43:37 -0800 (PST)
Received: from titov.fritz.box ([191.101.157.6])
        by smtp.gmail.com with ESMTPSA id q8-20020a027b08000000b003af4300d670sm1802449jac.27.2023.02.04.05.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 05:43:37 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     Tassilo Horn <tsdh@gnu.org>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Paolo Bonzini <pbonzini@redhat.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 2/3] userdiff: support Java record types
Date:   Sat,  4 Feb 2023 14:43:28 +0100
Message-Id: <20230204134329.251451-3-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230204134329.251451-1-rybak.a.v@gmail.com>
References: <877cwxvl3a.fsf@gnu.org>
 <20230204134329.251451-1-rybak.a.v@gmail.com>
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
any, without separating whitespace.

Code examples:

    public record Example(int i, String s) {
    }

    public record WithTypeParameters<A, B>(A a, B b, String s) {
    }

Support records in the builtin userdiff pattern for Java.  Add "record"
to the alternatives of keywords for kinds of class, and match an opening
parenthesis as the first character right after the type name.

An alternative approach could be to have an optional group that would
match both the opening and the closing parentheses with some way of
matching the declarations of the components.  Just use the simpler
regular expression for now.

[1] detailed description is available in "JEP 395: Records"
    https://openjdk.org/jeps/395

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t4018/java-record                 | 6 ++++++
 t/t4018/java-record-type-parameters | 6 ++++++
 userdiff.c                          | 2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 t/t4018/java-record
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
index 759e22ffff..f92b3029aa 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -171,7 +171,7 @@ PATTERNS("html",
 PATTERNS("java",
 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
 	 /* Class, enum, and interface declarations */
-	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+[A-Za-z][A-Za-z0-9_$]*([ \t]+|<).*)$\n"
+	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface|record)[ \t]+[A-Za-z][A-Za-z0-9_$]*([ \t]+|[<(]).*)$\n"
 	 /* Method definitions; note that constructor signatures are not */
 	 /* matched because they are indistinguishable from method calls. */
 	 "^[ \t]*(([A-Za-z_<>&][][?&<>.,A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
-- 
2.39.1

