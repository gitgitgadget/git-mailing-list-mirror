From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] checkout: reorder option handling
Date: Fri, 07 Sep 2012 13:19:43 -0700
Message-ID: <7vpq5xwppc.fsf@alter.siamese.dyndns.org>
References: <1346248524-11616-3-git-send-email-pclouds@gmail.com>
 <1346330750-17937-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 22:19:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA51x-00016K-Dv
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 22:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755905Ab2IGUTs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Sep 2012 16:19:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48501 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753291Ab2IGUTr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2012 16:19:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03E009311;
	Fri,  7 Sep 2012 16:19:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CsivdXZc9RjF
	QEUJOPKTVaWNanQ=; b=ZFQxL4G1/Ah/9ChMTW1eYHiI2C/WaUDouPCRY9HykwPs
	2k0xpe0wUc/xtls5HQo6qRGqzzQDY+r5bTmnbIyf17L9I9ovo/xlPFvN+lgGk78r
	6u/YfwM427iwDtNy+EXwMtUkaXH4Yuw682JLNJ8wQiC3JQhe5qoL4CSmK4YOHvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=r+vMw4
	RlrW1O6c3B1W+WEVl9foJ9lR8ZhbmRPYxtLtu4SArPTeLvoJ97BYxIh6Gpv7Jv4l
	Dv17Icjs7X1FSXbqjA31Kx9DTNwPG3MR3ly+MZdXUFYS9JSD0ZmOGGRaDtirn80/
	AwfXKMzFztn2hsre4+SMVs31BCyMmSnGfGiIA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5D509310;
	Fri,  7 Sep 2012 16:19:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D1C2930C; Fri,  7 Sep 2012
 16:19:45 -0400 (EDT)
In-Reply-To: <1346330750-17937-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 30 Aug
 2012 19:45:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D5DD564-F929-11E1-A4F6-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204996>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +	if (opts->track !=3D BRANCH_TRACK_UNSPECIFIED)
> +		die(_("%s cannot be used with updating paths"), "--track");

I think most of the places we try to enclose these literals inside
quotes, so I'd squash in a patch to make this:

		die(_("'%s' cannot be used with updating paths"), "--track");

and update others to match.

> +	if (new->name && !new->commit)
> +		die(_("Cannot switch branch to a non-commit '%s'."),
> +		    new->name);

This is one of the only few places that end a sentence with a full-stop=
=2E

> +		/* Try to give more helpful suggestion, new_branch &&
> +		   argc > 1 will be caught later */

Style;

> +		if (opts.new_branch && argc =3D=3D 1)
> +			die(_("Cannot update paths and switch to branch '%s' at the same =
time.\n"
> +			      "Did you intend to checkout '%s' which can not be resolved =
as commit?"),
> +			    opts.new_branch, argv[0]);
> =20
>  		if (opts.force_detach)
>  			die(_("git checkout: --detach does not take a path argument"));

I tried this codepath and the message left me feeling uneasy.  I'd do:

		die(_("git checkout: --detach does not take a path argument '%s'"),
			argv[0]);

Other than these, I didn't find anything obviously wrong with my
final review before merging to 'next', so I'll merge it soonish.

Thanks.
