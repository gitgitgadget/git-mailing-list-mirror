From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 12:35:33 +0100
Message-ID: <200704171235.34793.andyparkins@gmail.com>
References: <200704171041.46176.andyparkins@gmail.com> <7v7isbpb0p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 13:35:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdlyM-0002gy-Hb
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 13:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832AbXDQLfn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 07:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753857AbXDQLfm
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 07:35:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:28924 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832AbXDQLfl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 07:35:41 -0400
Received: by ug-out-1314.google.com with SMTP id 44so143703uga
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 04:35:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eMHpxVDYMGM64TF1CEa8v+/MHwStFoRmxc5F2fdGBrD9QYdzvP6rjynIXX8+ujOni5AAMGffckctxYtsPKj6STziC7uZ+iowRQWWJSYL3plMRQqkG1nJ9I/58GqCebKpWjmVMGbnC7fpYyT2O6KihhZgzJ+BtUs8tQPxB+SaSD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JBiqU4q2P6Z9yGqZ3KHZQpiRAN4xb+cKEaLpnMSl9C0aQG8WTSrodIbwK10UquLAMjCnMJPWETuPHWiN5/9QhUh1f3Ay2hBxgPgB/XL0ywCShmy4Q9zX/sKKeTA8HLZtEywSpE4YD3RcZqpCcn6c75SB3FPCoyg+l5wy/EJWrvI=
Received: by 10.82.138.6 with SMTP id l6mr10176281bud.1176809739162;
        Tue, 17 Apr 2007 04:35:39 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id c24sm15595404ika.2007.04.17.04.35.37;
        Tue, 17 Apr 2007 04:35:38 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <7v7isbpb0p.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44762>

On Tuesday 2007 April 17 11:09, Junio C Hamano wrote:

> In http://article.gmane.org/gmane.comp.version-control.git/44654,
> Linus said:
>     And *I* claim that if you don't get an immediate and empty diff, your
>     system is TOTALLY BROKEN.

Well that one is easy - the file is normalised to contain collapsed keywords 
upon checkin, so diff works the same as it ever did.  The output would be 
immediate and empty so is not TOTALLY BROKEN.

> 	$ git checkout B
>
> 	should be immediate and instantaneous.

Now - that's a much better argument.  However, it's not relevant, keywords (in 
other VCSs, and so why not in git) are only updated when a file is checked 
out.  There is no need to touch every file.  It's actually beneficial, 
because the keyword in the file is the state of the file at the time it was 
checked in - which is actually more useful than updating it to the latest 
commit every time.

That means you're only ever expanding in a file that your changing anyway - so 
it's effectively free.  git-checkout would still be immediate and 
instantaneous.

> If you try to keyword expand commit id, date or anything that is
> sensitive to *how* you got there, even though A and B have the
> exact same set of blobs, you have to essentially update all of
> them.  Computing what to expand to takes (perhaps prohibitively
> expensive) time, but more importantly rewriting the whole 20k
> (or howmanyever you have in your project) files out becomes
> necessary, if your keyword expansion wants to say "oh, this file
> was taken from a checkout of branch B", for obvious reasons.

Ignoring the fact that expansion is only when a file is checked out; I'd argue 
that it's your own fault if you enable keyword expansion on twenty thousand 
files.  A lot of the discussion has been about how useless keyword expansion 
is in almost every case.  I only want it for a few files in my repository; so 
am willing to pay the small computing cost.  Obviously keywords would be 
disabled by default - in which case, you get what you deserve if you enable 
them on everything.

Putting my own selfish requirements aside, from a purely "mine is better than 
yours" point of view, git can't do something that CVS (in all it's 
horridness) can.  It's distinctly off-putting to people when they 
say "keyword expansion", that the response is "YOU'RE AN IDIOT - GO AWAY - 
YOU DON'T DESERVE TO USE GIT"; and back they'll scurry to CVS/subversion.

> Keyword expanding blob-id, or munging line-endings to CRLF form
> on platforms that want it, do not have this problem, as how you
> reached to the blob content does not affect the result of
> expansion, therefore not just the blobs in commit A and commit B
> but the working tree checked out of them must match with each
> other.

That's true - however, even if the only keyword git supports is $BlobID$, that 
would address a large proportion of people's needs.  As I said above though, 
the keywords are only expanded on checkout (and checkin to be consistent).

> Having reiterated what Linus already said why keyword expansion
> and git are not friendly with each other (perhaps the reason is
> because the former is stupid and git is smart), I'd try to be a

(This is were my "YOU'RE AN IDIOT - YOU CAN'T USE GIT" alarm goes off).  Git 
is better than CVS/subversion in every respect - save this one.  It's almost 
completely free to do (apart from the initial coding of it of course) because 
of these two factors:
 - The keywords are collapsed in the repository
 - The keywords are only expanded on checkout
It doesn't fundamentally alter anything that git does right now.

>  * We do not do the borrowing from working tree when doing
>    grep_sha1(), but when we grep inside a file from working tree
>    with grep_file(), we do not currently make it go through
>    convert_to_git() to fix line endings.  Maybe we should, if
>    only for consistency.

I'd actually argue not - git-grep searches the working tree.  The expanded 
keywords are in the working tree.  Take the CRLF case - I'm a clueless user, 
who only understands the system I'm working on.  I want to search for all the 
line endings, so I do git-grep "\r\n" - that should work, because I'm 
searching my working tree.

>  * We do not currently run convert_to_git() on the patch text
>    given to git-apply; we could do so in parse_single_patch().

Yep - definitely; the applied patch should certainly be normalised before 
application.  I'd have to add it if I wanted keywords anyway wouldn't I?



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
