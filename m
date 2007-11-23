From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't add To: recipients to the Cc: header
Date: Fri, 23 Nov 2007 11:48:48 -0800
Message-ID: <7vejegu4in.fsf@gitster.siamese.dyndns.org>
References: <1195470026-7389-1-git-send-email-ask@develooper.com>
	<7vr6ill5f1.fsf@gitster.siamese.dyndns.org>
	<7A3DDFA5-085D-4D92-BE96-A405FF1FB029@develooper.com>
	<7v8x4slovk.fsf@gitster.siamese.dyndns.org>
	<87ejekzpx3.fsf@osv.gnss.ru>
	<7vr6ikk6rf.fsf@gitster.siamese.dyndns.org>
	<87lk8orgpm.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ask =?utf-8?Q?Bj=C3=B8rn?= Hansen <ask@develooper.com>,
	git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 20:49:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IveWa-0000To-5z
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 20:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267AbXKWTs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 14:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755767AbXKWTs5
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 14:48:57 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:53700 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093AbXKWTs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 14:48:57 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id EAC40325;
	Fri, 23 Nov 2007 14:49:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6484998F14;
	Fri, 23 Nov 2007 14:49:14 -0500 (EST)
In-Reply-To: <87lk8orgpm.fsf@osv.gnss.ru> (Sergei Organov's message of "Fri,
	23 Nov 2007 20:53:41 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65919>

Sergei Organov <osv@javad.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergei Organov <osv@javad.com> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>> [...]
>>>> Oops, forgot to say "no need to resend".  I asked only because I
>>>> wanted an independent datapoint for Emacs diff mode breakage.
>>>
>>> I bet I can damage any patch using any editor ;)
>>>
>>> More interesting is what version of Emacs it was?
>>
>> To be fair and honest, I do not think there is a simple fix for
>> this, although it probably is possible to fix it.
>>
>> What is causing the "breakage" is the fact that format-patch
>> output ends with the signature delimiter line "^-- $" that
>> immediately follows the patch text.
>
> Exactly. What causes breakage is the fact that the '-' character (as
> well as '+', ' ', '!', '#', and '\'), being the first symbol of a line
> has special meaning in the diff format.

That is correct only if they appear inside a hunk.  The number
of preimage and postimage lines in a hunk is recorded on the
hunk header line --- tools are given enough information to tell
a line that begins with a SP (or '+' or '-') outside a patch
from another such line that is inside the patch.

The diff editing mode of Emacs, at least the version that caused
this issue, however did not make use of that information.
That's the breakage.  Not format-patch output.
