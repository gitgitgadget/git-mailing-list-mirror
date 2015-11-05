From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] run-command: Remove set_nonblocking
Date: Thu, 05 Nov 2015 11:37:00 -0800
Message-ID: <xmqqio5g5jc3.fsf@gitster.mtv.corp.google.com>
References: <1446747439-30349-1-git-send-email-sbeller@google.com>
	<1446747439-30349-2-git-send-email-sbeller@google.com>
	<xmqqpozo5lqg.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZgEtKoYqxa8+wj0PCJedW140CQAPX6XwEYib1W3fPhXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 20:37:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuQLV-0003NX-33
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 20:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbbKEThI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 14:37:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60687 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751509AbbKEThE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 14:37:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 995B8286BC;
	Thu,  5 Nov 2015 14:37:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rUU6dZcDZu6zADjVqCBWfgQveLw=; b=lRrNJE
	Mvl/e41U5l75qE4NT/LGyaVe796OOwl4hUi+ICz2BDAwdpV9Wygw3/ogNsHdKsn7
	S3FSHHMdaTwvOCkCHfCdRd5Ait/RFT56BaIxxlifJ8oj3A/MRfliV1RyqFnVRj7k
	dQrLDhf6+KLA8feLOQ9sdv7UDyLbImVJACtUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=npNpp8CEYG+tvhaM6rG/4JoMoZjHXajd
	5EgiExK8XBiGeJPsEOuDfVLPZOLhlPlumKVAMQXTcbb+tzbkFiIsBtUhRU6udAle
	DHJ3CZb6teorCN/6iwpFQScFKfOtu+FLWP2xyjnFBoWNDhD4IBZ4jFYWcvfoIt9G
	TVQlMaVklR8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 90ED3286BB;
	Thu,  5 Nov 2015 14:37:02 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ED10D286B9;
	Thu,  5 Nov 2015 14:37:01 -0500 (EST)
In-Reply-To: <CAGZ79kZgEtKoYqxa8+wj0PCJedW140CQAPX6XwEYib1W3fPhXw@mail.gmail.com>
	(Stefan Beller's message of "Thu, 5 Nov 2015 11:22:29 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 963F84BE-83F4-11E5-830B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280936>

Stefan Beller <sbeller@google.com> writes:

> On Thu, Nov 5, 2015 at 10:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> strbuf_read_once can also operate on blocking file descriptors if we are
>>> sure they are ready. The poll (2) command however makes sure this is the
>>> case.
>>>
>>> Reading the manual for poll (2), there may be spurious returns indicating
>>> readiness but that is for network sockets only. Pipes should be unaffected.
>>
>> Given the presence of "for example" in that bug section, I wouldn't
>> say "only" or "should be unaffected".
>
> Reading the documentation we are in agreement, that we expect
> no spurious returns, no?

Given the presence of "for example" in that bug section, I wouldn't
say "only" or "should be unaffected".  I cannot say "we expect no
spurious returns".

>> Thanks.  Let's apply these fixes on sb/submodule-parallel-fetch,
>> merge the result to 'next' and have people play with it.
>
> Maybe the commit message was weakly crafted. Do you want me to resend?

I somehow feel that it is prudent to let this cook just above 'next'
for a few days (not just for the log message but to verify the
strategy and wait for others to come up with even better ideas), but
then I'll be offline starting next week, so I expect that merging
the final version to 'next' will be done by our interim maintainer,
which means we still have time to polish ;-)

Here is what I queued for now.

-- >8 --
From: Stefan Beller <sbeller@google.com>
Date: Thu, 5 Nov 2015 10:17:18 -0800
Subject: [PATCH] run-command: remove set_nonblocking()

strbuf_read_once can also operate on blocking file descriptors if we
are sure they are ready.  And the poll(2) we call before calling
this ensures that this is the case.

Reading the manual for poll(2), there may be spurious returns
indicating readiness but that is for network sockets only and pipes
should be unaffected.

With this change, we rely on

 - poll(2) returns only non-empty pipes; and
 - read(2) on a non-empty pipe does not block.

This should fix compilation on Windows.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 run-command.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/run-command.c b/run-command.c
index 1fbd286..07424e9 100644
--- a/run-command.c
+++ b/run-command.c
@@ -996,17 +996,6 @@ static void pp_cleanup(struct parallel_processes *pp)
 	sigchain_pop_common();
 }
 
-static void set_nonblocking(int fd)
-{
-	int flags = fcntl(fd, F_GETFL);
-	if (flags < 0)
-		warning("Could not get file status flags, "
-			"output will be degraded");
-	else if (fcntl(fd, F_SETFL, flags | O_NONBLOCK))
-		warning("Could not set file status flags, "
-			"output will be degraded");
-}
-
 /* returns
  *  0 if a new task was started.
  *  1 if no new jobs was started (get_next_task ran out of work, non critical
@@ -1042,8 +1031,6 @@ static int pp_start_one(struct parallel_processes *pp)
 		return code ? -1 : 1;
 	}
 
-	set_nonblocking(pp->children[i].process.err);
-
 	pp->nr_processes++;
 	pp->children[i].in_use = 1;
 	pp->pfd[i].fd = pp->children[i].process.err;
-- 
2.6.2-539-g1c5cd50
