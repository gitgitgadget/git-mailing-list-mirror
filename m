From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge --abort
Date: Mon, 23 Feb 2009 18:01:56 -0800
Message-ID: <7vk57goanf.fsf@gitster.siamese.dyndns.org>
References: <43d8ce650902190205yc2274c5gb8e658c8608267ff@mail.gmail.com>
 <43d8ce650902230441n51c9e5a8h722682cda778aa7a@mail.gmail.com>
 <7vvdr0obuj.fsf@gitster.siamese.dyndns.org>
 <200902240253.35470.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>,
	Bryan Donlan <bdonlan@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 03:03:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbme0-0000nq-4z
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 03:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753AbZBXCCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 21:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753092AbZBXCCI
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 21:02:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbZBXCCI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 21:02:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 954F32BCB4;
	Mon, 23 Feb 2009 21:02:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EB6552BCAB; Mon,
 23 Feb 2009 21:01:57 -0500 (EST)
In-Reply-To: <200902240253.35470.jnareb@gmail.com> (Jakub Narebski's message
 of "Tue, 24 Feb 2009 02:53:34 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 229D9EEE-0217-11DE-A26B-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111197>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>> John Tapsell <johnflux@gmail.com> writes:
>> 
>> > It sounds like we have some sort of plan then.  Will Nana's patch be
>> > committed into mainline git?  Then we can add the --abort porcelain
>> 
>> I do not know what plan you are talking about, but that's not how the
>> development works.  If something is merged to 'pu', and you have a cool
>> feature you would want to take advantage of it, you can build your cool
>> feature on top of that particular topic.  If the result looks reasonable
>> they would cook for a while in 'next' for further polishing and then
>> finally go to 'mainline'.
>> 
>> I personally did not think "--keep" would need to be be part of a
>> reasonable "merge --abort" implementation, but I may have missed some
>> description of a viable design discussed on the list.
>
> My idea was that merge would do the following:
>
>   $ <save stash into MERGE_STASH or similar, no reset>
>   $ <do a merge>
>
> Then we have two possibilities:
>
>   # merge failed with conflicts
>   $ git merge --abort (would unstash MERGE_STASH and delete it)

Here "would unstash" needs to follow something else, namely, make your
work tree free of local changes.  How?  "reset --hard"?

>   # we created merge conflict
>   $ <MERGE_STASH is removed together with MERGE_HEAD>

You mean "created a merge without conflict", right?  That part is easy to
guess and understand.

In fact, when you run more than one strategies, something similar to this
already happens internally.  The C version may be harder to follow, but
you can check the last scripted version contrib/examples/git-merge.sh and
find two functions, savestate/restorestate pair, that does exactly that.

It way predates --keep patch, by the way.
