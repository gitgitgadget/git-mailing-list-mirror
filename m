From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] gitweb: Make linking to actions requiring JavaScript a feature
Date: Thu, 26 Nov 2009 21:12:15 +0100
Message-ID: <200911262112.16280.jnareb@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <7vpr76m8dx.fsf@alter.siamese.dyndns.org> <200911260159.48311.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 21:12:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDkhd-0005or-Ap
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 21:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbZKZUMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 15:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbZKZUMV
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 15:12:21 -0500
Received: from mail-bw0-f223.google.com ([209.85.218.223]:51975 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbZKZUMV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 15:12:21 -0500
Received: by bwz23 with SMTP id 23so812534bwz.29
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 12:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Effxr/5hgAQdG7K+aOYXUTe7zdM9QEfqqEXlgZEaPE4=;
        b=e2ouTK9t28JhgnsOxhmvJ3g5CCcZCl2N9q4Iy4R1EdZkqCgKVe1lXHTMiXuF6rWm90
         ac+CuZUgU63bKuSCniBsGsbtD6yL4c6uUMsThiIhRhg0McvmHfuz8Fg2CKxs82DEH6Qs
         r/oqjns8nGUHWQ68FrsoNyowT7G8uB4rAEEps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=J3kKkQdDe4agrymsxunmH4LKCC+g+4BnJOpXb0NszmvnfwaTgh1ycUaYjapOsrp1Qh
         CWlcG4nqNOMZ/b5A121zhXU724vKoibMlGygSVbXm508rP31aZMvn5WA9CYLkw/Z0kjI
         M1/KAORWreDOV082o4gg0a9gvQ2e8dzcK/hEU=
Received: by 10.204.34.73 with SMTP id k9mr202543bkd.45.1259266344337;
        Thu, 26 Nov 2009 12:12:24 -0800 (PST)
Received: from ?192.168.1.13? (abvg159.neoplus.adsl.tpnet.pl [83.8.204.159])
        by mx.google.com with ESMTPS id 19sm1351412fkr.48.2009.11.26.12.12.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Nov 2009 12:12:23 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200911260159.48311.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133832>

On Thu, 26 Nov 2009, Jakub Narebski wrote:
> On Thu, 26 Nov 2009, Junio C Hamano wrote:

> > A follow-up patch to add a gitweb configuration switch that disables the
> > non-working view by default but allows site owners to enable it in order
> > to help improving the feature would be a sensible thing to do.  As long as
> > that patch is solidly done we can merge the whole thing to 'master' in the
> > upcoming release.
> 
> But if it is already in 'next', then I'll try to come up with patch which
> makes JavaScript-ing links (replacing links with JavaScript to equivalent
> actions utilizing JavaScript, currently only 'blame' -> 'blame_incremental')
> configurable.

Here it is.  I am a bit ambiguous about *naming* of this feature (and
whether it should be overridable), that's why it is marked as RFC.

Also the subject of this commit could have been better, I think...

-- >8 --
Let gitweb turn some links (like 'blame' links) into linking to
actions which require JavaScript (like 'blame_incremental' action)
only if 'javascript-actions' feature is enabled.

This means that links to such actions would be present only if both
JavaScript is enabled and 'javascript-actions' feature is enabled.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a80cbd3..0ab47e1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -432,6 +432,13 @@ our %feature = (
 	'timed' => {
 		'override' => 0,
 		'default' => [0]},
+
+	# Enable turning some links into links to actions which require
+	# JavaScript to run (like 'blame_incremental').  Enabled by default.
+	# Project specific override is currently not supported.
+	'javascript-actions' => {
+		'override' => 0,
+		'default' => [1]},
 );
 
 sub gitweb_get_feature {
@@ -3326,7 +3333,7 @@ sub git_footer_html {
 		      qq!startBlame("!. href(action=>"blame_data", -replay=>1) .qq!",\n!.
 		      qq!           "!. href() .qq!");\n!.
 		      qq!</script>\n!;
-	} else {
+	} elsif (gitweb_check_feature('javascript-actions')) {
 		print qq!<script type="text/javascript">\n!.
 		      qq!window.onload = fixLinks;\n!.
 		      qq!</script>\n!;
-- 
1.6.5.3
