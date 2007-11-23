From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH] Don't add To: recipients to the Cc: header
Date: Fri, 23 Nov 2007 23:18:03 +0300
Message-ID: <87hcjcra10.fsf@osv.gnss.ru>
References: <1195470026-7389-1-git-send-email-ask@develooper.com>
	<7vr6ill5f1.fsf@gitster.siamese.dyndns.org>
	<7A3DDFA5-085D-4D92-BE96-A405FF1FB029@develooper.com>
	<7v8x4slovk.fsf@gitster.siamese.dyndns.org>
	<87ejekzpx3.fsf@osv.gnss.ru>
	<7vr6ikk6rf.fsf@gitster.siamese.dyndns.org>
	<87lk8orgpm.fsf@osv.gnss.ru>
	<7vejegu4in.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ask =?utf-8?Q?Bj=C3=B8rn?= Hansen <ask@develooper.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 21:18:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvezD-0002TT-PL
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 21:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757348AbXKWUSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 15:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757347AbXKWUSd
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 15:18:33 -0500
Received: from javad.com ([216.122.176.236]:2638 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757337AbXKWUSc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 15:18:32 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lANKI9H73345;
	Fri, 23 Nov 2007 20:18:10 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1IveyR-0005L0-HI; Fri, 23 Nov 2007 23:18:03 +0300
In-Reply-To: <7vejegu4in.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 23 Nov 2007 11\:48\:48 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65922>

Junio C Hamano <gitster@pobox.com> writes:

> Sergei Organov <osv@javad.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Sergei Organov <osv@javad.com> writes:
>>>
>>>> Junio C Hamano <gitster@pobox.com> writes:
>>>> [...]
>>>>> Oops, forgot to say "no need to resend".  I asked only because I
>>>>> wanted an independent datapoint for Emacs diff mode breakage.
>>>>
>>>> I bet I can damage any patch using any editor ;)
>>>>
>>>> More interesting is what version of Emacs it was?
>>>
>>> To be fair and honest, I do not think there is a simple fix for
>>> this, although it probably is possible to fix it.
>>>
>>> What is causing the "breakage" is the fact that format-patch
>>> output ends with the signature delimiter line "^-- $" that
>>> immediately follows the patch text.
>>
>> Exactly. What causes breakage is the fact that the '-' character (as
>> well as '+', ' ', '!', '#', and '\'), being the first symbol of a line
>> has special meaning in the diff format.
>
> That is correct only if they appear inside a hunk.  The number
> of preimage and postimage lines in a hunk is recorded on the
> hunk header line --- tools are given enough information to tell
> a line that begins with a SP (or '+' or '-') outside a patch
> from another such line that is inside the patch.

Yeah, it's one valid interpretation. Here is another one:

  "The chunk range for the original should be the sum of all contextual
  and deletion (including changed) chunk lines. The chunk range for the
  new file should be a sum of all contextual and addition (including
  changed) chunk lines. If chunk size information does not correspond
  with the number of lines in the hunk, then the diff could be
  considered invalid and be rejected."

taken from here: <http://www.answers.com/topic/diff?cat=technology>

The above implies that a tool should be able to determine the "end of
hunk" without using the hunk header information. This is rather hard to
do with current format-patch output, and it's impossible to do if there
are no "unchanged context" lines at all (i.e., format-patch -U0).

> The diff editing mode of Emacs, at least the version that caused
> this issue, however did not make use of that information.
> That's the breakage.  Not format-patch output.

IMHO it's rather useless to argue about it without strict definition of
correct format of a patch (do you have one?). However, it's easy to add
an empty line for format-patch and very difficult, if not impossible,
for Emacs to handle this without such a line.

Therefore I repeat my question: are there any objections to add such an
empty line by format-patch?

-- 
Sergei.
