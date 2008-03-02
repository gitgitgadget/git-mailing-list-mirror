From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff-index --raw HEAD and git diff --raw HEAD output the
 same thing?
Date: Sat, 01 Mar 2008 21:48:39 -0800
Message-ID: <7vbq5xvfpk.fsf@gitster.siamese.dyndns.org>
References: <46dff0320803010510q67bc4101k9f85c71e5d20b4@mail.gmail.com>
 <alpine.LSU.1.00.0803011320100.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 02 06:50:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVh5I-0002qj-0f
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 06:50:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbYCBFtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 00:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbYCBFtD
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 00:49:03 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbYCBFtB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 00:49:01 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 122D626DA;
	Sun,  2 Mar 2008 00:48:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0D81826D8; Sun,  2 Mar 2008 00:48:46 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0803011320100.22527@racer.site> (Johannes
 Schindelin's message of "Sat, 1 Mar 2008 13:21:02 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75725>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 1 Mar 2008, Ping Yin wrote:
>
>> Strange things is this line
>> :160000 160000 34f279b1662a6bef6a8fdea1827bbdbd80f12444
>> 0000000000000000000000000000000000000000 M      commonmake
>> 
>> why mod is 160000 while sha1 is 0000...
>
> This indicates that a submodule (160000) was deleted (00000).  It is 
> easier not to handle a deletion as mode change...

Read the question again.

When you compare something with a work tree state, and when the work tree
state is dirty, we always show 0{40} to mean "it is dirty and we do not
know what the object name of that thing is, until you actuallly run
git-update-index (or git-add) it" (and at that point it would stop being
dirty).  For blobs (be it a regular file or a symbolic link), this has an
advantage of not having to run hash-object to obtain the object name of an
object that would be created if you actually did git-add it.

When we check if it is dirty, we already do an lstat(2) and know the type
of it, so we can show the mode bits.  So you will see 100644, 100755 or
120000 for blobs.  Similarly for a submodule.

For a submodule, we could read the value from $sub/.git/HEAD, but it is
more consistent to show 0{40} on the work tree side (typically the right
hand side, unless you use -R).


