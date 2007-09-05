From: Junio C Hamano <gitster@pobox.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 14:46:59 -0700
Message-ID: <7v1wdciy3w.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
	<46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
	<alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
	<7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.9999.0709051634190.21186@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nix <nix@esperi.org.uk>, Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 23:47:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT2iT-0002Oz-78
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 23:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbXIEVrN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 17:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754205AbXIEVrM
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 17:47:12 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:40928 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755560AbXIEVrM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 17:47:12 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 5523212F1FD;
	Wed,  5 Sep 2007 17:47:23 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.9999.0709051634190.21186@xanadu.home> (Nicolas
	Pitre's message of "Wed, 05 Sep 2007 16:35:19 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57769>

Nicolas Pitre <nico@cam.org> writes:

>> This patch does not add invocation of the "auto repacking".  It
>> is left to key Porcelain commands that could produce tons of
>> loose objects to add a call to "git gc --auto" after they are
>> done their work.  Obvious candidates are:
>> 
>> 	git add
>
> Nope!  'git add' creates loose objects which are not yet reachable from 
> anywhere.  They won't get repacked until a commit is made.

Bzzt, I am releaved to see you are sometimes wrong ;-)

They are reachable from the index and are not subject to
pruning.

>> 	git fetch
>
> I think that would be a much better idea to simply decrease the 
> fetch.unpackLimit default value.

One thing that I find lacking in that auto patch is actually
that we should sometimes consolidate multiple small packs into a
single larger one.  Any behaviour change to encourage creation
of many tiny packs should be avoided until it materializes.

Probably we should introduce a built-in minimum value for a
positive gc.auto, somewhere around 1000 or so, for this reason.
