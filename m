From: Jason Vas Dias <jason.vas.dias@gmail.com>
Subject: Re: clone hang prevention / timeout?
Date: Thu, 14 Apr 2016 19:32:24 +0100
Message-ID: <CALyZvKzzB9yv-aavw2RH7D7fK=vG88-j9W0LAmD3P6=CkSJCuw@mail.gmail.com>
References: <CALyZvKwxE4T8-FmEYgPMgAFKLmeAY5f-y-mDL8S9twTb0umRaA@mail.gmail.com>
	<20160413222900.GA10011@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:32:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqm48-0001el-A4
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 20:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576AbcDNSc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 14:32:28 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35931 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbcDNSc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 14:32:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id l6so120030wml.3
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 11:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=tyrm8Ru8GVlz0mhOTd1+FJ+5+tf9Fel7M5SyNYcUc68=;
        b=eIYYVp6CED1K0u4QMQcvDrrIZBNYz3zhDRu3xB8J/mw/gRcQcTu3xWmu6gyeJ3B4sY
         O/QVJriDVmkkTEDSE46nsKi4Yh+A8D8XPKkPL3TVwUIsbG58BuhHkq6IxkUQFhXOfiP7
         sgg762nIYocxnyBEPGLFYHKbq1/o9mMm1XypYrcMcPk7+ylbZcUlhisaQCsqv0EBWtJU
         qOQV5O5NZZy+1iZthYzWeU6/X8vndknsqDvS+Jc36M0KJglF/2THhEwf9Doq40AXjmCt
         F2TYpWlS9n5Fj4QIAYOed6/kIaqz2MlpARFp4DWM2b7MXd/9CAfGzGfy6B45sYyKLNV9
         414w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=tyrm8Ru8GVlz0mhOTd1+FJ+5+tf9Fel7M5SyNYcUc68=;
        b=UWmRnRivzkeEok48KJ6aS8dgukzRrEvc+xib5eQ0+f2ESUvx77a5QwmYQnNsfKo/CT
         wUO4slJa5f46j25BsIQ9ro8+qST/JFgSQo/zOSYX1VasivldipIx0ZrHyH32MntEUg0q
         iM2jnlmIHeXQ8pd8pfJytey6zQ56zrltXgVUapMY9rztMWAQqW+SaebQeLhu2/rUR0P1
         2Hdk65v5TFT3Isl39JmXdwOXaQc5s4VsndJFnoBqRfiGW2qXm9kYA0648Lgo5/x8UVyB
         vPdOFoWijj/gAs6Ty9qki+acEHDGDnNhSwX9amQ7zkSRxfMbOQ52rjHSaFCH+pcA/Biu
         fI5A==
X-Gm-Message-State: AOPr4FVzCN6Ds+5ZfxDO92ioE7fA5MdiNwC0PN9JvLP3XfnYUshIDpUDuqvTz42mrV4wvNgxNYqE3JjraFZwrQ==
X-Received: by 10.194.158.226 with SMTP id wx2mr16918830wjb.91.1460658745046;
 Thu, 14 Apr 2016 11:32:25 -0700 (PDT)
Received: by 10.28.234.70 with HTTP; Thu, 14 Apr 2016 11:32:24 -0700 (PDT)
In-Reply-To: <20160413222900.GA10011@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291554>

Thanks very much Eric & Jeff for your reply .

Personally, I would recommend setting the SO_RECVTIMEO for GIT server
sockets to a fixed default (eg. 5mins) , settable by a
'--receive-timeout'   argument or configuration parameter .

The problem I was trying to overcome was cloning all the repositories under
https://anongit.freedesktop.org/xorg/* .

About 4 git clones would succeed in succession, but then typically the 5th
would hang in read() forever - I left one such hung 'git clone' for nearly an
hour and it had not progressed or timed out . I tried inserting a delay of
up to 30 seconds between clones, but this did not help.

Maybe freedesktop.org's GIT server is too overloaded and they have
to resort to disabling 1 out of 5 GIT successive clone operations from
same connection or something.

Here is my solution, in case anyone else needs it :

<quote><pre>
      eips=()
       counts=()
       declare -i failed=0;
       { echo "$BASHPID" >/tmp/git.pid;
         GIT_TRACE=2 exec git clone
${proto}://${user}anongit.freedesktop.org/${repo}$name; }&
       while [ ! -f /tmp/git.pid ]; do sleep 1; done
       git_pid="$(cat /tmp/git.pid)";
       while [ -d /proc/$git_pid ]; do
           IFS=$'\n';
           declare -a kids=($(ps --ppid $git_pid -o 'pid=,eip='));
           unset IFS;
           declare -i n_kids=${#kids[@]} kid_n;
           for ((kid_n=0; kid_n < n_kids; kid_n+=1)); do
             declare -a ke=(${kids[kid_n]});
             kid=${ke[0]}
             eip=${ke[1]}
             if [ ! -v 'eips['$kid']' ]; then
                eips[$kid]="$eip";
             elif [ "${eips[$kid]}" = "$eip" ]; then
                if [ x = x"${counts[$kid]}" ]; then
                   counts[$kid]=1;
                else
                   counts[$kid]=$((${counts[$kid]}+1));
                   if (( ${counts[$kid]} >= 30 )); then
                      echo 'child process '$kid' of git main process
'$git_pid' appears to be stuck - killing it.';
                      kill -TERM $kid;
                      ((failed=1));
                   fi
                fi
             else
                eips[$kid]="$eip";
                counts[$kid]='';
             fi
          done ;
          sleep 1;
       done
       wait
</quote></pre>

This is part of a script that reads a list of the Xorg projects,
sets $repo to top level subdirectory, and $name to the project name,
and initiates the GIT clone .
It deems any GIT _CHILD_ process (eg. git-index-pack) that have not
changed their instruction pointer register (EIP)  for 30 seconds to be
"hung" .
There is logic at the end to retry all the failed clones.
It does work, but is far from pretty .
It sure would be nice if GIT had a timeout mechanism !

Thanks & Regards,
Jason






On 13/04/2016, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 11, 2016 at 10:49:19PM +0100, Jason Vas Dias wrote:
>
>> Is there any option I can specify to get the clone to timeout, or do I
>> manually
>> have to strace the git process and send it a signal after a hang is
>> detected?
>
> Oh, one other thing you might consider, it something like "timeout" from
> GNU coreutils, which puts a hard cap on the length of time a process can
> run.
>
> It's totally unaware of the state of the process, though, so if you
> really do have a clone which takes an hour, it might very well kill it
> at 99% complete. It has no mechanism for "gee, this process looks like
> it hasn't done anything for 5 minutes".
>
> I don't know offhand of a general tool for that.
>
> -Peff
>
