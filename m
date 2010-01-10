From: Dave Dulson <dave@dulson.com>
Subject: [PATCH/RFC 2/2] Remove $tagobjid from tagcontents population
Date: Sun, 10 Jan 2010 22:45:52 +0000
Message-ID: <2ee0b0aa1001101445u5962ec25y6fe612a70d283c92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 10 23:46:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NU6Xx-0007VH-7z
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 23:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244Ab0AJWqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 17:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754594Ab0AJWpy
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 17:45:54 -0500
Received: from mail-ew0-f214.google.com ([209.85.219.214]:48224 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570Ab0AJWpx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 17:45:53 -0500
Received: by mail-ew0-f214.google.com with SMTP id 6so21251053ewy.29
        for <git@vger.kernel.org>; Sun, 10 Jan 2010 14:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Iic0JmNRpbZ8s6eWZ2Lb8fHI9WDPlnP0F3/jxnw0z4Y=;
        b=Vrd3CwROhT+wnceBLSyvbL7Ze6zywLOiddGHQpk5jTl51QYd/r9cPMoVHp9sjFrfXc
         e/MSeS1m6ktI4HwF6OiePR5HSvYqYvv0iB/BeSlRk60R6X/1tp0QzbcinxvXSnmWxelC
         HHoZ0rYc5bIlcU5eyOD+SgC3a6xpz8SVIkqIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        b=dmvJ6ovQXDJzetp3LvZhIMQrPK3c+mQRDe41o2zvMNRG5OXr8KQI7hOPML1r1v6Yj8
         gGyJ9Np25/eIr15xW4g6H1Cl83Z4jnQerFOCJJO5LZqnjKiKfc/gmv1ZfhiAsdKAodra
         afG77A2C/eVaIXD8tnC7ca8ExoRW4aGsYvb+w=
Received: by 10.216.89.209 with SMTP id c59mr1816522wef.181.1263163552807; 
	Sun, 10 Jan 2010 14:45:52 -0800 (PST)
X-Google-Sender-Auth: 1f4c621c6d0660df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136592>

When the showtag proc is called directly after the tag has been
created rereadrefs hasn't been called, meaning the tag doesn't exist
in $tagobjid. This causes the cat-file to fail.
Instead of using $tagobjid, pass the $tag directly, ensuring the tag
contents are populated correctly.

Signed-off-by: David Dulson <dave@dulson.com>
---
 gitk |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index b34b481..65721e3 100755
--- a/gitk
+++ b/gitk
@@ -10482,7 +10482,7 @@ proc listrefs {id} {
 }

 proc showtag {tag isnew} {
-    global ctext tagcontents tagids linknum tagobjid
+    global ctext tagcontents tagids linknum

     if {$isnew} {
 	addtohistory [list showtag $tag 0] savectextpos
@@ -10493,7 +10493,7 @@ proc showtag {tag isnew} {
     set linknum 0
     if {![info exists tagcontents($tag)]} {
 	catch {
-	    set tagcontents($tag) [exec git cat-file tag $tagobjid($tag)]
+           set tagcontents($tag) [exec git cat-file tag $tag]
 	}
     }
     if {[info exists tagcontents($tag)]} {
-- 
1.6.6.75.g37bae.dirty
