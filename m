From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] fixup! git-remote-testpy: fix path hashing on Python 3
Date: Mon, 28 Jan 2013 11:20:43 +0000
Message-ID: <20130128112043.GZ7498@serenity.lan>
References: <cover.1358686905.git.john@keeping.me.uk>
 <611a44568bdc969bcfa3d7d870560855e00baf1e.1358686905.git.john@keeping.me.uk>
 <20130126175158.GK7498@serenity.lan>
 <7vwquzzkiw.fsf@alter.siamese.dyndns.org>
 <5104B0B5.1030501@alum.mit.edu>
 <20130127141329.GN7498@serenity.lan>
 <20130127145056.GP7498@serenity.lan>
 <51065692.9000708@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 28 12:30:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzmut-00046i-3N
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 12:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609Ab3A1L37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 06:29:59 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:60019 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab3A1L37 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 06:29:59 -0500
X-Greylist: delayed 546 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jan 2013 06:29:59 EST
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id C1AF96064FE;
	Mon, 28 Jan 2013 11:20:52 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rEcYQTaNc8HE; Mon, 28 Jan 2013 11:20:52 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 52638606516;
	Mon, 28 Jan 2013 11:20:52 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 37E90161E54E;
	Mon, 28 Jan 2013 11:20:52 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ph0TKeN4WglK; Mon, 28 Jan 2013 11:20:52 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 4240C161E34E;
	Mon, 28 Jan 2013 11:20:45 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <51065692.9000708@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214833>

---
On Mon, Jan 28, 2013 at 11:44:34AM +0100, Michael Haggerty wrote:
> NAK.  It is still not right.  If the locale is not utf-8 based, then it
> is incorrect to re-encode the string using utf-8.  I think you really
> have to use sys.getfilesystemencoding() as I suggested.

If you'd asked me what the patch contained I would have said it did use
getfilesystemencoding(), but I can't disbelieve my own eyes :-(

Junio, please can you squash this in?

 git-remote-testpy.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-remote-testpy.py b/git-remote-testpy.py
index 6098bdd..ca67899 100644
--- a/git-remote-testpy.py
+++ b/git-remote-testpy.py
@@ -49,7 +49,7 @@ def encode_filepath(path):
     """
     if sys.hexversion < 0x03000000:
         return path
-    return path.encode('utf-8', 'surrogateescape')
+    return path.encode(sys.getfilesystemencoding(), 'surrogateescape')
 
 
 def get_repo(alias, url):
-- 
1.8.1.1
