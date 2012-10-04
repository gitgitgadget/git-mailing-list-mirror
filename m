From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] wildmatch part 2
Date: Thu, 04 Oct 2012 10:43:16 -0700
Message-ID: <7vwqz6yvyj.fsf@alter.siamese.dyndns.org>
References: <7v626q3hen.fsf@alter.siamese.dyndns.org>
 <1349336392-1772-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:42:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJteb-00033L-HF
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933551Ab2JDRna convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2012 13:43:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54413 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933540Ab2JDRnT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2012 13:43:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED6EB9CEC;
	Thu,  4 Oct 2012 13:43:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3UcB8zPH5+6C
	nDJyAntgD6ql8j8=; b=ruCW3REA2021LXyraJIfkwrY1tj0brPe0Lg7s3AWKK0q
	+WB1eLpOtWcPobeBivLVZxvMg3MrV4aDVKIu0u67lxwgSfD7tCVITVfuZGf82w+8
	DXKmECJ07o4Fdv01OLpHD2CVKZMqm7f5nBiYQX2BY372RB45rDfazxMPcVxenG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sUwqao
	daZk9upxKppEkDe/Gqi38HXY3FqbzV+cAxTt/Z/LduluF2NkTo0GiQXpzEx+GZ5I
	ZxTBerm1NM4P4/kOX7aghF4giMw55ma8Hrn2GdI4DeBM+CpyROWJ9wQIZ61oARA/
	tI5GpPiQdz2INPxXhTjPC9caHuClTH9WcDRpw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAEAF9CEB;
	Thu,  4 Oct 2012 13:43:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3903C9CE7; Thu,  4 Oct 2012
 13:43:18 -0400 (EDT)
In-Reply-To: <1349336392-1772-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 4 Oct
 2012 14:39:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB621794-0E4A-11E2-9A90-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207019>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> On Thu, Oct 4, 2012 at 1:01 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Perhaps the wildmatch code may not be what we want X-<.
>
> When I imported wildmatch I was hoping to make minimum changes to it.
> But wildmatch is probably the only practical way to support "**" even
> if we later need to change it the way we want. Other options are base
> our work on top of compat/fnmatch.c, which is an #ifdef spaghetti
> mess, or write a new fnmatch()-compatible function. Both unattractive
> to me.
>
> Anyway, this is on top of nd/wildmatch, which makes "ab**cd" match
> full pathname.

I do not think we are in a hurry to push "**" support in before we
know what semantics we want to get out of it.  Pushing half-baked
"this is good enough at least to me for now" topics before they are
ready will cost the users in the longer term.

On the other hand, the three patches (2/3/4) in this series look
like a good improvement regardless of what kind of matching engine
we use.  I would have preferred to see them _before_ nd/wildmatch.

I do not agree with the reasoning behind [1/6] that changes

	union {
		char *pattern;
		strict git_attr *attr;
	} u;
	char is_macro;

to

	char *pattern;
	strict git_attr *attr;
	char is_macro;

by the way.

The union is much less about space saving but is more about the
nature of the usage; we use pattern or attr but not both at the same
time.  Even if the pattern becomes richer with later patches, that
does not change the fundamental premise that depending on the value
of "is_macro", either "attr" is used or "pattern" is used but they
won't be in effect at the same time.  The evolution of this should
go more like this, I think:

	union {
		struct {
			const char *string;
			int pattern_length;
			int prefix_literal_length;
			int flags;
		} pattern;
		struct git_attr *attr;
	} u;
	char is_macro;

Thanks.
