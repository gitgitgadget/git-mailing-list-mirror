From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Limit refs to fetch to minimum in shallow clones
Date: Fri, 06 Jan 2012 10:40:17 -0800
Message-ID: <7vfwfsllny.fsf@alter.siamese.dyndns.org>
References: <1325743516-14940-1-git-send-email-pclouds@gmail.com>
 <1325833869-20078-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 19:40:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjEiY-00070y-3y
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 19:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933195Ab2AFSkV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jan 2012 13:40:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52511 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758899Ab2AFSkV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jan 2012 13:40:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14EF14E19;
	Fri,  6 Jan 2012 13:40:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZY8UnM+glqf/
	MCta8BLaX2vp8c0=; b=avjFQCGPoSYPzFyt+reTa/2V7mc22lDgYNdIEPgs+Dp8
	RB70T/8FmGTd24Y10ua2oO5AwPzUu1+DUFROFdqedTRLQZ0bWwgs/nJvO4dpVv49
	ThYfTeUviFb6VecRzjNZL3rzWjxV976mt+1sOL3jLHKP+ltpYPDrqVa4ydAwngU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QiKvcx
	A0o2Tb4wFCby0zSEBwg0xT69dhGTJOrrMiezbLYgfazuMEb9E5Qy/YaP5M9qD973
	+yKni9K6VJAHcLQor41hQnBU+ub8iF99H8xt6P9XTJ3AdwT10bzwPs28EzjECi8O
	qBXUsPQddEAqfEn2Iap9Ph3BFJ0uD7PKh8Bl0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BD554E18;
	Fri,  6 Jan 2012 13:40:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AF8C4E15; Fri,  6 Jan 2012
 13:40:19 -0500 (EST)
In-Reply-To: <1325833869-20078-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 6 Jan
 2012 14:11:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E21B15DC-3895-11E1-BC94-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188037>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> The main purpose of shallow clones is to reduce download by only
> fetching objects up to a certain depth from the given refs. The numbe=
r
> of objects depend on how many refs to follow. So:
>
>  - Only fetch HEAD or the ref specified by --branch
>  - Only fetch tags that reference to downloaded objects
>
> More tags/branches can be fetched later using git-fetch as usual.
>
> The old behaviour can still be called with --no-single-branch
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Thanks.

> @@ -179,6 +180,15 @@ objects from the source repository into a pack i=
n the cloned repository.
>  	with a long history, and would want to send in fixes
>  	as patches.
> =20
> +--single-branch::
> +--no-single-branch::
> +	These options are only valid when --depth is given.
> +	 `--single-branch` only fetches one branch (either HEAD or
> +	specified by --branch) and tags that point to the downloaded
> +	history. `--no-single-branch` fetches all branches and tags
> +	like in normal clones. `--single-branch` is implied by
> +	default.
> +

My first reaction after reading "is implied by default" was "Huh? didn'=
t
we just read these kick in only when --depth is given?" and I had to re=
ad
it again. Here is my attempt to rephrase it.

        Clone only the history leading to the tip of a single branch,
        either specified by the `--branch` option or the primary branch
        remote's `HEAD` points at. When creating a shallow clone with t=
he
        `--depth` option, this is the default, unless `--no-single-bran=
ch`
        is given to fetch the histories near the tips of all branches.

        Currently this option only works when creating a shallow clone =
and
        does not have any effect without the `--depth` option.

We might want to later enhance this to work also with a full-depth clon=
e
that tracks only one branch, and the above phrasing would make it clear=
=2E

> +		if (!option_branch)
> +			remote_head =3D guess_remote_head(head, refs, 0);
> +		else {
> +			struct strbuf sb =3D STRBUF_INIT;
> +			strbuf_addstr(&sb, src_ref_prefix);
> +			strbuf_addstr(&sb, option_branch);
> +			remote_head =3D find_ref_by_name(refs, sb.buf);
> +			strbuf_release(&sb);
> +		}
> +
> +		if (!remote_head)
> +			die(_("Remote branch \"%s\" not found. Nothing to clone.\n"
> +			      "Try --no-single-branch to fetch all refs."),
> +			    option_branch ? option_branch : "HEAD");

Switching upon option_branch to tweak the message is a good idea, but
strictly speaking, we would hit this die() when guess_remote_head() doe=
s
not find where HEAD points at because it is detached, and in that case,
the error is not "Nothing to clone", but "We couldn't tell which branch
you meant to limit this cloning to".

> @@ -642,9 +679,12 @@ int cmd_clone(int argc, const char **argv, const=
 char *prefix)
> =20
>  		transport_set_option(transport, TRANS_OPT_KEEP, "yes");
> =20
> -		if (option_depth)
> +		if (option_depth) {
>  			transport_set_option(transport, TRANS_OPT_DEPTH,
>  					     option_depth);
> +			transport_set_option(transport, TRANS_OPT_FOLLOWTAGS,
> +					     option_single_branch ? "1" : NULL);

Curious. Does anybody set FOLLOWTAGS to the transport by default becore=
 we
come here (just asking)?
