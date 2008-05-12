From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make the exit code of add_file_to_index actually useful
Date: Mon, 12 May 2008 15:19:42 -0700
Message-ID: <7viqxjxj0h.fsf@gitster.siamese.dyndns.org>
References: <47C95E34.1050306@dirk.my1.cc> <20080302154154.GC2973@steel.home>
 <20080302154238.GD2973@steel.home>
 <alpine.LSU.1.00.0803021555500.22527@racer.site>
 <7vtzjpoye6.fsf@gitster.siamese.dyndns.org>
 <20080512175654.GB3128@steel.home>
 <7vzlqvxt1p.fsf@gitster.siamese.dyndns.org>
 <20080512205414.GH3128@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dirk =?utf-8?Q?S?= =?utf-8?Q?=C3=BCsserott?= 
	<newsletter@dirk.my1.cc>, Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 00:20:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvgNy-0000Q3-NJ
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 00:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169AbYELWT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 18:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbYELWT5
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 18:19:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbYELWT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 18:19:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9C4F438C4;
	Mon, 12 May 2008 18:19:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8D22E38C3; Mon, 12 May 2008 18:19:50 -0400 (EDT)
In-Reply-To: <20080512205414.GH3128@steel.home> (Alex Riesen's message of
 "Mon, 12 May 2008 22:54:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8CC74BF4-2071-11DD-8AE4-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81959>

Alex Riesen <raa.lkml@gmail.com> writes:

>> Why is this even needed to begin with?  I am aware of Dirk's original
>> issue discussed elsewhere, but we try fairly hard to be A-O-N when we can
>> afford to, and this option deliberately breaks it.  What is the real
>> reason why such an unreadable (either for privilege or for I/O error)
>> file should not live in .gitignore?
>
> Another program keeps the file open. There is an exclusive mode for
> opening files, which locks the files for everyone. I believe it is
> even default mode, unless selected otherwise.

I would understand there can be some files that cannot be read.  But when
there is such a file, why is it Ok to ignore an error to update the
contents from that file if/when the user asks to index the current
contents, provided if the contents of that file is to be tracked?  Isn't
it the true cause of the problem that the file is being tracked but it
shouldn't?

>> Now when somebody either forgets to check the return value from this
>> function, or deliberately ignores it, the resulting index will not match
>> what the code is told to update it with.
>
> I think I got them all in the current code...

Not checking the return code from this function that now diagnoses and
returns error code is a bug as you said, and the codebase after your patch
may not have that bug.

But mistakes happen.

That is why I am asking why it is Ok to sometimes ignore the error to
begin with.  If we do not need to ignore this condition, then new callers
have one less thing to worry about, and we would have one less cause of an
unnecessary bug.
