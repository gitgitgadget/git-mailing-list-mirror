From: Mathias Nyman <m.nyman@iki.fi>
Subject: Re: [PATCH] contrib/subtree: add repo url to commit messages
Date: Thu, 3 Mar 2016 13:42:22 +0200
Message-ID: <20160303114222.GA9814@iki.fi>
References: <20160223102559.GA18668@iki.fi>
 <CAPig+cSwQmbvZYbk3T-XYDfMYaMdJ=bFbDwEUtaR121pBrYJOQ@mail.gmail.com>
 <20160226082828.GA5960@iki.fi>
 <CAPig+cRTz_VYt-2q9y0+COhVCezMs-7Sm-v=jvhUxUSRhiN93g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Nicola Paolucci <npaolucci@atlassian.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 12:42:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abReR-0006gQ-K7
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 12:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757561AbcCCLm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 06:42:29 -0500
Received: from mail.kapsi.fi ([217.30.184.167]:39682 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754829AbcCCLm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 06:42:28 -0500
Received: from lakka.kapsi.fi ([2001:1bc8:1004::1] ident=Debian-exim)
	by mail.kapsi.fi with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <lem@kapsi.fi>)
	id 1abReA-00025m-Ae; Thu, 03 Mar 2016 13:42:22 +0200
Received: from lem by lakka.kapsi.fi with local (Exim 4.80)
	(envelope-from <lem@lakka.kapsi.fi>)
	id 1abReA-00045E-6z; Thu, 03 Mar 2016 13:42:22 +0200
Content-Disposition: inline
In-Reply-To: <CAPig+cRTz_VYt-2q9y0+COhVCezMs-7Sm-v=jvhUxUSRhiN93g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:1bc8:1004::1
X-SA-Exim-Mail-From: lem@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288170>

On 2016-02-26 14:49-0500, Eric Sunshine wrote:
>On Fri, Feb 26, 2016 at 3:28 AM, Mathias Nyman <m.nyman@iki.fi> wrote:
>> On 2016-02-25 17:23-0500, Eric Sunshine wrote:
>>> On Tue, Feb 23, 2016 at 5:25 AM, Mathias Nyman <mathias.nyman@iki.fi>
>>> wrote:
>>>> -       cat <<-EOF
>>>> -               $commit_message
>>>> -
>>>> -               git-subtree-dir: $dir
>>>> -               git-subtree-mainline: $latest_old
>>>> -               git-subtree-split: $latest_new
>>>> -       EOF
>>>> +       echo $commit_message
>>>> +       echo
>>>> +       echo git-subtree-dir: $dir
>>>> +       echo git-subtree-mainline: $latest_old
>>>> +       echo git-subtree-split: $latest_new
>>>
>>> It's not clear why this code was changed to use a series of echo's in
>>> place of the single cat. Although the net result is the same, this
>>> appears to be mere code churn. If your intention was to make it
>>> similar to how squash_msg() uses a series of echo's, then that might
>>> make sense, however, rejoin_msg() uses the same single 'cat' as
>>> add_msg(), so inconsistency remains. Thus, it's not clear what the
>>> intention is.
>>
>> Using a mixutre of heredoc and echo felt messy. But I'll change it
>> back to heredoc here, and through out the commit aim for near-zero
>> refactoring.
>
>An alternative would be to have a preparatory patch which unifies the
>heredoc vs. echo issue across add_msg(), squash_msg(), rejoin_msg(),
>but I wouldn't insist upon it (that's just more work for you). Leaving
>this bit alone is a reasonable choice.
>
>>>> +       repo="$4" # optional
>>>>         newsub_short=$(git rev-parse --short "$newsub")
>>>> -
>>>> +
>>>
>>>
>>> Okay, this change is removing an unnecessary tab. Perhaps the commit
>>> message can say that the patch fixes a few whitespace inconsistencies
>>> while touching nearby code.
>>
>> Will undo the whitespace fixing.
>
>Oh, I wasn't insisting that you should undo the whitespace fix.
>Typically, you'd make such fixes in a preparatory cleanup patch, but
>since there are only two cases here that you've fixed, it probably
>wouldn't hurt to retain them (if that's all there are in the file).
>The reason I suggested mentioning the whitespace fixes in the commit
>message is to let the reviewer know that they weren't cases of you
>accidentally making unwanted whitespace changes (like inserting tabs
>rather than removing them). As it was, as a reviewer, I had to go
>through extra effort to determine whether you had made a fix or had
>accidentally botched something.
>

Not fixing any whitespace inconsistencies felt like the consistent way to
go in this commit.

Would be great to have some feedback on the core idea of this change,
before spending more time on it. Anyone?

>>>>  cmd_merge()
>>>>  {
>>>> -       revs=$(git rev-parse $default --revs-only "$@") || exit $?
>>>> +       revs=$(git rev-parse $default --revs-only "$1") || exit $?
>>>
>>> Why is this variable still named 'revs' (plural) since you're only
>>> passing in $1 now rather than $@?
>>
>> Because technically the result can still be more then one rev I guess.
>> Consider 'git rev-parse HEAD~1..HEAD', which would return two hashes.
>
>Okay, so I was missing something obvious.
