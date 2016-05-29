From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [WIP-PATCH 0/2] send-email: refactor the email parser loop
Date: Sun, 29 May 2016 20:05:52 +0200
Message-ID: <vpq8tyshh8f.fsf@anie.imag.fr>
References: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
	<20160527201436.GA16547@dcvr.yhbt.net> <vpq8tyujkb0.fsf@anie.imag.fr>
	<7423b133-cec4-e633-f1ef-70ccc6a6cc02@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <e@80x24.org>, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	gitster@pobox.com, aaron@schrab.com
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Sun May 29 20:06:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b756O-0002wf-1j
	for gcvg-git-2@plane.gmane.org; Sun, 29 May 2016 20:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbcE2SGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2016 14:06:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42539 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932360AbcE2SGK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2016 14:06:10 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4TI5ofa029339
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 29 May 2016 20:05:50 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4TI5qlp017545;
	Sun, 29 May 2016 20:05:52 +0200
In-Reply-To: <7423b133-cec4-e633-f1ef-70ccc6a6cc02@grenoble-inp.org> (Samuel
	GROOT's message of "Sun, 29 May 2016 19:21:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Sun, 29 May 2016 20:05:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4TI5ofa029339
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465149953.55172@ds3Q8kwPshSU4YtXWCWULw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295841>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> Should we take what Eric suggested (see below) as standard output?
>
>> Since the headers are already shown after those lines, it's
>> redundant to have the entire line.  And we could add
>> trailers after the headers (with a blank line to delimit):
>>
>>     # existing header output:
>>     From: F <F@example.com>
>>     Cc: A <author@example.com>, One <one@example.com>
>>     Subject: foo
>>
>>     # new trailer output
>>     Signed-off-by: SoB <SoB@example.com>
>>     Acked-by: ack <ack@example.com>

I don't think adding the trailers in the output is needed. If the
message says

  Adding foo@example from Signed-off-by trailer

I can guess that it's from "Signed-off-by: foo@example" without having
it explicitly.

Perhaps others think differently, but for me, the shortest output would
be the better (if only to solve the "I never see these lines, they
scrolled out of my terminal" issue).

Ideally, I'd even like to shorten the current output a bit more (the
X-Mailer: header is useless IMHO, and the Date: and Message-id: headers
are probably not useful enough to be shown by default).

(Just thinking aloud, obviously none of this should be a prerequisite to
accept your refactoring patch)

> And keep "(mbox) Adding ..." lines as error output, or maybe
> displayable by a new option `--verbose`?

I think the "Adding ..." lines make sense by default at least for
beginners (just a few days ago, I received a bunch of test emails by
your team follow by a "Oops, I just noticed you got Cc-ed in my tests"
message ;-), that would probably have been worse without the message).
There could be an advice.* option to deactivate them, though.

The (mbox) prefix doesn't seem useful to me OTOH, I think it's a
leftover debugging message.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
