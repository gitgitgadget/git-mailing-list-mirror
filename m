From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix bugs in git_search_grep_body: it's length(),
	not len()
Date: Sat, 23 Feb 2008 22:37:08 +0100
Message-ID: <20080223213449.16213.42233.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jean-Baptiste Quenot <jbq@caraldi.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 22:38:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT248-0006Zq-U1
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 22:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755967AbYBWVhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 16:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755397AbYBWVhR
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 16:37:17 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:57949 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189AbYBWVhO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 16:37:14 -0500
Received: by py-out-1112.google.com with SMTP id u52so1572117pyb.10
        for <git@vger.kernel.org>; Sat, 23 Feb 2008 13:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc:date:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        bh=qWEm2i5OJ9UIVG+2ZIWuXmTOdLIJQ5KIqSo0A7tjDKI=;
        b=qZ8X9isozi3E1PDW1Nj8IrXVaklkJ56ISuOl3qrE6VYeXalzKsHG00A3bdbJRdN60e0wcNxh3F+JlkU5JhUScnoEbrPyxMcEzUzV6nrLDGyo01FgTlTK1wuI1nPW+zWFMZez5Qv29Z1VAia+QGTk9gQbzBotimXvScJtlg/Pb7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        b=ooUt55JjPNI5fUPbNLGC577jK+EE8A59dLYE2vnn3j1Hs4CcJic13UNpVKNvuD8hf7i4oyT3EMl27oMJVNgCgMKiKiibhfBEX0Z0fDVqTsGYm8kChVSCj0Opfuo3TyreWpquJ6SEsQbGfLVUxHPNaj3EC81asjFan3MhFHMuzII=
Received: by 10.65.213.4 with SMTP id p4mr1958793qbq.83.1203802633702;
        Sat, 23 Feb 2008 13:37:13 -0800 (PST)
Received: from localhost.localdomain ( [83.8.255.83])
        by mx.google.com with ESMTPS id b30sm5198882ika.11.2008.02.23.13.37.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Feb 2008 13:37:11 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1NLb8wo016253;
	Sat, 23 Feb 2008 22:37:09 +0100
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74857>


Use int(<expr>/2) to get integer value for a substring length.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I'm very very sorry. I though I have tested this, but somehow it
slipped through; most probably I have tested older version.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 326e27c..e8226b1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3792,7 +3792,7 @@ sub git_search_grep_body {
 			if ($line =~ m/^(.*)($search_regexp)(.*)$/i) {
 				my ($lead, $match, $trail) = ($1, $2, $3);
 				$match = chop_str($match, 70, 5);       # in case match is very long
-				my $contextlen = (80 - len($match))/2;  # is left for the remainder
+				my $contextlen = int((80 - length($match))/2); # for the remainder
 				$contextlen = 30 if ($contextlen > 30); # but not too much
 				$lead  = chop_str($lead,  $contextlen, 10);
 				$trail = chop_str($trail, $contextlen, 10);
