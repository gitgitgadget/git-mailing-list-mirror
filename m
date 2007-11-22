From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 1/4] Suppress spurious linefeeds in git-add--interactive
Date: Thu, 22 Nov 2007 11:18:27 +0100
Message-ID: <B649FFCA-C85F-4BB4-884A-525676ABCA9B@wincent.com>
References: <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com> <1195689773-28601-1-git-send-email-win@wincent.com> <1195689773-28601-2-git-send-email-win@wincent.com> <20071122085919.GB7153@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 11:21:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv9BH-0005iP-UM
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 11:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbXKVKUy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 05:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbXKVKUy
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 05:20:54 -0500
Received: from wincent.com ([72.3.236.74]:57168 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbXKVKUy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 05:20:54 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAMAISc4010255;
	Thu, 22 Nov 2007 04:18:29 -0600
In-Reply-To: <20071122085919.GB7153@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65771>

El 22/11/2007, a las 9:59, Jeff King escribi=F3:

> On Thu, Nov 22, 2007 at 01:02:50AM +0100, Wincent Colaiuta wrote:
>
>> +	return undef if ($#diff =3D=3D -1);
>
> Style nit: I think the rest of the code generally uses (and I prefer)
> "@diff" to get the number of elements. So:
>
>  return undef unless @diff;
>
> or I might even have written
>
>  my @diff =3D ...
>    or return undef;
>
> but perhaps I am the only one who finds $#array comparisons to -1 har=
d
> on the eyes.

No, I agree with you; it does read nicer. I'm not a real Perl =20
programmer, so everything I do I have to do it with a copy of =20
"Programming Perl" next to me to find out how to do things. It's handy =
=20
to have advice from people more familiar with the idioms. Will =20
incorporate something like this into the series:

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index a5a07bc..0a8f0a9 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -60,7 +60,7 @@ sub list_modified {
  		defined run_cmd_pipe(qw(git ls-files
  			                --exclude-standard --), $_)
  	} @ARGV;
-	return if $#tracked =3D=3D -1 && $#ARGV !=3D -1;
+	return if !@tracked && @ARGV;

  	for (run_cmd_pipe(qw(git diff-index --cached
  			     --numstat --summary HEAD --), @tracked)) {
@@ -340,8 +340,8 @@ sub add_untracked_cmd {

  sub parse_diff {
  	my ($path) =3D @_;
-	my @diff =3D run_cmd_pipe(qw(git diff-files -p --), $path);
-	return undef if ($#diff =3D=3D -1);
+	my @diff =3D run_cmd_pipe(qw(git diff-files -p --), $path)
+	    or return undef;
  	my (@hunk) =3D { TEXT =3D> [] };

  	for (@diff) {



Cheers,
Wincent
