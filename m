From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] branch: segfault fixes and validation
Date: Sat, 23 Feb 2013 12:01:56 -0800
Message-ID: <7vtxp27qa3.fsf@alter.siamese.dyndns.org>
References: <7vvc9kccwa.fsf@alter.siamese.dyndns.org>
 <1361622147-20921-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 21:02:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9LIg-0005QX-51
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 21:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757824Ab3BWUCA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2013 15:02:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61082 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757022Ab3BWUB7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2013 15:01:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F17DA3D2;
	Sat, 23 Feb 2013 15:01:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Aj9rQ9xd/YNk
	KhMWam2RbFNGZAc=; b=KcDIrzuM13lj551bcfBok15dHUueLk2prACFmINYnIeh
	N1xKOP/8IDjE3BRoxlpB1R8GKtobgSsQhpocEIQStcKzv8oJcitUpXPCE4YqAS1K
	gzV/FZY9QrbivcqcTZak9ASFWgPGXfphNYPnUrRUlZ0RiBxfLrV6Y3tQLYR2bn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Zu+wvZ
	G2FoB3wbCa/b59vAIjsbTClGj7Y9TRfFe0zboG7nQx7mrEzJ6+jkfn3l5Gx+TYCx
	OZpVjMLXzMvLew4Kj6EpZkfGhm8dFaOxVZP0+oJQjScvOCWbj4lXLZmWSv2U/39R
	vp3KPnzO+AFAzvw8pDAqWxM8F1BKZBtNokKJw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03E3BA3D0;
	Sat, 23 Feb 2013 15:01:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63D6DA3CF; Sat, 23 Feb 2013
 15:01:58 -0500 (EST)
In-Reply-To: <1361622147-20921-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 23 Feb
 2013 19:22:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E140A128-7DF3-11E2-869B-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216911>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

>  > What you can do is to have a single helper function that can expla=
in
>  > why branch_get() returned NULL (or extend branch_get() to serve th=
at
>  > purpose as well); then you do not have to duplicate the logic twic=
e
>  > on the caller's side (and there may be other callers that want to =
do
>  > the same).
>
>  The explanation mentions about the failed operation, which makes a
>  helper less useful. We could still do the helper, but it may lead to
>  i18n legos. So no helper in this version.

Who said explanation has to be conveyed in human language to the
caller of the helper?  Since there are only two possible cases, at
least for now, and I do not think there will be countless many in
the future, for the branch_get() function to fail, you can still do:

    	int explain_error;
	struct branch *branch =3D branch_get(argv[0], &explain_error);

        switch (explain_error) {
	case DEFAULT_HEAD_DETACHED:
        case GIVEN_HEAD_DETACHED:
		die(_("could not make %s upstream of the current branch "
			"because you do not have one"), new_upstream);
		break;
	default:
		break;
        }

and we could even fold the !ref_exists() check that is there for
typo-detection purposes into the framework, e.g.

	case GIVEN_BRANCH_DOES_NOT_EXIST:
		die(_("you told me to make %s upstream of %s "
			"but the latter does not exist yet"),
			new_upstream, argv[0]);

if we wanted to preserve what the current test does, no?

>  > The existing test might be wrong, by the way.  Your HEAD may point
>  > at a branch Y but you may not have any commit on it yet, and you m=
ay
>  > want to allow setting the upstream of that to-be-born branch to
>  > another branch X with "branch --set-upstream-to=3DX [Y|HEAD]".
>
>  It sounds complicated. I think we can revisit it when a user actuall=
y
>  complains about it.

Yeah, will replace the previous one and queue this version.

Thanks.
