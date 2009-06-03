From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 03 Jun 2009 15:16:12 -0700
Message-ID: <7vzlcp55g3.fsf@alter.siamese.dyndns.org>
References: <200905122329.15379.jnareb@gmail.com>
	<200906032220.00238.jnareb@gmail.com>
	<20090603202429.GO3355@spearce.org>
	<200906040004.18594.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 00:16:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBykz-0000Pi-Dk
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 00:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754395AbZFCWQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 18:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754287AbZFCWQL
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 18:16:11 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:47366 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096AbZFCWQK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 18:16:10 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090603221610.DCQS17135.fed1rmmtao104.cox.net@fed1rmimpo03.cox.net>;
          Wed, 3 Jun 2009 18:16:10 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id zaGC1b00F4aMwMQ04aGCF9; Wed, 03 Jun 2009 18:16:12 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=1cH15jnNZHcA:10 a=8-WIN01VSTQA:10
 a=pGLkceISAAAA:8 a=KiYATCRP-6Llle_O_eoA:9 a=x3eZ7E_xJgh9l9nztTwA:7
 a=RDNLOtXRhx58OyrKbdLwRq2mnYEA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <200906040004.18594.jnareb@gmail.com> (Jakub Narebski's message of "Thu\, 4 Jun 2009 00\:04\:09 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120654>

Jakub Narebski <jnareb@gmail.com> writes:

> 1. Server sends space separated list of capabilities it support. It
>    MUST NOT send capabilities it *does not* support. It MAY NOT send
>    "include-tag" if there are no tag objects (or is it SHOULD NOT?).

I doubt RFC 2119 lingo would include MAY NOT, as it is ambiguous
especially to non-native speakers (like me).  You meant to say "MAY omit
sending", perhaps, but in general capabilies are what you _can_ do at the
protocol level, and in my opinion, you shouldn't have to check if a
particular repository you (as a program with given set of features
implemented) happen to be looking at has tags in order to decide what
capabilities to advertise.

> 2. Client sends space separated list of capabilities it wants. It SHOULD
>    (or perhaps it is MAY?) send subset of server capabilities, i.e do
>    not send capabilities served does not advertise.

I'd say "the client SHOULD NOT ask for capabilities the server did not say
it supports".

> 3. Server MUST ignore capabilities it does not understand. Server MUST
>    NOT ignore capabilities (or SHOULD NOT only?) that client requested
>    and server advertised.

I know unrecognized capability requests are silently ignored, but I
consider that as a sloppy/practical programming, and not a specification.
