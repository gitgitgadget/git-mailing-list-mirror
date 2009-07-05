From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Wrong file diff for merge conflict
Date: Sun, 05 Jul 2009 12:22:22 -0700 (PDT)
Message-ID: <m3vdm7ue8k.fsf@localhost.localdomain>
References: <loom.20090704T072854-229@post.gmane.org>
	<alpine.LFD.2.01.0907051113240.3210@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Bucur <stefan.bucur@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 05 21:22:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNXIG-0008IY-I0
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 21:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbZGETWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 15:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752554AbZGETWV
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 15:22:21 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:56757 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbZGETWV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2009 15:22:21 -0400
Received: by fxm18 with SMTP id 18so3430691fxm.37
        for <git@vger.kernel.org>; Sun, 05 Jul 2009 12:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=rYwDfmNasneMdwpvmmcdHNSh6lj6MHI45kw11QTXvmI=;
        b=GVcrOBJJeD019ZwuRf/mVQIn/6WJZsY6YPcZGK1p+6LZK91PlzFE3iPB66lhkp0hLI
         1v7OblFIyevZ2cyfHB7XxVU+hMjPXW9plM+tyHH7EuEIHtXHRatKj8ZtjRxL7XmIwW12
         MqNVGsL4/MUa5weTagXTrqW9seE3gunpoA9Mg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=OZn+OGc1w+ywC2MT8gAvdaBcchyBWHpv8Rhb7YRPXQoeOfEIjeAp2cxIJh+LtLL3it
         egCwmCYhihIfnbfc3mQNpr3Ddd9MnNImJJ8LfJbanjjAq745yswQj/g1J12g2X1iFM3w
         TEbX9io6cKFUEceUr2kT8FJhX3DtAcJOYiTYU=
Received: by 10.103.167.14 with SMTP id u14mr2113857muo.81.1246821742926;
        Sun, 05 Jul 2009 12:22:22 -0700 (PDT)
Received: from localhost.localdomain (abvj223.neoplus.adsl.tpnet.pl [83.8.207.223])
        by mx.google.com with ESMTPS id 7sm29433622mup.24.2009.07.05.12.22.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Jul 2009 12:22:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n65JMMGU019284;
	Sun, 5 Jul 2009 21:22:22 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n65JMKIo019281;
	Sun, 5 Jul 2009 21:22:20 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LFD.2.01.0907051113240.3210@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122751>

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Sat, 4 Jul 2009, Stefan Bucur wrote:
> > 
> > http://pastebin.ca/1483228
> > 
> > The problem is with the last diff in the file, where the left portion is empty,
> > and the right portion contains code which already was marked as merged (common),
> > right before the start of the diff. Therefore, the mark at line 127 should
> > really have been before line 114.
> > 
> > Is this a bug or I am missing something?
> 
> I suspect (but without the origin files/history I can't verify) that what 
> happens is that the "successfully merged" code was seen as a fully new 
> snippet of code (probably due to getting re-indented?), and the other part 
> of that action on that branch was the removal of the old code.
> 
> That _removal_ is then shown as a conflict against the other branch, which 
> presumably didn't re-indent things (of course, it could be exactly the 
> other way around too), and so now you end up having the "conflict" being 
> seen as "one branch removes this code (empty conflict part), the other one 
> presumably changed it some way".
> 
> Is that what you wanted? Obviously not. To you, the conflict makes no 
> sense. You're a human, who tries to understand what wen't wrong, and to 
> you, the end result of the conflict resolution makes no sense.

[...]
>  - Don't rely so heavily on just the traditional three-way merge result.
> 
>    This is what I personally do. The trivial 3-way merge result is 
>    wondeful for the truly trivial merges, when it gives trivial results 
>    that are easy to fix up. But let's face it, the traditional 3-way merge 
>    result just sucks for anything more complicated. When you have an empty 
>    side on one of the conflicts, is that because the other side added 
>    everything, or is it because oen side removed it? Or is it, like in 
>    this case, simply because trivially similar lines got the whole diff 
>    confused about which parts didn't change at all?
> 
>    The good news is that git does have a few nice merge tools. One is 
>    "git diff", which actually shows way more than the trivial three-way 
>    end result, in that you can diff against either side, and by default it 
>    does that fairly complex "diff against both sides" thing that is also 
>    quite useful once you get used to it.
> 
>    Another is "gitk --merge [filename]" which is wonderful as a tool to 
>    see what both sides actually did, to figure out what the intent of both 
>    branches were when the three-way merge result is just noise.

There is also "git mergetool" which runs graphical merge tool of your
choice.  It can be easier to work with GUI here.


And git also supports diff3 conflict merge markers, which shows our
and their side, and also the ancestor side; in your case it would make
easy to distinguish between 'one side added' and 'other side removed'.
You can get it using 

  $ git checkout --conflict=diff3 <file>
 
(where <file> can be '.').  You would need modern git (post 1.6.2
I think) for that.

> The right answer is probably some combination of "all of the above". In 
> the meantime, right now, only the last one is something git itself will 
> help you with.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
