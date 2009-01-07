From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in a
 pack file
Date: Wed, 07 Jan 2009 01:42:03 -0800
Message-ID: <7vaba3a1w4.fsf@gitster.siamese.dyndns.org>
References: <20081209093627.77039a1f@perceptron>
 <1231282320.8870.52.camel@starfruit>
 <alpine.LFD.2.00.0901062005290.26118@xanadu.home>
 <1231292360.8870.61.camel@starfruit>
 <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>
 <1231314099.8870.415.camel@starfruit>
 <7vaba3bken.fsf@gitster.siamese.dyndns.org>
 <1231317131.8870.471.camel@starfruit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 10:43:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKUws-0000Ui-Jf
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 10:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633AbZAGJmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 04:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753065AbZAGJmP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 04:42:15 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62366 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbZAGJmO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 04:42:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D8D68EE4C;
	Wed,  7 Jan 2009 04:42:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DE1B38EE4B; Wed,
  7 Jan 2009 04:42:05 -0500 (EST)
In-Reply-To: <1231317131.8870.471.camel@starfruit> (R. Tyler Ballance's
 message of "Wed, 07 Jan 2009 00:32:11 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 758D41BA-DC9F-11DD-98CE-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104779>

"R. Tyler Ballance" <tyler@slide.com> writes:

> On Wed, 2009-01-07 at 00:16 -0800, Junio C Hamano wrote:
>> "R. Tyler Ballance" <tyler@slide.com> writes:
>> 
>> > Unfortunately it doesn't, what I did notice was this when I did a `git
>> > status` in the directory right after untarring:
>> >         tyler@grapefruit:~/jburgess_main> git status
>> >         #
>> >         # ---impressive amount of file names fly by---
>> >         # ----snip---
>> > ...
>> > Basically, somehow Git thinks that *every* file in the repository is
>> > deleted at this point.
>> 
>> That makes me suspect that your .git/index file is corrupt.
>
> Would this be tied to the corrupted pack file issue, or separate.

If you have perfectly good set of packs, if your index is corrupt you may
see "everything deleted", so in that sense it is independent.

As Linus's earlier conjecture was that this is related to some sort of
disk/cache corruption, I wouldn't be surprised if such a failure hit packs
and the index file indiscriminatingly.  So in that sense they are
related.

I think "git ls-files" (before doing anything else, such as resetting, of
course) would report that the index is corrupt, if that is indeed the case.
