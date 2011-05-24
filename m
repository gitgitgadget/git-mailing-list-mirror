From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: combined diff does not detect binary files and ignores -diff
 attribute
Date: Tue, 24 May 2011 18:38:36 +0200
Message-ID: <4DDBDF0C.2040708@drmicha.warpmail.net>
References: <BANLkTi=FtkiUjwAa7e3KAC5FF3GNxWzd3Q@mail.gmail.com> <4DDA618E.4030604@drmicha.warpmail.net> <BANLkTinu3AbTmtswn6DLQKAWdLL=gBvAqA@mail.gmail.com> <20110523181147.GA26035@sigill.intra.peff.net> <20110523201529.GA6281@sigill.intra.peff.net> <BANLkTikvPjO=bbhAoPCftdXzGSYtryNvzw@mail.gmail.com> <20110523234131.GB10488@sigill.intra.peff.net> <7v39k4aeos.fsf@alter.siamese.dyndns.org> <4DDB5C0F.1080102@drmicha.warpmail.net> <7vsjs48616.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 18:38:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOud5-0007Km-4l
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 18:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756042Ab1EXQil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 12:38:41 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:60470 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753413Ab1EXQil (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2011 12:38:41 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7340920A28;
	Tue, 24 May 2011 12:38:40 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 24 May 2011 12:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=duhBPYAKklO3Lf1bXQ47qir+Y+I=; b=pJjUgZo/xdsMAI09gtLtpTAv+ufUblRAy2UQMU3XYu7wsnLCcBNvdU5XZ0a2z8taD9Xzj12h1daoQslRL4Gi5xxQIUkyybYGa5BwPA+rhocbG0ygaHsiJHVkg3TfZEKgU16EWsicRDf+1indMvUFnbU0tkPI85q4QB0N9X+L74E=
X-Sasl-enc: kRF7uCXIPs4Oz/+K5IiOpgJJyWXAcekhQIn2kkzSZtMz 1306255120
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 64C39400AB3;
	Tue, 24 May 2011 12:38:38 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <7vsjs48616.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174328>

Junio C Hamano venit, vidit, dixit 24.05.2011 17:36:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Jeff, thanks a bunch for taking this up again! That's a great
>> improvement. (I'm not sure I can devote enough time to reviewing, but
>> I'll see.)
> 
> Thanks. I've given a cursory look at the rest of the series (including the
> addendum to be squashed in) and they seemed Ok. Will give it another round
> of eyeballing before merging to "next".
> 
>>> I however highly doubt that such an interface would make sense. For
>>> example, what would be the desirable format to compare three versions of
>>> "What's cooking" postings, and how would the updated compare-cooking.perl
>>> script would look like?
>>
>> Yeah, currently --cc with external makes no sense, but there are several
>> external tools which could present a 3-way diff in a useful way (or even
>> n-way with n>3), e.g. vimdiff, kdiff3, meld.
> 
> With an external command that can make 3-way diffs of arbitrary three
> directories, you can trivially do something like:
> 
> 	#!/bin/sh
> 	mkdir tmp-head tmp-index &&
>         ( cd tmp-head &&
>           GIT_DIR=../.git GIT_INDEX_FILE=$GIT_DIR/.index-head &&
>           git checkout -f HEAD
> 	) &&
>         ( cd tmp-index &&
>           GIT_DIR=../.git &&
>           git checkout -f .
> 	) &&
>         $ext_diff3_cmd tmp-head/ tmp-index/ . &
>         wait
>         rm -fr tmp-index tmp-head
> 

and the fancy version of that is "difftool" in a sense, yes.

> But that seems totally offtopic and has nothing to do with the "combined
> diff" discussion, no?

Well, it seemed that Jay wanted an external tool for merge diffs. "-m"
does a series of simple 2way diffs, but "--cc" is special in that it
looks at all diffs at once, so a corresponding external tool would have
to do the same.

> If you want to plug in an external command that can make n-way diff of n
> files when some paths are still shown using the usual --cc codepath, then
> you would need an interface totally different from the diff.<driver>.cmd
> interface for two-way diff to the external diff.  I pointed at where to
> plug such a thing, but I do not think it would be of much use unless you
> are handing the whole n-trees to the external command (which essentially
> is what the above outline does). How would the user read the output that
> comes out mixed from different codepaths, some from our own --cc while
> others come from the external command, possibly opening separate windows
> and even worse grabbing control and getting the caller stuck until the
> user closes that window?

I don't quite follow, I think I/we/? am/are mixing external diff drivers
and difftools. I agree that is a side track/off-topic.

> 
> 	Side note: about getting stuck, will we see an update to the
> 	diffstat count series by the end of this cycle? I do not mind
> 	carrying it over to the next cycle at all, but I'd rather see
> 	something already started gets finished.

Yes, on my list. End of month you said, right?

>> When the --cc/textconv issue came up I looked into this, and maybe
>> difftool is a place where one could plug this in first in the sense of
>> refactoring that even more and providing a diff3tool or such to view a
>> merge commit (or compare any 3 versions), or/and provide "git diff3 A B
>> C" which creates a fake merge (A+B -> C).
> 
> You do not need "git diff3 A B C" for a fake merge.
> 
> 	$ git diff 61d7503d 2d22086 5bf29b9
> 
> already is a way to show you how the commit 61d7503d was created by
> merging the other two (the merge result comes first and then its parents).

Yes. (I came across this when I investigated a bit back then but failed
to mention it.)

> You could put the index into the mix by doing something like:
> 
> 	$ git diff next master $(git write-tree)
> 
> Trying to show combined diff to merge the index and the working tree into
> the current HEAD (which may be an example that does not make much sense)
> would look like this:
> 
> 	$ git diff HEAD $(git write-tree) $(
> 		git read-tree --index-output=.tmp-index HEAD &&
> 		GIT_INDEX_FILE=.tmp-index git add -A :/ &&
>                 GIT_INDEX_FILE=.tmp-index git write-tree
> 	)
> 
> But for the "working tree" set, which paths should be included? The same
> set as what is in the index? Or would we use the set that is the union of
> other tree-like things that are being compared, including the ones that
> are not in the index? Or everything in the working tree, as we are
> interested in what the user _could_ add?  That is one of the reasons why I
> do not think it makes much sense trying to throw the working tree into the
> picture, as it would have to open a large can of worms.

I've simply been drooling too much over vim-fugitive and was wondering
which aspects would fit into our ui. I was thinking of a 3-way-diff
version of git status, so to say. Next would be a 3-way-merge interface
which does all your add/reset/checkout -p from 3 vim bufs in diff mode,
which even vim-fugitive doesn't do. We can all dream, can't we?

Michael
