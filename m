From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH 0/5] gitweb: Improve search code
Date: Wed, 22 Jun 2011 15:24:32 -0400
Message-ID: <4E024170.6000407@cisco.com>
References: <1308756535-29701-1-git-send-email-jnareb@gmail.com> <4E02220F.10800@cisco.com> <201106222000.04854.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 21:24:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZT2W-0004A8-Vm
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 21:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758493Ab1FVTYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 15:24:35 -0400
Received: from sj-iport-3.cisco.com ([171.71.176.72]:4853 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758056Ab1FVTYf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 15:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=4134; q=dns/txt;
  s=iport; t=1308770674; x=1309980274;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=1vvyzD8cq/n7xSng3+Mz6vDIu0pvwUeAXHYZNUfkYdY=;
  b=Z+2vVAuUhseIniBaEzQsabXopX0bRugzdpMkL06DB0VKM0lpgMmGOFk5
   jRl4mVnzMbALcAmMIcdaOTnzTuSl6bXUYAH+BiQpYwR5hdqZZmgbwSTkV
   2ScVYbFLZXMPVPNPwySGXe7+jNKw6XLwvg+7jw9AVHPEe1sl8Y9BLPsqK
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EADNBAk6rRDoG/2dsb2JhbABOBqcRd4hzojaeQIM5gnQEkWqEZYtD
X-IronPort-AV: E=Sophos;i="4.65,407,1304294400"; 
   d="scan'208";a="344325547"
Received: from mtv-core-1.cisco.com ([171.68.58.6])
  by sj-iport-3.cisco.com with ESMTP; 22 Jun 2011 19:24:34 +0000
Received: from [10.117.80.99] (rtp-hordp-8912.cisco.com [10.117.80.99])
	by mtv-core-1.cisco.com (8.14.3/8.14.3) with ESMTP id p5MJOWuw022350;
	Wed, 22 Jun 2011 19:24:33 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <201106222000.04854.jnareb@gmail.com>
X-Enigmail-Version: 1.1.2
X-TagToolbar-Keys: D20110622152432307
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176251>


On 06/22/2011 02:00 PM, Jakub Narebski wrote:
> On Wed, 22 Jun 2011, Phil Hord wrote:
>> On 06/22/2011 11:28 AM, Jakub Narebski wrote:
>>> P.S. Another addition that I sometimes wanted git to have would be
>                                                   ^^^
>
> This is a typo: I actually wanted to say "gitweb" here.
>
> Therefore this discussion is totally OFF-TOPIC now.
Dang.

>> I normally revert to 'git log --name-status | less <CR> /filename.foo',
>> which is awful, of course.  I've always assumed there's a better way I
>> haven't discovered yet.  But if there is, well... I haven't discovered
>> it yet.
>>
>> This syntax works on some files, but is limited and/or broken:
>>    # Finds all commits touching the file named './foo.bar', iff
>> ./foo.bar exists in the current commit.
>>    git log -- foo.bar
> Errr... if you use "git log foo.bar" it is true, but "git log -- foo.bar"
> will find commits even if foo.bar existed only in the past... though
> history simplification can make git return empty set.

That doesn't work for me.  Does it work for you?  I only see the
gitweb.pl history if I include --full-history.

    git version
    #-- git version 1.7.5.rc1

    git log -- gitweb.pl | wc
    #--   0       0       0

    git log --full-history -- gitweb.pl | wc
    #--    175     412    4087


>> I say 'broken', but maybe it's not; it feels like it is when I do this:
>>
>>    # Returns zero logs
>>    git log -- some-deleted-file.txt
>>
>>    # Returns at least two logs
>>    git log --all -- some-deleted-file.txt
>      git log --full-history -- some-deleted-file.txt
>

Thanks very much.  That is exactly what I was missing.

I obviously didn't know about --full-history.  I didn't notice it in
spite of looking for this before and consulting 'git help log'.  So I'm
guessing the documentation could use some help there.  It's already
pretty crowded, though.  Maybe just a note next to '--all' which, for
me, served as a distractingly red herring.

> For example in git.git repository:
>
>    $ # git log --full-history --oneline -- gitweb.pl | cat
>    2ad9331 v053
>    185f09e v049
>    ff7669a v048
>    fbb592a v043
>    [...]
>    e0389bd v001
>    ecb378f v000
>    4c02e3c v000
>    161332a first working version
>
> (Don't you just love Kay Sievers commit messages ;-) ?).
>
>> I think I understand why that happens (search optimization), but it is
>> unexpected from the user's perspective.  I also suspect it will miss the
>> 'pre-resurrection' commits for files which were deleted and resurrected
>> in the past.
>>
>>
>> What do you think of these as new 'Commit limiters' for git log:
>>
>>        --name=<pattern>, --name-glob=<glob>
>>            Limit the commits output to ones touching files that match the
>>            specified pattern (regular expression) or glob (shell glob
>>            pattern).
> Why not use "git log --full-history -- '<glob>'" (i.e. remember about
> shell escaping glob)?  I don't know if it works as intended in current
> git or not...
>

I think that'll work fine.  But glob paths failed for me when I tried it
while composing the original email.  I think I just mis-interpreted the
reason for the missing commits when I didn't have --full-history.

Also, globbing is not mentioned in the '[--] <path>' section of 'git log
--help'.  In fact, the only references to globs in the 'git log' help
[1] are related to refs, not filenames.  Ditto for 'git rev-list'.

I initially expected "git log -- 'foo.*'" to work.  But it didn't (foo.*
had been deleted) or it only partially worked (no --full-history).  So I
interpreted this as it being only partially supported.  I did consult
the man page, but it did not do anything to correct my wrong
interpretation.  A now-enwisened google search turned up a thread [2]
from 2009 apparently pre-dating this feature.

Thanks again for the education, Jakub.  I really appreciate how helpful
this list is.

[1] excepting '-O'
[2] http://article.gmane.org/gmane.comp.version-control.git/109506/


Phil
