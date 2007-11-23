From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't add To: recipients to the Cc: header
Date: Fri, 23 Nov 2007 15:54:56 -0800
Message-ID: <7vejegsejz.fsf@gitster.siamese.dyndns.org>
References: <1195470026-7389-1-git-send-email-ask@develooper.com>
	<7vr6ill5f1.fsf@gitster.siamese.dyndns.org>
	<7A3DDFA5-085D-4D92-BE96-A405FF1FB029@develooper.com>
	<7v8x4slovk.fsf@gitster.siamese.dyndns.org>
	<87ejekzpx3.fsf@osv.gnss.ru>
	<7vr6ikk6rf.fsf@gitster.siamese.dyndns.org>
	<87lk8orgpm.fsf@osv.gnss.ru>
	<7vejegu4in.fsf@gitster.siamese.dyndns.org>
	<87hcjcra10.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ask =?utf-8?Q?Bj=C3=B8rn?= Hansen <ask@develooper.com>,
	git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Sat Nov 24 00:55:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IviMl-0008BC-QH
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 00:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbXKWXzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 18:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752299AbXKWXzF
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 18:55:05 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55980 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbXKWXzD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 18:55:03 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 784532EF;
	Fri, 23 Nov 2007 18:55:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id DA7DB990A9;
	Fri, 23 Nov 2007 18:55:19 -0500 (EST)
In-Reply-To: <87hcjcra10.fsf@osv.gnss.ru> (Sergei Organov's message of "Fri,
	23 Nov 2007 23:18:03 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65933>

Sergei Organov <osv@javad.com> writes:

> Yeah, it's one valid interpretation. Here is another one:
> ...
> taken from here: <http://www.answers.com/topic/diff?cat=technology>

Rants about how dangerous GNU patch liberally (mis)interprets a
broken patch and git-apply is written deliberately more strict
have been repeated on this list, and I would not steal it from
Linus in this response.

>> The diff editing mode of Emacs, at least the version that caused
>> this issue, however did not make use of that information.
>
> IMHO it's rather useless to argue about it without strict definition of
> correct format of a patch (do you have one?)

Yes.  2004 POSIX does not talk about unified context, but Austin
group's SD5-XCU-ERN-103/120 has additions to define unified
context and renames the traditional '-c' output to "copied
context".  Obviously it defines what the numbers on the hunk
header lines mean quite precisely.  GNU folks even managed to
insert text that allows a completely empty line (not a line with
a single SP on it) to express a context line that is empty,
which means...

> However, it's easy to add
> an empty line for format-patch and very difficult, if not impossible,
> for Emacs to handle this without such a line.
>
> Therefore I repeat my question: are there any objections to add such an
> empty line by format-patch?

... there is a strong objection, if you are talking about adding
an empty line before "-- \n" that is in front of the GIT version
signature: such an empty line would not help at all.  A broken
implementation will just skip over such an empty line, counting
it as a line common to both preimage and postimage, and will
still miscount the e-mail signature separator "-- \n" as a line
removed from the preimage.

Having said that, the _ONLY_ reason I made format-patch end its
output with "-- \n" with GIT version was because I wanted to do
an informal census of the user community by observing mailing
list traffic of projects that use git.  The tool has since
matured, and census in such a form is not so important anymore.

If we wanted to have a workaround to this issue, we could simply
remove these last two lines, and that would a be much better one
than an extra blank line.  I do not have a strong objection to
such a change, but you would need to adjust the tests.  The most
depressing part of the whole exercise would be to make sure that
the adjustments to the tests are correct.
