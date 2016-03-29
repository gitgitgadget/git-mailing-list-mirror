From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] config --show-origin: report paths with forward slashes
Date: Tue, 29 Mar 2016 13:05:06 -0700
Message-ID: <xmqqwpolvyml.fsf@gitster.mtv.corp.google.com>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
	<8beb1c208e33e1de8f272caa22fb7a0b662ca4cc.1458668543.git.johannes.schindelin@gmx.de>
	<56F8E435.3020304@kdbg.org>
	<alpine.DEB.2.20.1603281712470.4690@virtualbox>
	<56FAD506.4050701@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:14:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akzvl-0001IN-Uk
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 22:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbcC2UGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 16:06:47 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754085AbcC2UFK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 16:05:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E44C550D5C;
	Tue, 29 Mar 2016 16:05:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KJ1guVH63n0NEpAFlTa1WoPMw40=; b=qknTC6
	qDMMcVdHZ7uAJb0xKJ1AOm76cxD0aUm3OjQLK/rEukXo9NFg3PjctkmcG01UEdJr
	h8DcY78wazYJER3+31797zl3vUyjL+llhqeQ9srMm1jlT6hG39stDjjz4OBu8Brf
	K5SHX3clhKuUHVF3BMBjWUtJQICpm6fzJ9mvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RgpH9ZLR/WXDQ0erYMtXTQhnifkmTEBB
	ZlbrIjtOgvmOe8gXhIiyfn2wHA4lR/VI6y9rNm0uu3Wt4YGMnkz1zofvTJsgZwTz
	7YxUeZUUqKGjdZfAaWQI72FaBtUxQZES/h+VUsABhgNONsOewNJvt/n4Ht9ZzlJ+
	X7MRIes8wYA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DAA1B50D5B;
	Tue, 29 Mar 2016 16:05:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3A68250D57;
	Tue, 29 Mar 2016 16:05:08 -0400 (EDT)
In-Reply-To: <56FAD506.4050701@kdbg.org> (Johannes Sixt's message of "Tue, 29
	Mar 2016 21:18:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8930C992-F5E9-11E5-9228-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290181>

Johannes Sixt <j6t@kdbg.org> writes:

> This part of your 45bf3297 (t1300: fix the new --show-origin tests on
> Windows)
>
> @@ -1205,6 +1205,9 @@ test_expect_success POSIXPERM,PERL 'preserves existing per
>           "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) != 0600"
>  '
>  
> +! test_have_prereq MINGW ||
> +HOME="$(pwd)" # convert to Windows path
> +
>  test_expect_success 'set up --show-origin tests' '
>         INCLUDE_DIR="$HOME/include" &&
>         mkdir -p "$INCLUDE_DIR" &&
>
> is actually a much more concise version of my proposed patch,
> although the result still misuses $HOME where it does not have
> to. In fact, if I revert 5ca6b7bb (config --show-origin: report
> paths with forward slashes), the tests still pass. But since it
> does not make a difference save for a few microseconds more or
> less during startup, it is not worth the churn at this point.

Well, from the point of view of codebase cleanliness, if we can do
without 5ca6b7bb4, we would be much better off in the longer term,
so I would say it would be wonderful if we can safely revert it.
