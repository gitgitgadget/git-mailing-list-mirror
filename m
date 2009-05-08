From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: 'git am --abort' can silently reset the wrong branch
Date: Fri, 08 May 2009 02:01:16 -0700
Message-ID: <7v7i0s0y03.fsf@alter.siamese.dyndns.org>
References: <20090506191945.GG6325@blackpad>
	<20090508082826.GA29737@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eduardo Habkost <ehabkost@raisama.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 08 11:01:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2LxN-0001LD-Gu
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 11:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbZEHJBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 05:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbZEHJBR
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 05:01:17 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:60116 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbZEHJBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 05:01:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090508090117.UGWO25927.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 May 2009 05:01:17 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id ox1G1b0074aMwMQ04x1GJy; Fri, 08 May 2009 05:01:16 -0400
X-Authority-Analysis: v=1.0 c=1 a=U5Cb-xvLp14A:10 a=v5yyCeP7a8wA:10
 a=PKzvZo6CAAAA:8 a=4MQlGTHb121L9bl245oA:9 a=PL2dZzHV7r5YxgnGqwIA:7
 a=Z0SKMVn3C9QcfH-kLGqxmsAgwjQA:4 a=OdWmie4EkE0A:10
X-CM-Score: 0.00
In-Reply-To: <20090508082826.GA29737@coredump.intra.peff.net> (Jeff King's message of "Fri\, 8 May 2009 04\:28\:26 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118592>

Jeff King <peff@peff.net> writes:

> Switching branches and clobbering some other branch
> with --abort is just _one_ thing you can do to screw yourself. You could
> also have been doing useful work on the _same_ branch, and that would
> get clobbered by --abort.  However, I'm not sure if we have a good way
> of telling the difference between "work which I did to try to get these
> patches to apply, but which should be thrown away when I abort" and
> "work which I did because I forgot I had an active git-am".

I think I've said this already, but honestly speaking, I think --abort
should not do --reset at all, but just remove the $dotest directory.  Or
perhaps introduce a --clear option to do so.

At least your patch is an improvement.

What I sometimes see to my users happen is to try applying to the oldest
integration branch the patch (the users think) ought to apply, see it fail
to apply, switch to a bit newer branch and run "am" again (trusting that
it will pick up the material from $dotest), repeat the above and then give
up with "git am --abort".  I do not think anybody can offhand explain to
which branch and to what state the command takes the user back to in such
a situation without looking at what the code actually does X-<; even
though I think it should take the user back to the original branch, I do
not think that is what the code does.
