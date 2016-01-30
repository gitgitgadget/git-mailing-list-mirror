From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH 3/5] notes: read copied notes with strbuf_getline()
Date: Sat, 30 Jan 2016 19:05:07 +0100
Message-ID: <56ACFB53.7070400@moritzneeb.de>
References: <56ACF82B.2030005@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 30 19:06:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPZuX-00079g-Pp
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 19:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933235AbcA3SGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 13:06:08 -0500
Received: from moritzneeb.de ([78.47.1.106]:48379 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933064AbcA3SGF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 13:06:05 -0500
Received: from [192.168.1.11] (x4db33e5e.dyn.telefonica.de [77.179.62.94])
	by moritzneeb.de (Postfix) with ESMTPSA id 317521C04F
	for <git@vger.kernel.org>; Sat, 30 Jan 2016 19:06:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1454177164;
	bh=yg7p9qOLH9owKwZMtleQE7SahPRzq4f5Fel2kYRtBrg=;
	h=From:Subject:References:To:Date:In-Reply-To:From;
	b=mx70VrolhxEVS1SDZbSmAegFU1pqtqGFOdZRARPDxidBLXCOHmhCC4VjQAmGkEf+9
	 91SbPj4CDLgEDVwoPyn4pUn8wqBvqsvjpXvZjHCHUfza2Fnj7HbE9bTRnSeOKRmSA7
	 URr7bqRjaa6NkG2c4XjJeL7kLunhOd/hUoLbA37k=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56ACF82B.2030005@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285119>

    The notes that are copied from stdin are trimmed with strbuf_rtrim()
    after splitting by ' '. There is thus no logic expecting CR, so
    strbuf_getline_lf() can be replaced by its CRLF counterpart.

Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---
 builtin/notes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index ed6f222..bbd7544 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -290,7 +290,7 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 		t = &default_notes_tree;
 	}
 -	while (strbuf_getline_lf(&buf, stdin) != EOF) {
+	while (strbuf_getline(&buf, stdin) != EOF) {
 		unsigned char from_obj[20], to_obj[20];
 		struct strbuf **split;
 		int err;
-- 
2.4.3
