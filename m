From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH 2/3] perl/Git.pm: Honor SSH_ASKPASS as fallback if GIT_ASKPASS
 is not set
Date: Tue, 18 Dec 2012 01:28:47 +0100
Message-ID: <50CFB8BF.4000405@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de> <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de> <7v39c41keo.fsf@alter.siamese.dyndns.org> <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4F00B7F3.1060105@tu-clausthal.de> <4F038E49.9080809@tu-clausthal.de> <7vy5toqqab.fsf@alter.siamese.dyndns.org> <7vmwzzqwud.fsf@alter.siamese.dyndns.org> <509FD4F6.5050606@gym-oha.de> <50B11AF5.2090701@tu-clausthal.de> <7vtxsdvug3.fsf@alter.siamese.dyndns.org> <50CF4020.4090901@tu-clausthal.de
 > <7vehiol9w2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 01:29:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkl3W-0002Xx-7j
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 01:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702Ab2LRA2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 19:28:43 -0500
Received: from mailrelay1.rz.tu-clausthal.de ([139.174.2.42]:27574 "EHLO
	mailrelay1.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752992Ab2LRA2m (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2012 19:28:42 -0500
Received: from hades.rz.tu-clausthal.de (mailrelay1.rz.tu-clausthal.de [139.174.2.42])
	by mailrelay1.rz.tu-clausthal.de (Postfix) with ESMTP id 7F8E942E2CD;
	Tue, 18 Dec 2012 01:28:41 +0100 (CET)
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 567964220EB;
	Tue, 18 Dec 2012 01:28:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=kIhJuZbdhn/1yAklASUkg+TCAiE=; b=qtGykETnMrw5Bi9guz9XEXH3A9qX
	W+tjR5ZZvzn4WeIyCyQW7ztpTrWil4So6Dt0QM9d2X4+uNS0KOaKntFzY2Jzbs47
	FPaGMj8Zv52a53/7F8jLg4KTo2IO5aQkv7rfK05tPn1xQHWYQmBrO4QITSgMKHXo
	Phs5KiAq8X7AJas=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=vCwrg+C7nCOBuqOb1rq7CLg8DxkzA2RuFIUxcdqCm081qyh3s6ivyOm
	pTfFCZ3c7/ADVaizxAQl3BqgsgLRl2+Xm6ef1K22sSJey6P9Ux/MzWm+nOOt2wO0
	wHyhoB7qrYg+x9VHBu4THB+Z+m2u5XPemEFElehReZj401FdCtIk=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 02C244220A4;
	Tue, 18 Dec 2012 01:28:41 +0100 (CET)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.8)
  with ESMTPSA id 41972854; Tue, 18 Dec 2012 01:28:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vehiol9w2.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1200_1299 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, DKIM_SIGNATURE 0, DOMAINKEY_SIG 0, __ANY_URI 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MOZILLA_USER_AGENT 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211720>

If GIT_ASKPASS environment variable is not set, git-svn does not try to use
SSH_ASKPASS as git-core does. This change adds a fallback to SSH_ASKPASS.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 perl/Git.pm | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 72e93c7..8dfca65 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -515,8 +515,8 @@ sub html_path { command_oneline('--html-path') }

 Query user C<PROMPT> and return answer from user.

-Honours GIT_ASKPASS environment variable for querying
-the user. If no GIT_ASKPASS variable is set or an error occoured,
+Honours GIT_ASKPASS and SSH_ASKPASS environment variables for querying
+the user. If no *_ASKPASS variable is set or an error occoured,
 the terminal is tried as a fallback.

 =cut
@@ -527,6 +527,9 @@ sub prompt {
 	if (exists $ENV{'GIT_ASKPASS'}) {
 		$ret = _prompt($ENV{'GIT_ASKPASS'}, $prompt);
 	}
+	if (!defined $ret && exists $ENV{'SSH_ASKPASS'}) {
+		$ret = _prompt($ENV{'SSH_ASKPASS'}, $prompt);
+	}
 	if (!defined $ret) {
 		print STDERR $prompt;
 		STDERR->flush;
-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
