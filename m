From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/11] fixup! vcs-svn: Learn to parse variable-length integers
Date: Wed, 13 Oct 2010 04:19:54 -0500
Message-ID: <20101013091954.GB32608@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100810125317.GB3921@kytes>
 <20101011023435.GA706@burratino>
 <20101011040140.GC5649@burratino>
 <20101013091714.GA32608@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 11:23:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5xYQ-0005BR-VU
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 11:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518Ab0JMJXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 05:23:18 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63552 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab0JMJXR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 05:23:17 -0400
Received: by ywi6 with SMTP id 6so1390006ywi.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 02:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=aNPyeYBOmk0IfQj+oc9SvK3b14Ahu/ZW0WLfGubTpfQ=;
        b=Xs71o/ld26iBr2f+rxPPYAvb9/I8/VIauTSpxYdO4dgb7J3ssFQVFymm/PpcLUsC7/
         CXjGABgRUgL+j7MteFbDKzAS3H3o8KxVnJhV4ifQn6SiQdBzRsqR3GkWX8IUPvFTTmJS
         wTqkW4/H4YyjQ+AKCXvC68OYhd5CxEEiDOmr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PoGimaV5T10GQjLMfqRU6GSJaI7vOqMKqj93w6zQn8nz9Zf2a+bb4O7K/Y1NGRoz4A
         jbJMRePdD5gzETPyQYyhDUGNP/I9UwvZw8topfsOqgTs6nzn+roJvAyq1jQCBX+kbd7j
         rPgWgmc5Ja8sJXuDiQpML+IG/lLvr5UY7TxVM=
Received: by 10.236.95.9 with SMTP id o9mr15195306yhf.2.1286961794835;
        Wed, 13 Oct 2010 02:23:14 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id 29sm7249113yhl.5.2010.10.13.02.23.13
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 02:23:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101013091714.GA32608@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158914>

Report EOF correctly in integer parsing code.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This patch is meant for squashing.

 vcs-svn/svndiff.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index df0b1a2..36d2b30 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -45,7 +45,8 @@ static int read_int(struct line_buffer *in, uintmax_t *result, off_t *len)
 	while (sz) {
 		int ch = buffer_read_char(in);
 		if (ch == EOF)
-			break;
+			return error("Delta ends early (%"PRIu64" bytes remaining)",
+				     (uint64_t) sz);
 		sz--;
 		rv <<= VLI_BITS_PER_DIGIT;
 		rv += (ch & VLI_DIGIT_MASK);
-- 
1.7.2.3
