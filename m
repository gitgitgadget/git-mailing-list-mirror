Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9F2C433E1
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A83720776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Z5NM84vT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405187AbgFSR5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39658 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404868AbgFSR46 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:58 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 34FD360A5C;
        Fri, 19 Jun 2020 17:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589381;
        bh=WY3PBUcXZxcwrx1+8moTMqCV5IR1KmrTN41x3B0zcEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Z5NM84vTL6awN91aymY0dbhXV9eZutiQfrT5ytGvLxDoYsLNAd1Ajb/WEsfTh1KxH
         7uJeMBkn/E36FjiKNaHluGcQPEGqAhG5KG+n9zl//Q2oD6TBTWqRNH6FglH8bayIyN
         K9Yr03StnX70O7258iNzAoV60FNRNFRa2mcWLsES8akIMs1UuesW+SAZH0++UmOxAB
         Gs9/SzoeHwrOl59kHrWHDxo3/xMeHaMhcArZDAHdFQ/b8ZV4HAjes3BG9PuziUV+TE
         0vVTPfbFeBMcY9ZLMdhWsdzhBND2UT8eJuSJ41Nu4ok85syXPPwqQepYcpRJjLH63/
         hQqiQDyovsMiaCQmQAan+UY51YV6xPs3zoinE4q2HDR/sDrO5h/uq9X/q02wwB+y5W
         C3un+8PdTkGiCUQrEK5TWW7+Ru/qdjHflWOdMVK00/h+cVleflmS3y8QbxXKDS4MJs
         ST/XpWP/u6xWgPYCOWw7USbqBN3N8VQQ7IkVoArhhT2hzREmSCH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 16/44] docs: update remote helper docs for object-format extensions
Date:   Fri, 19 Jun 2020 17:55:33 +0000
Message-Id: <20200619175601.569856-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the remote helper docs to document the object-format extensions
we will implement in remote-curl and the transport helper code shortly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitremote-helpers.txt | 33 +++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 93baeeb029..6f1e269ae4 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -238,6 +238,9 @@ the remote repository.
 	`--signed-tags=verbatim` to linkgit:git-fast-export[1].  In the
 	absence of this capability, Git will use `--signed-tags=warn-strip`.
 
+'object-format'::
+	This indicates that the helper is able to interact with the remote
+	side using an explicit hash algorithm extension.
 
 
 COMMANDS
@@ -257,12 +260,14 @@ Support for this command is mandatory.
 'list'::
 	Lists the refs, one per line, in the format "<value> <name>
 	[<attr> ...]". The value may be a hex sha1 hash, "@<dest>" for
-	a symref, or "?" to indicate that the helper could not get the
-	value of the ref. A space-separated list of attributes follows
-	the name; unrecognized attributes are ignored. The list ends
-	with a blank line.
+	a symref, ":<keyword> <value>" for a key-value pair, or
+	"?" to indicate that the helper could not get the value of the
+	ref. A space-separated list of attributes follows the name;
+	unrecognized attributes are ignored. The list ends with a
+	blank line.
 +
 See REF LIST ATTRIBUTES for a list of currently defined attributes.
+See REF LIST KEYWORDS for a list of currently defined keywords.
 +
 Supported if the helper has the "fetch" or "import" capability.
 
@@ -432,6 +437,18 @@ attributes are defined.
 	This ref is unchanged since the last import or fetch, although
 	the helper cannot necessarily determine what value that produced.
 
+REF LIST KEYWORDS
+-----------------
+
+The 'list' command may produce a list of key-value pairs.
+The following keys are defined.
+
+'object-format'::
+	The refs are using the given hash algorithm.  This keyword is only
+	used if the server and client both support the object-format
+	extension.
+
+
 OPTIONS
 -------
 
@@ -516,6 +533,14 @@ set by Git if the remote helper has the 'option' capability.
 	transaction.  If successful, all refs will be updated, or none will.  If the
 	remote side does not support this capability, the push will fail.
 
+'option object-format' {'true'|algorithm}::
+	If 'true', indicate that the caller wants hash algorithm information
+	to be passed back from the remote.  This mode is used when fetching
+	refs.
++
+If set to an algorithm, indicate that the caller wants to interact with
+the remote side using that algorithm.
+
 SEE ALSO
 --------
 linkgit:git-remote[1]
