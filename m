From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCHv4] Add contrib/credentials/netrc with GPG support
Date: Tue, 05 Feb 2013 17:30:12 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87ehgupf63.fsf@lifelogs.com>
References: <87ehgvua6h.fsf@lifelogs.com>
	<20130204211726.GB13186@sigill.intra.peff.net>
	<87mwvjsqjc.fsf_-_@lifelogs.com>
	<7vvca6u47f.fsf@alter.siamese.dyndns.org>
	<87k3qmr8yc.fsf@lifelogs.com> <87fw1ar3og.fsf_-_@lifelogs.com>
	<7vhalqsfkf.fsf@alter.siamese.dyndns.org>
	<877gmmqyho.fsf@lifelogs.com>
	<7vpq0equo9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 23:30:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2r2F-0001EL-W6
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 23:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757372Ab3BEWaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 17:30:16 -0500
Received: from z.lifelogs.com ([173.255.230.239]:40824 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757345Ab3BEWaN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 17:30:13 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 0F54EDE0E3;
	Tue,  5 Feb 2013 22:30:13 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <7vpq0equo9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 05 Feb 2013 14:09:58 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215549>

On Tue, 05 Feb 2013 14:09:58 -0800 Junio C Hamano <gitster@pobox.com> wrote: 

JCH> open $io, "-|", qw(gpg --decrypt), $ARGV[0]

OK, the below will be in PATCHv6 (I'll wait on mailing it until after
you've reviewed the rest of PATCHv5).  Thanks for checking... I must
have had a typo or a missing comma or something, I could swear I tried
exactly what you show.

Ted


diff --git a/contrib/credential/netrc/git-credential-netrc b/contrib/credential/netrc/git-credential-netrc
index 8298564..5f91630 100755
--- a/contrib/credential/netrc/git-credential-netrc
+++ b/contrib/credential/netrc/git-credential-netrc
@@ -230,13 +230,9 @@ sub load_netrc {
 
 	my $io;
 	if ($gpgmode) {
-		# typical shell character escapes from http://www.slac.stanford.edu/slac/www/resource/how-to-use/cgi-rexx/cgi-esc.html
-		my $f = $file;
-		$f =~ s/([;<>\*\|`&\$!#\(\)\[\]\{\}:'"])/\\$1/g;
-		# GPG doesn't work well with 2- or 3-argument open
-		my $cmd = "gpg --decrypt $f";
-		log_verbose("Using GPG to open $file: [$cmd]");
-		open $io, "$cmd|";
+		my @cmd = (qw(gpg --decrypt), $file);
+		log_verbose("Using GPG to open $file: [@cmd]");
+		open $io, "-|", @cmd;
 	}
 	else {
 		log_verbose("Opening $file...");
