From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC-PATCH 1/2] send-email: new option to quote an email and reply to
Date: Wed, 25 May 2016 18:56:08 +0200
Message-ID: <vpqeg8q5b6f.fsf@anie.imag.fr>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
	<1464031829-6107-2-git-send-email-tom.russello@grenoble-inp.org>
	<vpq60u4bl4e.fsf@anie.imag.fr>
	<b1752a59-af2b-6e18-fc69-0650440939e3@grenoble-inp.org>
	<vpqh9dmfy5k.fsf@anie.imag.fr>
	<xmqqwpmi16zt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Samuel GROOT <samuel.groot@grenoble-inp.org>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@ensimag.grenoble-inp.fr,
	Tom Russello <tom.russello@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 18:56:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5c6Z-0000RL-L5
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 18:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755792AbcEYQ4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 12:56:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34048 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755491AbcEYQ4T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 12:56:19 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4PGu69q004609
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 25 May 2016 18:56:06 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4PGu8r2024675;
	Wed, 25 May 2016 18:56:08 +0200
In-Reply-To: <xmqqwpmi16zt.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 25 May 2016 08:40:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Wed, 25 May 2016 18:56:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4PGu69q004609
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464800170.60309@lbA6zNyvv5BKNo2qOZJtXQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295581>

Junio C Hamano <gitster@pobox.com> writes:

> I wonder if we can safely repurpose existing --in-reply-to option?

In theory, obviously no as there can be a file with this name _and_ it
can be a valid message-id. In practice, it is clearly unlikely. The only
use-case I can think of where both would be valid is if the user happens
to have saved the message using the message-id as filename. But then,
the ambiguity would not harm, as the message-id contained in the file
would be the same as the filename.

> That is, if the value of --in-reply-to can be reliably determined as
> a filename that has the message (as opposed to a message-id), we
> read the "Message-Id:" from that file to figuire out what message-id
> to use, and figure out To/Cc: to use for the purpose of your (1) at
> the same time.

This should work, but sounds like too much of overloading of
--in-reply-to IMHO: if given a message id, it would only add a reference
to this message-id, but if given a file, it would also modify the To:
and Cc: list.

Not a strong objection, though.

> In the future, you might even teach send-email, perhaps via a user
> configurable hook, a way to get to the message header and text given a
> message-id, and when it happens, the same logic can be used when
> --in-reply-to is given a message-id (i.e. you go from the id to the
> message and find the addresses you would To/Cc: your message).

That is the plan indeed. Fetching from gmane for example should be
rather easy in perl, and would be really convenient!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
