From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v9 5/5] bisect: allow any terms set by user
Date: Fri, 26 Jun 2015 22:18:27 +0200
Message-ID: <vpqvbeaql4c.fsf@anie.imag.fr>
References: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435258257-29047-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435258257-29047-6-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqk2urwjmq.fsf@gitster.dls.corp.google.com>
	<xmqqfv5fwib3.fsf@gitster.dls.corp.google.com>
	<vpqegkyyj7z.fsf@anie.imag.fr>
	<xmqqtwtuv2jr.fsf@gitster.dls.corp.google.com>
	<vpq8ub6s8hc.fsf@anie.imag.fr>
	<xmqq1tgyuyuy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 22:19:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8a5d-0006df-NH
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 22:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbbFZUTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 16:19:05 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58046 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954AbbFZUTD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 16:19:03 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5QKIOsY019637
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 26 Jun 2015 22:18:25 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5QKIRee015807;
	Fri, 26 Jun 2015 22:18:27 +0200
In-Reply-To: <xmqq1tgyuyuy.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 26 Jun 2015 11:08:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 26 Jun 2015 22:18:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5QKIOsY019637
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435954705.46855@JRWTKcHMPkuHFyrRPCwNnA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272818>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> And indeed "git bisect terms foo bar" errors out. I think the reason it
>> is this way is to allow
>>
>> $ git bisect terms foo bar
>> $ git bisect start <sha1> <sha1>
>>
>> But actually, we can allow "git bisect terms" until BISECT_TERMS is
>> created, which is your intuition and makes more sense IMHO. I'll try to
>> do that.
>
> I am not sure if it is a good idea, though.  Matching the intuition
> of those who (think they) know how it is implemented is much less
> important than providing a behaviour that is simple to explain to
> casual users.

I thought about it a bit more. Essentially, we have two options simple
to implement:

1) Allow `git bisect terms` when BISECT_TERMS does not exists. This
   prevents running `git bisect terms` twice in a row, but would match
   your first guess: we could still run it until the terms are commited.
 
   Pro: it feels more natural to me to write
 
   git bisect start
   git bisect terms foo bar
   ...
   git bisect reset
 
   => everything happens between start and reset.

2) Allow `git bisect terms` when BISECT_START does not exist (the current
   implementation).

I'm keeping option 2) for now, but if anyone think option 1) is better,
it shouldn't be hard to change.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
