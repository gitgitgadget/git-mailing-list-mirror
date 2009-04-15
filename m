From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RESEND] gitweb: Fix snapshots requested via PATH_INFO
Date: Tue, 14 Apr 2009 23:40:48 -0700
Message-ID: <7vvdp6xvv3.fsf@gitster.siamese.dyndns.org>
References: <20090414104648.GA36554444@CIS.FU-Berlin.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Holger =?utf-8?Q?Wei=C3=9F?= <holger@zedat.fu-berlin.de>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 08:42:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtypL-0007WN-SX
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 08:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbZDOGk5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Apr 2009 02:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbZDOGk4
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 02:40:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbZDOGk4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Apr 2009 02:40:56 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3D24FFE10;
	Wed, 15 Apr 2009 02:40:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4EF99FE0F; Wed,
 15 Apr 2009 02:40:50 -0400 (EDT)
In-Reply-To: <20090414104648.GA36554444@CIS.FU-Berlin.DE> (Holger
 =?utf-8?Q?Wei=C3=9F's?= message of "Tue, 14 Apr 2009 12:46:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5EE9D320-2988-11DE-8484-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116590>

Holger Wei=C3=9F <holger@zedat.fu-berlin.de> writes:

> Fix the detection of the requested snapshot format, which failed for
> PATH_INFO URLs since the references to the hashes which describe the
> supported snapshot formats weren't dereferenced appropriately.
>
> Signed-off-by: Holger Wei=C3=9F <holger@zedat.fu-berlin.de>
> ---
> I guess this one got lost.  Without this patch, snapshots won't work =
if
> Gitweb is configured to generate PATH_INFO URLs.  (Original Message-I=
D:
> <20090331161636.GV30233737@CIS.FU-Berlin.DE>).

The patch looks obviously correct; "our %known_snapshort_formats" maps =
a
name to a hashref, but the current code makes a nonsense assignment,
essentialy doing ($fmt, %opt) =3D ($name, $hashref), but what would I
know...  I am not using gitweb actively.

These lines come from 1ec2fb5 (gitweb: retrieve snapshot format from
PATH_INFO, 2008-11-02) by Guiseppe.

Judging from the "git shortlog -n -s --grep=3DPATH_INFO gitweb" output,=
 I
think I should have heard from either Guiseppe and Jakub by now if this
patch is desired.  Pinging them...

>  gitweb/gitweb.perl |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 33ef190..3f99361 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -688,10 +688,10 @@ sub evaluate_path_info {
>  		# extensions. Allowed extensions are both the defined suffix
>  		# (which includes the initial dot already) and the snapshot
>  		# format key itself, with a prepended dot
> -		while (my ($fmt, %opt) =3D each %known_snapshot_formats) {
> +		while (my ($fmt, $opt) =3D each %known_snapshot_formats) {
>  			my $hash =3D $refname;
>  			my $sfx;
> -			$hash =3D~ s/(\Q$opt{'suffix'}\E|\Q.$fmt\E)$//;
> +			$hash =3D~ s/(\Q$opt->{'suffix'}\E|\Q.$fmt\E)$//;
>  			next unless $sfx =3D $1;
>  			# a valid suffix was found, so set the snapshot format
>  			# and reset the hash parameter
> --=20
> 1.6.2.1
