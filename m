From: Conley Owens <cco3@android.com>
Subject: Re: [BUG] Halt during fetch on MacOS
Date: Mon, 3 Mar 2014 17:03:05 -0800
Message-ID: <CAFFUb6W7htX9zVB669Ki84nef5XE9Uek_aJhHLRwFg25Kt=cDQ@mail.gmail.com>
References: <CAFFUb6X455R4OD5FKnVFHFmvTyRqtV300bc=a8Xs03agM+=uLQ@mail.gmail.com>
	<20140301061532.GC20397@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 04 02:03:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKdlK-0005vt-Hi
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 02:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755536AbaCDBDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 20:03:08 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:40839 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755286AbaCDBDH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 20:03:07 -0500
Received: by mail-ie0-f176.google.com with SMTP id rd18so5105015iec.35
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 17:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20120917;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zhcMFhaMe2dMp7XQmH8i2mgGNLIjq7ZnFExCVxItRoY=;
        b=m8v66GMD0xolhoqQt0swqjXy/Eg1S6d2W94sgCZTSaRFrxhjU447dJ7QGSLmNRQEiv
         9Gf2FBEWQdWbek4BKhlo9UI0HMDPEi8esMhYOSrDvgjK0OBr37bTSe8u17RwwjZFcewB
         fTrRo1pN8XFCyT3l5616HTn3Of8jGhfKUpWFUxpUMVBYEtZWUsPBs69xgSBenq0TXDP2
         /0/PSoI+Ubc5/7U4c+uzEhBoQ8cIXLjEpN+SKV+YeBMhrjTiXl+RXdUzmUJXG2VDPbuk
         B5eVj/MSjE1gWQpaqfwH16xjPZDXsuSYBxoSJKQ/Jk+0JIVYYknmaF+lNzFN7LQLOo6x
         POaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zhcMFhaMe2dMp7XQmH8i2mgGNLIjq7ZnFExCVxItRoY=;
        b=G1aEbqJ4M3RuyIn+FBKc9M2TUvfVtDikKycKZzMQAxBW2n85V96XvIAqyrMznTF4xB
         5ST7jPz8Rzlpy6CCuPzX20QAdUwTWFT9NVyRFju4J3sddmqzFmMvfJt+9DUixyKKjXk4
         8FfBM7cYLe0UUlFoWoZSuIrJt6DA02pKIeDvzrsS8rd/LWQJ4U4Xe0APuox4ktEomW6U
         DfBByUJ+xxT3yrRKq/KTOdalHZkhB7U58bx1UWlS8G5EPhUiLOao7G3FpJoGUrj872CO
         /Sw6s8WB3xe8M/fLcthgXWnzd3mdaUFkqSFbdZyIttS05WxOJOP6ZwwnqfrktsN5rNyw
         QTTA==
X-Gm-Message-State: ALoCoQlMk9m2CjLaqohDeMWmc9oA15+Vj+kvK6OGtBWfTRNmn2jZUFdBgog1b/u2AYIE8DbIH9YQ
X-Received: by 10.50.154.66 with SMTP id vm2mr325324igb.4.1393894985973; Mon,
 03 Mar 2014 17:03:05 -0800 (PST)
Received: by 10.64.145.101 with HTTP; Mon, 3 Mar 2014 17:03:05 -0800 (PST)
In-Reply-To: <20140301061532.GC20397@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243320>

On Fri, Feb 28, 2014 at 10:15 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 28, 2014 at 03:26:28PM -0800, Conley Owens wrote:
>
>> test.sh
>> """""""""""""""""""""""""""""""""""""
>> #!/bin/bash
>> rungit() {
>>     mkdir $1
>>     GIT_DIR=$1 git init --bare
>>     echo '[remote "aosp"]' > $1/config
>>     echo '    url =
>> https://android.googlesource.com/platform/external/tinyxml2' >>
>> $1/config
>>     GIT_DIR=$1 git fetch aosp +refs/heads/master:refs/remotes/aosp/master
>
> I don't think this is affecting your test, but you probably want ">>" to
> append to the config for the first line, too. Otherwise you are
> overwriting some of git's default settings.
>
>> When everything cools, you can see that there are some fetches hanging
>> (typically).
>> $ ps | grep 'git fetch'
>> ...
>> 63310 ttys004    0:00.01 git fetch aosp
>> +refs/heads/master:refs/remotes/aosp/master
>> [...]
>
> I can't reproduce here on Linux. Can you find out what the processes are
> doing with something like strace?

Yes, none of my Linux users have had any problems with this, but many
of my Mac users have.

I'm trying to run it under dtruss, but it's slowing the entire system
down to a halt.

>
>> You can look at the parent process of each and see that one half
>> spawned the other half, or you can look at the environment variables
>> for each to see that there are two processes operating in the same
>> directory for each directory where there's an issue.
>> $ echo "$(for pid in $(ps | grep 'git fetch' | grep -o '^[0-9]*'); do
>> ps -p $pid -wwwE | grep 'GIT_DIR=[^ ]*' -o; done)" | sort
>> GIT_DIR=testdir14
>> GIT_DIR=testdir14
>> GIT_DIR=testdir32
>> GIT_DIR=testdir32
>> GIT_DIR=testdir47
>> GIT_DIR=testdir47
>
> A fetch will start many sub-processes. Try:
>
>   GIT_TRACE=1 git fetch \
>     https://android.googlesource.com/platform/external/tinyxml2
>
> which shows git-fetch starting the git-remote-https helper, which in
> turn starts git-fetch-pack to do the actual protocol, which uses
> git-unpack-objects to manage the incoming pack.

This is the full output of a fetch that ends up hanging:
trace: built-in: git 'fetch' 'aosp'
'+refs/heads/master:refs/remotes/aosp/master'
trace: run_command: 'git-remote-https' 'aosp'
'https://android.googlesource.com/platform/external/tinyxml2'

>
> -Peff
