From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Mon, 17 Dec 2007 13:16:52 -0800
Message-ID: <7v3au16myj.fsf@gitster.siamese.dyndns.org>
References: <7vsl2jh3rb.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999999.0712132227090.8467@xanadu.home>
	<m3fxy5qwbq.fsf@roke.D-201>
	<alpine.LFD.0.999999.0712140836140.8467@xanadu.home>
	<20071214215206.GB7300@mail.oracle.com>
	<alpine.LFD.0.999999.0712141724260.8467@xanadu.home>
	<20071214223957.GC7300@mail.oracle.com>
	<alpine.LFD.0.999999.0712141744460.8467@xanadu.home>
	<20071215004230.GF7300@mail.oracle.com>
	<alpine.LFD.0.999999.0712142114400.8467@xanadu.home>
	<20071217200920.GB19816@mail.oracle.com>
	<alpine.LFD.0.999999.0712171517320.8467@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 22:17:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4NLS-0006FC-OO
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 22:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758511AbXLQVRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 16:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757948AbXLQVRI
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 16:17:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041AbXLQVRH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 16:17:07 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8742F4EB2;
	Mon, 17 Dec 2007 16:16:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D9EB64EAE;
	Mon, 17 Dec 2007 16:16:53 -0500 (EST)
In-Reply-To: <alpine.LFD.0.999999.0712171517320.8467@xanadu.home> (Nicolas
	Pitre's message of "Mon, 17 Dec 2007 15:41:24 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68623>

Nicolas Pitre <nico@cam.org> writes:

> On Mon, 17 Dec 2007, Joel Becker wrote:
>
>> 	You may not see a case for actual corruptions, but my coworker
>> updated his tree on a box with 1.5.x, then tried to work on a box with
>> 1.4.x (I think 1.4.2 back then), and ended up with a tree that was
>> unusable.  He had to re-clone, and I think he got lucky recovering
>> pending changes (probably using 1.5.x on the branches with the changes,
>> as master was what got broken).
>
> I still claim that there wasn't any corruptions.
> ...
> Your allegation of corruptions is cavalier just as well.
>
> I'm telling you that there won't be any such corruption.  Just like in 
> the M$ Office case, it is expected that newer versions make data 
> unusable by older versions at some point -- that's the inevitable side 
> effect of progress.

This is mostly spilt milk under the bridge now, but I have to mildly
disagree.

If we had core.usedeltabaseoffset instead of repack.usedeltabaseoffset,
and made the format negotiation in fetch-pack protocol pay attention to
that variable, Joel's coworker did not have to suffer if the repository
explicitly asked OFS_DELTA not to be used.

Instead we unconditionally said "if you are downloading with the new
client, we assume you would never be using older client to access that
repository locally, if you did so, you are screwed."

IOW, I think e4fe4b8ef7cdde842a9e5e2594d0fba1367d9dd3 (let the GIT
native protocol use offsets to delta base when possible) could have been
a bit more careful in this respect.
