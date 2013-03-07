From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] In partial SVN merges, the ranges contains additional
 character "*"
Date: Thu, 7 Mar 2013 10:44:41 +0000
Message-ID: <20130307104441.GA25337@dcvr.yhbt.net>
References: <000001ce1ab2$903fbc40$b0bf34c0$@certicon.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sam Vilain <sam@vilain.net>
To: Jan =?utf-8?B?UGXFoXRh?= <jan.pesta@certicon.cz>
X-From: git-owner@vger.kernel.org Thu Mar 07 11:45:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDYK5-00074C-JE
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 11:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213Ab3CGKoo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Mar 2013 05:44:44 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:45828 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756118Ab3CGKon (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 05:44:43 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DF821F712;
	Thu,  7 Mar 2013 10:44:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <000001ce1ab2$903fbc40$b0bf34c0$@certicon.cz>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217589>

(adding Sam to the Cc:, I rely on him for SVN merge knowledge)

Jan Pe=C5=A1ta <jan.pesta@certicon.cz> wrote:
> See http://www.open.collab.net/community/subversion/articles/merge-in=
fo.html
> Extract:
> The range r30430:30435 that was added to 1.5.x in this merge has a '*=
'
> suffix for 1.5.x\www.
> This '*' is the marker for a non-inheritable mergeinfo range.
> The '*' means that only the path on which the mergeinfo is explicitly=
 set
> has had this range merged into it.

Jan: can you write a better commit message to explain what your
patch fixes/changes, and why we do it?

Something like:

  Subject: [PATCH] git svn: ignore partial svn:mergeinfo

  <explain why we ignore partial svn:mergeinfo in the body>

See Documentation/SubmittingPatches for hints.  Thanks!

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
> +				."dirprop: $source:$range\n";
> +			next;
> +		}
>  		my ($bottom, $top) =3D split "-", $range;
>  		$top ||=3D $bottom;
>  		my $bottom_commit =3D $gs->find_rev_after( $bottom, 1, $top );
> --=20
