Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5CCC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 14:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCF160F02
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 14:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240152AbhHJOob (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 10:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbhHJOoa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 10:44:30 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8892C0613D3
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 07:44:07 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:51830)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDSz7-0001T4-TK
        for git@vger.kernel.org; Tue, 10 Aug 2021 10:44:05 -0400
Received: from auth2-smtp.messagingengine.com ([66.111.4.228]:33117)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDSz7-00053b-NP; Tue, 10 Aug 2021 10:44:05 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4E61827C0054;
        Tue, 10 Aug 2021 10:44:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 10 Aug 2021 10:44:05 -0400
X-ME-Sender: <xms:tZASYUSsPpBGMXK9Adz9b6plChGa9DjxXy7faFSA9Srb_xHlGxe-Cw>
    <xme:tZASYRyNGshWUJzAHHnsO0x2sVS_LHpwcVmpFm1Z6DPmTlH3fAP7pshIqHNHEeuu-
    7XrKnTWMVF-gw>
X-ME-Received: <xmr:tZASYR2VRWNNilX8vKVZXdsYJ6adfRjRRMiyexTvW0fimJPdFRttuULbRAE3jpi93Ea1lDx9M5je656Oyu-yE3Vf0pKcusoFKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeelgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefvrghsshhilhhoucfjohhrnhcuoehtshguhhesghhnuhdrohhrgheq
    necuggftrfgrthhtvghrnhepfedvleeugfdvgfejueetgfekffelffduveegffegudefte
    ekhfffieevkeetjeeinecuffhomhgrihhnpehuthhilhdrmhgrphenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhorhhnodhmvghsmhhtph
    gruhhthhhpvghrshhonhgrlhhithihqdekieejfeekjeekgedqieefhedvleekqdhtshgu
    hheppehgnhhurdhorhhgsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:tZASYYD3N6qjTiwVsf8oclgeaz26KhUf9JKJly8wAffEY-t29oIXhg>
    <xmx:tZASYdgldSgbHz-JIr5BGRbxe0SdGelf3IHIa8qio-ThlAy1AiJ_ag>
    <xmx:tZASYUrJ5y0fdir5L8ZK9JaHzNTpElpUxUqy56rL6kS2Un8OaVXYJQ>
    <xmx:tZASYdJYE7xpQXcXh2hhrcas64h-fU8fSU8fNSJ_pRaujCRtzaB4HA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Aug 2021 10:44:04 -0400 (EDT)
From:   Tassilo Horn <tsdh@gnu.org>
To:     git@vger.kernel.org
Cc:     Tassilo Horn <tsdh@gnu.org>
Subject: [PATCH v3] userdiff: improve java regex for array, qualified, and generic return types
Date:   Tue, 10 Aug 2021 16:43:58 +0200
Message-Id: <20210810144358.235603-1-tsdh@gnu.org>
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

  public String[] secondMethod(String[] RIGHT)
  public List<String> secondMethod(String[] RIGHT)
  public <T> List<T> secondMethod(T[] RIGHT)
  public <AType, B> Map<AType, B> secondMethod(String[] RIGHT)
  public <AType, B> java.util.Map<AType, Map<B, B[]>> secondMethod(String[] RIGHT)

Signed-off-by: Tassilo Horn <tsdh@gnu.org>
---
 t/t4018/java-return-array    | 10 ++++++++++
 t/t4018/java-return-generic  | 10 ++++++++++
 t/t4018/java-return-generic2 | 10 ++++++++++
 t/t4018/java-return-generic3 | 10 ++++++++++
 t/t4018/java-return-generic4 | 10 ++++++++++
 userdiff.c                   | 10 +++++++++-
 6 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 t/t4018/java-return-array
 create mode 100644 t/t4018/java-return-generic
 create mode 100644 t/t4018/java-return-generic2
 create mode 100644 t/t4018/java-return-generic3
 create mode 100644 t/t4018/java-return-generic4

diff --git a/t/t4018/java-return-array b/t/t4018/java-return-array
new file mode 100644
index 0000000000..fc8882a5a9
--- /dev/null
+++ b/t/t4018/java-return-array
@@ -0,0 +1,10 @@
+class MyExample {
+    public void firstMethod() {
+        // Whatever...
+    }
+
+ public String[] secondMethod(String[] RIGHT) {
+        // Whatever...
+        return new; // ChangeMe
+    }
+}
diff --git a/t/t4018/java-return-generic b/t/t4018/java-return-generic
new file mode 100644
index 0000000000..7ea7bf8f07
--- /dev/null
+++ b/t/t4018/java-return-generic
@@ -0,0 +1,10 @@
+class MyExample {
+    public void firstMethod() {
+        // Whatever...
+    }
+
+    public List<String> secondMethod(String[] RIGHT) {
+        // Whatever...
+        return Arrays.asList("ChangeMe");
+    }
+}
diff --git a/t/t4018/java-return-generic2 b/t/t4018/java-return-generic2
new file mode 100644
index 0000000000..d2d2ab7f37
--- /dev/null
+++ b/t/t4018/java-return-generic2
@@ -0,0 +1,10 @@
+class MyExample {
+    public void firstMethod() {
+        // Whatever...
+    }
+
+    public <T> List<T> secondMethod(T[] RIGHT) {
+        // Whatever...
+        return (List<T>) Arrays.asList("ChangeMe");
+    }
+}
diff --git a/t/t4018/java-return-generic3 b/t/t4018/java-return-generic3
new file mode 100644
index 0000000000..3db1a1ddba
--- /dev/null
+++ b/t/t4018/java-return-generic3
@@ -0,0 +1,10 @@
+class MyExample {
+    public void firstMethod() {
+        // Whatever...
+    }
+
+    public <AType, B> Map<AType, B> secondMethod(String[] RIGHT) {
+        // Whatever...
+        return new java.util.HashMap<>(); // ChangeMe
+    }
+}
diff --git a/t/t4018/java-return-generic4 b/t/t4018/java-return-generic4
new file mode 100644
index 0000000000..59f2a50dd2
--- /dev/null
+++ b/t/t4018/java-return-generic4
@@ -0,0 +1,10 @@
+class MyExample {
+    public void firstMethod() {
+        // Whatever...
+    }
+
+ public <AType, B> java.util.Map<AType, Map<B, B[]>> secondMethod(String[] RIGHT) {
+        // Whatever...
+        return new java.util.HashMap<>(); // ChangeMe
+    }
+}
diff --git a/userdiff.c b/userdiff.c
index 3c3bbe38b0..ded42945c3 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -142,7 +142,15 @@ PATTERNS("html",
 	 "[^<>= \t]+"),
 PATTERNS("java",
 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
-	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
+         /* Method signatures contain: */
+         /*   modifiers: public static */
+         "^[ \t]*(([A-Za-z_][A-Za-z]*[ \t]+)*"
+         /*   optionally type parameters: <A, B, C> */
+         "(<[A-Za-z0-9_, \t]+>[ \t]+)?"
+         /*   a return type: java.util.Map<A, B[]> */
+         "([A-Za-z_]([A-Za-z_0-9<>,.]|\\[[ \t]*\\])*[ \t]+)+"
+         /*   the method name followed by the parameter list: myMethod(...) */
+         "[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
-- 
2.32.0

