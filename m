Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D5CC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D75D60F94
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhHJTKM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 15:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhHJTKM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 15:10:12 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4094C0613C1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 12:09:49 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:33164)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDX8F-0007rH-9V
        for git@vger.kernel.org; Tue, 10 Aug 2021 15:09:47 -0400
Received: from auth1-smtp.messagingengine.com ([66.111.4.227]:41619)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDX8F-0001I4-3i; Tue, 10 Aug 2021 15:09:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8D0C527C0054;
        Tue, 10 Aug 2021 15:09:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 10 Aug 2021 15:09:46 -0400
X-ME-Sender: <xms:-s4SYbkCQaF-xhXJgNm3mlHUyc9W6UgRXnk39lZ1VCfGc-FKg8kDKA>
    <xme:-s4SYe16okkTinoGdO4aiIDq5y51eItv4i9L1aCSSf67zWayFs_KxErW_bO_mTZke
    Dmp4UqT-r9Lpw>
X-ME-Received: <xmr:-s4SYRqdeyQw0xK8GYhZ6CI1deFHiyPegkEFThVvolLTvWp3KjJvkpaP0oOGmRpQhmhtu4kvKkP4_1-2VlsO2K2mxFLf2s5FRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeelgddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepvfgrshhsihhlohcujfhorhhnuceothhsughhsehgnhhurdhorhhg
    qeenucggtffrrghtthgvrhhnpeefvdeluefgvdfgjeeutefgkeffleffudevgeffgedufe
    etkefhffeiveekteejieenucffohhmrghinhepuhhtihhlrdhmrghpnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhrnhdomhgvshhmth
    hprghuthhhphgvrhhsohhnrghlihhthidqkeeijeefkeejkeegqdeifeehvdelkedqthhs
    ughhpeepghhnuhdrohhrghesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:-s4SYTmsojzp7iucy8mEUV9yM2HKmMao2tIZH4PwPSmYxwfUAtkpBg>
    <xmx:-s4SYZ1OzmZ_CaQCmT77KMG3lJ_eUqq3ZxfQA_PgAZbUIPNGvZOg-g>
    <xmx:-s4SYSsjG0ADdYeRO58cctgtAUwRwt0MvlD_JYYyT1Uvb7y-wiWwsw>
    <xmx:-s4SYW-DkX2iqqoSVeXGbtIuGpWF-6BsyQ8m7IR-jTnYOfVVbmiizg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Aug 2021 15:09:45 -0400 (EDT)
From:   Tassilo Horn <tsdh@gnu.org>
To:     git@vger.kernel.org
Cc:     Tassilo Horn <tsdh@gnu.org>
Subject: [PATCH v4] userdiff: improve java hunk header regex
Date:   Tue, 10 Aug 2021 21:09:37 +0200
Message-Id: <20210810190937.305765-1-tsdh@gnu.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the git diff hunk headers show the wrong method signature if the
method has a qualified return type, an array return type, or a generic return
type because the regex doesn't allow dots (.), [], or < and > in the return
type.  Also, type parameter declarations couldn't be matched.

Add several t4018 tests asserting the right hunk headers for increasingly
complex method signatures:

  public String[] myMethod(String[] RIGHT)
  public List<String> myMethod(String[] RIGHT)
  public <T> List<T> myMethod(T[] RIGHT)
  public <AType, B> Map<AType, B> myMethod(String[] RIGHT)
  public <AType, B> java.util.Map<AType, Map<B, B[]>> myMethod(String[] RIGHT)
  public List<? extends Comparable> myMethod(String[] RIGHT)
  public <T extends Serializable & Comparable<T>> List<T> myMethod(String[] RIGHT)

Signed-off-by: Tassilo Horn <tsdh@gnu.org>
---
 t/t4018/java-constructor             |  6 ++++++
 t/t4018/java-enum-constant           |  6 ++++++
 t/t4018/java-nested-field            |  6 ++++++
 t/t4018/java-return-array            |  6 ++++++
 t/t4018/java-return-generic          |  6 ++++++
 t/t4018/java-return-generic-bounded  |  6 ++++++
 t/t4018/java-return-generic-wildcart |  6 ++++++
 t/t4018/java-return-generic2         |  6 ++++++
 t/t4018/java-return-generic3         |  6 ++++++
 t/t4018/java-return-generic4         |  6 ++++++
 userdiff.c                           | 23 ++++++++++++++++++++++-
 11 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 t/t4018/java-constructor
 create mode 100644 t/t4018/java-enum-constant
 create mode 100644 t/t4018/java-nested-field
 create mode 100644 t/t4018/java-return-array
 create mode 100644 t/t4018/java-return-generic
 create mode 100644 t/t4018/java-return-generic-bounded
 create mode 100644 t/t4018/java-return-generic-wildcart
 create mode 100644 t/t4018/java-return-generic2
 create mode 100644 t/t4018/java-return-generic3
 create mode 100644 t/t4018/java-return-generic4

diff --git a/t/t4018/java-constructor b/t/t4018/java-constructor
new file mode 100644
index 0000000000..9daf7c5430
--- /dev/null
+++ b/t/t4018/java-constructor
@@ -0,0 +1,6 @@
+public class MyClass {
+    MyClass(String RIGHT) {
+        // Whatever
+        // ChangeMe
+    }
+}
diff --git a/t/t4018/java-enum-constant b/t/t4018/java-enum-constant
new file mode 100644
index 0000000000..a1931c8379
--- /dev/null
+++ b/t/t4018/java-enum-constant
@@ -0,0 +1,6 @@
+private enum RIGHT {
+    ONE,
+    TWO,
+    THREE,
+    ChangeMe
+}
diff --git a/t/t4018/java-nested-field b/t/t4018/java-nested-field
new file mode 100644
index 0000000000..d92d3ec688
--- /dev/null
+++ b/t/t4018/java-nested-field
@@ -0,0 +1,6 @@
+class MyExample {
+    private static class RIGHT {
+        // change an inner class field
+        String inner = "ChangeMe";
+    }
+}
diff --git a/t/t4018/java-return-array b/t/t4018/java-return-array
new file mode 100644
index 0000000000..747638b9a8
--- /dev/null
+++ b/t/t4018/java-return-array
@@ -0,0 +1,6 @@
+class MyExample {
+    public String[] myMethod(String[] RIGHT) {
+        // Whatever...
+        return new; // ChangeMe
+    }
+}
diff --git a/t/t4018/java-return-generic b/t/t4018/java-return-generic
new file mode 100644
index 0000000000..161dd8338f
--- /dev/null
+++ b/t/t4018/java-return-generic
@@ -0,0 +1,6 @@
+class MyExample {
+    public List<String> myMethod(String[] RIGHT) {
+        // Whatever...
+        return Arrays.asList("ChangeMe");
+    }
+}
diff --git a/t/t4018/java-return-generic-bounded b/t/t4018/java-return-generic-bounded
new file mode 100644
index 0000000000..440115a788
--- /dev/null
+++ b/t/t4018/java-return-generic-bounded
@@ -0,0 +1,6 @@
+class MyExample {
+    public <T extends Serializable & Comparable<T>> List<T> myMethod(String[] RIGHT) {
+        // Whatever...
+        return (List<T>) Arrays.asList("ChangeMe");
+    }
+}
diff --git a/t/t4018/java-return-generic-wildcart b/t/t4018/java-return-generic-wildcart
new file mode 100644
index 0000000000..2d682e1e2b
--- /dev/null
+++ b/t/t4018/java-return-generic-wildcart
@@ -0,0 +1,6 @@
+class MyExample {
+    public List<? extends Comparable> myMethod(String[] RIGHT) {
+        // Whatever...
+        return Arrays.asList("ChangeMe");
+    }
+}
diff --git a/t/t4018/java-return-generic2 b/t/t4018/java-return-generic2
new file mode 100644
index 0000000000..7109c27456
--- /dev/null
+++ b/t/t4018/java-return-generic2
@@ -0,0 +1,6 @@
+class MyExample {
+    public <T> List<T> myMethod(T[] RIGHT) {
+        // Whatever...
+        return (List<T>) Arrays.asList("ChangeMe");
+    }
+}
diff --git a/t/t4018/java-return-generic3 b/t/t4018/java-return-generic3
new file mode 100644
index 0000000000..849f116f50
--- /dev/null
+++ b/t/t4018/java-return-generic3
@@ -0,0 +1,6 @@
+class MyExample {
+    public <AType, B> Map<AType, B> myMethod(String[] RIGHT) {
+        // Whatever...
+        return new java.util.HashMap<>(); // ChangeMe
+    }
+}
diff --git a/t/t4018/java-return-generic4 b/t/t4018/java-return-generic4
new file mode 100644
index 0000000000..1b22c8c037
--- /dev/null
+++ b/t/t4018/java-return-generic4
@@ -0,0 +1,6 @@
+class MyExample {
+    public <AType, B> java.util.Map<AType, Map<B, B[]>> myMethod(String[] RIGHT) {
+        // Whatever...
+        return new java.util.HashMap<>(); // ChangeMe
+    }
+}
diff --git a/userdiff.c b/userdiff.c
index 3c3bbe38b0..9bd751b7d2 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -142,7 +142,28 @@ PATTERNS("html",
 	 "[^<>= \t]+"),
 PATTERNS("java",
 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
-	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
+         "^[ \t]*("
+         /* Class, enum, and interface declarations: */
+         /*   optional modifiers: public */
+         "(([a-z]+[ \t]+)*"
+         /*   the kind of declaration */
+         "(class|enum|interface)[ \t]+"
+         /*   the name */
+         "[A-Za-z][A-Za-z0-9_$]*[ \t]+.*)"
+         /* Method & constructor signatures: */
+         /*   optional modifiers: public static */
+         "|(([a-z]+[ \t]+)*"
+         /*   type params and return types for methods but not constructors */
+         "("
+         /*     optional type parameters: <A, B extends Comparable<B>> */
+         "(<[A-Za-z0-9_,.&<> \t]+>[ \t]+)?"
+         /*     return type: java.util.Map<A, B[]> or List<?> */
+         "([A-Za-z_]([A-Za-z_0-9<>,.?]|\\[[ \t]*\\])*[ \t]+)+"
+         /*   end of type params and return type */
+         ")?"
+         /*   the method name followed by the parameter list: myMethod(...) */
+         "[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)"
+         ")$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
-- 
2.32.0

