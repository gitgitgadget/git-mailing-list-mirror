From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] diff.c: convert builtin funcname patterns to
 non-GNU extended regex syntax
Date: Fri, 19 Sep 2008 13:29:20 -0700
Message-ID: <7v7i97swv3.fsf@gitster.siamese.dyndns.org>
References: <7vskry1485.fsf@gitster.siamese.dyndns.org>
 <4i0Mu795rKpv37JoHytmE6kODBjwgwITn0-DuKdZiFs3ZnUlyJC-Fw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Git Mailing List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johan Herland <johan@herland.net>,
	Andreas Ericsson <ae@op5.se>, Kirill Smelkov <kirr@mns.spb.ru>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>,
	Jonathan del Strother <maillist@steelskies.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Sep 19 22:30:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgmcr-0006Ri-FK
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 22:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754464AbYISU3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 16:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754237AbYISU3k
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 16:29:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033AbYISU3k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 16:29:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1BA556375A;
	Fri, 19 Sep 2008 16:29:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 96C0B6374D; Fri, 19 Sep 2008 16:29:23 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AEB93604-8689-11DD-89A9-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96313>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> The 'non-GNU' part of this basic RE to extended RE conversion means '\\s' was
> converted to ' '.

I think a large part of this series should be in 'maint', as the existing
hunk head pattern engine does _not_ work for people without GNU regexp.

I've created two branches to house this topic:

 - bc/maint-diff-hunk-header-fix is rebased to 'maint', so that after
   testing we can merge it to 'maint' for 1.6.0.3 and later versions.

   Its current tip is at 45d9414;

 - bc/master-diff-hunk-header-fix forks from the above, and merges later
   "language" additions that happened on 'master'.  We can merge this
   after testing to 'master' for 1.6.1.

   Its current tip is at dde4af4.

Neither has [4/4] on it.  I'd like two patches so that:

 * [PATCH 1/2] applies to bc/maint-diff-hunk-header-fix, so that the
   languages in 1.6.0.2 are fixed for non GNU platforms;

 * After applying [1/2] to bc/maint-diff-hunk-header-fix, I'll merge the
   branch to bc/master-diff-hunk-header-fix and then...

 * [PATCH 2/2] applies on top of it to convert new languages that are
   supported only on 'master' to use xfuncname.
