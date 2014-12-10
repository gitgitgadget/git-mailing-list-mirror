From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/5] glossary: introduce glossary lookup command
Date: Wed, 10 Dec 2014 14:50:55 -0800
Message-ID: <xmqqa92vf7ao.fsf@gitster.dls.corp.google.com>
References: <cover.1418052470.git.git@drmicha.warpmail.net>
	<585191103e7bdd21ed422324504b6503bec2b914.1418052470.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 10 23:51:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyq62-0000Is-K7
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 23:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758206AbaLJWu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 17:50:58 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57591 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758203AbaLJWu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 17:50:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A043250FD;
	Wed, 10 Dec 2014 17:50:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JB91Pbd28oHyy2/n/o1FESwod1c=; b=NRaReJ
	VDXM8yuGrj/N8AR6RHSaxHb7GWqqbPSozeQfsz7YVe/DOlxtScG9MNwyVi8AQhW4
	7Cqjlb05mDE8xlulUgFoV3tjlwg0U8P8b23DWm8PYNl4gv3a6fOEWBLqr7E/aey1
	GURB5aaB8OzgbicVnYmwJUiE2eBecQl/pGGWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rpRv5yJYsCW+vmOr2g3GCeEkwLnyu0H0
	tyMCx1lx4+f10vsZPofQ8SZjVo4CAJ9pD7cGRtbCPPilo/l9syuWvgQ+mY/iAG84
	jReIHlsEpJaajPADQ9uJK6ZplEBWL+BuEyMgsCJ5jI7TZ+QmTwQF11WnpVzdwkCg
	11Q9ZvrlSsg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18601250FC;
	Wed, 10 Dec 2014 17:50:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8A08C250FB;
	Wed, 10 Dec 2014 17:50:56 -0500 (EST)
In-Reply-To: <585191103e7bdd21ed422324504b6503bec2b914.1418052470.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Mon, 8 Dec 2014 16:38:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 00A2F82A-80BF-11E4-ABF5-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261254>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> When using a localised git, there are many reasons why a correspondence
> between English and localised git terms is needed:
> - connect localised messages with English ones (porcelain vs. plumbing)
> - connect localised messages with English man pages or online docs
> - help out someone in a different locale
>
> Introduce a `git glossary' command that leverages the existing infrastructure
> in three possible ways:
> - `git glossary' lists all glossary terms along with their translation
> - `git glossary foo' matches `foo' in the glossary (both English and
>   localisation; partial matches shown)
> - `git glossary -a foo' matches `foo' in the git message catalogue
>   (English, exact match only).
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Some bike-shedding expected regarding the interface...
> Once I've learned how to test l10n stuff, this will be amended.

This is interesting.

I wondered if we want to also have the associated documentation in
response to a query, but I am not sure how well that would go
without having a translated glossary at least.  I.e. pulling the
original from glossary-content.txt would produce something like
this:

	$ LANG=de git glossary -l blob object
        Blob-Objekten
	Untyped <<def_object,object>>, e.g. the contents of a file.

which is not ideal.

I noticed that you allow querying more than one term from the
command line, so the above example would not work quite well, as we
would end up querying "blob" and then "object", not a single term
"blob object" which does have N_() translation in <glossary.h>.
