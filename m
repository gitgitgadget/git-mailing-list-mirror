From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] revision: add --grep-reflog to filter commits by
 reflog messages
Date: Fri, 28 Sep 2012 22:35:56 -0700
Message-ID: <7v4nmhjsqr.fsf@alter.siamese.dyndns.org>
References: <7vr4pmm3qz.fsf@alter.siamese.dyndns.org>
 <1348893689-20240-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 07:36:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THpj9-0002NJ-Jg
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 07:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950Ab2I2FgB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Sep 2012 01:36:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57256 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737Ab2I2Ff7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Sep 2012 01:35:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17E1192B2;
	Sat, 29 Sep 2012 01:35:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pOO8oGEoGbTJ
	OBC5q2J23NtaDMo=; b=syvLh7BFxMhYBQRyWdN2S+t0K4E0fFwpeGXDNz72yoS8
	MvacS6gL1PuqCdMa3wSKqTZou76kKh3oLZwJFN0z6qqiBbk4zCp1Maqi/9bVlxmg
	IJj/FjOUS6DO3FeZF/ypZeyE9aDtpceRwawuPEkx9BfdnltmfA4C/FWPKmLCZeg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WuYhM7
	SBFE1pNyCKStHMUv9ovWFK7iNYiSMWFeJjRlI1qLZp/WQxzoJPWmWuMfInZIemY4
	rdyJMxRbcD/sgAx2IouTsXpc/3btAvZCi4/73aVeVzFDR8V3gMl8y3Vp3WYHvOkq
	lFYSAjJ4xrj8G1GpIUorCMdEP+BPjQex1cKm0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0557792B1;
	Sat, 29 Sep 2012 01:35:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7642D92B0; Sat, 29 Sep 2012
 01:35:58 -0400 (EDT)
In-Reply-To: <1348893689-20240-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 29 Sep
 2012 11:41:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C002032-09F7-11E2-AD50-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206627>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> On Sat, Sep 29, 2012 at 12:55 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> For that to happen, the code _must_ know what kind of headers we
>> would support; discarding the existing enum is going in a wrong
>> direction.
>
> Or what kind of manipulation is required for a header. The caller can
> decide if it wants such manipulation or not. Somebody might want to
> grep committer's date, for example.

Yes, if we wanted to filter log outputs to commits authored only on
Thursdays, we would introduce --author-date=3D"<some expression that
yields true only on Thursdays, given the timestmap" option, add
GREP_HEADER_AUTHOR_TIMESTAMP_EXPRESSION=3D2 to enum grep_header_field,
and add a new element { "author ", 7 } to grep.c::header_field[2]
(the index 2 matches GREP_HEADER_AUTHOR_TIMESTAMP_EXPRESSION), and
implement the evaluator for <some expression that yields true only
on Thursdays, given the timestamp> language in the GREP_PATTERN_HEAD
part of match_one_pattern() and use the p->field to select that
logic.  At that point, we may be better off introducing a helper
function to split the more complex logic for GREP_PATTERN_HEAD out
of the match_one_pattern() function.
