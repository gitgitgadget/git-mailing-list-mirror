From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fact-import: failed to apply delta
Date: Tue, 10 Feb 2009 14:30:00 -0800
Message-ID: <7vprhqkjrr.fsf@gitster.siamese.dyndns.org>
References: <20090210155626.GM30949@spearce.org>
 <alpine.LNX.1.00.0902101118110.19665@iabervon.org>
 <20090210172212.GR30949@spearce.org>
 <alpine.LNX.1.00.0902101226580.19665@iabervon.org>
 <20090210191220.GT30949@spearce.org>
 <alpine.LNX.1.00.0902101427300.19665@iabervon.org>
 <20090210201203.GU30949@spearce.org>
 <alpine.LNX.1.00.0902101520240.19665@iabervon.org>
 <20090210212539.GV30949@spearce.org>
 <alpine.LNX.1.00.0902101628140.19665@iabervon.org>
 <20090210213612.GW30949@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 23:31:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX18j-0002nk-GV
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 23:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027AbZBJWaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 17:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755936AbZBJWaK
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 17:30:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755938AbZBJWaI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 17:30:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E79789828D;
	Tue, 10 Feb 2009 17:30:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4E0359828B; Tue,
 10 Feb 2009 17:30:01 -0500 (EST)
In-Reply-To: <20090210213612.GW30949@spearce.org> (Shawn O. Pearce's message
 of "Tue, 10 Feb 2009 13:36:12 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5EEC070A-F7C2-11DD-BBE2-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109325>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Daniel Barkalow <barkalow@iabervon.org> wrote:
>> On Tue, 10 Feb 2009, Shawn O. Pearce wrote:
>> > 
>> > We should dump the cached_objects table in sha1_file.c during
>> > a checkpoint in fast-import.
>> 
>> No, that one's keyed by sha1, and doesn't get collisions; it's the 
>> delta_base_cache that's the issue; it's keyed by struct packed_git * and 
>> offset.
>
> Uh, yea, I realize that after I sent the message.  Does this patch
> fix it for you?
>
> --8<--
> Clear the delta base cache during fast-import checkpoint
>
> Otherwise we may reuse the same memory address for a totally
> different "struct packed_git", and a previously cached object from
> the prior occupant might be returned when trying to unpack an object
> from the new pack.

Can this be made more automatic?

For example if you do this every time a new pack is installed to
sha1_file(), like in add_packed_git() perhaps, wouldn't that be much less
error prone?
