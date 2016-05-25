From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC-PATCH 1/2] send-email: new option to quote an email and reply to
Date: Wed, 25 May 2016 20:31:00 +0200
Message-ID: <vpq8tyyt2fv.fsf@anie.imag.fr>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
	<1464031829-6107-2-git-send-email-tom.russello@grenoble-inp.org>
	<vpq60u4bl4e.fsf@anie.imag.fr>
	<b1752a59-af2b-6e18-fc69-0650440939e3@grenoble-inp.org>
	<vpqh9dmfy5k.fsf@anie.imag.fr>
	<xmqqwpmi16zt.fsf@gitster.mtv.corp.google.com>
	<vpqeg8q5b6f.fsf@anie.imag.fr>
	<xmqqr3cqypg6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Samuel GROOT <samuel.groot@grenoble-inp.org>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@ensimag.grenoble-inp.fr,
	Tom Russello <tom.russello@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 20:31:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5daQ-0001Qr-0M
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 20:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbcEYSbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 14:31:12 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37502 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742AbcEYSbK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 14:31:10 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4PIUwYq031058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 25 May 2016 20:30:58 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4PIV014026000;
	Wed, 25 May 2016 20:31:00 +0200
In-Reply-To: <xmqqr3cqypg6.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 25 May 2016 11:15:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Wed, 25 May 2016 20:30:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4PIUwYq031058
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464805860.70411@mX4unWtb8aV8198UkgOH4A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295585>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> This should work, but sounds like too much of overloading of
>> --in-reply-to IMHO: if given a message id, it would only add a reference
>> to this message-id, but if given a file, it would also modify the To:
>> and Cc: list.
>>
>> Not a strong objection, though.
>
> Well, with your "that is the plan indeed", the option would behave
> the same whether given a message ID or a filename, no?

The "fetch message from ID" feature should not be unconditional IMHO. So
it would probably be stg like:

  git send-email --in-reply-to=<id> --fetch

What's a bit counter-intuitive is that --fetch would not only trigger
fetching the complete message, but also populate To/Cc. But thinking
about it, it's not _that_ counter-intuitive, as fetching the message
should be done for a reason, so the user can guess that the message is
going to be used for something.

So, a possible UI would be:

  git send-email --in-reply-to=<id> => just set In-Reply-To: field.

  git send-email --in-reply-to=<file> => set In-Reply-To, To and Cc.

  git send-email --in-reply-to=<file> --cite => in addition, add the
    body of the message quoted with '> '.

  git send-email --in-reply-to=<id> --fetch => fetch and do like <file>
    using the default configuration for fetch.

This leaves room for:

  git send-email --in-reply-to=<id> --fetch=gmane => fetch from gmane
    (details on how to fetch would be in the config file)

This UI wouldn't allow using a file to get only the message-id. But I'm
not sure this is an interesting use-case.

So, I guess you convinced me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
