Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83E051F453
	for <e@80x24.org>; Fri,  9 Nov 2018 07:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbeKIRXY (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:23:24 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:59700
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728067AbeKIRXX (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Nov 2018 12:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1541749441;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=Z2y4zmci2wGOjRJUXxq7g7ieC+eKRnV6t9fkPom5fCI=;
        b=w+uMhzDhNeornbrqXIRr+LK5U4Tnbdx2w6emaWgoMvnxYuwIkZyumNDyLZj3Hj9x
        UXzkM8nq7xSI9fZzUhdHg0wBjcRwfqY/4LQgaocVixcAW1rtybLMgKqtlSyh6dgjbGl
        1voBI3w1jRdpCsPNNLjr5CHIl2WjMMT7Hth7oEik=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020166f76d851b-3a0f5414-48ce-4172-8200-0a59fd3f66d9-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020166f76d845f-1a02a31e-5094-4b27-974d-a23811066c58-000000@eu-west-1.amazonses.com>
References: <01020166f76d845f-1a02a31e-5094-4b27-974d-a23811066c58-000000@eu-west-1.amazonses.com>
Subject: [RFC PATCH 5/5] ref-filter: add docs for new options
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 9 Nov 2018 07:44:01 +0000
X-SES-Outgoing: 2018.11.09-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add documentation for formatting options objectsize:disk
and deltabase.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 Documentation/git-for-each-ref.txt | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 901faef1bfdce..22d2ff88110cd 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -128,13 +128,18 @@ objecttype::
 
 objectsize::
 	The size of the object (the same as 'git cat-file -s' reports).
-
+	Append `:disk` to get the size, in bytes, that the object takes up on
+	disk. See the note about on-disk sizes in the `CAVEATS` section below.
 objectname::
 	The object name (aka SHA-1).
 	For a non-ambiguous abbreviation of the object name append `:short`.
 	For an abbreviation of the object name with desired length append
 	`:short=<length>`, where the minimum length is MINIMUM_ABBREV. The
 	length may be exceeded to ensure unique object names.
+deltabase::
+	If the object is stored as a delta on-disk, this expands to the 40-hex
+	sha1 of the delta base object. Otherwise, expands to the null sha1
+	(40 zeroes). See `CAVEATS` section below.
 
 upstream::
 	The name of a local ref which can be considered ``upstream''
@@ -361,6 +366,20 @@ This prints the authorname, if present.
 git for-each-ref --format="%(refname)%(if)%(authorname)%(then) Authored by: %(authorname)%(end)"
 ------------
 
+CAVEATS
+-------
+
+Note that the sizes of objects on disk are reported accurately, but care
+should be taken in drawing conclusions about which refs or objects are
+responsible for disk usage. The size of a packed non-delta object may be
+much larger than the size of objects which delta against it, but the
+choice of which object is the base and which is the delta is arbitrary
+and is subject to change during a repack.
+
+Note also that multiple copies of an object may be present in the object
+database; in this case, it is undefined which copy's size or delta base
+will be reported.
+
 SEE ALSO
 --------
 linkgit:git-show-ref[1]

--
https://github.com/git/git/pull/552
