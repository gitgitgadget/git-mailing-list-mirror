From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: use streaming interface for reading large
 loose blobs
Date: Tue, 29 May 2012 10:56:18 -0700
Message-ID: <7vd35m6fct.fsf@alter.siamese.dyndns.org>
References: <1338028081-22638-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 19:56:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZQef-0001LC-RZ
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 19:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738Ab2E2R4V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 May 2012 13:56:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59991 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754517Ab2E2R4V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 May 2012 13:56:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87E9B8616;
	Tue, 29 May 2012 13:56:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0UGGBSOHmlih
	JhyWHSo0c1pIXfw=; b=dgSkGC3UfUf2S7xPH/3QMcmKPVewecoDCceoC/pSXVh3
	bumskgiAq7+WLMuvcltEm2oriQb3mJ6Do+5STDaMYwv+Mfl7OGV6xpCaBhrnmw8I
	lSNA2Ww6UmpwBK3Ji3vuI4HxtLdPSy8+xxePdSVtsxKsTPAE48uEmQbwn1eILOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=p+9dfm
	UvFWrCHx4vOWn+OeQZMB1mo/we6cZeEuBVnqRS3DjU8X+ayOX/YB0z4ZEW1w7Qf1
	PGOuKYDlvKI8opTflO6MX+VBwHa+krKVeZB/xXRENdiZLgKtnJazJeoHYmG5ZX+N
	uVlbGSJKCm3zNG7Xy4zHV71Pa9e2b/w543hIc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DE5A8615;
	Tue, 29 May 2012 13:56:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1407A8612; Tue, 29 May 2012
 13:56:19 -0400 (EDT)
In-Reply-To: <1338028081-22638-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 26 May
 2012 17:28:01 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 988725DA-A9B7-11E1-B176-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198743>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> git usually streams large blobs directly to packs. But there are case=
s
> where git can create large loose blobs (unpack-objects or hash-object
> over pipe). Or they can come from other git implementations.
> core.bigfilethreshold can also be lowered down and introduce a new
> wave of large loose blobs.
>
> Use streaming interface to read/compress/write these blobs in one
> go. Fall back to normal way if somehow streaming interface cannot be
> used.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  On top of ng/pack-objects-cleanup. Changes since the last version is
>  we do not rely on close_istream(NULL); any more.

This version looks much cleaner, at least to me, as the logic in the
function always switches upon "st", using it as "are we reading the
data from the stream incrementally?"  boolean.

Thanks, will queue.
