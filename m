From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] In inproperly merges, the ranges contains additional
 character "*"
Date: Fri, 01 Mar 2013 09:54:41 -0800
Message-ID: <7v1ubzgg4e.fsf@alter.siamese.dyndns.org>
References: <002101ce1681$4f261090$ed7231b0$@certicon.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>,
	"'Matthieu Moy'" <Matthieu.Moy@grenoble-inp.fr>
To: Jan =?utf-8?Q?Pe=C5=A1ta?= <jan.pesta@certicon.cz>
X-From: git-owner@vger.kernel.org Fri Mar 01 18:55:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBUAt-0004Ue-Q1
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 18:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab3CARyp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Mar 2013 12:54:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56509 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198Ab3CARyo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Mar 2013 12:54:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD468B279;
	Fri,  1 Mar 2013 12:54:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bCpmf59aGtf+
	RWDxxhEg1cFKMkU=; b=TbSsL7YT0Rnm5bOAAcOLRRCEZkXcQdioe3RyoWI7Utqq
	cnm2cCzxpkqxyEmiv1NnqI7kexUJV2oKWdBclZvZXSj/HovuptYE9ZUAqgHWVl24
	/cK+K/zNbVl/0dRdqaFezCFrdmT/6smA4Fo67T4lHC4xuACNGrPxANUJmBXVuFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gEzsXA
	iw6NWLa+2u2MEUHFdFvJch7to+ATXiJa4nvR6rqyCWXykM6TaX0G4vUdFmGch9zc
	FJVlVBX8Blep4OFLv+oaykfdlYh8pBmUKJ/OUt+1Zm0nM+m/I8g3U8stGPPvCKlO
	2deMI5kbrHZXim3C7GcO+qURoYnZ0l7/8senQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B243EB278;
	Fri,  1 Mar 2013 12:54:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C715B277; Fri,  1 Mar 2013
 12:54:43 -0500 (EST)
In-Reply-To: <002101ce1681$4f261090$ed7231b0$@certicon.cz> ("Jan
 =?utf-8?Q?Pe=C5=A1ta=22's?= message of "Fri, 1 Mar 2013 14:33:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 18BDFD90-8299-11E2-9033-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217285>

Jan Pe=C5=A1ta <jan.pesta@certicon.cz> writes:

> In inproperly merges, the ranges contains additional character "*".

Thanks, but -ECANNOTPARSE.  What are "inproperly merges"?

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

If I am reading the above correctly, blindly removing '*' from the
range will record a wrong merge in the result, because on the SVN
side only the history of part of the tree is merged but we represent
the result as a full merge (and Git only records full merge of
histories), no?

My gut feeling tells me that failing the import, saying "We cannot
represent this history", might be a more honest and safe thing to
do.

> Signed-off-by: Jan Pesta <jan.pesta@certicon.cz>
> ---
>  perl/Git/SVN.pm | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> index 0ebc68a..6bd18e9 100644
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
> @@ -1493,6 +1493,7 @@ sub lookup_svn_merge {
>  	my @merged_commit_ranges;
>  	# find the tip
>  	for my $range ( @ranges ) {
> +		$range =3D~ s/[*]$//;
>  		my ($bottom, $top) =3D split "-", $range;
>  		$top ||=3D $bottom;
>  		my $bottom_commit =3D $gs->find_rev_after( $bottom, 1, $top );
