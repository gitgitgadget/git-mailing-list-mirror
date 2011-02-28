From: Phil Hord <hordp@cisco.com>
Subject: Re: git-grep to operate across who repository and not just CWD?
Date: Mon, 28 Feb 2011 17:25:58 -0500
Message-ID: <4D6C20F6.3070905@cisco.com>
References: <AANLkTimnOSzF1o-fX-n7b26Qx2aLP3aU3pTMGY_f5hKy@mail.gmail.com> <4D6B6A8B.20709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Chanters <david.chanters@googlemail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 23:35:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuBgg-0005be-Ce
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 23:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab1B1WfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 17:35:25 -0500
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:61185 "EHLO
	rtp-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab1B1WfY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 17:35:24 -0500
X-Greylist: delayed 564 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Feb 2011 17:35:24 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1997; q=dns/txt;
  s=iport; t=1298932524; x=1300142124;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=NHetpxNu6+SV71rJkox4Ky34JfWDUqOn+JFATMSA4cs=;
  b=G2CEklfEd+OVdbizZgXhbwsVSxHVeK875s4yuYz98ACiRwNkrUE4ffU9
   pEfqyfCvvCsDzeIAr7twZpzbGXrWzj4bENrvIHTx7DbXgSfQmiMJnSqUi
   GrHu+7cIJqszornRSIwPHMqwursjq7vLWpInIymHc42jxiLPh2anIi3xR
   k=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAE+va01AZnwN/2dsb2JhbACmRXSgAZtjhWEEhQ+HDYM+
X-IronPort-AV: E=Sophos;i="4.62,242,1297036800"; 
   d="scan'208";a="221262231"
Received: from rtp-core-2.cisco.com ([64.102.124.13])
  by rtp-iport-2.cisco.com with ESMTP; 28 Feb 2011 22:25:59 +0000
Received: from [64.100.104.120] (dhcp-64-100-104-120.cisco.com [64.100.104.120])
	by rtp-core-2.cisco.com (8.13.8/8.14.3) with ESMTP id p1SMPxu1024500;
	Mon, 28 Feb 2011 22:25:59 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <4D6B6A8B.20709@drmicha.warpmail.net>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168156>

(cc list: Pardon this duplicate attempt)

On 02/28/2011 04:27 AM, Michael J Gruber wrote:
> David Chanters venit, vidit, dixit 28.02.2011 01:17:
>> > Hi all,
>> > 
>> > [ Please Cc me as I am not subscribed to this list, thanks. ]
>> > 
>> > I'm wondering if there's an easy way to get git-grep (and I suppose
>> > other commands which operate on a per-repository level rather than
>> > per-tree) to work across the whole repository?
> git grep -- $(git rev-parse --show-cdup)
>
> is the best we have right now. I think we're still looking for a good
> way to denote "root of repo" (like "." for cwd).
>
> Also, we're thinking of changing a few defaults (to repo-wide), but "git
> grep" is meant to stay close to ordinary grep.

But git grep is different than grep in exactly the "files selection"
area.  With grep, I always have to specify the files to search.  With
git-grep, I don't.

Oridinary grep with no paths fails (reads stdin), so when I make this
mistake it is always immediately evident. I retry the command with
paths/wildcards.  But git-grep with no path "works" and I am likely to
forget that it worked only on my $PWD.

git-grep also includes subdirectories and excludes untracked files by
default.  This makes git-grep feel like the "repository grep" tool that
it is. The fact that it does _not_ search from the top of the repository
by default seems (to me) to be the only oddball case.

I would be much more comfortable with David's proposed option turned on
always.  When I want to search "here", I can add a dot.

  git grep foo       # search the whole repository
  git grep foo -- .  # Search only from $PWD

Maybe it's dangerous as an always-on option, as it can break scripts. 
And I'd be happy-ish even with a --full-tree option.  But I think I
would eventually alias it so it always does what I expect.

I know that's not what the original question was, but it's the behavior
I often erroneously expect.

Thoughts?

Phil
