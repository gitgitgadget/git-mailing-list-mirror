From: David Kastrup <dak@gnu.org>
Subject: Re: Marking commits as transitory for git bisect?
Date: Wed, 02 Dec 2009 12:01:28 +0100
Message-ID: <87tyw9wsfr.fsf@lola.goethe.zz>
References: <871vjdyb59.fsf@lola.goethe.zz>
	<4B164501.7010902@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 02 16:17:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFqxW-0001wr-HX
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 16:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357AbZLBPR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 10:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbZLBPR1
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 10:17:27 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:36437 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbZLBPR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 10:17:26 -0500
Received: from localhost ([127.0.0.1]:57737 helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.67)
	(envelope-from <dak@gnu.org>)
	id 1NFqxQ-0004AH-BR; Wed, 02 Dec 2009 10:17:32 -0500
Received: by lola.goethe.zz (Postfix, from userid 1000)
	id A7FFF248DE; Wed,  2 Dec 2009 12:01:28 +0100 (CET)
In-Reply-To: <4B164501.7010902@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Wed, 02 Dec 2009 11:44:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134338>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> David Kastrup venit, vidit, dixit 02.12.2009 10:32:
>> 
>> sometimes there are changes which would seem better to restructure into
>> more than one commit, with a non-operative intermediate state.
>> 
>> What I am thinking of is something like
>> 
>> a) change an API (small but highly intricate patch warranting thorough
>>    line-by-line review to make sure it's fine)
>> b) adapt all existing callers (really large but utterly trivial patch)
>
> A quick solution with current git would be "replace": Say, in
> A-B-C-D
> you want B and C to be considered an "atom" for bisection. So, "git
> replace" C by a commit C' which is B+C squashed and has A as its parent:
> A-C'-D.

That would lose B and C.  The idea was to have this available
publically.

> Alternatively, if you want this to be distributed more easily and think
> of it at the time of committing, producing a DAG like
>
> A--C'--D
>  \    /
>   B--C
>
> with C' as the first parent of D may help during bisection. I.e., you
> keep the detailed history on the side branch and squash it together on
> the --first-parent-line, with C,C' being tree-same.

That would seem to be more or less accomplished by putting B-C on a
side-branch, then merge that branch into A (C' basically being the merge
commit).  So the DAG would be something like

A------D
 \    /
  B--C

If B-C is a local branch, will their history make it through to a remote
repository when you push D?

It seems like this workflow could possibly meet my criteria when one has
push access to the repo in question.  If one passes D upstream via
git-format-patch, however, it would appear that just the equivalent of
C' makes it upstream, with the B-C history staying local.

Not sure what will happen when upstream pulls D.

Further comments/insights?

-- 
David Kastrup
