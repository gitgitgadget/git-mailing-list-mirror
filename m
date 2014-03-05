From: Conley Owens <cco3@android.com>
Subject: Re: [BUG] Halt during fetch on MacOS
Date: Wed, 5 Mar 2014 13:56:13 -0800
Message-ID: <CAFFUb6ViYitJC1sjL_nyWY1RHuJKURfcZ+_5Zk2kr+suh+txZg@mail.gmail.com>
References: <CAFFUb6X455R4OD5FKnVFHFmvTyRqtV300bc=a8Xs03agM+=uLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 22:56:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLJnX-0008Cc-FM
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 22:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014AbaCEV4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 16:56:14 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:51444 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbaCEV4N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 16:56:13 -0500
Received: by mail-ie0-f173.google.com with SMTP id rl12so1789414iec.18
        for <git@vger.kernel.org>; Wed, 05 Mar 2014 13:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20120917;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=17LuoS/NdidPiM80uR5EBiz2mFSDJrI7E3FGo6/uunc=;
        b=krQIEtQmNokW0qS31ELRPwu+qkp4Wy2XRMBXUGxyIs2xF8wX4HGcofTJn5kdHjOSSx
         HpVE/DadjP8CycR3kCTfv9jUIPpb372Mu4G4uIMUOwLnqN2vKjnyW5XGP/Yp6xkQE6Aw
         qWJrJbGOIDbawQwNMuOOOBxooCkUrJnv3rw6zYEtrh2XViZq4McPl9sz4nzt64IA+vTW
         dNwTBkxv9Jt0aJP1j+dY4RK7z+uMKCwpuwRcKZusus70RjNV+sS+kghWyuEU48BkPMjj
         kOAoPnaG5PK7csHq+mr93WH/AvaFvdWBghLwS6M+0TXBHSEevdZ/aus981CQsAvlQ0YI
         3rFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=17LuoS/NdidPiM80uR5EBiz2mFSDJrI7E3FGo6/uunc=;
        b=LrIu1MNrnKhnHOq0o/n0oNSc85CSOSKWe+c9+NXb7WXiExKEirk5XA6fdy52heY7Qb
         YwDB1Z9SgbuD2Gx08SonVRf+FlX9HpoA/c8VD1qO3bT8FnmGbnZC8tTW7SY3kIet0xKE
         +1VcYGIKVcUzyMzwmrJp1gjWGtEOlJx2xYnDLUxRf8+M+uTgMY2D2PbvT1F76fuyZyzZ
         INFutMuAC6kVVZdwVyP/XVgFnjPexA7nA0yi2i3Zsm7jSNT2jg9lFHX5lrn1sLltOYdB
         hABWvjXaW3rhWOMh/meKncsqnWqgPKLZMp7NqKEFr62S6I6XS+O76JLo7qYVeknh3WtO
         WA7w==
X-Gm-Message-State: ALoCoQl4qOSwFQj/qOEZsqTJ6Stka1To/13QjKcKYTgWwVSvT+nKRgU7bQFgDWniv4hUjGkVrUhj
X-Received: by 10.50.176.162 with SMTP id cj2mr11886279igc.7.1394056573094;
 Wed, 05 Mar 2014 13:56:13 -0800 (PST)
Received: by 10.64.145.101 with HTTP; Wed, 5 Mar 2014 13:56:13 -0800 (PST)
In-Reply-To: <CAFFUb6X455R4OD5FKnVFHFmvTyRqtV300bc=a8Xs03agM+=uLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243485>

On Fri, Feb 28, 2014 at 3:26 PM, Conley Owens <cco3@android.com> wrote:
> $ git --version  # This is just the git from MacPorts
> git version 1.8.5.5
> $ sw_vers
> ProductName:    Mac OS X
> ProductVersion: 10.8.5
> BuildVersion:   12F45

OK, I've tried using my own build from master, and I still get the same results.

I've done a little more investigation and discovered it always hangs at:
`atexit(notify_parent);` in `run-command.c:start_command`
when running:
trace: run_command: 'git-remote-https' 'aosp'
'https://android.googlesource.com/platform/external/tinyxml2'

Could this have to do with the atexit implementation?  (eg. limit on
the number of functions that can be registered, etc)

$ cc -v
Apple clang version 4.1 (tags/Apple/clang-421.11.66) (based on LLVM 3.1svn)
Target: x86_64-apple-darwin12.5.0
Thread model: posix

>
> test.sh
> """""""""""""""""""""""""""""""""""""
> #!/bin/bash
> rungit() {
>     mkdir $1
>     GIT_DIR=$1 git init --bare
>     echo '[remote "aosp"]' > $1/config
>     echo '    url =
> https://android.googlesource.com/platform/external/tinyxml2' >>
> $1/config
>     GIT_DIR=$1 git fetch aosp +refs/heads/master:refs/remotes/aosp/master
>     rm -rf $1
> }
>
> for i in $(seq 1 100)
> do
>     rungit testdir$i &
> done
> """""""""""""""""""""""""""""""""""""""
> $ ./test.sh  # Warning! This script fetches ~40MB of data
>
> When everything cools, you can see that there are some fetches hanging
> (typically).
> $ ps | grep 'git fetch'
> ...
> 63310 ttys004    0:00.01 git fetch aosp
> +refs/heads/master:refs/remotes/aosp/master
> 63314 ttys004    0:00.01 git fetch aosp
> +refs/heads/master:refs/remotes/aosp/master
> 63319 ttys004    0:00.01 git fetch aosp
> +refs/heads/master:refs/remotes/aosp/master
> 63407 ttys004    0:00.00 git fetch aosp
> +refs/heads/master:refs/remotes/aosp/master
> 63414 ttys004    0:00.00 git fetch aosp
> +refs/heads/master:refs/remotes/aosp/master
> 63420 ttys004    0:00.00 git fetch aosp
> +refs/heads/master:refs/remotes/aosp/master
> ...
>
> You can look at the parent process of each and see that one half
> spawned the other half, or you can look at the environment variables
> for each to see that there are two processes operating in the same
> directory for each directory where there's an issue.
> $ echo "$(for pid in $(ps | grep 'git fetch' | grep -o '^[0-9]*'); do
> ps -p $pid -wwwE | grep 'GIT_DIR=[^ ]*' -o; done)" | sort
> GIT_DIR=testdir14
> GIT_DIR=testdir14
> GIT_DIR=testdir32
> GIT_DIR=testdir32
> GIT_DIR=testdir47
> GIT_DIR=testdir47
>
> I've searched through the mailing list, but this doesn't seem to be a
> known issue.  I've only seen this occur on macs (and with a good deal
> of regularity).  It doesn't occur on my Ubuntu box.
>
> ~cco3
