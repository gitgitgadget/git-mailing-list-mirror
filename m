From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: ignore partial svn:mergeinfo
Date: Fri, 8 Mar 2013 09:53:30 +0000
Message-ID: <20130308095330.GA20205@dcvr.yhbt.net>
References: <000e01ce1b26$dbb65570$93230050$@certicon.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, 'Junio C Hamano' <gitster@pobox.com>,
	'Matthieu Moy' <Matthieu.Moy@grenoble-inp.fr>,
	'Sam Vilain' <sam@vilain.net>
To: Jan =?utf-8?B?UGXFoXRh?= <jan.pesta@certicon.cz>
X-From: git-owner@vger.kernel.org Fri Mar 08 10:53:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDtzy-0000Vs-99
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 10:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933529Ab3CHJxc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Mar 2013 04:53:32 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:53988 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933419Ab3CHJxb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 04:53:31 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 158F61F6E1;
	Fri,  8 Mar 2013 09:53:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <000e01ce1b26$dbb65570$93230050$@certicon.cz>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217654>

Jan Pe=C5=A1ta <jan.pesta@certicon.cz> wrote:
> Currently this is cosmetic change - the merges are ignored, becuase t=
he methods=20
> (lookup_svn_merge, find_rev_before, find_rev_after) are failing on co=
mparing text with number.
>=20
> See http://www.open.collab.net/community/subversion/articles/merge-in=
fo.html
> Extract:
> The range r30430:30435 that was added to 1.5.x in this merge has a '*=
' suffix for 1.5.x\www.
> This '*' is the marker for a non-inheritable mergeinfo range.
> The '*' means that only the path on which the mergeinfo is explicitly=
 set has had this range merged into it.
>=20
> Signed-off-by: Jan Pesta <jan.pesta@certicon.cz>

> ---
>  perl/Git/SVN.pm | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> index 0ebc68a..74d49bb 100644
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
> @@ -1493,6 +1493,11 @@ sub lookup_svn_merge {
>  	my @merged_commit_ranges;
>  	# find the tip
>  	for my $range ( @ranges ) {
> +		if ($range =3D~ /[*]$/) {
> +			warn "W:Ignoring partial merge in svn:mergeinfo "

Thanks,

I've pushed this with a minor formatting change (added space after
"W:") will push another change for formatting existing warnings more
consistently.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
