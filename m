From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] diff --relative: output paths as relative to the
 current subdirectory
Date: Tue, 12 Feb 2008 15:43:51 -0800
Message-ID: <7vfxvx211k.fsf@gitster.siamese.dyndns.org>
References: <7vzlu524n9.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802121531170.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 00:44:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP4ns-0005J7-11
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 00:44:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbYBLXoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 18:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753335AbYBLXoJ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 18:44:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56056 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbYBLXoI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 18:44:08 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DB99A679B;
	Tue, 12 Feb 2008 18:44:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 207DE6799; Tue, 12 Feb 2008 18:43:58 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0802121531170.2920@woody.linux-foundation.org>
 (Linus Torvalds's message of "Tue, 12 Feb 2008 15:33:44 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73713>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 12 Feb 2008, Junio C Hamano wrote:
>>
>> This adds --relative option to diff family.  When you start from
>> a subdirectory, 
>> 
>>  $ git diff --relative
>
> Ack, except I think it should allow you to actually *set* what the diff is 
> relative to.
>
> An example of that could be something like
>
> 	git diff --relative=drivers/scsi/ a..b -- drivers/scsi/
>
> where you aren't actually *in* that subdirectory, but for one reason or 
> another you're limiting the diff to just stuff in that subdirectory, and 
> want a diff that is relative to that one.
>
> Hmm?

Your example is shorter to type as:

	(cd drivers/scsi && git diff --relative a..b --)

Do you envision a useful case where --relative=<foo> does not
cover the pathspec you give?  IOW, with the "temporarily chdir
there" approach, you cannot express:

	git diff --relative=block/ a..b -- drivers/scsi

but I do not think it is useful.  On the other hand,

	git diff --relative=drivers a..b -- drivers/scsi

does make sense but again that is:

	(cd drivers && git diff --relative a..b -- scsi/)

So...
