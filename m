From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] merge-recursive: option to disable renames
Date: Tue, 16 Feb 2016 16:20:06 -0800
Message-ID: <xmqq7fi4kx1l.fsf@gitster.mtv.corp.google.com>
References: <1455665175-8665-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	Felipe =?utf-8?Q?Go?= =?utf-8?Q?n=C3=A7alves?= Assis 
	<felipegassis@gmail.com>
To: =?utf-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 01:20:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVpqq-0003wG-NR
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 01:20:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933431AbcBQAUK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 19:20:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61892 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933384AbcBQAUJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 19:20:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 802C4444AC;
	Tue, 16 Feb 2016 19:20:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Grz/eXiH4j5Y
	zmrmCoA+vVANbH8=; b=SPjisP9GllTlvme7veEuOkxJUaMbpOdu1NrfzvwSwKV7
	3Ix7yBcjTFKnJcG/248Cp22ltRO536iL7A5zTB1xKx9ux1p3fwqcxMzIcKPXZiPR
	fYlA168dE8I9qCSWHZ1gzJqYIaLbcMAOAQqt1paFDthWce+r4fCsZNl8fxuHvHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vag+rK
	UOJ5vq7XMz1S2tehR7UCKmqyCPgKfD217QQrECQ7xJZVsNQTsPpfy4JxV2SmANX3
	kKwSlPd1NIxLdffeYh7VFGM8kdL5DBu7Y4kct8zZwZFb99q5q9EUrKLq7dEVwEQ0
	mY0+imNy9nOkBGD8gUevchlfULHVx3xT4CQS0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 75B8B444AB;
	Tue, 16 Feb 2016 19:20:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E7571444A3;
	Tue, 16 Feb 2016 19:20:07 -0500 (EST)
In-Reply-To: <1455665175-8665-1-git-send-email-felipegassis@gmail.com>
	("Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis"'s message of "Tue, 16 Feb 2016
 21:26:15
	-0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 332D483E-D50C-11E5-9BD9-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286464>

"Felipe Gon=C3=A7alves Assis"  <felipeg.assis@gmail.com> writes:

> @@ -482,10 +482,13 @@ static struct string_list *get_renames(struct m=
erge_options *o,
>  	struct diff_options opts;
> =20
>  	renames =3D xcalloc(1, sizeof(struct string_list));
> +	if (!o->detect_rename)
> +		return renames;
> +
>  	diff_setup(&opts);
>  	DIFF_OPT_SET(&opts, RECURSIVE);
>  	DIFF_OPT_CLR(&opts, RENAME_EMPTY);
> -	opts.detect_rename =3D DIFF_DETECT_RENAME;
> +	opts.detect_rename =3D o->detect_rename;
>  	opts.rename_limit =3D o->merge_rename_limit >=3D 0 ? o->merge_renam=
e_limit :
>  			    o->diff_rename_limit >=3D 0 ? o->diff_rename_limit :
>  			    1000;

I do not think you want the latter change.  Also o->detect_rename
should be just a simple boolean and it is better not to link its
value with DIFF_ANYTHING symbol.
