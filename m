From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH UI experiment] diffstat: annotate/highlight new or
 removed files
Date: Mon, 15 Oct 2012 14:03:07 -0700
Message-ID: <7v626bwir8.fsf@alter.siamese.dyndns.org>
References: <1350311749-15447-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 23:03:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNrop-0005I1-Hb
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 23:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928Ab2JOVDM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 17:03:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53179 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895Ab2JOVDL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2012 17:03:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 326B48E39;
	Mon, 15 Oct 2012 17:03:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7bnlKMyeJ+GQ
	xlV76EDfLDQ4ZFM=; b=iAgy3bL28F2fcbZzEx00zXdgntWlEMClOkkRoniBK+9w
	uNJBBRuDslTAHpJXZrsWn70GQFWwOfxiTJtzOVqdXWsArHZy8NVAPZsqbune4ezW
	LxdXMo+5N+Ofp0+rHjlZBUKC2NWp2HO0NSLiltziFBcMdndobY+d9eCjq6y5LJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YhlqLN
	ic2RISujTCnkJ5mIFNbPFX88Na02BAd3GgMoosskGupe9yu+zLCsoPfYlltE71DJ
	fqzcUDkujwSWt9jziuJf+RYWrz0CjzSgHXPFklG+VWQB2zKCArXaQ+7xr+2M0Kjs
	ofpUMnR5CcLArgfWnPpTBXTxwHS6LgI+MeALY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 209AF8E38;
	Mon, 15 Oct 2012 17:03:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F35F8E35; Mon, 15 Oct 2012
 17:03:09 -0400 (EDT)
In-Reply-To: <1350311749-15447-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 15 Oct
 2012 21:35:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B94A82A0-170B-11E2-8DDD-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207779>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diffstat does not show whether a file is added or deleted. I know
> --summary does. But the problem with --summary is it makes me look fo=
r
> information of a file in two places: diffstat and summary. And with a
> commit that adds/removes a lot, showing both --stat --summary can be
> long.
>
> This patch adds "(new)", "(gone)" or "(new mode)" to diffstat, with
> highlight, to easily catch file additions/removals. The extra text is
> chosen to be short enough so that it won't take up too much space for
> path names:
>
>  .gitignore                  |   1 +
>  Makefile                    |   3 +
>  t/t3070-wildmatch.sh (new)  | 188 ++++++++++++++++++++++++
>  t/t3070/wildtest.txt (gone) | 165 ---------------------
>  test-wildmatch.c (new)      |  14 ++
>  wildmatch.c                 |   5 +-
>  6 files changed, 210 insertions(+), 166 deletions(-)
>
> I don't put creation modes in there too because most of the time it
> does not matter much to me and I could look down to --summary for mod=
e
> verification. But we could put "(new+x)" for 0755 and just "(new)" fo=
r
> 0644. "(new mode)" then could become "(+x)", "(-x)" or something like
> that.
>
> Coloring is to me an improvement over --summary. Probably the main
> point. Without it, perhaps it's not worth putting extra text to
> diffstat.

It is kind of surprising that you did not choose to paint new in
green and gone in red, and rather paint everything in yellow.

I personally think the above in monochrome is fairly easy to read;
with coloring, it might become too distracting, though.

Just a nit, "new mode" is too similar to "new".  Everything is "new"
in the sense that they have "new contents"; it may be better phrased
without saying "new" but giving a stress on "changed".

Thanks for a fun patch.  I am not strongly against it.
