From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] Convert struct diff_options to use struct pathspec
Date: Mon, 27 Sep 2010 15:19:56 -0700
Message-ID: <7vzkv2vng3.fsf@alter.siamese.dyndns.org>
References: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
 <1284938514-16663-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 00:20:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0M3a-0006jY-RJ
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 00:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760199Ab0I0WUG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 18:20:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab0I0WUF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 18:20:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 18DA3DA37D;
	Mon, 27 Sep 2010 18:20:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=UHUPTzcek7tXqEAaVe83nYSha
	XE=; b=C378nFvR++WT1KRnXUzIaiEDkjK6V9jGjpb2VvsfgcPmxo4qmkvO/oFmS
	b+R911fSukSixWPk9ayQM/22UvTj+IfSBRiAx09II+xuU2J5C4L411jrSv5ktyAZ
	pCYIZT4aNoeG0nZKsFdzmdxoDxTpX4r3Z5YgMe3R2K+SH2qMJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=CN6dbFCBKB6rkLCXEvY
	bYL8uoXU/G6IqAnfnPQgeEixcmsAk10zUiajMjvsHBwGy7OcYMbAVupzN/DLbMpA
	09Ov1j4T1iWxiTlMt+yP7D7B6kAsYBhaeKzRGn/Yn6V8pMKd8lRn568GW4Gha/Iw
	az5C5Yt+6L2vVbHa58E3TWqE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD7C7DA378;
	Mon, 27 Sep 2010 18:20:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C705DA376; Mon, 27 Sep
 2010 18:19:57 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5F06E83A-CA85-11DF-A0C3-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157373>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/revision.c b/revision.c
> index b1c1890..b2a5867 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -553,11 +553,7 @@ static void cherry_pick_list(struct commit_list =
*list, struct rev_info *revs)
> =20
>  	left_first =3D left_count < right_count;
>  	init_patch_ids(&ids);
> -	if (revs->diffopt.nr_paths) {
> -		ids.diffopts.nr_paths =3D revs->diffopt.nr_paths;
> -		ids.diffopts.paths =3D revs->diffopt.paths;
> -		ids.diffopts.pathlens =3D revs->diffopt.pathlens;
> -	}
> +	ids.diffopts.pathspec =3D revs->diffopt.pathspec;

Just a mental note; we need to be careful not to destroy this structure
(i.e. freeing ids.diffopts.pathspec.items) when we are done with ids.

Nice code reduction ;-)
