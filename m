From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree
 new"
Date: Tue, 30 Jun 2015 18:32:54 -0400
Message-ID: <55931916.9030908@gmail.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com> <CAPig+cT0a201MVTsvvLrndr40GsMkyvtao33Gt=AFhvShtr=Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 01 00:33:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA45V-0002Vp-P0
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 00:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716AbbF3WdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 18:33:05 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36818 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbbF3WdB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 18:33:01 -0400
Received: by ykdr198 with SMTP id r198so22968563ykd.3
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 15:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=c7NLyrCUNX6+XpAziuUjh3pxJcI8iZ3NczIW6oCVzIY=;
        b=iDV/8DAtlgGEwaXndI13PIGj7SC/D8kHurD0xTB/m982ROAaTsVznfpRBoU4oOudg9
         ymcrD74SkgctZ/8cD6OS7fNfDMD6/bb80zaMABDYOHGLSMEd271z5xg5D7lLgL7uTgxy
         8eWCyfaOIPqYS9138+H1EUA/QpU+Zg6siTRgZ1BQwO8iB8dpEGlulnZCrXiNwHr6nd5m
         yfvv6T0FBw5cxtu6fTXvkGt9/Eb6fv26/fCS4VsI/YAP51E/XXB4t0Cg4MnojORAkB60
         LdbuUP+gjIG2LWnUYD/nb/nk2VYwJvxsprNSeasx5k1IG3CrnaLLaKsAOnWOWaepjGOk
         Opyw==
X-Received: by 10.129.45.68 with SMTP id t65mr29208111ywt.152.1435703578466;
        Tue, 30 Jun 2015 15:32:58 -0700 (PDT)
Received: from marklaptop.lan (pool-96-255-220-63.washdc.fios.verizon.net. [96.255.220.63])
        by mx.google.com with ESMTPSA id b123sm42585039ywe.17.2015.06.30.15.32.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2015 15:32:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CAPig+cT0a201MVTsvvLrndr40GsMkyvtao33Gt=AFhvShtr=Kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273109>

On 06/30/2015 06:11 PM, Eric Sunshine wrote:
> On Tue, Jun 30, 2015 at 12:56 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> The command "git checkout --to <path>" is something of an anachronism,
>> encompassing functionality somewhere between "checkout" and "clone".
>> The introduction of the git-worktree command, however, provides a proper
>> and intuitive place to house such functionality. Consequently,
>> re-implement "git checkout --to" as "git worktree new".
>> [...]
>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>> ---
>> This is primarily a code and documentation relocation patch, with minor
>> new code added to builtin/worktree.c. Specifically:
>>
>> * builtin/worktree.c:new() is new. It recognizes a --force option ("git
>>    worktree new --force <path> <branch>") which allows a branch to be
>>    checked out in a new worktree even if already checked out in some
>>    other worktree (thus, mirroring the functionality of "git checkout
>>    --ignore-other-worktrees").
>
> Speaking of "git worktree new --force", should we revisit "git
> checkout --ignore-other-worktrees" before it gets set in stone? In
> particular, I'm wondering if it makes sense to overload git-checkout's
> existing --force option to encompass the functionality of
> --ignore-other-worktrees as well. I don't think there would be any
> semantic conflict by overloading --force, and I do think that --force
> is more discoverable and more intuitive.
>

I agree with -f subsuming --ignore...:  -f/--force should really mean 
"do this if at all possible", not just "ignore some checks". Similar to 
rm -f, etc.

Maintaining --ignore-other-worktrees, and making that a configurable 
option (worktree.ignoreothers??) would allow selectively ignoring just 
this one issue, perhaps permanently, but not the others -f already 
overrides. This would make sense if other options were added to ignore 
other subsets of checks that can block a checkout, probably not otherwise.


Mark
