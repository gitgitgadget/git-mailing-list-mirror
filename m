From: Phil Hord <hordp@cisco.com>
Subject: Re: git push vs. slow connection times - local commit resolution
 is too late
Date: Sat, 16 Jul 2011 00:38:45 -0400
Message-ID: <4E2115D5.4010002@cisco.com>
References: <4E1EEDAA.1000204@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Sat Jul 16 06:40:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhwg1-0000kx-Pg
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 06:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110Ab1GPEit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 00:38:49 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:21567 "EHLO
	rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab1GPEis (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 00:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1985; q=dns/txt;
  s=iport; t=1310791129; x=1312000729;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=FueQBHQYxiR4EvNkZ4Uzsh3tc+8frcJKF7R3Ti5XWq0=;
  b=arNr+7wGdYkjBljTxesA5c0ubhF8bn/V0Tpa35NLxHIc7SGKejqy91m1
   bDoHSW0r4K1SxUlZrP6VwMIfhlAf09ANQOdb6ZMoIZZJG/VhXbhXBNUog
   PzcoTy6L0y//yBx2TDFd7iQGxe1BZ1y3KBM+0w9yNQWmYXd8ZZFhCaZl4
   g=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAIQVIU6rRDoI/2dsb2JhbABThEijKnetY40ckFiBK4QAgQ8EkmaFAYtw
X-IronPort-AV: E=Sophos;i="4.67,212,1309737600"; 
   d="scan'208";a="3510159"
Received: from mtv-core-3.cisco.com ([171.68.58.8])
  by rcdn-iport-7.cisco.com with ESMTP; 16 Jul 2011 04:38:47 +0000
Received: from [10.117.80.100] (rtp-hordp-8913.cisco.com [10.117.80.100])
	by mtv-core-3.cisco.com (8.14.3/8.14.3) with ESMTP id p6G4ck8c010525;
	Sat, 16 Jul 2011 04:38:46 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110627 Thunderbird/5.0
In-Reply-To: <4E1EEDAA.1000204@redhat.com>
X-TagToolbar-Keys: D20110716003845411
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177249>


On 07/14/2011 09:22 AM, Eric Blake wrote:
> I've been bitten several times by this bug now, so I'll report it in the
> hopes that someone knows what to do to patch it.
>
> Scenario - I have a remote repository that takes on the order of 10
> seconds to connect to, for any operation like 'git push'.  I know that
> there is a lag, so I intentionally have two terminals open, both
> visiting the same directory, one for interaction with the remote, and
> the other for acting on the local repository, with the hope that I can
> do useful work in the second terminal rather than idly waiting on the
> lag in the first terminal.
>
> In the middle of rebasing a patch series, where I want to incrementally
> push the patches that I have gotten through so far, I used the following
> steps:
>
> On the remote-interaction terminal, I push the current state of my tree:
> git push remote HEAD:master
>
> On the local-interaction terminal, I move on to the next patch:
> git rebase --continue
>
> then, to my horror, I find out that the commit I'm working on locally
> has already been pushed!  Why?  Because 'git push remote HEAD:master'
> does not determine which commit 'HEAD' refers to until _after_ it has
> established a connection to remote, but the stupid 10-second lag was
> long enough that my actions in my second terminal have changed HEAD in
> the meantime.
>
> I would really love it if 'git push' would resolve all local references
> _prior_ to trying to connect to the remote server, rather than waiting
> until after the connection.  That way, my remote-interaction terminal
> can truly be a type-it-and-forget-it terminal, where the push action I
> requested reflects the state of the tree at the time I requested it,
> rather than picking up changes made later in another terminal.

I agree with your suggestion.  But as a quick fix, can you do this?
   git push remote $(cat .git/HEAD):master

Damned inconvenient, though.

Phil
