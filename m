From: Nicolas Pitre <nico@cam.org>
Subject: Re: How should I handle binary file with GIT
Date: Wed, 05 Apr 2006 15:31:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604051521480.2550@localhost.localdomain>
References: <20060405073022.13054.qmail@web25806.mail.ukl.yahoo.com>
 <7v3bgs4exz.fsf@assigned-by-dhcp.cox.net> <e10mn9$cjs$1@sea.gmane.org>
 <Pine.LNX.4.64.0604051131010.2550@localhost.localdomain>
 <86wte4rq3d.fsf@blue.stonehenge.com> <7vslor27n4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 21:31:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRDih-0002vS-JG
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 21:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWDETbI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 15:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWDETbH
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 15:31:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8826 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932070AbWDETbG
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 15:31:06 -0400
Received: from xanadu.home ([74.56.105.38]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IX90071KKVTGF20@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 05 Apr 2006 15:31:06 -0400 (EDT)
In-reply-to: <7vslor27n4.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18448>

On Wed, 5 Apr 2006, Junio C Hamano wrote:

> If we wanted to use the patch+diff (i.e. "format-patch,
> send-email, and then am" workflow) to transfer new version of
> binary files to a recipient, which I think is useful in some
> projects, the sanest way to handle this is probably to add
> Nico's delta, going from preimage to postimage, encoded for
> safer transport, to our diff output.  For safety and sanity, we
> will not "apply" the patch unless the patched file exactly
> matches the preimage that is recorded in the diff, and as long
> as the recipient has the preimage, such a patch would be able to
> reproduce the postimage and hopefully be smaller than
> transferring the whole thing.

Exactly the point.

> We've been trying to keep our diff output reversible (e.g. we
> show what the filemode of the preimage is), so if we take the
> above route, it probably should record deltas for both going
> from preimage to postimage _and_ going the other way (unless
> xdelta can be applied in-reverse, which I do not think is the
> case).

You cannot reverse a delta.  However if you were able to apply a delta 
from preimage to postimage that means you must already have had preimage 
in your object store.  Therefore reverting such a patch would simply 
involve restoring preimage.

> Of course, to be _completely_ generic, you could include both
> compressed then uuencoded preimage and postimage, and let the
> recipient sort it out.

I think this is just too much and besides the point of a diff.  If the 
work flow is so convoluted such that the simple binary patch as a delta 
doesn't apply then it would probably be a better idea to simply transfer 
those binaries as email attachments.  In other words, if a binary patch 
transfer mechanism is added, it should cover the common case and leave 
the rest for a better process like git-fetch/pull.


Nicolas
