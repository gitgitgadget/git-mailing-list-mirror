From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] branch: show more information when HEAD is detached
Date: Sun, 03 Mar 2013 14:28:08 -0800
Message-ID: <7vtxos9kzr.fsf@alter.siamese.dyndns.org>
References: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
 <1362303681-6585-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 03 23:28:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCHOY-0005tK-21
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 23:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667Ab3CCW2M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Mar 2013 17:28:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38213 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754635Ab3CCW2M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Mar 2013 17:28:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90180AC42;
	Sun,  3 Mar 2013 17:28:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=L605DgrpgjE4
	x+0+wOTta/3IQ/E=; b=tiYXqd8wMkssSOQThFSB6foQYhAqypuYdfGOvQdpN7zb
	Z+LR1Bxe8kT3WrFAgaPwnGqEhKovZrmn2GESjAk0Xmmz+12UlB0s6tsEcYSdyfpx
	330UkMuwZ7u2QVBnix2/Qmp/VV4CrawQzZDJ1OQrdbeRa/FMKDPGASOGHtgV6dY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=n4+DNT
	0BPoPlw/GQcjzm22brK1W8DeCboOMSA+SeUEnQN9iFNe+fzavF9+oHIEG86veMaW
	Ez6PApka2k4/shjmYBIh6AsqQJ5g3oBIxJw/uDaFNO1yKyy9UIOQ0NUn1RVXpVBP
	s3Dvwits1wpGGRkhQQ49nukXSlJd7beWpa1kA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85FF7AC41;
	Sun,  3 Mar 2013 17:28:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E70A9AC3F; Sun,  3 Mar 2013
 17:28:09 -0500 (EST)
In-Reply-To: <1362303681-6585-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 3 Mar
 2013 16:41:21 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0CCF0C4-8451-11E2-8FE0-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217364>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This prints more helpful info when HEAD is detached: is it detached
> because of bisect or rebase? What is the original branch name in thos=
e
> cases? Is it detached because the user checks out a remote ref or a
> tag (and which one)?
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/branch.c            | 25 ++++++++++++++++++++++++-
>  t/t6030-bisect-porcelain.sh |  2 +-
>  2 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 6371bf9..02dee0d 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -18,6 +18,7 @@
>  #include "string-list.h"
>  #include "column.h"
>  #include "utf8.h"
> +#include "wt-status.h"
> =20
>  static const char * const builtin_branch_usage[] =3D {
>  	N_("git branch [options] [-r | -a] [--merged | --no-merged]"),
> @@ -550,6 +551,28 @@ static int calc_maxwidth(struct ref_list *refs)
>  	return w;
>  }
> =20
> +static char *get_head_description()

s/()/(void)/;

I think the series is much easier to read than the previous round
(except for some nits, which I'll send separately).  We would want
to add tests to protect the "where did we detach from" feature done
by [PATCH 4/5], which does not seem to have any.
