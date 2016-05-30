From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [WIP-PATCH 0/2] send-email: refactor the email parser loop
Date: Mon, 30 May 2016 16:01:29 +0200
Message-ID: <0abbc11b-5741-ee2e-292c-245c2b974f8e@grenoble-inp.org>
References: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
 <20160527201436.GA16547@dcvr.yhbt.net> <vpq8tyujkb0.fsf@anie.imag.fr>
 <7423b133-cec4-e633-f1ef-70ccc6a6cc02@grenoble-inp.org>
 <vpq8tyshh8f.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <e@80x24.org>, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	gitster@pobox.com, aaron@schrab.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 30 16:01:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7NlB-0002Dq-1D
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 16:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbcE3OBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 10:01:32 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:34559 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783AbcE3OBc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 10:01:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 7AAF320AD;
	Mon, 30 May 2016 16:01:28 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vooMSoO-pw9j; Mon, 30 May 2016 16:01:28 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 61D8820AA;
	Mon, 30 May 2016 16:01:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 5B7152077;
	Mon, 30 May 2016 16:01:28 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lirckgd-LXq6; Mon, 30 May 2016 16:01:28 +0200 (CEST)
Received: from wificampus-028107.grenet.fr (wificampus-028107.grenet.fr [130.190.28.107])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 3E6E42066;
	Mon, 30 May 2016 16:01:28 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
In-Reply-To: <vpq8tyshh8f.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295896>

On 05/29/2016 08:05 PM, Matthieu Moy wrote:
> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>
>> Should we take what Eric suggested (see below) as standard output?
>>
>>> Since the headers are already shown after those lines, it's
>>> redundant to have the entire line.  And we could add
>>> trailers after the headers (with a blank line to delimit):
>>>
>>>     # existing header output:
>>>     From: F <F@example.com>
>>>     Cc: A <author@example.com>, One <one@example.com>
>>>     Subject: foo
>>>
>>>     # new trailer output
>>>     Signed-off-by: SoB <SoB@example.com>
>>>     Acked-by: ack <ack@example.com>
>
> I don't think adding the trailers in the output is needed. If the
> message says
>
>   Adding foo@example from Signed-off-by trailer
>
> I can guess that it's from "Signed-off-by: foo@example" without having
> it explicitly.
>
> Perhaps others think differently, but for me, the shortest output would
> be the better (if only to solve the "I never see these lines, they
> scrolled out of my terminal" issue).

I agree, the shorter the better.

> Ideally, I'd even like to shorten the current output a bit more (the
> X-Mailer: header is useless IMHO, and the Date: and Message-id: headers
> are probably not useful enough to be shown by default).

Agreed.

> (Just thinking aloud, obviously none of this should be a prerequisite to
> accept your refactoring patch)
>
>> And keep "(mbox) Adding ..." lines as error output, or maybe
>> displayable by a new option `--verbose`?
>
> I think the "Adding ..." lines make sense by default at least for
> beginners (just a few days ago, I received a bunch of test emails by
> your team follow by a "Oops, I just noticed you got Cc-ed in my tests"
> message ;-), that would probably have been worse without the message).
> There could be an advice.* option to deactivate them, though.

An advice.* option seems a good solution to me.

> The (mbox) prefix doesn't seem useful to me OTOH, I think it's a
> leftover debugging message.

(mbox) prefix was introduced by Ryan Anderson in 2005 (can't find the 
exact commit though), in opposition with the (non-mbox) format ("lots of 
email") that was used before.

Is the "lots of email" format still used?

When adding Cc: from a Signed-off-by: field, (body) prefix is used.
