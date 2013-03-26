From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] attr directory matching regression
Date: Tue, 26 Mar 2013 08:10:36 -0700
Message-ID: <7v38viurgz.fsf@alter.siamese.dyndns.org>
References: <20130319175756.GA13760@sigill.intra.peff.net>
 <1364191510-8900-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, avila.jn@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 16:11:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKVWv-0007mL-3H
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 16:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934623Ab3CZPKk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Mar 2013 11:10:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63628 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759818Ab3CZPKj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Mar 2013 11:10:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DD60AE4F;
	Tue, 26 Mar 2013 11:10:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=69nKW+D/c1Xw
	e1wg9zUp+bi2JSY=; b=srILfNJC/aOBo6Blzbt4vUJ5JOiQVEDJJOE7bA+zlEV2
	6IRpWVyLmS2A05nA5itJayhlhIpKlmMtipH83X3nLDu5LX0fxukeecPMmJpuPjs2
	ykfby2vY2Z84LN0iVO1KmOJmAaAS49ru/4E7Ns2XfFV/80++wZHt9EkOwjkoses=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BDHflH
	DyS2ST+yqnAfpzRFCiLcxeg1Wjh5Y7DLhQEK7wteBknFOQ9JWEOtbgjxxaWmy2fV
	zwgq4SUEH3igjOZepO+gAUbNQ+rjW3obP9VcYCMKF+3nRBnfw/L2m9PdN52K0WJz
	6kZ4psSpeS8ccRCOdouaMLMIBa+WEhHhpHOtQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73591AE4E;
	Tue, 26 Mar 2013 11:10:39 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECF6DAE4C; Tue, 26 Mar 2013
 11:10:38 -0400 (EDT)
In-Reply-To: <1364191510-8900-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 25 Mar
 2013 13:05:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5180604A-9627-11E2-AE06-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219163>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> I think the fix is something like this. There is still one thing I'd
> like to do: make this code not rely on NUL for terminating the
> patterns. That should remove the ugly "p[len] =3D '\0'" in
> prepare_attr_stack() 4/4 and and the reallocation in add_exclude() (i=
n
> current code). But let's deal with the regression first.

As a regression fix, we would need a fix that applies to
maint-1.8.1, not 'next'.

>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
>   wildmatch: do not require "text" to be NUL-terminated
>   attr.c: fix pattern{,len} inconsistency in struct match_attr
>   dir.c: make match_{base,path}name respect {basename,path}len
>   attr.c: fix matching "subdir" without the trailing slash
>
>  attr.c                          | 11 ++++++++++-
>  dir.c                           | 13 ++++++++-----
>  dir.h                           |  2 +-
>  t/t5002-archive-attr-pattern.sh |  6 ++++++
>  wildmatch.c                     | 43 ++++++++++++++++++++++++-------=
----------
>  wildmatch.h                     | 11 +++++++++--
>  6 files changed, 59 insertions(+), 27 deletions(-)
