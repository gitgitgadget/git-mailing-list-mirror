From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git gc & deleted branches
Date: Fri, 09 May 2008 18:21:00 -0700
Message-ID: <7vskwr9coz.fsf@gitster.siamese.dyndns.org>
References: <20080508214454.GA1939@sigill.intra.peff.net>
 <48237650.5060008@nrlssc.navy.mil>
 <20080508224827.GA2938@sigill.intra.peff.net>
 <loom.20080509T011318-478@post.gmane.org>
 <20080509041921.GA14773@sigill.intra.peff.net>
 <E1B43061-69C7-43D7-9A57-34B7C55DF345@adacore.com>
 <48246A44.7020303@nrlssc.navy.mil>
 <alpine.LFD.1.10.0805091205580.23581@xanadu.home>
 <7vwsm39kft.fsf@gitster.siamese.dyndns.org> <877ie3yqb3.fsf@jeremyms.com>
 <20080510002014.GH29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremy Maitin-Shepard <jbms@cmu.edu>, Nicolas Pitre <nico@cam.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Geert Bosch <bosch@adacore.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 10 03:22:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JudnK-0003ej-Ar
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 03:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbYEJBVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 21:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753833AbYEJBVY
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 21:21:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51559 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbYEJBVW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 21:21:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 070EF9CCE;
	Fri,  9 May 2008 21:21:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 26F659CC8; Fri,  9 May 2008 21:21:09 -0400 (EDT)
In-Reply-To: <20080510002014.GH29038@spearce.org> (Shawn O. Pearce's message
 of "Fri, 9 May 2008 20:20:14 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 65BD0ABA-1E2F-11DD-AF64-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81641>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Jeremy Maitin-Shepard <jbms@cmu.edu> wrote:
>> It is extremely cumbersome to have to worry about whether there are
>> other concurrent accesses to the repository when running e.g. git gc.
>> For servers, you may never be able to guarantee that nothing else is
>> accessing the repository concurrently.  Here is a possible solution:
>> 
>> Each git process creates a log file of the references that it has
>> created.  The log file should be named in some way with e.g. the process
>> id and start time of the process, and simply consist of a list of
>> 20-byte sha1 hashes to be considered additional in-use references for
>> the purpose of garbage collection.

How would that solve the issue that you should not prune/gc the repository
"clone --shared" aka "alternates" borrows from?

By the way, I do not think your "git-commit stopped for two weeks due to a
long editing session of the commit message" should result in any object
lossage, as the new objects are all reachable from the index, and the new
tree nor the new commit hasn't been built while you are typing (rather,
not typing) the log message.

Hmm, a partial commit that uses a temporary index file may lose, come to
think of it.  Perhaps we should teach reachable.c about the temporary
index file as well.  I dunno.
 
