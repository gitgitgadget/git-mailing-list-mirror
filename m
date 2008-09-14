From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/16] checkout_entry(): CE_NO_CHECKOUT on checked out entries.
Date: Sun, 14 Sep 2008 20:07:57 +0700
Message-ID: <1221397685-27715-9-git-send-email-pclouds@gmail.com>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
 <1221397685-27715-2-git-send-email-pclouds@gmail.com>
 <1221397685-27715-3-git-send-email-pclouds@gmail.com>
 <1221397685-27715-4-git-send-email-pclouds@gmail.com>
 <1221397685-27715-5-git-send-email-pclouds@gmail.com>
 <1221397685-27715-6-git-send-email-pclouds@gmail.com>
 <1221397685-27715-7-git-send-email-pclouds@gmail.com>
 <1221397685-27715-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 15:10:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KerMx-0005vw-Ff
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 15:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbYINNJP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 09:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754132AbYINNJP
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 09:09:15 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:21050 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828AbYINNJN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 09:09:13 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1590748wfd.4
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 06:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=EuSD3JKxEEDzlmN4AutMbCqIV2eHJxTtisxMVCFjz2Q=;
        b=ksnDYvu6ju44fgkYb8inRRqKZLLbLq4ZtzUrI7jjvWskaVUcmXwJBPlyhF1JXZBym4
         /LABYqiZ3oLL6WlmYeMzoVwt+Ctz2Rrx7ghgdYEQgdIIcu6FX7GZyUSvYWXmZT+KnrrK
         Z24ARezhXqDgB5/NyXdi2FLq8K7FjntEOCSuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=cb2iEUaHECs/dUjWP5h36teu7IuWToFp2PFT0bof9+qfEbmXLMs4GVr8r8+YjHxzCP
         ejEVJpafaf2rcNS2W7ClEaoANl1gSzhVaN7eowkPsyngKJ9IZaigcm+36goK77eFvfdB
         qDWQl6q19Z7sdvOMzMsp4QIIohFFRGGeNSKdY=
Received: by 10.142.128.6 with SMTP id a6mr2254519wfd.331.1221397753657;
        Sun, 14 Sep 2008 06:09:13 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.40.147])
        by mx.google.com with ESMTPS id 20sm20089213wfi.11.2008.09.14.06.09.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 06:09:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Sep 2008 20:09:06 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221397685-27715-8-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95835>

With this you can just do "git checkout some-files" to
widen your checkout. One caveat though: caller must save
the index.

=46or all of its callers (unpack_trees(), checkout-index, checkout
and apply), only "git apply" does not write index back.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 entry.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/entry.c b/entry.c
index aa2ee46..305f8d3 100644
--- a/entry.c
+++ b/entry.c
@@ -230,5 +230,6 @@ int checkout_entry(struct cache_entry *ce, const st=
ruct checkout *state, char *t
 	} else if (state->not_new)
 		return 0;
 	create_directories(path, state);
+	ce_mark_checkout(ce);
 	return write_entry(ce, path, state, 0);
 }
--=20
1.6.0.96.g2fad1.dirty
