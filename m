From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/2] CRLF: ce_compare_data() checks for a sha1 of a path
Date: Thu, 19 May 2016 16:10:44 -0700
Message-ID: <xmqqfutdhcej.fsf@gitster.mtv.corp.google.com>
References: <573A993F.8020205@web.de>
	<1463667675-25930-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Fri May 20 01:11:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3X64-0006xT-UW
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 01:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbcESXKs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 19:10:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753809AbcESXKs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2016 19:10:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE0701E289;
	Thu, 19 May 2016 19:10:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0ldYi4eduiLu
	j0qyCMAH4DpACIc=; b=ACJX85Hz1dy2J9oHSAsGaT34NOJkVfdEb4+2q7q3g3xS
	gTGZNndzpL9O1xui5jsZ8HUWigLpA6aj/0YGApzFOWdJPLHhLvI2saPXY/0NUU3u
	wyyHfxPPEI+h7MKBrGp5OaVUq1kYf0YUHwvdCQEitUQxroiDbns6obUMnwMO+dQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pKhprC
	Pa58wi9Sc4E3emkyEi/Fbw/SZsUKbEU1QNzdMBKG0vbZA8N/or3rz5E9sXK72cUU
	FJSKgHyLrQ4ZaoBK9Ks8/MIyoTMTz4bSMhRl3GwhtbSenT8zZZBUAhQJyBmJrVVs
	r20x6VYRDBquHUpOkuA14cUS7gS/oRMzfvp3I=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A68121E288;
	Thu, 19 May 2016 19:10:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2CB831E287;
	Thu, 19 May 2016 19:10:46 -0400 (EDT)
In-Reply-To: <1463667675-25930-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Thu, 19 May 2016 16:21:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EAFD1568-1E16-11E6-9521-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295127>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Break up the old 10/10 series about CLRF handling into smaller
> series. This is a small bugfix, when merge.renormalize is used
> with core.autocrlf (and no attributes are set).

Is it worth protecting the fix with a new test?  Or does this flip
an existing "expect-failure" to "expect-success"?

> Prepare the refactoring to use the streaming interface.

> Changes since v4:
>  - Rename #define in cache.h into HASH_USE_SHA_NOT_PATH
>  - convert.c: Rename has_cr_in_index into blob_has_cr()
>    Better logic when sha1 !=3D NULL,
>    Adjusted the commit message
>
> Torsten B=C3=B6gershausen (2):
>   read-cache: factor out get_sha1_from_index() helper
>   convert: ce_compare_data() checks for a sha1 of a path
>
>  cache.h      |  4 ++++
>  convert.c    | 34 ++++++++++++++++++++++------------
>  convert.h    | 23 +++++++++++++++++++----
>  read-cache.c | 33 +++++++++++++++++++++------------
>  sha1_file.c  | 17 +++++++++++++----
>  5 files changed, 79 insertions(+), 32 deletions(-)
