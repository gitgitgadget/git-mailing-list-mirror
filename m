From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Rename lineno_width to decimal_width and export it
Date: Mon, 13 Feb 2012 15:29:28 -0800
Message-ID: <7vhayub9d3.fsf@alter.siamese.dyndns.org>
References: <7vsjigl79j.fsf@alter.siamese.dyndns.org>
 <1329056180-29796-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Feb 14 00:29:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx5Ky-0001Oq-R0
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 00:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758318Ab2BMX3f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 18:29:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55946 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758307Ab2BMX3b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 18:29:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5521B78BC;
	Mon, 13 Feb 2012 18:29:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1Nn6wgjr7ehi
	+bPLgVPdQ+Ci/c4=; b=fqiiFL3ZrqHbjuu/p4oFfZayb7qyPbpvOHxHyPLWtwB6
	C30Yqkwz8HR9fTfRgoOB3KhGOUy/34hB3/qGSbmoejJk7qGXLNxATcKZuc9vP7IP
	TOryaHEzxbmPIfy+OFEHvge2aYWQzdNalJzaiSOiaRIW3SkrCHdInoxyElSarvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RJ5vG1
	TIce/k4Qq5UdS7gZRz29SiDmn0gy0pSobyHjolGOx7tE6b/yFV5JXJsNgXMpwM7V
	O/cXUMyPIkepR6qqVfbPXlnLTmsFh+zLemUF5mBPltX4ol7+6Lmmq1p9OyEqO6lO
	Nnal9YmFYhShIoXURE7YXA8oMhujJBgXbnIa4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CBE378BB;
	Mon, 13 Feb 2012 18:29:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D00F078BA; Mon, 13 Feb 2012
 18:29:29 -0500 (EST)
In-Reply-To: <1329056180-29796-1-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Sun, 12 Feb 2012
 15:16:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9392A128-569A-11E1-849A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190688>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> This function will be used in calculating diff --stat graph width.
> The name is changed because the function works for any number.
> The function is moved from builtins/blame.c to pager.c because it
> will be used not only in builtins/blame.c.

I'd prefer to see description of preliminary changes phrased without
depending too heavily on things that hasn't happened when possible.
Making a generic helper function to count digits necessary to print a
cardinal number available to future callers is a good thing by itself,
even if the "dynamic --stat width computation" turned out to be a bad
idea for whatever reason (I am not saying it is a bad idea here).

Perhaps like this.

	Subject: make lineno_width() from blame reusable for others

	builtin/blame.c has a helper function to compute how many columns
	we need to show a line-number, whose implementation is reusable as
	a more generic helper function to count the number of columns
	necessary to show any cardinal number.

	Rename it to decimal_width(), move it to pager.c and export it for
        use by future callers.

And you can say something like "I'll be using this in 'diff --stat' in
later patches" after the three-dash line.

> ---

Sign-off before the three-dash line?

> +/*
> + * How many columns do we need to show numbers in decimal?

s/numbers/this number/;

> + */
> +int decimal_width(int number)

Don't we want to make the argument "unsigned number" instead?

> +{
> +	int i, width;
> +
> +	for (width =3D 1, i =3D 10; i <=3D number; width++)
> +		i *=3D 10;
> +	return width;
> +}
