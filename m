From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [BUG] gitweb: XSS vulnerability of RSS feed
Date: Tue, 13 Nov 2012 00:09:05 +0100
Message-ID: <m2ip9apgfi.fsf@igel.home>
References: <20121111232820.284510@gmx.net>
	<CAM9Z-n=6xsC7yiKJ+NU-CxNPxEXWmJzvXLUocgZgWPQnuK6G4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: glpk xypron <xypron.glpk@gmx.de>, git@vger.kernel.org,
	jnareb@gmail.com, Junio C Hamano <gitster@pobox.com>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 00:09:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY38B-0006U0-7s
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 00:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080Ab2KLXJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 18:09:12 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:56448 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010Ab2KLXJL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 18:09:11 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Y0nhy3lPqz4KK3w;
	Tue, 13 Nov 2012 00:09:06 +0100 (CET)
X-Auth-Info: 24ETuxX1fsdNooEjoWWqpdy64FPNJZNP7/Ibh9J3ZAY=
Received: from igel.home (ppp-93-104-135-112.dynamic.mnet-online.de [93.104.135.112])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Y0nhy3LPzzbbh9;
	Tue, 13 Nov 2012 00:09:06 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 1CDEDCA2A4; Tue, 13 Nov 2012 00:09:06 +0100 (CET)
X-Yow: Everything will be ALL RIGHT if we can just remember things about
 ALGEBRA.. or SOCCER..  or SOCIALISM..
In-Reply-To: <CAM9Z-n=6xsC7yiKJ+NU-CxNPxEXWmJzvXLUocgZgWPQnuK6G4Q@mail.gmail.com>
	(Drew Northup's message of "Mon, 12 Nov 2012 13:55:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209540>

Drew Northup <n1xim.email@gmail.com> writes:

> Something like this may be useful to defuse the "file" parameter, but
> I presume a more definitive fix is in order...

A proper fix will have to add esc_html to the feed generation, something
like this (untested):

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 10ed9e5..a51a8ba 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -8055,6 +8055,7 @@ sub git_feed {
 		$feed_type = 'history';
 	}
 	$title .= " $feed_type";
+	$title = esc_html($title);
 	my $descr = git_get_project_description($project);
 	if (defined $descr) {
 		$descr = esc_html($descr);


Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
