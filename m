From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] rebase -i: use config file format to save author information
Date: Sat, 20 Jun 2009 23:56:43 -0700
Message-ID: <7vhbyat6qc.fsf@alter.siamese.dyndns.org>
References: <20090621050846.3554.31660.chriscool@tuxfamily.org>
	<7vprcyt7fk.fsf@alter.siamese.dyndns.org>
	<alpine.LNX.2.00.0906210244510.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Jun 21 08:56:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIGz1-0006Qs-FP
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 08:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbZFUG4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 02:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985AbZFUG4p
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 02:56:45 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:48769 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597AbZFUG4o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 02:56:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090621065644.DKUN2915.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 21 Jun 2009 02:56:44 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6Wwj1c0064aMwMQ03Wwjit; Sun, 21 Jun 2009 02:56:43 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=wW3WdqC5rP8A:10 a=5ercUPtEAAAA:8
 a=4rConXgZLCxED3Xk2eEA:9 a=bMlNFpQyHV3EPOHR9fUAaeysWysA:4 a=JM1vJQTMoX0A:10
X-CM-Score: 0.00
In-Reply-To: <alpine.LNX.2.00.0906210244510.2147@iabervon.org> (Daniel Barkalow's message of "Sun\, 21 Jun 2009 02\:51\:53 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121969>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> Why is this a good change?
>
> It was always using a temporary file; it just used to use a temporary file 
> that was a shell script fragment and needed to be read with "eval". It 
> can't be done entirely in core because it may be determined before a 
> conflict and only used when run with --continue after the user resolves 
> the conflict.

Ahh, Ok.

Using a _known_ and defined format, instead of ad-hoc scriptlet, is an
improvement.

I still wonder if we can avoid using three separate "git show" and "git
config" invocations, though.  But a half of that inefficiency will go away
when this is migrated to C, as a single git_config() will grab all three, 
although the writing side is still very inefficient X-<.
