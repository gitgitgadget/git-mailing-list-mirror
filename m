Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACACC05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 23:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjBCXXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 18:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjBCXXt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 18:23:49 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69233A58DB
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 15:23:46 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z11so6622670ede.1
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 15:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbZq5firGddkAkNT9+2+N3pL53e1DAOsm6pG0PlKNhQ=;
        b=MMFj+8ORw4KnE/VLaah2HIA/AEdW5pwT62yMMa4rfE4/vBD9UHQT1Ej0tc/4yr+7Ml
         L20Yq958fh8DQeknwAEdXAVFrGBC1UYWXrR2opxWjAIVJc9DCBNWwZFYVQLLomJsB3sg
         rtjPOELruc4oPvWl1rJTkBNAabdeoa0nknXiGxYkM80KFxMlSiY3SqJ/XaC7XpBU6G9E
         LcbvdBnSxVq9BOXkpkF7eZgLXo7xXEyqGFvvC62hGwe26YwXs2IZ9Py+vTIFJqxiMD9w
         gGzeMwgaTuf0Rw3+koge4Uz4pWBzOqXcuwN1gSwrTcpOYqZ40JhekQzqN0Da2SFxkGJ4
         DqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbZq5firGddkAkNT9+2+N3pL53e1DAOsm6pG0PlKNhQ=;
        b=ak/Q9vyTTR8nNqG8yjKjwPt26CgH6MYZ1XPCpeAA0/jpg1vEQS8S2yLG1FrLViv632
         phj/foNxocKIYRKTxumfFnY+jnnJ5ql+5El1sBOgL8nhpKhe+VAyLQ69TUegTEaH4Kor
         Lw/9lc4Gv/17L7kxszlm9VsLvuFzr2T+mTqukXdGeGyR0JSPMs65lgxs+YAHL1DubNWM
         uaGAk7Xa8c9gEkk5FQgFvFv6/XxFsc5cNz+eV4/oI/hXcg6gIQMxeZu8weEsk0wsAiat
         FXIBVeC16umkoe1XwOlBh0XbcWswRv6MlJ5caZ1UQhKR49pugQAP1rlfcxjSHI6RD78x
         uUDg==
X-Gm-Message-State: AO0yUKWdU5XZYguTQYikwRt2fo3fXhO3MQpscDPtMfe/87++wUGPncpF
        6Io/EpbbcCJFXfwBq5OWk1+sylpSVl0LdSG6dBw=
X-Google-Smtp-Source: AK7set9qzJsETcsa+E1iZtxRt92GDRbVdqmMmVczp+GrWDwMo8/r0vt68ip/MUPvGyeHdTsymYviZA==
X-Received: by 2002:a05:6402:336:b0:4a2:449a:9498 with SMTP id q22-20020a056402033600b004a2449a9498mr12152181edw.31.1675466624707;
        Fri, 03 Feb 2023 15:23:44 -0800 (PST)
Received: from titov.fritz.box ([216.24.213.52])
        by smtp.gmail.com with ESMTPSA id u4-20020aa7db84000000b0049f88f00f70sm1787917edt.7.2023.02.03.15.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 15:23:43 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Paolo Bonzini <pbonzini@redhat.com>,
        Johannes Sixt <j6t@kdbg.org>, Tassilo Horn <tsdh@gnu.org>
Subject: [PATCH v1 2/3] userdiff: support Java record types
Date:   Sat,  4 Feb 2023 00:23:38 +0100
Message-Id: <20230203232339.216592-3-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230203232339.216592-1-rybak.a.v@gmail.com>
References: <20230203232339.216592-1-rybak.a.v@gmail.com>
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

