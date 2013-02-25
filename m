From: Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH] diff: Fix rename pretty-print when suffix and prefix
 overlap
Date: Mon, 25 Feb 2013 22:36:55 +0000
Message-ID: <512BE787.1090901@iee.org>
References: <1361638125-11245-1-git-send-email-apelisse@gmail.com> <7vzjyu3we1.fsf@alter.siamese.dyndns.org> <CALWbr2yviqF68zF7mBbhaXW7oFar0YRqROBWXwqjo7UNgZNVBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 23:37:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA6fl-0002zA-J2
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 23:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759546Ab3BYWhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 17:37:00 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:38160 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758924Ab3BYWg7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2013 17:36:59 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApQBACXRK1FZ8rke/2dsb2JhbAANOIZPuwqBHIMSAQEBAQIBIxVAARALDgoCAgUWCwICCQMCAQIBDzYGDQEFAgEBh30DCaxdcYhcDYlXgSOLFIJXB2OBSoETA5RgjSuIEQ0
X-IronPort-AV: E=Sophos;i="4.84,736,1355097600"; 
   d="scan'208";a="419771625"
Received: from host-89-242-185-30.as13285.net (HELO [192.168.0.7]) ([89.242.185.30])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 25 Feb 2013 22:36:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <CALWbr2yviqF68zF7mBbhaXW7oFar0YRqROBWXwqjo7UNgZNVBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217115>

On 25/02/13 19:50, Antoine Pelisse wrote:
> On Sun, Feb 24, 2013 at 10:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Antoine Pelisse <apelisse@gmail.com> writes:
>>
>>> When considering a rename for two files that have a suffix and a prefix
>>> that can overlap, a confusing line is shown. As an example, renaming
>>> "a/b/b/c" to "a/b/c" shows "a/b/{ => }/b/c".
>>
>> This would be vastly more readable if it had "It should show XXX
>> instead" somewhere in the description, perhaps at the end of this
>> sentence.  It can also be after "thus the { => }" below, but I think
>> giving the expected output earlier would be more appropriate.
>
> Good catch, this would probably be better:
>
>      When considering a rename for two files that have a suffix and a prefix
>      that can overlap, a confusing line is shown. As an example, renaming
>      "a/b/b/c" to "a/b/c" shows "a/b/{ => }/b/c", instead of "a/b/{ => b}/c"
>
>>> Currently, what we do is calculate the common prefix ("a/b/"), and the
>>> common suffix ("/b/c"), but the same "/b/" is actually counted both in
>>> prefix and suffix. Then when calculating the size of the non-common part,
>>> we end-up with a negative value which is reset to 0, thus the "{ => }".
>>
>> In this example, the common prefix would be "a/b/" and the common
>> suffix that does not overlap with the prefix part would be "/c", so
>> I am imagining that "a/b/{ => b}/c" would be the desired output?
>
> Yes, at least that's what I expected.

Surely it would be "a/b/{b => }/c", that is, we have reduced the number 
of b's by one. Or am I misunderstanding something?
(I'm guessing it was an all too obvious typo that was misread)

>
>> This is a really old thinko (dating back to June 2005).  I'll queue
>> the patch on maint-1.7.6 (because 1.7.6.6 is slightly more than one
>> year old while 1.7.5.4 is a lot older) to allow distros that issue
>> incremental fixes on top of ancient versions of Git to pick up the
>> fix if they wanted to.  Perhaps we would want to add a few tests?
>
> I can easily understand why that was missed.
> I will try to resubmit with tests very soon.
Philip
