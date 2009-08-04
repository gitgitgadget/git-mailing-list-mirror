From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH v2] Let mailsplit and mailinfo handle mails with CRLF
	line-endings
Date: Tue, 4 Aug 2009 23:03:27 +0200
Message-ID: <20090804210327.GA23747@blimp.localdomain>
References: <4A7735B0.2040703@zytor.com> <81b0412b0908032335s3363849aj32a0e93efa15c012@mail.gmail.com> <7v7hxk5b4y.fsf@alter.siamese.dyndns.org> <20090804172638.GA15136@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 23:03:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYRAf-0007pD-AC
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 23:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbZHDVDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 17:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754726AbZHDVDg
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 17:03:36 -0400
Received: from mout2.freenet.de ([195.4.92.92]:37580 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752680AbZHDVDg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 17:03:36 -0400
Received: from [195.4.92.18] (helo=8.mx.freenet.de)
	by mout2.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #92)
	id 1MYRAS-0005Fn-OO; Tue, 04 Aug 2009 23:03:32 +0200
Received: from x7bb5.x.pppool.de ([89.59.123.181]:52266 helo=tigra.home)
	by 8.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #93)
	id 1MYRAS-0000dt-Gz; Tue, 04 Aug 2009 23:03:32 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id D505B277D8;
	Tue,  4 Aug 2009 23:03:27 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 95C2236D28; Tue,  4 Aug 2009 23:03:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090804172638.GA15136@blimp.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-purgate-ID: 149285::1249419812-00005325-CE2A70B6/0-0/0-0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124810>

Noticed by H. Peter Anvin.

It is not that uncommon to have mails with DOS line-ending,
notably Thunderbird and web mailers like Gmail (when saving
what they call "original" message).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Corrected bug with unconditonal last (or very long) line shortening if
it contains a CR in next-to-last character. Noticed by Sverre Rabbelier.

It should also handle the case mentioned by Brandon Casey.

 builtin-mailsplit.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index ad5f6b5..48285a0 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -58,6 +58,8 @@ int read_line_with_nul(char *buf, int size, FILE *in)
 		if (c == '\n' || len + 1 >= size)
 			break;
 	}
+	if (c == '\n' && len > 1 && buf[len - 2] == '\r')
+		buf[--len - 1] = '\n';
 	buf[len] = '\0';
 
 	return len;
-- 
1.6.4.34.gc3135e
