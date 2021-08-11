Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379F7C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 17:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B15660F56
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 17:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhHKRvo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 13:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhHKRvn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 13:51:43 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAFAC061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 10:51:19 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:40172)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDsNj-00064i-Vp
        for git@vger.kernel.org; Wed, 11 Aug 2021 13:51:11 -0400
Received: from auth2-smtp.messagingengine.com ([66.111.4.228]:44697)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1mDsNj-000386-Q5; Wed, 11 Aug 2021 13:51:11 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id B737127C0054;
        Wed, 11 Aug 2021 13:51:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 11 Aug 2021 13:51:11 -0400
X-ME-Sender: <xms:Dg4UYVTDI9qrHoGknyhakoqX59pCe1IAKs1zUi9KGAH2nPDGDqhOuA>
    <xme:Dg4UYey-HTREG8mYissDCB0tmojxKNoMkQoyeWaTWvJTL6o1nZt4sj6vjBuPYFrGO
    MydLIHMoGiNIw>
X-ME-Received: <xmr:Dg4UYa2qIosvviA_jpbtg5TSDKGNc2EQZQf6cQOLjWc0xui9RoFSpdEtpccV5LNLmoYTBniWrDg4m30XHXNXfFTloD8TMmxCrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkedugdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepvfgrshhsihhlohcujfhorhhnuceothhsughhsehgnhhurdhorhhg
    qeenucggtffrrghtthgvrhhnpeevffekhfegvdefiefgjeeujedvfffhffeutefhgfekie
    eiheeludeludeltdefhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehthhhorhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    ekieejfeekjeekgedqieefhedvleekqdhtshguhheppehgnhhurdhorhhgsehfrghsthhm
    rghilhdrfhhm
X-ME-Proxy: <xmx:Dg4UYdCFeQX8zRhxn98_q71ausuM5rzKhPwgPD-xpbkjM_RgcLPVBg>
    <xmx:Dg4UYeid-nqhYcIBuF9HUFinkwRUap8CYak3LemA1VSiiA-62-fcCQ>
    <xmx:Dg4UYRpIWskydxCIxzxStkN-GcTY5Ga5p0ziFe1v7HRsgcNoebOhTQ>
    <xmx:Dg4UYWKQx71O2fKtB5P1h161wDZHhzr9Otb0K_pkkVSdxPZMauuuwg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Aug 2021 13:51:09 -0400 (EDT)
From:   Tassilo Horn <tsdh@gnu.org>
To:     git@vger.kernel.org
Cc:     Tassilo Horn <tsdh@gnu.org>
Subject: [PATCH v6] userdiff: improve java hunk header regex
Date:   Wed, 11 Aug 2021 19:51:04 +0200
Message-Id: <20210811175104.48119-1-tsdh@gnu.org>
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

Add several t4018 tests asserting the right hunk headers for different cases:

  - enum constant change
  - change in generic method with bounded type parameters
  - change in generic method with wildcard
  - field change in a nested class

Signed-off-by: Tassilo Horn <tsdh@gnu.org>
---
 t/t4018/java-class-member-function          | 4 ++++
 t/t4018/java-enum-constant                  | 6 ++++++
 t/t4018/java-method-return-generic-bounded  | 9 +++++++++
 t/t4018/java-method-return-generic-wildcard | 9 +++++++++
 t/t4018/java-nested-field                   | 6 ++++++
 userdiff.c                                  | 6 +++++-
 6 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 t/t4018/java-enum-constant
 create mode 100644 t/t4018/java-method-return-generic-bounded
 create mode 100644 t/t4018/java-method-return-generic-wildcard
 create mode 100644 t/t4018/java-nested-field

diff --git a/t/t4018/java-class-member-function b/t/t4018/java-class-member-function
index 298bc7a71b..3b95f68b3b 100644
--- a/t/t4018/java-class-member-function
+++ b/t/t4018/java-class-member-function
@@ -3,6 +3,10 @@ public class Beer
 	int special;
 	public static void main(String RIGHT[])
 	{
+		someMethodCall();
+		someOtherMethod("17")
+			.doThat();
+		// Whatever
 		System.out.print("ChangeMe");
 	}
 }
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
diff --git a/t/t4018/java-method-return-generic-bounded b/t/t4018/java-method-return-generic-bounded
new file mode 100644
index 0000000000..66dd78c379
--- /dev/null
+++ b/t/t4018/java-method-return-generic-bounded
@@ -0,0 +1,9 @@
+class MyExample {
+    public <T extends Bar & Foo<T>, R> Map<T, R[]> foo(String[] RIGHT) {
+        someMethodCall();
+        someOtherMethod()
+            .doThat();
+        // Whatever...
+        return (List<T>) Arrays.asList("ChangeMe");
+    }
+}
diff --git a/t/t4018/java-method-return-generic-wildcard b/t/t4018/java-method-return-generic-wildcard
new file mode 100644
index 0000000000..96e9e5f2c1
--- /dev/null
+++ b/t/t4018/java-method-return-generic-wildcard
@@ -0,0 +1,9 @@
+class MyExample {
+    public List<? extends Comparable> foo(String[] RIGHT) {
+        someMethodCall();
+        someOtherMethod()
+            .doThat();
+        // Whatever...
+        return Arrays.asList("ChangeMe");
+    }
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
diff --git a/userdiff.c b/userdiff.c
index 3c3bbe38b0..3452aacd6d 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -142,7 +142,11 @@ PATTERNS("html",
 	 "[^<>= \t]+"),
 PATTERNS("java",
 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
-	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
+	 /* Class, enum, and interface declarations */
+	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+[A-Za-z][A-Za-z0-9_$]*[ \t]+.*)$\n"
+	 /* Method definitions; note that constructor signatures are not */
+	 /* matched because they are indistinguishable from method calls. */
+	 "^[ \t]*(([A-Za-z_<>&][][?&<>.,A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
-- 
2.32.0

