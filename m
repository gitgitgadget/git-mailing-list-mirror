From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/subtree: portability fix for string printing
Date: Fri, 08 May 2015 11:44:23 -0700
Message-ID: <xmqqpp6alxiw.fsf@gitster.dls.corp.google.com>
References: <xmqqmw1gp7aa.fsf@gitster.dls.corp.google.com>
	<1431046619-2340-1-git-send-email-danny0838@gmail.com>
	<xmqqy4kzklhp.fsf@gitster.dls.corp.google.com>
	<CAPig+cQQSrQiSzp7Jat8LYH+RqYdpJ2XCXweAtrYE_QoLzSznQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Danny Lin <danny0838@gmail.com>, git develop <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 08 20:44:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqnGA-0006RW-Sw
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 20:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbbEHSo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 14:44:26 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54214 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752666AbbEHSo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 14:44:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 81F9A4DE72;
	Fri,  8 May 2015 14:44:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q2N4D9lnYmhXHfi8OLSDwmYw1qk=; b=sgx0Dm
	+V3kXnRhBGvkJWeUTbVCtTshl5DJYVyqFhVA+mDjY55sqsvv+N4wqko/PWf8AZ6e
	XBX1CKwh/Bd6+H2cv4NbNmatzXerGzhRJjiLpVJGR3hbYh9obyBdBqmz0oZS9Pxy
	XR3Ofuc0tdlyRupZR42Fu+ssYeAqitVr+bXb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t7dCZsb7V/bS5weKLhUVqtVFMbflaRLF
	qrznhcfsQMKERDk3z5ateQASbLkRb2Mjv+zRjk0oyYYiq2QDRXMXeaSqbrFOpFXN
	7e45SQQppVlBJ/SkTtZl4ShcTJDJ6Ir/aXZIVz9salI3TPctvUJCvS7bj3JOuU8Y
	vf2WwB5SsZE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AD084DE70;
	Fri,  8 May 2015 14:44:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E88D64DE6D;
	Fri,  8 May 2015 14:44:24 -0400 (EDT)
In-Reply-To: <CAPig+cQQSrQiSzp7Jat8LYH+RqYdpJ2XCXweAtrYE_QoLzSznQ@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 8 May 2015 13:56:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3FB39020-F5B2-11E4-B7A1-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268643>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, May 8, 2015 at 1:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Danny Lin <danny0838@gmail.com> writes:
>>
>>> Replace echo using printf in debug() and say() for
>>> better portability.
>>>
>>> Also re-wrap previous 'say -n "$str<CR>"' using a new
>>> function progress() to prevent CR chars included in the
>>> source code, which could be mal-processed in some shells.
>>> For example, MsysGit trims CR before executing a shell
>>> script file in order to make it work right on Windows
>>> even if it uses CRLF as linefeeds.
>>>
>>> Signed-off-by: Danny Lin <danny0838@gmail.com>
>>> ---
>>
>> Thanks, this looks good.  Will apply with a little bit of tweak in
>> the log message.
>
> Hmm, I would say that the changes to debug() and say() should either
> be dropped or moved to a separate patch (along with the first
> paragraph of the commit message). With the introduction of the
> progress() abstraction, there is no longer any need for changes to
> say(), and the "better portability" rationale for changing say() and
> debug() is never properly explained, and is thus nebulous at best.

I justified them in this way.

    contrib/subtree: portability fix for string printing
    
    'echo -n' is not portable, but this script used it as a way to give
    a string followed by a carriage return for progress messages.
    Introduce a new helper shell function "progress" and use printf as a
    more portable way to do this.  As a side effect, this makes it
    unnecessary to have a raw CR in our source, which can be munged in
    some shells.  For example, MsysGit trims CR before executing a shell
    script file in order to make it work right on Windows even if it
    uses CRLF as linefeeds.
    
    While at it, replace "echo" using printf in debug() and say() to
    avoid tempting people introducing the same bug.
    
    Signed-off-by: Danny Lin <danny0838@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
