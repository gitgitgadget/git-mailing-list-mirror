From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/10] clone: --branch=<branch> always means
 refs/heads/<branch>
Date: Wed, 11 Jan 2012 12:01:09 -0800
Message-ID: <7v4nw26mbe.fsf@alter.siamese.dyndns.org>
References: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
 <1326189427-20800-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 21:01:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl4MH-0001P7-W0
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 21:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757994Ab2AKUBO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 15:01:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38793 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756958Ab2AKUBM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 15:01:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B674972D6;
	Wed, 11 Jan 2012 15:01:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0hIusxo8YZ6B
	NcYtckpP3YJYOEg=; b=wVhoy2j02WWmWqXrX6tqj7ifahypYAX/gWF/cdo4eIZn
	IXA4zhjNgdw1Gi42Be6kNhzcYTSZF+isiIRiBXQUbEDpGDciHW3rgecymXd5lIQl
	QYJHPlys69HZ6n7tte87CeLyV4gFF1hqd4/qkXGUStKEdd+ECPVpVuSwNiA8kG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pMgknJ
	jkmTMmBHkE9GSvo76+RIsx6+SAUar+OvEK6wQM/xeoYO3KWUFkFdwRAT5gzt/lPH
	RpVm40XrHveXb5y/0SEXkB+9J7/lxIOL0kjr10HPRP0SB8rlpcqG+Q21WHfsa1/Z
	mfFS6L2LGm7NnnribKo2uG2XLJ/bjGznkvDjY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD7B072D5;
	Wed, 11 Jan 2012 15:01:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0AAEA72D2; Wed, 11 Jan 2012
 15:01:10 -0500 (EST)
In-Reply-To: <1326189427-20800-8-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 10 Jan
 2012 16:57:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 02120E84-3C8F-11E1-97F9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188389>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> It does not make sense to look outside refs/heads for HEAD's target
> (src_ref_prefix can be set to "refs/" if --mirror is used) because re=
f
> code only allows symref in form refs/heads/...
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/clone.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 05224d7..960242f 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -463,7 +463,7 @@ static void update_remote_refs(const struct ref *=
refs,
>  static void update_head(const struct ref *our, const struct ref *rem=
ote,
>  			const char *msg)
>  {
> -	if (our) {
> +	if (our && !prefixcmp(our->name, "refs/heads/")) {
>  		/* Local default branch link */
>  		create_symref("HEAD", our->name, NULL);
>  		if (!option_bare) {

I think this makes sense. In the following three casees:

 - When cloning without --branch, if we could not find a branch that ma=
tch
   HEAD at the remote;

 - When cloning with --branch, if we did not see such a branch at the
   remote; or

 - When cloning from an empty repository

we come here with "our" set to NULL. Additionally, if the remote HEAD
points outside refs/heads/ and the transport could detect that case
(e.g. a helper that reads from ls-remote output), we can see our->name
outside refs/heads/. Is there any other case where our is not NULL and
our->name does not start with refs/heads/?

The "else if (remote)" clause (not shown, outside the context) that
follows still has comments that says it is a case for "Source had detac=
hed
HEAD pointing somewhere", and needs to be adjusted for this change, no?=
 It
is "(1) we know the HEAD points at a non-branch, (2) HEAD may point at =
a
branch but we do not know which one, or (3) we asked for a specific bra=
nch
but it did not exist there" (cloning from an empty will have NULL in
remote and the comment would not apply to that case).

> @@ -760,7 +760,7 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
> =20
>  		if (option_branch) {
>  			struct strbuf head =3D STRBUF_INIT;
> -			strbuf_addstr(&head, src_ref_prefix);
> +			strbuf_addstr(&head, "refs/heads/");
>  			strbuf_addstr(&head, option_branch);
>  			our_head_points_at =3D
>  				find_ref_by_name(mapped_refs, head.buf);
