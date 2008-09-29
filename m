From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: remove PATH_INFO from $my_url and $my_uri
Date: Mon, 29 Sep 2008 15:07:42 +0200
Message-ID: <1222693662-27426-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 15:08:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkIUC-0002Qc-1I
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 15:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbYI2NHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 09:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbYI2NHM
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 09:07:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:64820 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbYI2NHL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 09:07:11 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1427598fgg.17
        for <git@vger.kernel.org>; Mon, 29 Sep 2008 06:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=OUz/uQIrCRtpHAbWNAJAmNqICDOTdiLo1lIg9Ons6w4=;
        b=u1WCNCBFycm0XrY0yNJsBMFlJp+MhT+kr6jBK/U2g4DFDqjB22nzF5QAEOwYz4Fd8a
         kFzpfohtdrU7Rjs7FkYD3IKTxnv/S0dCEoWr+vn4+RAbxAkvMSUl27wbmU6stBPUlU4u
         bDYdKlF8tdg+FMTENFSMZmVW3m03X/6h5aSt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=g/zmywv6JHZRsTxNRGihBbWrMRigaFUCz3m19DP+gjB30OIE/AvqWXFQ54/FV29f/w
         2Ufhzu7Y07fqKROfmZh3LUOZTHJew+WqUJ/YDbm3u+gbSCj+85o/kOb3dyQMJ36RjV0Q
         8i8eAqXIz9op8S6awVZ/BSPTJedb28wssxSf0=
Received: by 10.180.212.1 with SMTP id k1mr2228792bkg.58.1222693630041;
        Mon, 29 Sep 2008 06:07:10 -0700 (PDT)
Received: from localhost ([78.15.6.228])
        by mx.google.com with ESMTPS id 28sm137792fkx.1.2008.09.29.06.07.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Sep 2008 06:07:09 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97009>

This patch fixes PATH_INFO handling by removing the relevant part from
$my_url and $my_uri, thus making it unnecessary to specify them by hand
in the gitweb configuration.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index da474d0..ffe3dbf 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -27,6 +27,13 @@ our $version = "++GIT_VERSION++";
 our $my_url = $cgi->url();
 our $my_uri = $cgi->url(-absolute => 1);
 
+# if we're called with PATH_INFO, we have to strip that
+# from the URL to find our real URL
+if (my $path_info = $ENV{"PATH_INFO"}) {
+	$my_url =~ s,\Q$path_info\E$,,;
+	$my_uri =~ s,\Q$path_info\E$,,;
+}
+
 # core git executable to use
 # this can just be "git" if your webserver has a sensible PATH
 our $GIT = "++GIT_BINDIR++/git";
-- 
1.5.6.5
