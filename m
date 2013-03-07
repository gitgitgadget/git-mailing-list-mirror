From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] In partial SVN merges, the ranges contains additional
 character "*"
Date: Wed, 06 Mar 2013 16:04:49 -0800
Message-ID: <7vppzcnkgu.fsf@alter.siamese.dyndns.org>
References: <000001ce1ab2$903fbc40$b0bf34c0$@certicon.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	Jan =?utf-8?Q?Pe=C5=A1ta?= <jan.pesta@certicon.cz>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Mar 07 01:05:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDOL6-0001Ou-PT
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 01:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758092Ab3CGAEy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Mar 2013 19:04:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63159 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757370Ab3CGAEv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Mar 2013 19:04:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F296AB33;
	Wed,  6 Mar 2013 19:04:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=b0UFClD7Dl0u
	JIoH8/Hzk2xzCj0=; b=n60eHXNKohfcHvmtC2ME3YRejQ35YnLF3H4Knn4emV2Y
	pb8CuMlMrtIggHYpiDvj+c/ZytsOUDHxeCzVL3g5LcRfRXM/ij3t8k+hbwL5htGt
	iJI7Pbbg0S67ckfPgIFmPlNoD8zXba9AAqbMjRg0d6MqtVrHcSK5uN3s+KgUTJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=orYbpS
	8Y/7LaxRjyEmt3jJ6qn1RiprhWBxp3fCWUvF2MwW0OJJRyRkLv6RbeLXEctw9zDv
	GfbSX3U8qjh8Tg2WQG+439pf+O5L6W+gLmbPsaH+Oosq8a4Ki/jGerVb22gFIy3O
	dmlEVXekBo4lvCNMQRffNy+WZakSVeJDKQ1ac=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 645E2AB31;
	Wed,  6 Mar 2013 19:04:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB424AB2E; Wed,  6 Mar 2013
 19:04:50 -0500 (EST)
In-Reply-To: <000001ce1ab2$903fbc40$b0bf34c0$@certicon.cz> ("Jan
 =?utf-8?Q?Pe=C5=A1ta=22's?= message of "Wed, 6 Mar 2013 22:35:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1AD536A-86BA-11E2-B823-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217562>

Jan Pe=C5=A1ta <jan.pesta@certicon.cz> writes:

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
>
> Signed-off-by: Jan Pesta <jan.pesta@certicon.cz>
> ---
>  perl/Git/SVN.pm | 5 +++++
>  1 file changed, 5 insertions(+)
>
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
