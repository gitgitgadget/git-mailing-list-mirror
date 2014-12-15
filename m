From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 11/23] untracked cache: load from UNTR index extension
Date: Mon, 15 Dec 2014 11:35:37 -0800
Message-ID: <xmqq7fxsemeu.fsf@gitster.dls.corp.google.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
	<1418047507-22892-13-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 20:35:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0bQp-0000EJ-8M
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 20:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbaLOTfm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Dec 2014 14:35:42 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59941 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751039AbaLOTfl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Dec 2014 14:35:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D19E278B7;
	Mon, 15 Dec 2014 14:35:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1NA7ek7DDEnf
	y7hEkOjWNWLB0+U=; b=TvsDYtXVAc1bTRo5DCej8R/pRsKswH7VNU6J5iFppg3d
	Ql3rWPVakT40NfEfkdkkHMkV1Z9ASp4n+mL3W19jIcHQRao+evcivAEWCBFwEnrz
	xoLJrILV3v4mrCAJdiiw4juBUrOT3BWing+2na7L5LxUgJQT+EAWL/z16FJLCaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gtgYuZ
	CjFEtrjhU0m8CqJvDrRgdyT5Csjkdy9/KvTy2G7V5JUhj9sLI88zwVVW44FIe3Da
	iSEqy7k+pGLM6jr1tLMb4pHThI8KkqXcz3ttajK0rbaEK0XIYOobLwHHVhLj7Muc
	n9ixZPGNJC6xxLGdg2WSRTlvGjZg3FuDfNU9Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 33DC4278B6;
	Mon, 15 Dec 2014 14:35:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A3072278B5;
	Mon, 15 Dec 2014 14:35:39 -0500 (EST)
In-Reply-To: <1418047507-22892-13-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 8 Dec
 2014 21:04:55 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8CE310F6-8491-11E4-9875-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261412>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +struct untracked_cache *read_untracked_extension(const void *data, u=
nsigned long sz)
> +{
> +	const struct ondisk_untracked_cache *ouc;
> +	struct untracked_cache *uc;
> +	struct read_data rd;
> +	const unsigned char *next =3D data, *end =3D data + sz;

data + sz is arithmetic on void * which is a no-no.
