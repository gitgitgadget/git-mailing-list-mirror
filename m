From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 3/4] tests: add new test for the url_normalize function
Date: Sun, 21 Jul 2013 22:15:01 -0700
Message-ID: <7veharqip6.fsf@alter.siamese.dyndns.org>
References: <f1109cf05979890ea9441fae7881586@f74d39fa044aa309eaea14b9f57fe79>
	<185ed81d5965642db680fa361ee07ce@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 22 07:15:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V18T8-0003c9-WE
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 07:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167Ab3GVFPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 01:15:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33010 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755047Ab3GVFPE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 01:15:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87C992C6DE;
	Mon, 22 Jul 2013 05:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0Uwzsqgk//8O0VP4/ukTZ+gaRLw=; b=eTCENN
	xe4JO5JihSy1egFv6Re29IP2cklVj2dKaxfajZmR+2/HTaX1pkIKTTaAMlQ1keRb
	PLBoelfAJ9DhAwW3VWQLBGjkG4iKWEecKXFrH/DGHa52I0kvuzmhsz1MdgfEO+XV
	PS4MTogvxBCDfY0n4FTVwykJxaYhYYaH/TZF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wgE3r2LMS1otpev9e3fMTgPGHH8+n2j4
	xdSUGFHPPzJyPlcZu/Lv5VODWUTF7xEbM3P1x5HiGYZR8f9v3znWrp3XekdIsSvo
	o/RrRm38MV/6uU6t0DEZvNnykMGTM20DNX1gNxfI1aVWctDSIKtWbMUy6slVzJRM
	0/vcBPzrNk4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77EDC2C6DC;
	Mon, 22 Jul 2013 05:15:03 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BBBE22C6D9;
	Mon, 22 Jul 2013 05:15:02 +0000 (UTC)
In-Reply-To: <185ed81d5965642db680fa361ee07ce@f74d39fa044aa309eaea14b9f57fe79>
	(Kyle J. McKay's message of "Sun, 21 Jul 2013 20:18:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A9DC8EEA-F28D-11E2-98E5-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230959>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> +test_expect_success 'url general escapes' '
> +	! test-url-normalize "http://x.y?%fg" &&
> +	test "$(test-url-normalize -p "X://W/%7e%41^%3a")" = "x://w/~A%5E%3A" &&
> +	test "$(test-url-normalize -p "X://W/:/?#[]@")" = "x://w/:/?#[]@" &&
> +	test "$(test-url-normalize -p "X://W/$&()*+,;=")" = "x://w/$&()*+,;=" &&
> +	test "$(test-url-normalize -p "X://W/'\''")" = "x://w/'\''" &&
> +	test "$(test-url-normalize -p "X://W?'\!'")" = "x://w/?'\!'"
> +';#'

Hmm,... what is the magic on the last line about?
