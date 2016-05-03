From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/41] Add and use error_errno() and warning_errno()
Date: Tue, 03 May 2016 13:11:02 -0700
Message-ID: <xmqq1t5inbqh.fsf@gitster.mtv.corp.google.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
	<1462277054-5943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 22:11:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axgf3-0000JA-9B
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 22:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223AbcECULI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 16:11:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64995 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756095AbcECULH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2016 16:11:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DBE0189BE;
	Tue,  3 May 2016 16:11:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=39abN0KK5l8n
	ny+brH1pHHYWzoo=; b=SBlKI/2Ct9nwg5LPHFSwyblQB2bIGoFON8ftODVp73Fk
	An1LCZVpc5BeaRMh4Zvhxpf9y9OQsE62DGwtJTQ/GXRpLTEzO6HUH7Z2ENYHUtFb
	7Y7wsjjBTByLVuwucV/VDWBMMLM/Z9DIBywvVk1kHwLJm/o1gR+oTH7V8u1ouHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Usy/Qo
	Yf1jNzmsq2N7RvN1rsHclYzftW2N4yDgq6CIzYAbDHxpEWY0fOPnFX7KkgJH05DT
	EQ2O946d5EHMHmrD1gWr4xU6DsyI5y/I+d5SRtgzE05q+MzV66p7ChBV+HFFrnNL
	d2Cc60MVuHJVPR36wQRa/cgmpZfHZYbDLOyb4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 02A59189BD;
	Tue,  3 May 2016 16:11:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 412F0189BC;
	Tue,  3 May 2016 16:11:04 -0400 (EDT)
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 3 May
 2016 19:03:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 29E5B720-116B-11E6-917F-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293449>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Changes are in
>
>   [01/41] usage.c: move format processing out of die_errno()
>   [02/41] usage.c: add warning_errno() and error_errno()
>   [12/41] builtin/update-index.c: prefer "err" to "errno" in process_=
lstat_error
>   [17/41] compat/win32/syslog.c: use warning_errno()
>   [27/41] grep.c: use error_errno()
>
> 12/41 is basically a revert with s/strerror(errno)/strerror(err)/.
> Interdiff from v1

Thanks.  The earlier parts that lay the foundation looked good, and
most of the conversion of the callers were, too (I think there was
only one whose validity I wasn't sure about, though).

Some of the changes that are more than a straight and faithful
conversion, i.e. fixes to places that used to show an extra newline,
used to lack errno in the output, etc., deserve to be mentioned in
the log message of respective patches.

Thanks.
