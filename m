From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] Avoid segfault in diff --stat rename output.
Date: Mon, 22 May 2006 20:36:34 -0400
Message-ID: <BAYC1-PASMTP115C9137E5BDABD705881BAE9B0@CEZ.ICE>
References: <e7bda7770605221609h7c18c2ccpe92db34050d46f9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 02:43:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiKz3-0007oQ-H9
	for gcvg-git@gmane.org; Tue, 23 May 2006 02:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWEWAmb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 20:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWEWAmb
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 20:42:31 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:5102 "EHLO
	BAYC1-PASMTP11.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751201AbWEWAma (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 20:42:30 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP11.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 22 May 2006 17:47:22 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 2A7F7644C28;
	Mon, 22 May 2006 20:42:29 -0400 (EDT)
To: "Torgil Svensson" <torgil.svensson@gmail.com>
Message-Id: <20060522203634.2f7b0613.seanlkml@sympatico.ca>
In-Reply-To: <e7bda7770605221609h7c18c2ccpe92db34050d46f9f@mail.gmail.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 23 May 2006 00:47:22.0468 (UTC) FILETIME=[73CFF240:01C67E02]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
---
 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

On Tue, 23 May 2006 01:09:43 +0200
"Torgil Svensson" <torgil.svensson@gmail.com> wrote:

> Hi
> 
> It seems like git-diff-tree has some problems with moved files:
> 
> $ git-diff-tree -p --stat --summary -M
> 348f179e3195448cea49c98a79cce8c7f446ce26
> 343ca16424ba031b37e4df49afddaee098a8f347 | wc -l
> *** glibc detected *** free(): invalid pointer: 0x12ecbbf0 ***
> 6101


diff --git a/diff.c b/diff.c
index 7f35e59..a7bb9b9 100644
--- a/diff.c
+++ b/diff.c
@@ -237,7 +237,7 @@ static char *pprint_rename(const char *a
 		if (a_midlen < 0) a_midlen = 0;
 		if (b_midlen < 0) b_midlen = 0;
 
-		name = xmalloc(len_a + len_b - pfx_length - sfx_length + 7);
+		name = xmalloc(pfx_length + a_midlen + b_midlen + sfx_length + 7);
 		sprintf(name, "%.*s{%.*s => %.*s}%s",
 			pfx_length, a,
 			a_midlen, a + pfx_length,
-- 
1.3.GIT
