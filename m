Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109CBC7EE25
	for <git@archiver.kernel.org>; Tue, 16 May 2023 17:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjEPR5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 13:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjEPR4v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 13:56:51 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231CB10D8
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:56:50 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 931F15C01BA;
        Tue, 16 May 2023 13:56:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 16 May 2023 13:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1684259809; x=1684346209; bh=aNZ+hGsot0PdGHcbyRna6L3AL
        89Xsx8z3ZuH/tpxVP4=; b=y7UecfC1sa48I3YUFJKYIOR4Mcw9SsIdwM/PLHUEy
        BUTtSW/sbt+Ymyq2d3dT7X4qHOWDd3HaBSkDlGfess+uF0rLvXTrV6PAQf6X2BwS
        dJqVHwgJxbJP0uS/8hok7sJjyR8ubmW6C0JqorNDrPz0TG3Edt3DdHdvwd3s7cJA
        P4C5oGoCN1UGKF/VY4Nk1Dk3ns9AVRncFDfeg1IMwou1rkW5QL1hY8LBl76TyhV4
        NNsxsxJSuTEpDC1ZMgBClC5E1Kj2QgLLX5OX1H0/0xMc93wTDvSCno9hbKlPB8xx
        oqI6JXqnf/jg6zIxiDOeW6G6qaDqNthcTO36iKGArMx3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684259809; x=1684346209; bh=aNZ+hGsot0PdGHcbyRna6L3AL89Xsx8z3Zu
        H/tpxVP4=; b=rISMunTmqkzkuNYvTeAlnKNe8nZH9VNHrl6qNXDpAQ7MRy5DF1N
        U0rYwbxYdoOvs5ss5R/mKXzPmhKGAC9V8VT5HzQ2qKdeNcsxgYCTIteUO/VLDfMf
        slfuQJlCH+/VVhkkqI0Uk/iegRmLSQqZtTToItYt8xsSBRIxM2himFL/win9pI5g
        5HXqOXa2S1e0Zx2f4QgpUwGi1BmUOwwJ+ymPwCsTN66TswjCNbfuFHNLchXI3m2N
        8fYt1K3/b6Hfb0W41W3z4CHurkZ3BYyDqbR7EHgs5H4ZV/lwjtRPp39bYEsLEzqR
        HuBfUmlgKiFZZd9zUMcy+IanyxeD3AYDh4w==
X-ME-Sender: <xms:4cNjZOCFROdFKl1ytd8MXieTQBMyl3I3IcefWtYFlRsb9MbQ8hBL17M>
    <xme:4cNjZIhc6voBTnA0RuOTn4NLxI-iHbWrYaCBHf6Ma-dZN2bkTebCpdqg1VSxH4nts
    ItNrjG4QLPUF6S5oQ>
X-ME-Received: <xmr:4cNjZBnuq5mmyghX1C4PVC_VcyY3juCeiieY7c3_Kk-afTRoIIN7psapYWW9nyA5wypzxABB7up5a3iaGZ_5GORIyssFg4r3LE_H4VmuWenoHn-r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehledguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepve
    fgleevieekgeejieekueevhfelieduvdelgeefkeejtdekvedttefgffevtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:4cNjZMxCDlgp7mH2bD2yJhPy9Jik3XYrtBNra77aN19gQpr-nI9g_g>
    <xmx:4cNjZDR9aQbv_jkyM4648C91FHO478IN7Zw6BrPkC5CeCwheC7ZLdA>
    <xmx:4cNjZHajPYZ0Rw--p6yUnmrMWOtG0mq7cF7GY-7W68_LeeWKCDaSKg>
    <xmx:4cNjZOd8q3nAifiIyEtFHpdtlqdEJkDGC5n6Wl7hds5n3oXxg1hUEw>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 May 2023 13:56:48 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 3/3] tag: keep the message file in case ref transaction fails
Date:   Tue, 16 May 2023 19:55:46 +0200
Message-Id: <81bca0673d817067d6c2af9819d266abb69f6c82.1684258780.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684258780.git.code@khaugsbakk.name>
References: <cover.1684067644.git.code@khaugsbakk.name> <cover.1684258780.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ref transaction can fail after the user has written their tag
message. In particular, if there exists a tag `foo/bar` and `git tag -a
foo` is said then the command will only fail once it tries to write
`refs/tags/foo`, which is after the file has been unlinked.

Hold on to the message file for a little longer so that it is not
unlinked before the fatal error occurs.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    § From v2
    
    (Noting for other reviewers (after v2):)
    
    I duplicated this message (this isn’t obvious in the diff):
    
        fprintf(stderr,
                _("The tag message has been left in %s\n"),
                path);

 builtin/tag.c  | 24 +++++++++++++++---------
 t/t7004-tag.sh | 10 ++++++++++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index d428c45dc8d..7df9c143ac0 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -266,11 +266,10 @@ static const char message_advice_nested_tag[] =
 static void create_tag(const struct object_id *object, const char *object_ref,
 		       const char *tag,
 		       struct strbuf *buf, struct create_tag_options *opt,
-		       struct object_id *prev, struct object_id *result)
+		       struct object_id *prev, struct object_id *result, char *path)
 {
 	enum object_type type;
 	struct strbuf header = STRBUF_INIT;
-	char *path = NULL;
 
 	type = oid_object_info(the_repository, object, NULL);
 	if (type <= OBJ_NONE)
@@ -294,7 +293,6 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 		int fd;
 
 		/* write the template message before editing: */
-		path = git_pathdup("TAG_EDITMSG");
 		fd = xopen(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
 
 		if (opt->message_given) {
@@ -336,10 +334,6 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 				path);
 		exit(128);
 	}
-	if (path) {
-		unlink_or_warn(path);
-		free(path);
-	}
 }
 
 static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
@@ -487,6 +481,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	};
 	int ret = 0;
 	const char *only_in_list = NULL;
+	char *path = NULL;
 
 	setup_ref_filter_porcelain_msg();
 
@@ -621,7 +616,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (create_tag_object) {
 		if (force_sign_annotate && !annotate)
 			opt.sign = 1;
-		create_tag(&object, object_ref, tag, &buf, &opt, &prev, &object);
+		path = git_pathdup("TAG_EDITMSG");
+		create_tag(&object, object_ref, tag, &buf, &opt, &prev, &object,
+			   path);
 	}
 
 	transaction = ref_transaction_begin(&err);
@@ -629,8 +626,17 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	    ref_transaction_update(transaction, ref.buf, &object, &prev,
 				   create_reflog ? REF_FORCE_CREATE_REFLOG : 0,
 				   reflog_msg.buf, &err) ||
-	    ref_transaction_commit(transaction, &err))
+	    ref_transaction_commit(transaction, &err)) {
+		if (path)
+			fprintf(stderr,
+				_("The tag message has been left in %s\n"),
+				path);
 		die("%s", err.buf);
+	}
+	if (path) {
+		unlink_or_warn(path);
+		free(path);
+	}
 	ref_transaction_free(transaction);
 	if (force && !is_null_oid(&prev) && !oideq(&prev, &object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag,
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 1cb738b00d2..e6f9579cff7 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -2136,4 +2136,14 @@ test_expect_success 'If tag is created then tag message file is unlinked' '
 	test_path_is_missing .git/TAG_EDITMSG
 '
 
+test_expect_success 'If tag cannot be created then tag message file is not unlinked' '
+	test_when_finished "git tag -d foo/bar && rm .git/TAG_EDITMSG" &&
+	write_script fakeeditor <<-\EOF &&
+	echo Message >.git/TAG_EDITMSG
+	EOF
+	git tag foo/bar &&
+	test_must_fail env GIT_EDITOR=./fakeeditor git tag -a foo &&
+	test_path_exists .git/TAG_EDITMSG
+'
+
 test_done
-- 
2.40.1

