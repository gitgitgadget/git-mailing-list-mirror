From: Robert Zeh <robert.allan.zeh@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Mon, 11 Feb 2013 08:13:53 -0600
Message-ID: <CAKXa9=pCSWtXq+5x_LcZ9gsSpa1yT0QD5DsBguTqosoH0cj-nw@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
	<7vehgqzc2p.fsf@alter.siamese.dyndns.org>
	<7va9rezaoy.fsf@alter.siamese.dyndns.org>
	<7vsj56w5y9.fsf@alter.siamese.dyndns.org>
	<9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
	<CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
	<7vliaxwa9p.fsf@alter.siamese.dyndns.org>
	<CAKXa9=qQwJqxZLxhAS35QeF1+dwH+ukod0NfFggVCuUZHz-USg@mail.gmail.com>
	<CACsJy8BvN0xX_=fx78hVLw=2Wyk=RUHYs_x9r5RJ0TvBAoA83g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 15:14:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4u9M-0002B5-Ni
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 15:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757329Ab3BKOOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 09:14:05 -0500
Received: from mail-wg0-f48.google.com ([74.125.82.48]:50884 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756516Ab3BKOOD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 09:14:03 -0500
Received: by mail-wg0-f48.google.com with SMTP id 16so4664400wgi.3
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 06:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=JQmsEDgnnZf+UUT6AyD1ZpEAlRJbFeRfjw7Uly4iqHU=;
        b=xekRLKuVwkgEXPujIDyeApXLPcueOSYji0Ja5BqHriXf2FQiuHwV7LzqW6aUDTzd9j
         m/4FmnDJIm0ktB3ha/CaXLSjATG6sjwKSIp3w8U8TcQoFvL89EzCN9Mug1kSDKjCwjIn
         FVzo6gSbXMJirWu0DOIU0lx8QizT9WCTFmjPqxeGxxyJHF9AfjDiOM5SjAYj0qGdGk8A
         ym/8IqbB8V4s+GNtpOwi36gMWy0cJjfTQ3bqE+Ga9M3oWi49oYzdXf+/uxBBv5YOxSDn
         KUWzO7/Zirtfb5vxChoGO5aLgkjDj5VIQEKqkmpCiaJHXJ8dcy9t/EDR3XUHXDmRmbq2
         EWZg==
X-Received: by 10.180.92.129 with SMTP id cm1mr16395730wib.10.1360592033408;
 Mon, 11 Feb 2013 06:13:53 -0800 (PST)
Received: by 10.216.101.130 with HTTP; Mon, 11 Feb 2013 06:13:53 -0800 (PST)
In-Reply-To: <CACsJy8BvN0xX_=fx78hVLw=2Wyk=RUHYs_x9r5RJ0TvBAoA83g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216035>

On Sun, Feb 10, 2013 at 9:21 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Feb 11, 2013 at 2:03 AM, Robert Zeh <robert.allan.zeh@gmail.com> wrote:
>> On Sat, Feb 9, 2013 at 1:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>>
>>>> This is much better than Junio's suggestion to study possible
>>>> implementations on all platforms and designing a generic daemon/
>>>> communication channel.  That's no weekend project.
>>>
>>> It appears that you misunderstood what I wrote.  That was not "here
>>> is a design; I want it in my system.  Go implemment it".
>>>
>>> It was "If somebody wants to discuss it but does not know where to
>>> begin, doing a small experiment like this and reporting how well it
>>> worked here may be one way to do so.", nothing more.
>>
>> What if instead of communicating over a socket, the daemon
>> dumped a file containing all of the lstat information after git
>> wrote a file? By definition the daemon should know about file writes.
>>
>> There would be no network communication, which I think would make
>> things more secure. It would simplify the rendezvous by insisting on
>> well known locations in $GIT_DIR.
>
> We need some sort of interactive communication to the daemon anyway,
> to validate that the information is uptodate. Assume that a user makes
> some changes to his worktree before starting the daemon, git needs to
> know that what the daemon provides does not represent a complete
> file-change picture and it better refreshes the index the old way
> once, then trust the daemon.
>
> I think we could solve that by storing a "session id", provided by the
> daemon, in .git/index. If the session id is not present (or does not
> match what the current daemon gives), refresh the old way. After
> refreshing, it may ask the daemon for new session id and store it.
> Next time if the session id is still valid, trust the daemon's data.
> This session id should be different every time the daemon restarts for
> this to work.

I think we could do this without interactive communication,
if we did the following:
   1) The Daemon waits to see $GIT_DIR/lstat_request, and atomically
       writes out $GIT_DIR/lstat_cache.  By atomically I mean that it writes
       things out to a temporary file, and then does a rename.

   2) The client erases $GIT_DIR/lstat_cache, and writes
      $GIT_DIR/lstat_request

I think this is better than socket based communication because there
are fewer places to check
for failures.

Robert
