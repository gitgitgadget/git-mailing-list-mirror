From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Convert all fnmatch() calls to wildmatch()
Date: Wed, 19 Dec 2012 10:36:32 -0800
Message-ID: <7v8v8tanyn.fsf@alter.siamese.dyndns.org>
References: <1355922488-20976-1-git-send-email-pclouds@gmail.com>
 <1355922488-20976-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 19:37:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlOVh-0005MY-VG
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 19:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab2LSSgg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2012 13:36:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62050 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331Ab2LSSgf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2012 13:36:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8FC1B544;
	Wed, 19 Dec 2012 13:36:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9TDxKOCqmxtm
	rv+BMOITnbt7ieo=; b=EvAK4MLlVjzyFkYy+oOV5jK0z6HiwR5U0AKjvgNF756n
	KLit3AqkgXZlOlzPpXpIdm8sI2NBUHPsE/IzClSGayS4R2kPsfwN9k3fIY1fmFYg
	c4fCdb+N15ormvJSqoWMfG/svQDQgJaRrb3d+bTeBVcanmUrJM83l7IQQIJn4ao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VaG4Ia
	YSsDSgkcivmqaAZ5yWoxjcajDPW2mLc5S3nKQ5SbyOWpnI4zvK+zriaVzDhXASJ4
	M+7dQMwgqI0iBS53sY10BJFo0Eiijod5pjH/Zs4eRmFdoy7C4i8msHbSwCkVVwZb
	y8qbgt6IZ1SV1qjMrlbLYx2m5205pJEggKBjM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C45DBB543;
	Wed, 19 Dec 2012 13:36:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22B1EB53E; Wed, 19 Dec 2012
 13:36:34 -0500 (EST)
In-Reply-To: <1355922488-20976-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 19 Dec
 2012 20:08:08 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03B032EA-4A0B-11E2-A97B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211840>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/tree-walk.c b/tree-walk.c
> index 492c7cd..c729e89 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -3,6 +3,7 @@
>  #include "unpack-trees.h"
>  #include "dir.h"
>  #include "tree.h"
> +#include "wildmatch.h"
> =20
>  static const char *get_mode(const char *str, unsigned int *modep)
>  {
> @@ -627,7 +628,7 @@ enum interesting tree_entry_interesting(const str=
uct name_entry *entry,
>  				return entry_interesting;
> =20
>  			if (item->use_wildcard) {
> -				if (!fnmatch(match + baselen, entry->path, 0))
> +				if (!wildmatch(match + baselen, entry->path, 0))
>  					return entry_interesting;

This and the change to dir.c obviously have interactions with
8c6abbc (pathspec: apply "*.c" optimization from exclude,
2012-11-24).

I've already alluded to it in my response to 2/3, I guess.
