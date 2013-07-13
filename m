From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mailmap: Testing the single letter name case.
Date: Sat, 13 Jul 2013 13:20:10 -0700
Message-ID: <7vk3kugqkl.fsf@alter.siamese.dyndns.org>
References: <1373665135-32484-2-git-send-email-gitster@pobox.com>
	<1373700020-30436-1-git-send-email-stefanbeller@googlemail.com>
	<7v8v1aicn5.fsf@alter.siamese.dyndns.org>
	<51E198FC.5080005@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jul 13 22:20:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uy6It-0007w8-Ke
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 22:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758261Ab3GMUUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 16:20:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38496 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758254Ab3GMUUW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 16:20:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6E2030519;
	Sat, 13 Jul 2013 20:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3uZ0LKE1qL6qnJl7D7QTtEHC6hU=; b=c4Iulw
	ExVcoXC7M0q18dC5Q4V9qv/zPQNSDAZk6O9RMsHOWiJhOGZzd5cXhIpfrHyAxOaV
	dbPxVjTzMniFnjpBnwPSkT+ONr7k32lZmUNdOAiERG8kCXcNQ5nX5GgcBkZrHlS0
	d0slOXHAA/5ET5oYxaQ5wiZTnZvHgnFzq+pes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rNsTIGlWYqyMJPxjaregrtRdsaJg+Azw
	1tTUSDVCOJXra3PjDqbQqypI6tGXTiWJzDxx7KZw7wuHrpIJuqwy9Arw5EeXs8Rn
	BSIZwMvziyvuoXypSxS5MnCAZMMvsrShh0ETG9GRQGXlK/LWu5qpLf/KhoN5Q4vh
	bLTXFd1cKBQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B97CF30517;
	Sat, 13 Jul 2013 20:20:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB97E30515;
	Sat, 13 Jul 2013 20:20:20 +0000 (UTC)
In-Reply-To: <51E198FC.5080005@googlemail.com> (Stefan Beller's message of
	"Sat, 13 Jul 2013 20:14:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A438360A-EBF9-11E2-BD9D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230291>

Stefan Beller <stefanbeller@googlemail.com> writes:

> Indeed the patch tests for both bugs unintentionally.

I was puzzled because I do not think that is what is happening with
the posted patch.

If I drop the tip one from jc/mailmap-case-insensitivity and apply
this patch instead, the test passes (which is good).

	git checkout 1ab5d42
        git am <sb.mbox
        make && cd t && sh t4203-mailmap.sh

Of course, if I revert 543f991 (i.e. do not downcase fix), the test
in this patch fails as expected.

	git checkout 1ab5d42
        git am <sb.mbox
	git show 543f991 | git apply -R
        make && cd t && sh t4203-mailmap.sh ;# should fail and does

But if I only revert a66e77e (i.e. off-by-one fix) while still
keeping the downcase fix, the test in this patch should fail---but
it doesn't seem to.

	git checkout 1ab5d42
        git am <sb.mbox
	git show a66e77e | git apply -R -3
        make && cd t && sh t4203-mailmap.sh ;# should fail but doesn't

The off-by-one fix seems to be correct from code inspection, but the
new test does not seem to demonstrate a case where the code before
the fix misbehaves.
