Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2D3020A1E
	for <e@80x24.org>; Mon, 24 Dec 2018 13:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbeLXNYc (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 08:24:32 -0500
Received: from a7-10.smtp-out.eu-west-1.amazonses.com ([54.240.7.10]:49730
        "EHLO a7-10.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbeLXNYc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 24 Dec 2018 08:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1545657870;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=QqsQOMsAKbX8VhSWwkhRkBkLAD9uhddMbS7hwh+Laik=;
        b=SVziePt/A3+0idsbqV8PdNmH2I6beFj5F9BTuXr3rFIczK7gdvHL2SJRJjKIU+07
        BSnECTfGIc38DI4OHfWPwi3g8KaVTYQY6SxtO34n9By+yedWteRITZvxOR31aQGhbC9
        iuGUV2t45zL2DU4y0u+1xyeMQQFEUK8EItMeUTBU=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020167e0636912-b5ab3444-ff8a-4958-916e-e155a80dcc37-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020167e063687c-37a43a09-0a5f-4335-8c21-ec15a0a67882-000000@eu-west-1.amazonses.com>
References: <01020167e063687c-37a43a09-0a5f-4335-8c21-ec15a0a67882-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 6/6] ref-filter: add docs for new options
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Dec 2018 13:24:30 +0000
X-SES-Outgoing: 2018.12.24-54.240.7.10
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
index 901faef1bfdce..774cecc7ede78 100644
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
+	This expands to the object name of the delta base for the
+	given object, if it is stored as a delta.  Otherwise it
+	expands to the null object name (all zeroes).
 
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
