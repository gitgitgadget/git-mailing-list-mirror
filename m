From: =?UTF-8?Q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
Subject: [PATCH] gitweb: Output valid utf8 in git_blame_common('data')
Date: Mon, 28 Nov 2011 00:52:44 +0100
Message-ID: <CAKD0Uuxq+wLdRy5r_hz9qgjHkDmFHHbeAVkb07HizX9xaGMptw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 00:55:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUoZc-0002QD-HM
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 00:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab1K0XxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Nov 2011 18:53:08 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55070 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab1K0XxH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 18:53:07 -0500
Received: by wwp14 with SMTP id 14so7815411wwp.1
        for <git@vger.kernel.org>; Sun, 27 Nov 2011 15:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=vOXzA0GWCPY2sy75lf0C52Ww5Ebp7bIO5Wc8v3Dmvww=;
        b=Q232Mq77GCEqQpiT3D40NV71fehfYJ5vjQd75gNTAcSFNqpVyuk/36uVqEZ7KvMKFP
         1ApRr0wy1GPpHyrIfR7pkt2VCHNj5WWyl2FWEjHyrzjKcFbr6EF8ksbVvhfIhG0+3xxA
         oS7asLhT34SMe0g/8buj0XpYxTv6nqNuVbmDI=
Received: by 10.227.208.199 with SMTP id gd7mr13760717wbb.2.1322437985072;
 Sun, 27 Nov 2011 15:53:05 -0800 (PST)
Received: by 10.180.87.37 with HTTP; Sun, 27 Nov 2011 15:52:44 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185995>

With javascript-actions enabled gitweb showed broken author names in
the tooltips on blame pages.

Signed-off-by: Juergen Kreileder <jk@blackdown.de>
---
 gitweb/gitweb.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4f0c3bd..c863afe 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6107,7 +6107,9 @@ sub git_blame_common {
 			-type=>"text/plain", -charset => "utf-8",
 			-status=> "200 OK");
 		local $| = 1; # output autoflush
-		print while <$fd>;
+		while (my $line = <$fd>) {
+			print to_utf8($line);
+		}
 		close $fd
 			or print "ERROR $!\n";

-- 
1.7.5.4
