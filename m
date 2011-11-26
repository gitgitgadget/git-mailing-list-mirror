From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH] honour GIT_ASKPASS for querying username in git-svn
Date: Sat, 26 Nov 2011 12:33:31 +0100
Message-ID: <4ED0CE8B.70205@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 12:33:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUGVh-0000JH-Jx
	for gcvg-git-2@lo.gmane.org; Sat, 26 Nov 2011 12:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589Ab1KZLd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Nov 2011 06:33:28 -0500
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:61485 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254Ab1KZLd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2011 06:33:27 -0500
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 7BE4E42207E;
	Sat, 26 Nov 2011 12:33:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=0lr6JcXPnZU0K01p2zT90anYJ7U=; b=448i1OMVDyLCX4le/2NtViuja2fm
	0lL9m4kKQjh1VgD5EcDhebdgdiVpq5tfEw9iieV5G7TgX0GYaHxrd5f2mvC+kvZQ
	x61CkmE5OUryjAzT9vp6h8Og41t1owZHjReU9VdCGYuSj98ilSSuKguXP7fGqmnK
	r3BQB3+L732kswo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=of2Oryljjo2FJFBiHtKiAwIjgrpIOd2vcdbiGNmV9onNSl031uywxJI
	OctdS0oJ38ItQ2PgL664y6DcORfXzSMFeCbig3ANXyVRxjrl2oktuC3CszqmHe9w
	EDsz/uuexwxXoWlhdquSp+J4CAh5/3hstk/YLnwlUWlEzKltXlJw=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 3E91742204F;
	Sat, 26 Nov 2011 12:33:25 +0100 (CET)
Received: from [91.4.123.74] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.2)
  with ESMTPSA id 23911624; Sat, 26 Nov 2011 12:33:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
X-Enigmail-Version: 1.3.3
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185951>

Hi,

there's also another point where git-svn doesn't honour GIT_ASKPASS:

>From 632c264d0de127c35fbe45866ed81e832f357d56 Mon Sep 17 00:00:00 2001
From: Sven Strickroth <email@cs-ware.de>
Date: Sat, 26 Nov 2011 12:01:19 +0100
Subject: [PATCH] honour GIT_ASKPASS for querying further actions on unknown
 certificates

git-svn reads user answers from an interactive terminal.
This behavior cause GUIs to hang waiting for git-svn to
complete.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 git-svn.perl |   9 +++++++++--
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index e30df22..d7aeb11 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4361,7 +4361,14 @@ prompt:
 	      "(R)eject, accept (t)emporarily or accept (p)ermanently? " :
 	      "(R)eject or accept (t)emporarily? ";
 	STDERR->flush;
-	$choice = lc(substr(<STDIN> || 'R', 0, 1));
+	if (exists $ENV{GIT_ASKPASS}) {
+		print STDERR "\n";
+		open(PH, "-|", $ENV{GIT_ASKPASS}, "Certificate unknown");
+		$choice = lc(substr(<PH> || 'R', 0, 1));
+		close(PH);
+	} else {
+		$choice = lc(substr(<STDIN> || 'R', 0, 1));
+	}
 	if ($choice =~ /^t$/i) {
 		$cred->may_save(undef);
 	} elsif ($choice =~ /^r$/i) {
-- 
1.7.7.1.msysgit.0

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
