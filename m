From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-send-email.perl: check for lines longer than 998
 characters
Date: Fri, 18 Jan 2008 09:12:32 +0100
Message-ID: <47905F70.5090003@viscovery.net>
References: <20080117153252.GD2816@coredump.intra.peff.net> <1200642458-3280-1-git-send-email-ediap@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: =?UTF-8?B?QWRhbSBQacSFdHlzemVr?= <ediap@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Jan 18 09:13:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFmLb-0002fh-0M
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 09:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbYARIMh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jan 2008 03:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752313AbYARIMh
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 03:12:37 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:55616 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbYARIMg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jan 2008 03:12:36 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JFmKw-0000mY-He; Fri, 18 Jan 2008 09:12:26 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 77DE669F; Fri, 18 Jan 2008 09:12:32 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1200642458-3280-1-git-send-email-ediap@users.sourceforge.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70974>

Adam Pi=C4=85tyszek schrieb:
> According to RFC2822 (Internet Message Format), each line of a messag=
e
> must be no more than 998 characters. This patch adds a check for the
> length of each body line of a message and dies if the length exceeds
> the limit.
>=20
> Signed-off-by: Adam Pi=C4=85tyszek <ediap@users.sourceforge.net>
> ---
>  git-send-email.perl |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>=20
> diff --git a/git-send-email.perl b/git-send-email.perl
> index e47994a..6d623ea 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -748,6 +748,9 @@ foreach my $t (@files) {
>  				$header_done =3D 1;
>  			}
>  		} else {
> +			if (length($_) > 998) {
> +				die "(msg) This message contains lines longer than 998 character=
s,\nwhich can not be correctly send as plain text using SMTP.\n";
> +			}
>  			$message .=3D  $_;
>  			if (/^(Signed-off-by|Cc): (.*)$/i && $signed_off_cc) {
>  				my $c =3D $2;

Is it good to die() in this situation? If you are sending a patch serie=
s
and one patch in the middle triggers this condition, then only half of =
the
series is sent. Maybe it would be better to warn here only, collect fil=
e
names of the suspects, send the patch nevertheless, and write a summary=
 at
the end?

-- Hannes
