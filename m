From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: Find out on which branch a commit was originally made
Date: Mon, 20 Sep 2010 10:12:06 +0200
Message-ID: <1jp42v5.w5dez21d3nlciM%lists@haller-berlin.de>
References: <201009200547.o8K5ldI7010683@no.baka.org>
Cc: git@vger.kernel.org
To: in-gitvger@baka.org (Seth Robertson),
	art.08.09@gmail.com (Artur Skawina)
X-From: git-owner@vger.kernel.org Mon Sep 20 10:12:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxbU0-0008VE-DM
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567Ab0ITIMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:12:10 -0400
Received: from mail.ableton.net ([62.96.12.115]:49904 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755559Ab0ITIMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=KC/WhfYryuJNcDjoO0ybBfCmaT/Y0jK3tQ28F/zk6Gg=;
	b=lmwCcdWEQLWDhFPeD0JG2z64um0+CyE1ncfGNol610zsNwvQIGlaB6RrtIDXa1+eLfzZToGbZSEjXkYZFC3s/Ezjul7vM9VQh0VOIBwO+1rgcGwoMmXfiaWU20G74BeSMguTbXSupIeZJ4tTpH2JCr9sTmZux1NE+i/bik/SM0g=;
Received: from macbook-stk.office.ableton.com ([10.1.12.2])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1OxbTr-0006TG-Fq; Mon, 20 Sep 2010 10:12:07 +0200
In-Reply-To: <201009200547.o8K5ldI7010683@no.baka.org>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156556>

Seth Robertson <in-gitvger@baka.org> wrote:

> In message <4C96B97D.6030209@gmail.com>, Artur Skawina writes:
> 
>     On 09/20/10 01:54, Seth Robertson wrote:
> 
>     > I'd like a command that would tell me the right branch something was
>     > on whether it was on master or topic or whatever.  If instead of
>     > "master" the branch was named "supertopic" and master commit AA had
>     > child D would that make a difference?
> 
>     Like i said, "arguably". In theory, no, there is no difference. In
>     practice, some branches will be more long-lived than others -- and
>     certain conventions will apply. Hence, i think that answer /is/ the
>     right one, in context -- that script was specifically looking for
>     info on /another/ branch.
> 
> Only if the topic branch didn't have a merge on it.
> 
>          -AA-- subtopic
>         /     \
>        A---B---C topic
>       /         \
>  D---E---F---G---H---I---J---K---L---M---N master
>                           \         /
>                            O---P---Q another-topic
> 
> 
> In the above example, the subtopic branch merge from AA to C prevents
> you from finding out what branch B is on using the original script.

When you say "the original script", are you talking about Artur's
one-liner or my script?

My script gives me exactly the information I want in all cases.  For a
given command $1 and a target branch $2, it shows you all merges that
were involved in bringing $1 into $2. For example:

  Called with "B" "master", it returns H
  Called with "AA" "master", it returns C, H
    (and that's good, because for someone asking "what was AA's original
     branch?" it's not clear if he will be more interested in topic or
     sub-topic, so show him both)
  Called with "F" "master", it returns nothing

The one limitation is that the result is empty both when $1 started on
$2, and when $1 is not reachable from $2 at all, in which case it should
probably error out (like when you call it with "F" "topic").  That's
easy to add as an additional check at the beginning of the script,
though.


The script works even in cases where you have a long-running topic
branch that is occasionally brought up to date with master, like this:


         F---G---H---I---J---O---P  topic
        /       /       /         \
   A---B---C---D---E---K---L---M---N---Q master


When called with "F" "master", it returns only N, but not H or J.
Exactly what I need.  (We have this kind of history a lot in our code
base.)

You could even call the script with "C" "topic" if you wanted to (in
which case it would return H, but not J).  It's not quite clear why you
would want to though.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
