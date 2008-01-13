From: Junio C Hamano <gitster@pobox.com>
Subject: Re: performance problem: "git commit filename"
Date: Sun, 13 Jan 2008 00:12:21 -0800
Message-ID: <7vtzliqh3u.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Kristian H?gsberg <krh@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 13 09:13:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDxxs-00027o-7z
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 09:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbYAMIMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 03:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbYAMIMc
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 03:12:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60016 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbYAMIMb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 03:12:31 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E69537F7;
	Sun, 13 Jan 2008 03:12:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 85E5F37F6;
	Sun, 13 Jan 2008 03:12:23 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 12 Jan 2008 20:04:22 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70373>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> HOWEVER. This was just a quick hack, and while it all looks sane, this is 
> some damn core code. Somebody else should double- and triple-check this.

Double-checked.  The patch looks sane.

> [ That 4x lstat thing bothers me. I think we should add a flag to the 
>   index saying "we checked this once already, it's clean", so that if we 
>   do multiple passes over the index, we can still do just a single lstat() 
>   on just the first pass. But that's a separate issue.

I've thought about this in a different context before, but it
seemed quite tricky, as some codepaths in more complex commands
(commit being one of them) tend to use the cache and discard to
use it for different purpose (like creating temporary index and
then reading the real index).  Besides, I had an impression that
we ran out of the bits of ce_flags in the cache entry, although
we could shorten the maximum path we support from 4k down to 2k
bytes.  I'll have to think about this a bit more.
