From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] safecrlf: Add mechanism to warn about irreversible crlf conversions
Date: Sun, 03 Feb 2008 14:53:11 -0800
Message-ID: <7vejbtsld4.fsf@gitster.siamese.dyndns.org>
References: <12019685081997-git-send-email-prohaska@zib.de>
	<7vbq6yuxeh.fsf@gitster.siamese.dyndns.org>
	<4C024D67-9FA5-451D-BB91-CE9464C6F50D@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Feb 03 23:54:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLniv-0001u5-7v
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 23:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005AbYBCWxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 17:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752345AbYBCWxc
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 17:53:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33271 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbYBCWxc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 17:53:32 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CFCDE67B4;
	Sun,  3 Feb 2008 17:53:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B96A67B1;
	Sun,  3 Feb 2008 17:53:28 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72415>

Steffen Prohaska <prohaska@zib.de> writes:

>> The whole point of git-apply is to apply the patch.  If you say
>> --whitespace=fix and some contents (say one of the testsuite
>> files in our t/ directory) needed to keep trailing newline, you
>> obviously are left with a broken result, and you would recover
>> by checking it out from index or HEAD and reapply.  Why
>> shouldn't the same principle hold here?
>
> You are right.  All files should be committed before running
> git apply and therefore the original files can be recovered by
> git checkout.  Hmm ... so apply should either just warn or be
> completely quiet as git blame is?  I think it should warn.

I agree that warning is needed if the setting says "warn".

Of course, it could become part of an irreversible action if you
did this:

	$ git commit ;# or whatever.  Now there is no local mods
        $ git apply <patch-1
	$ edit ;# to fix things up
        $ git apply <patch-2

and if you get the warning from patch-2.

But the safecrlf warning is primarily about a misdetection of
binaryness, so I do not think this sequence is not something we
would even want to worry about.
