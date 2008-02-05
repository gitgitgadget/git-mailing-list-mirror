From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/9] Add flag to make unpack_trees() not print errors.
Date: Tue, 05 Feb 2008 15:43:55 -0800
Message-ID: <7v7ihj7yv8.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802041335390.13593@iabervon.org>
	<alpine.LSU.1.00.0802050112380.8543@racer.site>
	<alpine.LNX.1.00.0802051439200.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 01:35:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMYFk-00019u-Dq
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 01:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760999AbYBFAec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 19:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760998AbYBFAeb
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 19:34:31 -0500
Received: from lollipop.listbox.com ([208.210.124.78]:59230 "EHLO
	lollipop.listbox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760822AbYBFAe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 19:34:27 -0500
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by lollipop.listbox.com (Postfix) with ESMTP id 20A7050A0F6
	for <git@vger.kernel.org>; Tue,  5 Feb 2008 18:47:00 -0500 (EST)
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 9994E193CC5;
	Tue,  5 Feb 2008 18:44:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 2E377193BD9;
	Tue,  5 Feb 2008 18:44:19 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72730>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Tue, 5 Feb 2008, Johannes Schindelin wrote:
> ...
>> > Additionally, if unpack_trees() returns with an error, but without 
>> > printing anything, it will roll back any changes to the index (by 
>> > rereading the index, currently). This obviously could be done by the 
>> > caller, but chances are that the caller would forget and debugging this 
>> > is difficult.
>> 
>> Granted, it is easy to forget.  But maybe the caller does not need the 
>> index?  Or maybe it wants a different one?  I'd prefer the caller to clean 
>> up, if necessary.
>
> That's what makes it "gently" instead of just "silent"; it has no effect 
> if it doesn't succeed. Longer term, I'd like to have unpack_trees() unpack 
> into a separate index, which should actually be faster (since it doesn't 
> have to keep shifting the entries in the index it's working on) and make 
> this moot.

Absolutely.  That is the original motivation I did the_index
thing for.

But "re-reading" may not be quite nice.  It would defeat the
optimization introduced by the change to use CE_UPTODATE flag to
avoid unnecessary lstat(2) calls.
