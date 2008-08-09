From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout --track: make up a sensible branch name if '-b'
 was omitted
Date: Sat, 09 Aug 2008 14:11:59 -0700
Message-ID: <7vsktd51wg.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0808091559460.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vtzdu6nb7.fsf@gitster.siamese.dyndns.org>
 <7vvdya55ur.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0808092302520.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 09 23:13:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRvkM-0007H9-IE
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 23:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbYHIVMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 17:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbYHIVMH
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 17:12:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47941 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbYHIVMG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 17:12:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 994A146B2E;
	Sat,  9 Aug 2008 17:12:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DF65946B2B; Sat,  9 Aug 2008 17:12:01 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0808092302520.24820@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Sat, 9 Aug 2008 23:08:04 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D1081D58-6657-11DD-ACA0-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91782>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 9 Aug 2008, Junio C Hamano wrote:
> ...
> At first, I liked the thoughts, but...
>
>> (1) You may not necessarily are used to --track, but may still want this
>>     done.  It might not be a bad idea to associate this "local dwimming"
>>     to creation of a new branch.  In other words, all of these:
>> 
>>     $ git checkout -b origin/next
>
> This cannot be dwimmed, as it literally means "start a new branch called 
> 'origin/next' from HEAD".

Right.  Forget this part.

>> (2) If you work with somebody else, you might not want to have the name
>>     mapping to be "s|^[^/]*/||" (i.e. drop "origin/"):
>> 
>>     $ git remote add -f jeff $url_to_his_repository
>>     $ git checkout -b [--track] jeff-next jeff/next
>>     $ git checkout -b [--track] origin-next origin/next
>
> As I said, I think you must not allow switching around the options -b and 
> --track.

Oh, that was a typo.  "git checkout [--track] -b" was what I meant, but
the point was that with your patch "git checkout --track jeff/next" and
"git checkout --track origin/next" would create 'next' branch which will
not be useful for people who work with more than one repository.

Yes, you can of course explicitly name what you want to create with -b,
but that argument goes directly against the "usability enhancement" theme
of your patch.

Don't mistake this comment as "I oppose to the patch".  I was hoping
people who care, not necessarily you, might come up with a clean UI and
mechanism to let users affect how this dwimmery would work depending on
how the users want to work, by raising this point as something to ponder
on.
