From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] rebase -i: use config file format to save author information
Date: Sun, 21 Jun 2009 01:10:41 -0700
Message-ID: <7vbpoit3b2.fsf@alter.siamese.dyndns.org>
References: <20090621050846.3554.31660.chriscool@tuxfamily.org>
	<alpine.LNX.2.00.0906210244510.2147@iabervon.org>
	<7vhbyat6qc.fsf@alter.siamese.dyndns.org>
	<200906211001.42254.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 10:11:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MII96-0006Ia-4H
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 10:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbZFUIK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 04:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbZFUIK6
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 04:10:58 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:61682 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbZFUIK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 04:10:57 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090621081059.KVNU17135.fed1rmmtao104.cox.net@fed1rmimpo03.cox.net>;
          Sun, 21 Jun 2009 04:10:59 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 6YAx1c0014aMwMQ04YAxlK; Sun, 21 Jun 2009 04:10:59 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=wW3WdqC5rP8A:10 a=pGLkceISAAAA:8
 a=5ercUPtEAAAA:8 a=jZIWoBbWMGIzIg0-MxAA:9 a=k1-1ujf6G44l_-w5Ub1X6GaAoqsA:4
 a=MSl-tDqOz04A:10 a=JM1vJQTMoX0A:10
X-CM-Score: 0.00
In-Reply-To: <200906211001.42254.jnareb@gmail.com> (Jakub Narebski's message of "Sun\, 21 Jun 2009 10\:01\:41 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121971>

Jakub Narebski <jnareb@gmail.com> writes:

> On Sun, 21 June 2009, Junio C Hamano wrote:
>> Daniel Barkalow <barkalow@iabervon.org> writes:
>> 
>>>> Why is this a good change?
>>>
>>> It was always using a temporary file; it just used to use a temporary file 
>>> that was a shell script fragment and needed to be read with "eval". It 
>>> can't be done entirely in core because it may be determined before a 
>>> conflict and only used when run with --continue after the user resolves 
>>> the conflict.
>> 
>> Ahh, Ok.
>> 
>> Using a _known_ and defined format, instead of ad-hoc scriptlet, is an
>> improvement.
>> 
>> I still wonder if we can avoid using three separate "git show" and "git
>> config" invocations, though.  But a half of that inefficiency will go away
>> when this is migrated to C, as a single git_config() will grab all three, 
>> although the writing side is still very inefficient X-<.
>
> I think we can on the reading side: just use "git config --list", or
> perhaps "git config --get-regexp <sth>" (where <sth> can be ".*") which
> conveniently has SPC as separator, and feed it to appropriate 3 x 'read'.
>
> On the writing side we can simply write in the config file format, we
> don't need to use git-config for that.  Although I wonder if there won't
> be trouble with shell escaping and quoting rules (eval / sed, which
> I guess does shell quoting / shell unquoting).
>
> On getting the information side we can use git-show with custom format
> or git-cat-file fed to while-read-case construct.
>
> This way from 3 x 3 = 9 git commands git-rebase--interactive.sh would
> use only 2.

That's not what I meant.
