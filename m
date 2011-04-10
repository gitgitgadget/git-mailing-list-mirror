From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] Replace has_wildcard with PATHSPEC_NOGLOB
Date: Sat, 09 Apr 2011 17:49:50 -0700
Message-ID: <7vbp0fylox.fsf@alter.siamese.dyndns.org>
References: <1302368060-23827-1-git-send-email-pclouds@gmail.com>
 <1302368060-23827-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 02:50:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8irH-0003ku-FR
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 02:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755735Ab1DJAuE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Apr 2011 20:50:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35301 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab1DJAuD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2011 20:50:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C81E95E71;
	Sat,  9 Apr 2011 20:51:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ur//RUqh4E8s
	Q0s9NYEufa9mSA8=; b=jIy4ei2TTDb75ca39z+M0TrmK6rcloRbFph2g0rVNoLW
	w9XglDbaClCrK6X6cQjjMI0ygH43LHnyssAY0qYNhe4sblwtdnWPILTbCk4IqE42
	CeHTJmYOmUxc8KOGyB6hKCFDQiYHUfsnl8OXF6Zw2oXEYWzJ48j3qXbzMfo364U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FVybX+
	nro1B3h314j9mktswZieEHwunoEx1vUpk6MATgjnCPrnrxvv2lwGvU3w7p/gDunz
	xCvd7rm8+b7EhcLeQQq7wWqkFzbqjc0miPbOU8wYf9J/kfbaWLpgcRgXG7CcwsgN
	kgaKOhfCyFQmHTMe9McmcWFjgLiW+06hlcUAs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 994CD5E70;
	Sat,  9 Apr 2011 20:51:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7E5D35E6F; Sat,  9 Apr 2011
 20:51:48 -0400 (EDT)
In-Reply-To: <1302368060-23827-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 9 Apr
 2011 23:54:17 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9953AA2-630C-11E0-998A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171226>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> ---
>  cache.h     |   22 ++++++++++++++++++++--
>  dir.c       |   11 +++++++----
>  setup.c     |   17 -----------------
>  tree-walk.c |   25 ++++++++++++-------------
>  4 files changed, 39 insertions(+), 36 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 27ac8a7..da1a46c 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -501,16 +501,34 @@ extern int index_name_is_other(const struct ind=
ex_state *, const char *, int);
>  extern int ie_match_stat(const struct index_state *, struct cache_en=
try *, struct stat *, unsigned int);
>  extern int ie_modified(const struct index_state *, struct cache_entr=
y *, struct stat *, unsigned int);
> =20
> +/*
> + * Magic pathspec
> + *
> + * NEEDSWORK: These need to be moved to dir.h or even to a new
> + * pathspec.h when we restructure get_pathspec() users to use the
> + * "struct pathspec" interface.
> + *
> + * Possible future magic semantics include stuff like:
> + *
> + *	{ PATHSPEC_NOGLOB, '!', "noglob" },
> + *	{ PATHSPEC_RECURSIVE, '*', "recursive" },
> + *	{ PATHSPEC_REGEXP, '\0', "regexp" },
> + *
> + */

Gaah, why did you butcher this to heve only the whole comment and struc=
t
type declaration here, without moving the "Possible future magic" comme=
nt
that clearly belongs to the structure definition you still have in dir.=
c
to where it belongs?  Also if NOGLOB is no longer "Possible future", wh=
y
is it still here?
