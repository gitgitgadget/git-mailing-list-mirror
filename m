Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903DA30596D
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721386; cv=none; b=WWAGkYvr//y5RLPcSYdZ37YVPttsqpK6fvoPvqXmikhAfXl+PBJyoiEBx7hyAGMUZ4h7bjnq6LRC9m5AmY/kPVs4XrTYci1SwgfWUNy7pwmH3HYtakh1AMEcSV1r0F+5TvGr1oVFlutippbRhcCqYZ9l0W+gPbznHy81GqbsMA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721386; c=relaxed/simple;
	bh=QVNy1BjoaeAmBJOXtwgSjoyNFA+kpwM5qb53s5ZTzQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=atpvb7Vt0F94ZmkMvos3ZU1VJezR9Mb5BDfDPTObPb1jgDfY5fWieBLGKaT9tMpcon3xWSTFSYDaZ2yEEcRtAmbVQNYh5XH3a0wOr/zHr7ZF3a6QGI9llTA4sjU8dC+TRkExeKxKJZQLqgLXWH6+6yHSO6LXLIUcOzy0j6wtepk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4cp9SR5XhWz7QXB4
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 18:36:23 +0200 (CEST)
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4cp9SH2Z6QzRpKJ;
	Fri, 17 Oct 2025 18:36:15 +0200 (CEST)
Message-ID: <fd4437c2-ca62-4221-b426-f3c3dc3d2a47@kdbg.org>
Date: Fri, 17 Oct 2025 18:36:15 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] Revert "gitk: Only restore window size from
 ~/.gitk, not position"
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
References: <20250928135435.59623-1-rappazzo@gmail.com>
 <20250928135435.59623-2-rappazzo@gmail.com>
 <be1e6cba-c94d-4c2f-ab68-e368ffe9daa5@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
Cc: Michael Rappazzo <rappazzo@gmail.com>, git@vger.kernel.org
In-Reply-To: <be1e6cba-c94d-4c2f-ab68-e368ffe9daa5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 28.09.25 um 16:17 schrieb Mark Levedahl:
> On 9/28/25 9:54 AM, Michael Rappazzo wrote:
>> From: Johannes Sixt <johannes.sixt@telecom.at>
>>
>> This reverts commit b9bee11526ec23541ddbbd75716bfd1acc241463.
>>
>> The commit catered to an unsupportable port of the Windows Tcl/Tk
>> stuck at 8.4.1 that was used by Cygwin. 8.4.1 has some bad bugs in its
>> layout engine, and forced changes in Gitk to be compatible. All this
>> became irrelevant around 2011 after Cygwin gained an X11 server and
>> switched to a supportable port of the Unix/X11 Tcl/Tk (it is now on the
>> current 8.6 code base).
>>
>> Helped-by: Mark Levedahl <mlevedahl@gmail.com>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>>  gitk | 12 ++----------
>>  1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/gitk b/gitk
>> index 6e4d71d585..275f353811 100755
>> --- a/gitk
>> +++ b/gitk
>> @@ -2764,17 +2764,9 @@ proc makewindow {} {
>>      .pwbottom add .bright
>>      .ctop add .pwbottom
>>  
>> -    # restore window width & height if known
>> +    # restore window position if known
>>      if {[info exists geometry(main)]} {
>> -        if {[scan $geometry(main) "%dx%d" w h] >= 2} {
>> -            if {$w > [winfo screenwidth .]} {
>> -                set w [winfo screenwidth .]
>> -            }
>> -            if {$h > [winfo screenheight .]} {
>> -                set h [winfo screenheight .]
>> -            }
>> -            wm geometry . "${w}x$h"
>> -        }
>> +        wm geometry . "$geometry(main)"
>>      }
>>  
>>      if {[info exists geometry(state)] && $geometry(state) eq "zoomed"} {
> I mis-interpreted an earlier inquiry about the patch being reverted here. Patch e9937d2a03
> actually addressed the issues of Cygwin's 8.4.1 Tcl/Tk. Part of that was fixing the window
> geometry being restored, as sometimes the window manager would size the main window in a
> manner causing 8.4.1 to fail. But, this override of the main window manager on all
> platforms raised complaints on the mailing list, and commit b9bee11526 was the response:
> it was only the SIZE of the Window that mattered on Cygwin, not its location, so allowing
> window managers to set the location was ok.
> 
> Personally, I'm fine with gitk remembering / restoring the full window geometry (I wrote
> it that way in e9937d2a03).
Thank you for the hint. I found the thread, and after reading it I
notice that the opposition is based on that restoring the position
doesn't put the window on the desired monitor. I can't test this right
now. I've rewritten the commit message as follows. Whether or not the
position should be restored seems to be a personal preference, and the
patch applies my and your preference, but obviously not everyone's.
Please let me know whether I understood the situation correctly or not.

    Revert "gitk: Only restore window size from ~/.gitk, not position"
    
    This reverts commit b9bee11526ec (gitk: Only restore window size from
    ~/.gitk, not position, 2008-03-10).
    
    The earlier commit e9937d2a03a4 (Make gitk work reasonably well on
    Cygwin, 2007-02-01) reworked the window layout considerably. Much of
    this became irrelevant around 2011 after Cygwin gained an X11 server
    and switched to a supportable port of the Unix/X11 Tcl/Tk (it is now
    on the current 8.6 code base).
    
    Part of the necessary change was to restore the window size across
    sessions, but the position was also restored. This raised complaints
    on the mailing list[*], because Gitk was opened on the wrong monitor.
    b9bee11526ec was the compromise, because it was only the size that
    mattered for the Cygwin layout engine to work.
    
    I personally, find it annoying when Gitk pops up on a random location
    on the screen, in particular, since many other applications restore
    the window positions across sessions, so why not Gitk as well? (I do
    not operate multi-monitor setups, so I cannot test the case.)
    
    [*] https://lore.kernel.org/git/47AAA254.2020008@thorn.ws/

-- Hannes

