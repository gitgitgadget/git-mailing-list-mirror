From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow update hooks to update refs on their own
Date: Tue, 27 Nov 2007 19:49:31 -0800
Message-ID: <7vzlwz9ghg.fsf@gitster.siamese.dyndns.org>
References: <20071127211730.GA11861@midwinter.com>
	<7v4pf7b20b.fsf@gitster.siamese.dyndns.org>
	<49EB8C6F-8100-48C1-BB2D-A8F6023BACAD@midwinter.com>
	<Pine.LNX.4.64.0711272143470.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 13:19:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKwl-0004fR-99
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:19:15 +0100
Received: from mail-mx9.uio.no ([129.240.10.39])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxDzE-0000L8-Ss
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 04:53:20 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx9.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxDy1-0002Yp-1g
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 04:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbXK1Dtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 22:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbXK1Dtk
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 22:49:40 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50820 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbXK1Dtk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 22:49:40 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 504C62EF;
	Tue, 27 Nov 2007 22:49:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 56F249A963;
	Tue, 27 Nov 2007 22:49:55 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711272143470.5349@iabervon.org> (Daniel
	Barkalow's message of "Tue, 27 Nov 2007 22:25:32 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.8, required=5.0, autolearn=disabled, AWL=2.229,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 473121C33CFA2077BB9AE1380CAEC1A41E444383
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -47 maxlevel 200 minaction 2 bait 0 mail/h: 34 total 723761 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66296>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Tue, 27 Nov 2007, Steven Grimm wrote:
>
>> On Nov 27, 2007, at 5:19 PM, Junio C Hamano wrote:
>> 
>> >How does this interact with the "pretend to have fetched back
>> >immediately" supported by modern git-push?
>> 
>> 
>> That continues to fire, but it updates the local tracking ref to point to the
>> SHA1 that was pushed, which isn't the actual remote ref. So you have to do a
>> real fetch to get the local tracking ref pointed to the right place. In other
>> words, that feature doesn't do any good in this context, but it doesn't really
>> hurt anything either.
>> 
>> It would of course be better if git-push could notice that it needs to do an
>> actual fetch. I think it'd be sufficient to transmit the final remote ref SHA1
>> back to git-push, and if it doesn't match what was pushed, that's a sign that
>> a fetch is needed. But that change wouldn't be mutually exclusive with this
>> patch, I believe.
>
> Couldn't you do this with a status message? ("ok <refname> changed by 
> hook" or something.)
>
> I disagree that the feature doesn't do any good; it records that the state 
> of the remote is at least as new as the local state, so you can tell 
> without a network connection that you don't have any local changes you 
> haven't sent off.

Yeah, and I am wondering why update hook needs to be changed for this.
Didn't we introduce post-receive exactly for this sort of thing?
