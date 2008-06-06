From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Fri, 6 Jun 2008 02:26:54 +0200
Message-ID: <200806060226.57124.jnareb@gmail.com>
References: <940824.46903.qm@web31808.mail.mud.yahoo.com> <200806041603.49555.jnareb@gmail.com> <7vd4mw4dpp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 02:28:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4PoQ-0001un-RJ
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 02:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbYFFA1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 20:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754609AbYFFA1Q
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 20:27:16 -0400
Received: from gv-out-0910.google.com ([216.239.58.184]:32153 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436AbYFFA1P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 20:27:15 -0400
Received: by gv-out-0910.google.com with SMTP id e6so312374gvc.37
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 17:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=n/H1GXGd9fjB7mJzxSL+GXmAxhgweALCk6BKzmk0GNc=;
        b=CDE/3GRcNT/Do5Fvuf9wG62LcXGAGn/KRqS2Rr/XYJOtWUGv0+BOqxf0yE7J+/BpWM
         nMsiwNo/1KCbbQM7jIS1roZjFgmRQGmRp42SQK9lICsrApXx8VX7NcArEq7JOMVcOJgk
         tP7qnBRvwvIz+b0JYJBQFSK+9W7pCOwFu+jco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=uFLLxaM2pwaydLDGvTEMIq8Z8PXmXQLUsNCMw0s5MkJ5cZEo3QO4aRZNWL3gtDOQ5w
         cv2iYIAybJ3HBndHKG+5roiTAYWYxToujKuQ3S+XoHqJHLDS4weC9tvyMQYLJDYpVEy0
         kvC15c0SWr4NwzmY/NWlu+MugSkVjtc3QH6kE=
Received: by 10.103.207.11 with SMTP id j11mr1145820muq.47.1212712033355;
        Thu, 05 Jun 2008 17:27:13 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.208.97])
        by mx.google.com with ESMTPS id j2sm17171448mue.8.2008.06.05.17.27.07
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Jun 2008 17:27:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vd4mw4dpp.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84013>

On Tue, 5 Jan 2008, Junio C Hamano <gitster@pobox.com> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> On Wed, 4 Jun 2008, Junio C Hamano wrote:
>>>
>>> Yes, but the current scheme breaks down in another way.  When $full_rev
>>> added many lines to the file, and you are adding the link to for a line
>>> near the end of the file and such a line may not exist.  This cannot be
>>> cheaply done even inside blame itself.
>>
>> I think the scheme could be fixed by proposed below git-blame porcelain
>> format output extension.
> 
> For the line number information, I do not think so.

I think I have not made myself clear enough.  In the proposed additional
blame format extension "previous" header (or "pre-image" header, or sth
like that) would contain pre-image (before change) line number
information, or information that line was added in blamed commit.

> Luben's "continue from the same line number in the parent commit" is a
> cute hack, but that strategy needs a qualifying comment "because hoping
> that the same line number in the parent commit might have something
> relevant would be better than stopping and giving up sometimes."  It
> cannot reliably work (and it is not Luben's fault).

Therefore my proposal.  I'm not sure though if it can be done cheaply.
And Luben's idea is good enough in most cases; as a hint is definitely
good enough.

> But the #l<lno> fragment is just a hint to scroll to that point after
> restarting the blame from previous commit and jumping to the result, so it
> may not be too big a deal.  Such a line may not exist in the resulting
> blame page, but that's Ok.

Let me give an example on how I visualized proposed "pre-image" header
extension would work.

Assume that we started from commit 'S' and commit 'B' is to be blamed
for the line in question.  Let's us assume that commit 'B' has only
one parent, and that "context" diff between B^1 and B is available to
blame.  For an example, let's use [modified] example from GNU diff
documentation (info):

     diff --git-context a/lao-tzu b/lao-tzu
     index 55fb100..198772c 100644
     *** a/lao-tzu
     --- b/lao-tzu
     ***************
     *** 1,7 ****
     - The Way that can be told of is not the eternal Way;
     - The name that can be named is not the eternal name.
       The Nameless is the origin of Heaven and Earth;
     ! The Named is the mother of all things.
       Therefore let there always be non-being,
         so we may see their subtlety,
       And let there always be being,
     --- 1,6 ----
       The Nameless is the origin of Heaven and Earth;
     ! The named is the mother of all things.
     !
       Therefore let there always be non-being,
         so we may see their subtlety,
       And let there always be being,
     ***************
     *** 9,11 ****
     --- 8,13 ----
       The two are the same,
       But after they are produced,
       But after they are produced,
         they have different names.
     + They both may be called deep and profound.
     + Deeper and more profound,
     + The door of all subtleties!

First example: lets assume that we want find blame (annotation) for
the following line:
      "The named is the mother of all things."
Assuming that block of commonly blamed lines begin with given line,
current blame output would look like the following:

  <sha-1 of commit 'B'> <current-lineno> 2 <block-size>
  author A U Thor
  author-mail <author@example.com>
  author-time 1150613103
  author-tz -0700
  committer C O Mitter
  committer-mail <committer@example.com>
  committer-time 1150690754
  committer-tz -0700
  filename lao-tzu
  summary Be even more cryptic
  	The named is the mother of all things.

What I wanted to add was the following header

  parents <sha-1 of commit 'B^1'>
  pre-image 2 4 lao-tzu

where 2 is the line number in the commit given line is attributed to,
where 4 is the line number of _corresponding_ line in pre-image (before
change that gave examined line current form), and 'lao-tzu' is the name
of file of pre-image for this line.


Second example: lets assume that we want find blame (annotation) for
the following line:
      "The door of all subtleties!"

This time the line was added in the commit it is attributed to (commit
blamed for this line), so there is no corresponding pre-image line.
Extra headers would now look like the following:

  parents <sha-1 of commit 'B^1'>
  pre-image 13 - lao-tzu


Of course 'parents' and 'pre-image' headers can be joined together in
the 'previous' header you proposed.

>>> Another breakage is even though $full_rev^ _may_ exist (iow, $full_rev
>>> might not be the root commit), the file being blamed may not exist there
>>> (iow $full_rev might have introduced the file).  Instead of running
>>> "rev-parse $full_rev^", you would at least need to ask "rev-list -1
>>> $full_rev^ -- $path" or something from the Porcelain layer, but
>>> unfortunately this is rather expensive.
>>
>> Doesn't blame know revision graph for history of a given file already?
> 
> Not in the sense of "rev-list -2 $full_rev -- $path | sed -e 1d".  It
> builds the graph as it digs deeper, and when it stops, it stopped digging,
> so all it knows at that point without further computation is $full_rev^@,
> and not "the previous commit that touched the path".
> 
> But as Luben explained (and you drew a simple strand of pearls history to
> illustrate), immediate parent is just for the purpose of restarting the
> computation.

What I worry about is what happens in the (rare I think) case when
_merge_ commit is blamed, and firs-parent leg is simplified in the
"per-file" history.


For example if git-blame output for given line looks like below:

  64625efeb1f216c3811230845bb519123ea0ddc5 2 2 1
  author Jakub Narebski
  author-mail <jnareb@gmail.com>
  author-time 1212711688
  author-tz +0200
  committer Jakub Narebski
  committer-mail <jnareb@gmail.com>
  committer-time 1212711688
  committer-tz +0200
  filename foo
  summary Merge branch 'b' (Fullstop _and_ capitalization)
  	Second line.

and "git show 64625efeb1f216c3811230845bb519123ea0ddc5" is:

  commit 64625efeb1f216c3811230845bb519123ea0ddc5
  Merge: 288f63a... ec70d8b...
  Author: Jakub Narebski <jnareb@gmail.com>
  Date:   Fri Jun 6 02:21:28 2008 +0200
  
      Merge branch 'b' (Fullstop _and_ capitalization)

  diff --cc foo
  index 11c1e59,2636666..888af51
  --- a/foo
  +++ b/foo
  @@@ -1,3 -1,3 +1,3 @@@
    First line
  - second line.
   -Second line
  ++Second line.
    Third line.

What should be "previous" line then? Or perhaps there should be _two_
"previous" lines.

>>> Because blame already almost knows if the commit the final blame lies on
>>> has a parent, it would be reasonably cheap to add that "parent or nothing"
>>> information to its --porcelain (and its --incremental) format if we wanted
>>> to.
>>
>> It would be easy to add 'parents' header, perhaps empty if we blame
>> root commit, or a boundary commit (do we say 'boundary' then?) when
>> doing revision limited blaming.
> 
> It shouldn't be too hard to say "parents of the blamed commit that has the
> corresponding preimage of the file is this", and the history does not have
> to be limited.  You need to also handle "the commit that introduced the
> path" case just like "root" and "boundary" that we cannot dig further than
> that point.

Errr... do your code deal with that case (no path before blamed commit)?
 
> I'll follow this message up with two weatherballoon patches.

Thanks a lot. It looks like step in good direction (implementing first
proposal), with the caveat of attributed commit being evil merge.

-- 
Jakub Narebski
Poland
