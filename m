From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git-for-windows] Case insensitive branch names
Date: Mon, 21 Dec 2015 09:37:08 -0800
Message-ID: <xmqqa8p3hfej.fsf@gitster.mtv.corp.google.com>
References: <D350A5BC87B74A53B5BE4B10BC658208@PhilipOakley>
	<CACsJy8CEYaf9NA4J_2u1cqsikYvtR7nz=FEiwAxsKMLSREDhCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>,
	git-for-windows <git-for-windows@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 18:38:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB4PL-0004PL-6S
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 18:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbbLURh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 12:37:27 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751444AbbLURhK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 12:37:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 25D9132BC1;
	Mon, 21 Dec 2015 12:37:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VYEKY92eLXv27ELImG8re8bwQ1Q=; b=cT6XWM
	G5UNZ7e4tFAGAnwkhKrT1s7F0Fn9nJXl8p9huuBMcCzM1gU1lG46ZbLExYdw6OAw
	BR8G3IldacyYn/YRpYCIWiJoiCdaEpw9ifVSTSeUp9x/0xuY3+4xN1Ef5V9pFclP
	n2usJ5ocN57UClTzpyS3S2u0drYWT6be2Cdzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vtsPox9wFkOATvznjR2ZvnC0J9nxuYRV
	5OkY6OjGIBp7Q+VI1v7mdVr49578XrD5qXXFu8LEYLinLagkPqaMoLkd2tM0FrnO
	G1/7uzD/1xD2usSc24Qx3pJSTjD59qEc0papYoBr9XteIzlmPkvqW62WnLicx5O6
	buav67FhKFg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0FC0F32BBE;
	Mon, 21 Dec 2015 12:37:10 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 845D032BBB;
	Mon, 21 Dec 2015 12:37:09 -0500 (EST)
In-Reply-To: <CACsJy8CEYaf9NA4J_2u1cqsikYvtR7nz=FEiwAxsKMLSREDhCg@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 21 Dec 2015 19:21:02 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 762DC058-A809-11E5-BBE0-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282804>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Dec 21, 2015 at 6:01 PM, Philip Oakley <philipoakley@iee.org> wrote:
>> On the Git User's list, Diego J. reported that:
>>
>> 'When I "checkout" a branch using different Upper Case/Lower Case than the
>> original, the branch doesn't show in "git branch [--list]"' [1]
>>
>> While case sensitivity for filenames is a common issue on Windows and the
>> like, I haven't seen any discussion regarding ref name sensitivity - any
>> pointers to past discussions?
>
> Multiple ref backend [1] should solve this.

Yup, I had the same reaction.  Instead of restricting the namespace
of branches even on systems that do not have this problem, use a ref
backend that is not limited by the underlying filesystem.  A much
better solution.

In addition to the LMDB backend, it might not be a bad idea to add
another filesystem-based backend that encodes the refnames safely on
case insensitive or case destroying filesystem.  That way, those who
do not want an extra dependency but do want case sensitive refnames
would have an option, and having two non-default backends with quite
different semantics may be a good way to ensure that the API for
refs backend is kept sane.
