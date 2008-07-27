From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) 4/6] gitk: Fixed broken exception handling in diff.
Date: Sun, 27 Jul 2008 10:20:53 +0400
Organization: TEPKOM
Message-ID: <200807271020.53171.angavrilov@gmail.com>
References: <200807271017.23272.angavrilov@gmail.com> <200807271019.17267.angavrilov@gmail.com> <200807271020.02415.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 27 08:22:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMzdt-0003Pc-DO
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 08:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbYG0GVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 02:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753271AbYG0GVE
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 02:21:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:54108 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbYG0GVC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 02:21:02 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1893254fgg.17
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 23:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9BtUbU3fWuNckZcwsa6KoQ+CLb9WvKwQprTl1hnucvo=;
        b=PoG+zHLLEj8hCXLt/lQ8uUmy7O6Shjb44AVzQRpc8h6hxkrj4kYyG9LlUxNrPSAgV4
         iu3pPoi9+PwferJUpRGis0fH8itHNLhhRE1STj4aWFWkOy3fnINqY18GR1zRg/VV0McF
         7CzkkmwKvu6AvV0w+PUvN1mjEvefFfGPs7KcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EGmadq/TiSPLd+hGkbpM2IfycHyozJ/MjAbyVEv2E1MgTeqwRWozRFBq9Z4Hbk6ULl
         qykz/cEVfo9jmdTbZgo024sKl98KGAYoxsl4GtoBpzVLQv6yFG1xa3Be44qeOil15LGR
         yKsnEdzrjQw7c/NUeofiAjYMADftpSDZi5g+c=
Received: by 10.86.95.20 with SMTP id s20mr1394060fgb.65.1217139661140;
        Sat, 26 Jul 2008 23:21:01 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id e20sm7395166fga.1.2008.07.26.23.21.00
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jul 2008 23:21:00 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200807271020.02415.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90318>

Date: Sat, 26 Jul 2008 18:48:41 +0400

If the tree diff command failed to start for some
random reason, treepending remained set, and thus
no more diffs were shown after that.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index d7fea26..abb6542 100755
--- a/gitk
+++ b/gitk
@@ -6457,9 +6457,10 @@ proc diffcmd {ids flags} {
 proc gettreediffs {ids} {
     global treediff treepending
 
+    if {[catch {set gdtf [open [diffcmd $ids {--no-commit-id}] r]}]} return
+
     set treepending $ids
     set treediff {}
-    if {[catch {set gdtf [open [diffcmd $ids {--no-commit-id}] r]}]} return
     fconfigure $gdtf -blocking 0
     filerun $gdtf [list gettreediffline $gdtf $ids]
 }
-- 
1.5.6.3.18.gfe82
