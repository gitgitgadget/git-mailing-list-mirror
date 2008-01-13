From: Junio C Hamano <gitster@pobox.com>
Subject: Re: performance problem: "git commit filename"
Date: Sun, 13 Jan 2008 00:14:37 -0800
Message-ID: <7vprw6qh02.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org>
	<alpine.LNX.1.00.0801130028460.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Kristian H?gsberg <krh@redhat.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Jan 13 09:15:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDxzu-0002Rp-V3
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 09:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbYAMIOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 03:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbYAMIOr
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 03:14:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60218 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbYAMIOq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 03:14:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1ADA63AA4;
	Sun, 13 Jan 2008 03:14:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9628C3AA2;
	Sun, 13 Jan 2008 03:14:40 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0801130028460.13593@iabervon.org> (Daniel
	Barkalow's message of "Sun, 13 Jan 2008 00:38:51 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70374>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Sat, 12 Jan 2008, Linus Torvalds wrote:
>
>> It makes builtin-commit.c use the same logic that "git read-tree -i -m" 
>> does (which is what the old shell script did), and it seems to pass the 
>> test-suite, and it looks pretty obvious.
>
> The only issue I know about with using unpack_trees in C as a replacement 
> for read-tree in shell is that unpack_trees leaves "deletion" index 
> entries in memory which are not written to disk,...

I do not think you have to worry about that one.  That "to be
deleted" was a Linus invention and he surely remembers it.

write_index() function of course knows about skipping them (they
are marked as !ce->ce_mode).  I think the patch is safe.
