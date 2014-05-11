From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add--interactive: Preserve diff heading when splitting hunks
Date: Sun, 11 May 2014 10:52:45 -0700
Message-ID: <xmqqfvkgurrm.fsf@gitster.dls.corp.google.com>
References: <1399824596-4670-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 19:52:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjXvi-00008t-0r
	for gcvg-git-2@plane.gmane.org; Sun, 11 May 2014 19:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470AbaEKRwu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 May 2014 13:52:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54518 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663AbaEKRwt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 May 2014 13:52:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 432B516C98;
	Sun, 11 May 2014 13:52:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rBvKN8UV5X1X
	jnOyFTh9D3ba6dg=; b=f98cr24LvAYVLBZ06N1CkwWXF2Bo4ZJnh1FfpQCHlJBC
	5fdC9nwRAk/pO4oL6wJ1g+ctIrV+9JIUCSIuVrwOYYobUYElww5+H4OTy+F6CLsF
	CMGD4mug/fmpU3B3fiEuv8FlrmqZMVNkGV0V20pQgSZGCM8UqRPS1dTl3CtwOqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GYY6Cr
	0HUPiZTF7VlrpeWtQujM5MNKGBfiXbRLPulSfkeYrhO0iqT3Ev+41QpnV2L/Z3Or
	LhW5O7ykLqCEVKTPogMoFpQkQrFTt/u/BDTBXh38RT0I59fUd5B6cVobY9b9ULpZ
	TWL7mHUdqiKZd6C+gXJIUZTMjHiJfTj/CoD48=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3AB5516C97;
	Sun, 11 May 2014 13:52:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AC0BA16C93;
	Sun, 11 May 2014 13:52:46 -0400 (EDT)
In-Reply-To: <1399824596-4670-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 11 May
 2014 16:09:56 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0F769334-D935-11E3-B198-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248677>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the display of hunks in hunk splitting mode to preserve the di=
ff
> heading, which hasn't been done ever since the hunk splitting was
> initially added in v1.4.4.2-270-g835b2ae.
>
> Splitting the first hunk of this patch will now result in:
>
>     Stage this hunk [y,n,q,a,d,/,j,J,g,s,e,?]? s
>     Split into 2 hunks.
>     @@ -792,7 +792,7 @@ sub hunk_splittable {
>     [...]
>
> Instead of:
>
>     Stage this hunk [y,n,q,a,d,/,j,J,g,s,e,?]? s
>     Split into 2 hunks.
>     @@ -792,7 +792,7 @@
>     [...]
>
> This makes it easier to use the tool when you're splitting some giant
> hunk and can't remember in which function you are anymore.

Makes sense to me.

>
> The diff is somewhat larger than I initially expected because in orde=
r
> to display the headings in the same color scheme as the output from
> git-diff(1) itself I had to split up the code that would previously
> color diff output that previously consisted entirely of the fraginfo,
> but now consists of the fraginfo and the diff heading (the latter of
> which isn't colored).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
>  git-add--interactive.perl | 40 ++++++++++++++++++++++++-------------=
---
>  1 file changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 1fadd69..ed1e564 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -792,11 +792,11 @@ sub hunk_splittable {
> =20
>  sub parse_hunk_header {
>  	my ($line) =3D @_;
> -	my ($o_ofs, $o_cnt, $n_ofs, $n_cnt) =3D
> -	    $line =3D~ /^@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? @@/;
> +	my ($o_ofs, $o_cnt, $n_ofs, $n_cnt, $heading) =3D
> +	    $line =3D~ /^@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? @@(.*)/;
>  	$o_cnt =3D 1 unless defined $o_cnt;
>  	$n_cnt =3D 1 unless defined $n_cnt;
> -	return ($o_ofs, $o_cnt, $n_ofs, $n_cnt);
> +	return ($o_ofs, $o_cnt, $n_ofs, $n_cnt, $heading);
>  }
> =20
>  sub split_hunk {
> @@ -808,8 +808,7 @@ sub split_hunk {
>  	# If there are context lines in the middle of a hunk,
>  	# it can be split, but we would need to take care of
>  	# overlaps later.
> -
> -	my ($o_ofs, undef, $n_ofs) =3D parse_hunk_header($text->[0]);
> +	my ($o_ofs, undef, $n_ofs, undef, $heading) =3D parse_hunk_header($=
text->[0]);
>  	my $hunk_start =3D 1;
> =20
>        OUTER:
> @@ -886,17 +885,26 @@ sub split_hunk {
>  		my $o_cnt =3D $hunk->{OCNT};
>  		my $n_cnt =3D $hunk->{NCNT};
> =20
> -		my $head =3D ("@@ -$o_ofs" .
> -			    (($o_cnt !=3D 1) ? ",$o_cnt" : '') .
> -			    " +$n_ofs" .
> -			    (($n_cnt !=3D 1) ? ",$n_cnt" : '') .
> -			    " @@\n");
> -		my $display_head =3D $head;
> -		unshift @{$hunk->{TEXT}}, $head;
> -		if ($diff_use_color) {
> -			$display_head =3D colored($fraginfo_color, $head);
> -		}
> -		unshift @{$hunk->{DISPLAY}}, $display_head;
> +		my $fraginfo =3D join(
> +			"",
> +			"@@ -$o_ofs",
> +			(($o_cnt !=3D 1) ? ",$o_cnt" : ''),
> +			" +$n_ofs",
> +			(($n_cnt !=3D 1) ? ",$n_cnt" : ''),
> +			" @@"
> +		);
> +		unshift @{$hunk->{TEXT}}, join(
> +			"",
> +			$fraginfo,
> +			$heading,
> +			"\n"
> +		);
> +		unshift @{$hunk->{DISPLAY}}, join(
> +			"",
> +			$diff_use_color ? colored($fraginfo_color, $fraginfo) : $fraginfo=
,
> +			$heading,
> +			"\n"
> +		);
>  	}
>  	return @split;
>  }
