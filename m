From: Evan Phoenix <evan@fallingsnow.net>
Subject: Re: [PATCH] A more sensible error message why 'git rebase --continue' failed
Date: Mon, 20 Aug 2007 00:10:10 -0700
Message-ID: <2D8BF484-7990-4DDC-9E52-69143D4BA413@fallingsnow.net>
References: <11875724181583-git-send-email-evan@fallingsnow.net> <7vzm0m90ye.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 09:45:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN1wa-0002rm-A4
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 09:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbXHTHop (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 03:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbXHTHop
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 03:44:45 -0400
Received: from [67.43.164.194] ([67.43.164.194]:39764 "EHLO
	hoshi.fallingsnow.net" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbXHTHoo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 03:44:44 -0400
X-Greylist: delayed 2067 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Aug 2007 03:44:44 EDT
Received: from cpe-76-170-39-112.socal.res.rr.com ([76.170.39.112] helo=[192.168.1.103])
	by hoshi.fallingsnow.net with esmtpa (Exim 4.61)
	(envelope-from <evan@fallingsnow.net>)
	id 1IN1Oy-00055c-A9; Mon, 20 Aug 2007 00:10:16 -0700
In-Reply-To: <7vzm0m90ye.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56185>


On Aug 19, 2007, at 11:25 PM, Junio C Hamano wrote:

> Evan Phoenix <evan@fallingsnow.net> writes:
>
>> The current message is a bit cryptic, indicating that only
>> changes which contained merge conflicts should be added to the
>> index, but in fact, all outstanding changes must be.
>
> That might be true, and we might want a better yet still concise
> wording for the suggestion.
>
>
> Your wording, however, would lead a new user to run "git add"
> even before resolving the conflicts, and then make him complain
> "why doesn't git do that for me", and then again complain "gaah,
> I followed the suggestion and ended up committing garbage with
> funny <<< === >>> lines in it".

Hm, a good point.

How about something like

"Please verify all merge conflicts in all modified files, then run
'git add' to resolve them."

Or perhaps the behavior of rebase needs to be altered a bit
here. 'git ls-files -u' can detect there exists outstanding, unmerged
files. If those still exist, it should certainly stop outright. But,
it seems to me that if there are no unmerged files and still just
normal modified ones (git ls-files -m), 'git rebase --continue' should
be able to run 'git add -u' for the user.

Outside that, I do agree that the wording should be more stern about
checking all modified files before running 'git add'.

>
> So in that sense, I do not necessarily see _your_ new wording an
> improvement.
>
>> @@ -135,8 +135,12 @@ do
>>  	case "$1" in
>>  	--continue)
>>  		git diff-files --quiet || {
>> -			echo "You must edit all merge conflicts and then"
>> -			echo "mark them as resolved using git add"
>> +                        echo "Unable to continue rebase:"
>> +                        echo "  All modified files must be added  
>> to index first."
>
> Also I see whitespace breackages here --- did you intend to
> replace tabs with spaces, and if so why?

A mistake on my part. I sent in a new patch eariler but ended up having
mail server troubles. I've already got a new version that keeps the
tabs as they should be. The next version will be proper.

  - Evan Phoenix / evan@fallingsnow.net
