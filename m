From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep -P: Fix matching ^ and $
Date: Sun, 26 Feb 2012 14:39:29 -0800
Message-ID: <7vlinpdxsu.fsf@alter.siamese.dyndns.org>
References: <1330161868-7954-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 26 23:40:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1mlD-0005pv-MZ
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 23:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839Ab2BZWjd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Feb 2012 17:39:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50356 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752680Ab2BZWjc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2012 17:39:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4D28706B;
	Sun, 26 Feb 2012 17:39:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/rupDEBRXIgo
	BBgArjrcowlDbnc=; b=bo8GlfEnOJ5Rh7Rve2/IdRUGhobptBzR6pK0Ezx1Mqh3
	AT/oh6iri8595/qSfih0jafpWxNz2oAutETGH/8JpnyZ9fUsZZAHG1d3qImS0rKu
	VXu59kAcFU+HQFxHDmY0T7G36dRm4TWxRURAJskz5yKSd7oKMaBvwwcZOq5v7tk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TUS0w8
	QlitQgMOt29lZCHTlyjTNQzzW7AAg5VUs9ss0Fq0Ii7899ggig3u4y45MoDavN4E
	Ez2yzoykCIgrLj3h8prV9R+lehvFVq67ZAzK8jg0jwGsuV9SgrTjYN0K6rYM31vm
	ijb7sWBQOKaPoOAxeCvpl0MJJQj1xf5XorcZA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC673706A;
	Sun, 26 Feb 2012 17:39:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 399737068; Sun, 26 Feb 2012
 17:39:31 -0500 (EST)
In-Reply-To: <1330161868-7954-1-git-send-email-michal.kiedrowicz@gmail.com>
 (=?utf-8?Q?=22Micha=C5=82?= Kiedrowicz"'s message of "Sat, 25 Feb 2012
 10:24:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BFA0B392-60CA-11E1-807C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191579>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> @@ -893,4 +900,20 @@ test_expect_success 'mimic ack-grep --group' '
>  	test_cmp expected actual
>  '
> =20
> +cat >expected <<EOF
> +space: line with leading space1
> +space: line with leading space2
> +space: line with leading space3
> +EOF
> +
> +test_expect_success 'grep -E "^ "' '
> +	git grep -E "^ " space >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success "grep -P '^ '" '
> +	git grep -P "^ " space >actual &&
> +	test_cmp expected actual
> +'

This test does not pass for me as I do not usually build with pcre;
shouldn't it be protected with some test prerequisite?

Otherwise the patch looks good; thanks.
