From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP 01/11] Introduce "check-attr --excluded" as a
 replacement for "add --ignore-missing"
Date: Thu, 27 Oct 2011 11:08:10 -0700
Message-ID: <7vfwiez4s5.fsf@alter.siamese.dyndns.org>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 20:08:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJUNM-0007YX-JP
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 20:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329Ab1J0SIO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Oct 2011 14:08:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33436 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225Ab1J0SIN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2011 14:08:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0C52578B;
	Thu, 27 Oct 2011 14:08:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FQjCioJzV4BI
	xC2gF4PO/37GKK0=; b=ojslueDYNMfUQEDS46fPHKIREFEGhzp8VDbyzYqPVLqT
	LX0PnSjXXruLd71GUN5LsGT25OZ4i8D7AeN3JBG678U61629CcSd8v50zZvbRiKp
	5Eg/m1c/yZyKZP60geAtXhSHD9W4i9DdjR3FOtRyczWJE9QxqfCkI6p2YJmDqco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QISPjA
	u5lm0sf5+OihlAA6s+9en9WUgFa6ptbIofA/wrZfCdpa5+JuLbnNdkUKYNBUbex1
	UedDpVnR21FHTCC5/MzO4gpazsDt7fgQejdoZYUe4/OED5yvD0N7PBJrKWuuViAs
	PtUOc+yPJb73ys0r7wBc12ORO0cLLkfaeQDGI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A74CC578A;
	Thu, 27 Oct 2011 14:08:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37AAF5789; Thu, 27 Oct 2011
 14:08:12 -0400 (EDT)
In-Reply-To: <1319438176-7304-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 24 Oct
 2011 17:36:06 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A22FBAA6-00C6-11E1-85C2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184311>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> --ignore-missing is used by submodule to check if a path may be
> ignored by .gitignore files. It does not really fit in git-add (git
> add takes pathspec, but --ignore-missing takes only paths)
>
> Google reckons that --ignore-missing is not used anywhere but
> git-submodule.sh. Remove --ignore-missing and introduce "check-attr
> --excluded" as a replacement.

Hmm. "add --ignore-missing" somehow does not fit very well with other u=
ses
of the option of the same name. In all other contexts, "ignore-missing"
means just that: ignore the fact that whatever _thing_ we were made to
expect to exist by the instruction from the user does not exist, which
usually results in an error or a report. "add --ignore-missing" does no=
t
seem to be that (for one thing, it requires --dry-run).

It is unclear to me what is supposed to do to after reading the three-l=
ine
documentation in the manpage X-<.

So I am perfectly OK with the removal in the current form.

But I do not think "is this path ignored with the .gitignore rules" che=
ck
belongs to check-attr, either.

The pattern of having .scmignore files to list ignored paths were force=
d
upon us by historical version control systems, in the name of "the user=
s
expect it". If there weren't such constraints, it would have been far
nicer---we could have just said "if you want to ignore paths, just use =
the
attributes mechanism and give them the 'ignored' attribute" without hav=
ing
to have the exclude mechanism.

But we do not live in that ideal world.

Perhaps ls-files is a more suitable home for the feature?
