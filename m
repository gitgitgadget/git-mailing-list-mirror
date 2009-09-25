From: Christian Himpel <chressie@googlemail.com>
Subject: [PATCH 1/2] git-am: fixed patch_format detection according to
 RFC2822
Date: Fri, 25 Sep 2009 17:14:31 +0200
Message-ID: <d7d039c304614d8d39fd2e7ad8d036a77121cc4f.1253891124.git.chressie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 25 17:14:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrCVK-0000XR-OU
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 17:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbZIYPOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 11:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752860AbZIYPO3
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 11:14:29 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:33142 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839AbZIYPO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 11:14:29 -0400
Received: by fxm18 with SMTP id 18so2275850fxm.17
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=9ITkT1Pdluu9O2SeYlzc4YBUS9HNtfxnrHjbdZ9hlqk=;
        b=Y5fFsQwfovmVcyFOpeQ+digu7g7Ugbx6/TkWIo830ctElfWs2ilGHGNMD4rGiyLH9n
         Lg44mPxZdAXUzvcxUt21/woFNZfh+sNOHpD2/CNSgAeVRjVkhgHPG52IZhKBqiPEMe8M
         XsgcYdlGLsu2cXXLBWwZzGxtqWiwl9wdWcSCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=W8gzWHtGwDyrCvhd6X4J08XOo9WJ/YfyqhPgVmogSvOUcz7n0T2tKQDWXG/AK5DWeW
         IAZuJbqYnauLGKm8K9c1cjpTFAdGgusPUp2u0U0ypOHb65na29BJhig+GrmQY1MHIUda
         UlwlpzJiIve8eGQ1Xizcu6/YmqPaZxRQOS2wY=
Received: by 10.204.154.131 with SMTP id o3mr228083bkw.66.1253891672227;
        Fri, 25 Sep 2009 08:14:32 -0700 (PDT)
Received: from mrslave (HSI-KBW-078-043-091-043.hsi4.kabel-badenwuerttemberg.de [78.43.91.43])
        by mx.google.com with ESMTPS id c28sm3596047fka.56.2009.09.25.08.14.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Sep 2009 08:14:31 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129090>

RFC2822 specifies in paragraph 3.6.8, that optional header fields are
made up of any printable US-ASCII character except ' ' (space) and ':'
(colon).

The pattern for the egrep command is changed to match all of these
characters.

Signed-off-by: Christian Himpel <chressie@gmail.com>
---

Hi,

I had a problem with applying a patch with 'git am', because the one
header fields in the patch-e-mail contained numbers.  So I read the
RFC2822 what they say about header fields.  Unbelievable but any
printable character except space and colon are allowed in header fields.
So I changed the egrep expression according to this rule.

Regards,
chressie


 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 26ffe70..0ddd80f 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -205,7 +205,7 @@ check_patch_format () {
 			# and see if it looks like that they all begin with the
 			# header field names...
 			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p "$1" |
-			egrep -v '^[A-Za-z]+(-[A-Za-z]+)*:' >/dev/null ||
+			egrep -v '^[!-9;-~]+:' >/dev/null ||
 			patch_format=mbox
 		fi
 	} < "$1" || clean_abort
-- 
1.6.4.4
