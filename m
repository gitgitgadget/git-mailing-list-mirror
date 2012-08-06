From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 0/16] Introduce index file format version 5
Date: Mon, 06 Aug 2012 08:51:58 -0700
Message-ID: <7vzk68yq5d.fsf@alter.siamese.dyndns.org>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344263760-31191-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	trast@student.ethz.ch, mhagger@alum.mit.edu,
	robin.rosenberg@dewire.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 17:52:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyPbG-000202-8f
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 17:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756558Ab2HFPwE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Aug 2012 11:52:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43106 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756396Ab2HFPwD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Aug 2012 11:52:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75F7768BE;
	Mon,  6 Aug 2012 11:52:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7LQI/g3VJPAd
	XrDbPQiT05FABq4=; b=r5Z05q3BnfENJw7ROvKX4OVaTP4yZixFx8lwv2u2VglV
	7V1+7huQLrXLrzzAPLZR/4xPQz6VvSDEJEvk7iWmhaoBVG3Fri69tvY7BRt5ZDpv
	7k5+Q8vBbq+vRMfPPFJhtVvok4hHeXL15is+Wx+LGtGv/FZXVugvwDpngU2enr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EK57bf
	Uo+mp0RxJpYjouAZwLjK5jv1eqN098WsghmFMLGM5ZzukN6jx2OvoZ4qgzlmNhi2
	r3v4fu37Kjpw7KVZQbT/lz0+tXMuA1RUiiCv6nkpTADFqQ775MLkhXOewE0Fa0SK
	+p2QP/mjlkCyHsmygITyXRkofAxmyxUjPPDpc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6212968BC;
	Mon,  6 Aug 2012 11:52:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BDAD68B8; Mon,  6 Aug 2012
 11:52:00 -0400 (EDT)
In-Reply-To: <1344263760-31191-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 6 Aug
 2012 21:35:58 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8C6D546-DFDE-11E1-A406-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202967>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> These mails are about cosmetics only. But I think it helps maintenanc=
e
> in long term. I notice in your series we have many functions with _v2
> and _v5 mixed together. Worse, some functions that are _v2 only are
> not suffixed with _v2. I still think separating v2/v5 changes is a
> good idea. So I played a bit, see how it might become.
>
> The next two emails demonstrate how we take v2-specific code out to
> read-cache-v2.c, then add v5 code in the next patch. Notice there's v=
ery
> little change in read-cache.c in the second patch. I wanted to see ho=
w
> v5 changes affects v2 users and the second patch shows it.

I like the splitting of the backend into two files; it is a good
direction to go, but I really prefer to see it done way before in
the series, so that many symbols in read-cache-v2.c do not have to
be contaminated with foo_v2 suffix, and similarly _v5 suffix for
symbols in read-cache-v5.c when they are added.
