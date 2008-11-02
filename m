From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI 
 revamp
Date: Sun, 02 Nov 2008 14:17:05 -0800
Message-ID: <7vabch22ou.fsf@gitster.siamese.dyndns.org>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
 <20081030143918.GB14744@mit.edu> <vpqmygmw1mr.fsf@bauges.imag.fr>
 <alpine.LFD.2.00.0810301259130.13034@xanadu.home>
 <20081030170329.GK24098@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Theodore Tso <tytso@mit.edu>, Sam Vilain <sam@vilain.net>,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 02 23:19:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwlHr-0000Xb-93
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 23:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754814AbYKBWR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 17:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbYKBWR2
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 17:17:28 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782AbYKBWR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 17:17:27 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1416B77757;
	Sun,  2 Nov 2008 17:17:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5E9347774F; Sun,  2 Nov 2008 17:17:12 -0500 (EST)
In-Reply-To: <20081030170329.GK24098@artemis.corp> (Pierre Habouzit's message
 of "Thu, 30 Oct 2008 18:03:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 06EAF956-A92C-11DD-AFCD-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99880>

Pierre Habouzit <madcoder@debian.org> writes:

> On Thu, Oct 30, 2008 at 05:00:18PM +0000, Nicolas Pitre wrote:
>
>> If you have a file argument, the --hard option is redundant, isn't it?
>> So what about simply "git reset <file>" ?
>
> errrrm, git reset <file> resets the index notion of the file to its status
> in HEAD... which I'm sure is *somehow* useful to "some" people ;P

I'd agree that 'reset' is rather unfortunate.  It very originally was all
about the index (the "mixed" semantics, specifically "git reset" without
any committish nor any pathspec, was the original use case) and nothing
else.  IOW, "I staged a wrong change, let's start over by discarding all
staged changes".  A logical extension to it is "git reset -- pathspec",
IOW, "I know which paths I fubared, please reset only these paths, as
other staged changes are Ok".

So "reset <file>" is very much useful.

Then 'reset' learned to also muck with HEAD, so "reset HEAD^" (still
mixed, without any pathspec) can be used to amend the latest commit but
without losing the state you would eventually want to arrive at.  A
logical extension to this was "git reset --hard HEAD^" to nuking instead
of amending the mistake, and "git reset --soft HEAD^" to save the trouble
of staging the changes when the mistake you are fixing is small compared
to the entire change.

"checkout [$committish] $path" came much later, and the command is all
about index and files, and never about resetting HEAD.  "checkout $path"
does "reset --hard $path" (notice there is no $committish in either one)
would have done, so we stopped enhancing the "reset" command in that
direction.
