Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E3DC46467
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 18:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjASSTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 13:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjASSTl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 13:19:41 -0500
Received: from smtp-out-2.talktalk.net (smtp-out-2.talktalk.net [62.24.135.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA3C86A8
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 10:19:38 -0800 (PST)
Received: from localhost.localdomain ([88.110.98.79])
        by smtp.talktalk.net with SMTP
        id IZUipjyTdLVi2IZUipC7TI; Thu, 19 Jan 2023 18:18:36 +0000
X-Originating-IP: [88.110.98.79]
X-Spam: 0
X-OAuthority: v=2.3 cv=H8GlPNQi c=1 sm=1 tr=0 a=qs8Jj6vsB7NiZ+3IlNxB6Q==:117
 a=qs8Jj6vsB7NiZ+3IlNxB6Q==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=7a1DmALN0UtMUJkjXpMA:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>,
        self <philipoakley@iee.email>
Subject: [PATCH v5 1/5] doc: pretty-formats: separate parameters from placeholders
Date:   Thu, 19 Jan 2023 18:18:23 +0000
Message-Id: <20230119181827.1319-2-philipoakley@iee.email>
X-Mailer: git-send-email 2.39.1.windows.1
In-Reply-To: <20230119181827.1319-1-philipoakley@iee.email>
References: <20221112143616.1429-1-philipoakley@iee.email>
 <20230119181827.1319-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGTp0OUqD3NGPy3/1ba5RpzvzF0pUJsTRnGtJrNXAOebb88jZKzL8tJoeIccMntvl6Pg6HkLx1s3kCowat7FEpQbN85CobO5YByUIQHQnRXntpxuAym2
 dk+wzCTKl+oE0DA7dylFuv7uovCJOkr+PMA7kIbVOxdCcuyxO2/+J8VGU700eqVpPDNGOI1f8En1ynj2+O/KawNK6YTsyg0tzGjmBgcD9AXen7pX3F8YGQy/
 5eEf8+yoJWOZQDxwMm+LWrZ5VEW3GWAzKIevySyYsPR4yMoTYWxDLlG+jm9M0suNGMpJFLV2k9BuSOp/TkokRg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit a57523428b4 (pretty: support padding placeholders, %< %> and %><,
2013-04-19) introduced columnated place holders. These placeholders
can be confusing as they contain `<` and `>` characters as part
of their placeholders adjacent to the `<N>` parameters.

Add spaces either side of the `<N>` parameters in the title line.
The code (strtol) will consume any spaces around the number values
(assuming they are passed as a quoted string with spaces).
Note that the spaces are optional.

Subsequent commits will clarify other confusions.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 Documentation/pretty-formats.txt | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 0b4c1c8d98..02bec23509 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -146,24 +146,27 @@ The placeholders are:
 '%m':: left (`<`), right (`>`) or boundary (`-`) mark
 '%w([<w>[,<i1>[,<i2>]]])':: switch line wrapping, like the -w option of
 			    linkgit:git-shortlog[1].
-'%<(<N>[,trunc|ltrunc|mtrunc])':: make the next placeholder take at
+'%<( <N> [,trunc|ltrunc|mtrunc])':: make the next placeholder take at
 				  least N columns, padding spaces on
 				  the right if necessary.  Optionally
 				  truncate at the beginning (ltrunc),
 				  the middle (mtrunc) or the end
 				  (trunc) if the output is longer than
-				  N columns.  Note that truncating
+				  N columns.
+				  Note 1: that truncating
 				  only works correctly with N >= 2.
-'%<|(<N>)':: make the next placeholder take at least until Nth
+				  Note 2: spaces around the N
+				  values are optional.
+'%<|( <N> )':: make the next placeholder take at least until Nth
 	     columns, padding spaces on the right if necessary
-'%>(<N>)', '%>|(<N>)':: similar to '%<(<N>)', '%<|(<N>)' respectively,
+'%>( <N> )', '%>|( <N> )':: similar to '%<( <N> )', '%<|( <N> )' respectively,
 			but padding spaces on the left
-'%>>(<N>)', '%>>|(<N>)':: similar to '%>(<N>)', '%>|(<N>)'
+'%>>( <N> )', '%>>|( <N> )':: similar to '%>( <N> )', '%>|( <N> )'
 			  respectively, except that if the next
 			  placeholder takes more spaces than given and
 			  there are spaces on its left, use those
 			  spaces
-'%><(<N>)', '%><|(<N>)':: similar to '%<(<N>)', '%<|(<N>)'
+'%><( <N> )', '%><|( <N> )':: similar to '%<( <N> )', '%<|( <N> )'
 			  respectively, but padding both sides
 			  (i.e. the text is centered)
 
-- 
2.39.1.windows.1

