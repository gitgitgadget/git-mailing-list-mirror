From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-grep to operate across who repository and not just CWD?
Date: Tue, 01 Mar 2011 09:05:11 +0100
Message-ID: <4D6CA8B7.5000608@drmicha.warpmail.net>
References: <AANLkTimnOSzF1o-fX-n7b26Qx2aLP3aU3pTMGY_f5hKy@mail.gmail.com> <4D6B6A8B.20709@drmicha.warpmail.net> <4D6C20F6.3070905@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Chanters <david.chanters@googlemail.com>, git@vger.kernel.org
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 09:08:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuKdO-0001pU-EW
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 09:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755079Ab1CAIIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 03:08:37 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40662 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751519Ab1CAIIg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 03:08:36 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D2E1620627;
	Tue,  1 Mar 2011 03:08:35 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 01 Mar 2011 03:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=NhvrANsBLo1SDDRmhmCrH8S/+jk=; b=lN3zb1JYE2PNFoznVf6F5dLN+u/KgXnJa8ykhBGHv6zk26O9OINZM5tS3yZwRizendLxArLgJGVohL13BAumynBP7E5EHLyvBoS7q/tPuII6j1Ng5RTemq4RaKq2rsm82mzKDfaZCJFCCli6dNzMLBsbZCRosabt29GQ7w4OnCU=
X-Sasl-enc: aceztk/9V0jwbNSq36MGkrcFWVTuJoZplNXH7n4pBbN7 1298966915
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4422E445D02;
	Tue,  1 Mar 2011 03:08:35 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <4D6C20F6.3070905@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168188>

Phil Hord venit, vidit, dixit 28.02.2011 23:25:
> (cc list: Pardon this duplicate attempt)
> 
> On 02/28/2011 04:27 AM, Michael J Gruber wrote:
>> David Chanters venit, vidit, dixit 28.02.2011 01:17:
>>>> Hi all,
>>>>
>>>> [ Please Cc me as I am not subscribed to this list, thanks. ]
>>>>
>>>> I'm wondering if there's an easy way to get git-grep (and I suppose
>>>> other commands which operate on a per-repository level rather than
>>>> per-tree) to work across the whole repository?
>> git grep -- $(git rev-parse --show-cdup)
>>
>> is the best we have right now. I think we're still looking for a good
>> way to denote "root of repo" (like "." for cwd).
>>
>> Also, we're thinking of changing a few defaults (to repo-wide), but "git
>> grep" is meant to stay close to ordinary grep.
> 
> But git grep is different than grep in exactly the "files selection"
> area.  With grep, I always have to specify the files to search.  With
> git-grep, I don't.
> 
> Oridinary grep with no paths fails (reads stdin), so when I make this
> mistake it is always immediately evident. I retry the command with
> paths/wildcards.  But git-grep with no path "works" and I am likely to
> forget that it worked only on my $PWD.
> 
> git-grep also includes subdirectories and excludes untracked files by
> default.  This makes git-grep feel like the "repository grep" tool that
> it is. The fact that it does _not_ search from the top of the repository
> by default seems (to me) to be the only oddball case.
> 
> I would be much more comfortable with David's proposed option turned on
> always.  When I want to search "here", I can add a dot.
> 
>   git grep foo       # search the whole repository
>   git grep foo -- .  # Search only from $PWD
> 
> Maybe it's dangerous as an always-on option, as it can break scripts. 
> And I'd be happy-ish even with a --full-tree option.  But I think I
> would eventually alias it so it always does what I expect.
> 
> I know that's not what the original question was, but it's the behavior
> I often erroneously expect.

I would love "git grep" to be repowise, with the simple "git grep ." to
make it relative to cwd. We've discussed making more commands repowise,
and the consensus (which I've stated above, accepting the majority vote)
was that some should stay, e.g. git-grep. The discussion started with

<http://permalink.gmane.org/gmane.comp.version-control.git/166135>

and the consensus is stated here:

<http://permalink.gmane.org/gmane.comp.version-control.git/167149>

This does not prevent you from submitting a "--full-tree" patch for
git-grep, of course.

Michael
