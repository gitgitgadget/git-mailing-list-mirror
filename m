From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD/PATCH] stash: introduce checkpoint mode
Date: Thu, 19 Feb 2015 09:49:11 -0800
Message-ID: <xmqq7fvd23mw.fsf@gitster.dls.corp.google.com>
References: <54E5C27E.9060109@drmicha.warpmail.net>
	<dbd1aae0508bd72dc3b21fabda4c420eef487720.1424349039.git.git@drmicha.warpmail.net>
	<8AAD6FE6-75C1-4BA2-8667-4DF8BF6B1EE4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Armin Ronacher <armin.ronacher@active-4.com>,
	=?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 18:49:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOVE4-0006pq-35
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 18:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbbBSRtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 12:49:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751824AbbBSRtT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 12:49:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5ADA337FE6;
	Thu, 19 Feb 2015 12:49:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=22skFP70FOttchBTrnCRpwmWbug=; b=Ohj5YV
	Zd9pSbT2KfDtYbrH2iyEZAhoT6n/RBF14EfW756V4xXOD8OhJ0D+e+6MGuGz5vHY
	ZFzJbT2xpzvh6c6/PMY3VhsxgRBhab65w1Vt/sSdbWJhIQfb83+nqN+Ymc5M12MP
	Wa4Vb2Ex6ml25v6QASPoEQjooViA3IDAivJUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gELmGU8mQJBdF1WFIGX5qPHWl6TpL4E4
	fcMw3cVeRHW5rYrau4JRwkPVP/ILQp12XgL2bhdbZbNyub/d+gRGQeMpn6o70IYp
	z3cBU87sp3cYoAOf+4SfRXM+i8Go+S4Z5X+7z1auC8TI9kx/OkWenKcJAaOqZRyj
	TYFL1LyAGkQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 51C8237FE5;
	Thu, 19 Feb 2015 12:49:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3CF937FE4;
	Thu, 19 Feb 2015 12:49:12 -0500 (EST)
In-Reply-To: <8AAD6FE6-75C1-4BA2-8667-4DF8BF6B1EE4@gmail.com> (Kyle J. McKay's
	message of "Thu, 19 Feb 2015 05:58:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9D488A96-B85F-11E4-B3D3-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264104>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> What about a shortcut to "reset-and-apply" as well?
>
> I have often been frustrated when "git stash apply" refuses to work
> because I have changes that would be stepped on and there's no --force
> option like git checkout has.  I end up doing a reset just so I can
> run stash apply.

Doesn't that cut both ways, though?

A single step short-cut, done in any way other than a more explicit
way such as "git reset --hard && git stash apply" (e.g. "git stash
reset-and-apply" or "git stash apply --force") that makes it crystal
clear that the user _is_ discarding, has a risk of encouraging users
to form a dangerous habit of invoking the short-cut without thinking
and leading to "oops, I didn't mean that!".
