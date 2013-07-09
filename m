From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH/RFC] blame: accept multiple -L ranges
Date: Tue, 9 Jul 2013 21:12:28 +0200
Message-ID: <87a9lvcztv.fsf@hexa.v.cablecom.net>
References: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com>
	<7vk3l26695.fsf@alter.siamese.dyndns.org>
	<CAPig+cQ9sfV+PRqn5vrL0=xOZrKDDmsKdAPiB4PsCFb=jnk4kQ@mail.gmail.com>
	<7v38rnwuvb.fsf@alter.siamese.dyndns.org>
	<87ehb7d3za.fsf@hexa.v.cablecom.net>
	<CAPig+cT9U7L-03Fe5YLft=WS2EZY1B_BhLzkM_sT_3wQQ1g1MQ@mail.gmail.com>
	<7vy59fv9zr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 21:12:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwdL1-0001to-Og
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 21:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196Ab3GITMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 15:12:31 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:39180 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942Ab3GITMb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 15:12:31 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 9 Jul
 2013 21:12:27 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 9 Jul
 2013 21:12:28 +0200
In-Reply-To: <7vy59fv9zr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 09 Jul 2013 11:55:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229981>

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Tue, Jul 9, 2013 at 1:42 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>>  (2) In the ranges "-L <anything>,/B/ -L /C/,<anything>", the
>>>>      beginning of the second range is found by choosing C that comes
>>>>      _after_ the end of the previous range (/B/ may choose either
>>>>      the second or the 4th line, and the only C that comes after
>>>>      either of them is the 5th line and that is where the second
>>>>      range should begin, not at the beginning of the file).  The
>>>>      same for "-L 1,3 -L /C/" (only C that comes after 3 is eligible
>>>>      to be the beginning of the second range).
>>>
>>> So passing several -L arguments does not blame the union of what each
>>> argument would blame individually?  Doesn't that make it rather harder
>>> to explain?
>>
>> I don't think Junio meant to imply that. Collecting the blame ranges
>> can/should be a distinct step from coalescing them. Junio is saying
>> that an -L /re/ range search should start after the maximum line
>> number already specified by any preceding range.
>
> I am not sure if I want "maximum specified so far". I meant "start
> searching at the last location", e.g.
>
> 	-L 100,200 -L 4,6 -L /A/,+20
>
> would want to find the first A after line 6, not after line 200.

Ok, so my point (in new words, since the old one was apparently too
terse) is:

If you define it that way, the output of

  git blame -L 4,6; git blame -L /A/,+20

is significantly different from

  git blame -L 4,6 -L /A/,+20

Not just in the presentation or any possible coalescing, but in the
meaning of the ranges.

Do you really want to make it that way?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
