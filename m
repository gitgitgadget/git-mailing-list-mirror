From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: do not rely on dtype being NULL behavior
Date: Thu, 11 Nov 2010 09:47:36 -0800
Message-ID: <7voc9vhhvr.fsf@alter.siamese.dyndns.org>
References: <1289480602-10545-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens.Lehmann@web.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 18:47:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGbFY-0008FH-4T
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 18:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188Ab0KKRrs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 12:47:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51775 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124Ab0KKRrs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Nov 2010 12:47:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 742663676;
	Thu, 11 Nov 2010 12:47:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9R3HFqAwNiUX
	JvKHrRtiVmcxUOY=; b=NhH9lpQB9qXj5rpK5Q0XEwC1GwN9fKFjXzm3vYTXgHEk
	S8TmFw/SuU34UkDJqeiRwBRqoryEe/0Con5IxMJMtIHrWoZkTzW4RIpWtaB8kg83
	CJiShmPMxPm1q9n4ii8/8iTIydos+Ab9sgJACuhM3PlZ5Mb6HlJ6HmMcIHt8GxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uK37Br
	zMcF6nitsUCPOXb2eyM4DtjkLYqP3Oqj0LJOmurJBlL8GXC4PDeG7cloz+TqBQMe
	CmjDs3WwEp4GsPeKnXK1V2YFXoc7Sks1eLUMUHSwjKKVRxVd94SGfmvDLao5+j1f
	nfMLYREcpGXYWEAoa8AOwHN2H00MgJYWcug5o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 41C393672;
	Thu, 11 Nov 2010 12:47:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B53883671; Thu, 11 Nov 2010
 12:47:43 -0500 (EST)
In-Reply-To: <1289480602-10545-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Thu\, 11 Nov
 2010 20\:03\:22 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CCA2E23C-EDBB-11DF-B524-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161277>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Commit c84de70 (excluded_1(): support exclude files in index -
> 2009-08-20) added support for excluded() where dtype can be NULL. It
> was designed specifically for index matching because there was no
> other way to extract dtype information from index. It did not support
> wildcard matching (for example, "a*/" pattern would fail to match).
>
> The code was probably misread when commit 108da0d (git add: Add the
> "--ignore-missing" option for the dry run - 2010-07-10) was made
> because DT_UNKNOWN happens to be zero (NULL) too.
>
> Do not pass DT_UNKNOWN/NULL to excluded(), instead pass a pointer to =
a
> variable that contains DT_UNKNOWN. The real dtype will be extracted
> from worktree by excluded(), as expected.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  I do not add tests for the "a*/" failure above because I plan
>  to fix it. Expect c84de70 will be reverted "soon" (in my timescale)
>  when sparse checkout can pass real dtype.
>
>  builtin/add.c |    3 ++-
>  dir.c         |    2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 56a4e0a..1a4672d 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -446,7 +446,8 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
>  			if (!seen[i] && pathspec[i][0]
>  			    && !file_exists(pathspec[i])) {
>  				if (ignore_missing) {
> -					if (excluded(&dir, pathspec[i], DT_UNKNOWN))
> +					int dtype =3D DT_UNKNOWN;
> +					if (excluded(&dir, pathspec[i], &dtype))
>  						dir_add_ignored(&dir, pathspec[i], strlen(pathspec[i]));
>  				} else
>  					die("pathspec '%s' did not match any files",
> diff --git a/dir.c b/dir.c
> index b2dfb69..c4bed66 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -359,7 +359,7 @@ int excluded_from_list(const char *pathname,
>  			int to_exclude =3D x->to_exclude;
> =20
>  			if (x->flags & EXC_FLAG_MUSTBEDIR) {
> -				if (!dtype) {
> +				if (dtype !=3D NULL) {

Hmm, are you sure about this part?

>  					if (!prefixcmp(pathname, exclude) &&
>  					    pathname[x->patternlen] =3D=3D '/')
>  						return to_exclude;
> --=20
> 1.7.3.2.210.g045198
