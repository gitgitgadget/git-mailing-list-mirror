From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in git-verify-pack or in its documentation?
Date: Thu, 19 Mar 2015 10:59:32 -0700
Message-ID: <xmqq7fuckgvv.fsf@gitster.dls.corp.google.com>
References: <20150316080558.GA30234@glandium.org>
	<CACsJy8AXvYCje0-smbNdfGtjsdYieKyxxiHCGf32Jpi3seDrvA@mail.gmail.com>
	<20150316131808.GA19353@glandium.org>
	<CACsJy8B=S9ajzj9N-JoCou6_FVj9VgCHEkZ2AiQ=zR=aCLKXuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mike Hommey <mh@glandium.org>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 18:59:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYejM-0006P1-56
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 18:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757029AbbCSR7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 13:59:36 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54270 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757005AbbCSR7f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 13:59:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 98EB8403BC;
	Thu, 19 Mar 2015 13:59:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z7yHkoAGQZ5nNTS8Cjdz/zUJTb8=; b=Tsvvic
	CxmmR9o63XI8QobA7ZFRonLkhZN/kUN9HDt9SJalpWNDYCnJGH3pqsZJH7vsiMIQ
	aHbNtXjvTBjEeK4ZksPD3stdTh6xjFQazN65hFV6TEG5xL0+71DjkiH9a1aIawWS
	81CTzOECSxNYIwynQcsYlESCrhyDsslWs5/UI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uSjECWwFkLm7GMsXZWdVgMOo5zh2yquK
	uw3S2wXvNlldN2RdLDBBo7R/WujK+ftRycPYFsqd7V+yAr8Lzm4/EeacO1z1ZTE1
	duOVMPyr6a38RgFBm4x7WZXbNpwqa6fTjjnIKapuUR2PqYrdXNfHpkg7RiFVkChS
	uxhPCs8wKgU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91216403B9;
	Thu, 19 Mar 2015 13:59:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 177BE403B8;
	Thu, 19 Mar 2015 13:59:34 -0400 (EDT)
In-Reply-To: <CACsJy8B=S9ajzj9N-JoCou6_FVj9VgCHEkZ2AiQ=zR=aCLKXuw@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 18 Mar 2015 19:31:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B32BD148-CE61-11E4-97F9-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265814>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Mar 16, 2015 at 8:18 PM, Mike Hommey <mh@glandium.org> wrote:
>> On Mon, Mar 16, 2015 at 05:13:25PM +0700, Duy Nguyen wrote:
>>> On Mon, Mar 16, 2015 at 3:05 PM, Mike Hommey <mh@glandium.org> wrote:
>>> > Hi,
>>> >
>>> > git-verify-pack's man page says the following about --stat-only:
>>> >
>>> >    Do not verify the pack contents; only show the histogram of delta
>>> >    chain length. With --verbose, list of objects is also shown.
>>> >
>>> > However, there is no difference of output between --verbose and
>>> > --verbose --stat-only (and in fact, looking at the code, only one of
>>> > them has an effect, --stat-only having precedence).
>>>
>>> There is. very-pack --verbose would show a lot of "<sha-1> <type>
>>> <"random" numbers>" lines before the histogram while --stat-only (with
>>> or without --verbose) would only show the histogram.
>>
>> Err, I meant between --stat-only and --verbose --stat-only.
>
> Yeah --verbose is always ignored when --stat-only is set. This command is funny.

I would disagree.  "--verbose" is "do whatever you are told to do
but you can enhance the result by giving more verbose output".

To understand what I mean, compare "git verify-pack" (no other
options) and "git verify-pack --verbose".

Now, when you are asking the command to show the statistics only and
nothing else, there may be nothing useful that you can output to
enhance the "stat-only" output.  "git verify-pack --stat-only" (no
other options) and "git verify-pack --stat-only --verbose" can
produce exactly the same result in such a case.

So I do not see anything funny there.
