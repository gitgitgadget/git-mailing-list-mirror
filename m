From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH 4/5] ignore empty *_ASKPASS variables
Date: Tue, 27 Dec 2011 17:07:20 +0100
Message-ID: <4EF9ED38.9010502@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 17:07:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfZYk-0004AA-Bw
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 17:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630Ab1L0QHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 11:07:22 -0500
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:18070 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131Ab1L0QHU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 11:07:20 -0500
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id E5C04422105;
	Tue, 27 Dec 2011 17:07:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=zuQBpzJpF84YufBdpjUK0oEmlpY=; b=MirYHkmtePD3FepiqSHAQAWEm1LP
	UkDuIdfQa8lPR8Hw+CB2ek8sCDaI+LT1Eb0ZHuMtrfhILsgLeTduTJgb63p2Bz7B
	UmcbU3qKyjUuyK9u7TyyiavhzhBc0orIN+DXHLKl8V5mM945cjZMVCyydb9BA5UL
	2xdIgKEmSM/zv4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=R04nmokna5uVnL7HCRyQ5FPzUMTGY+mpnjm1Bg8X9U3Q+2ijr103sBo
	Rl4j7EYRrmokNadyVzLWiSNpAr6VA7SRjM77/yHdBdLIhd219v49MMSsEZDAZ2u3
	QJqPKZGC7IXQe9xtyOhrgufCYJMKGHpPl3SDYLCHAPcoLBWb3XBM=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id A77354220F4;
	Tue, 27 Dec 2011 17:07:19 +0100 (CET)
Received: from [91.4.99.60] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25242620; Tue, 27 Dec 2011 17:07:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <4EF9EBF4.7070200@tu-clausthal.de>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187720>


Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 perl/Git.pm |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 7fdf805..c6b3e11 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -537,6 +537,9 @@ sub askpass_prompt {

 sub _askpass_prompt {
 	my ($self, $askpass, $prompt) = _maybe_self(@_);
+	unless ($askpass) {
+		return undef;
+	}
 	my $ret;
 	open my $fh, "-|", $askpass, $prompt || return undef;
 	$ret = <$fh>;
-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
