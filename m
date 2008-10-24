From: "George Shammas" <georgyo@gmail.com>
Subject: Re: git performance
Date: Fri, 24 Oct 2008 13:42:00 -0400
Message-ID: <dfdaadcd0810241042k1469fc30x62daa19273404edc@mail.gmail.com>
References: <000901c93490$e0c40ed0$a24c2c70$@com>
	 <20081023163912.GA11489@coredump.intra.peff.net>
	 <000001c9358f$232bac70$69830550$@com>
	 <20081024142947.GB11568@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 19:43:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtQgz-0002ig-La
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 19:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbYJXRmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 13:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbYJXRmG
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 13:42:06 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:18255 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbYJXRmD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 13:42:03 -0400
Received: by ey-out-2122.google.com with SMTP id 6so341183eyi.37
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 10:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5wbHo62R43LqLAmPDm5jwoe2nm7HjAgUR3rnrum0Hf8=;
        b=j6veuFeOzmZEF3RNXzCnS/5xJcL8rAlCoH0T3ImSLAlqb2/Sfi+2opnN0L5XDb0UU2
         QA+/RTtLEIdEyTKEt/xvoLD2/2cvhClonsT7eiCCcEGlxL+3v2kCgJR6H3QPtw8W0HHR
         JfX2rFaquGqSvD8J1t6frRizMFL6PoC+S+UAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=h40yHC2JON39NUlqvVYzbdzeVBewBqlNyrsUPpTDvHvUN7KwFMRvEwK9uxq9+U/Owa
         QJJJIfhDohUqRpK605gxaSIfQGTevafKEQ7gW4VViEJO5JAgp9M6ELWbxyYyf+zgawGe
         OX882FHd6P6iLerN/37wTs37sYOW+UNAb5Zyk=
Received: by 10.187.179.4 with SMTP id g4mr177622fap.24.1224870120757;
        Fri, 24 Oct 2008 10:42:00 -0700 (PDT)
Received: by 10.187.250.1 with HTTP; Fri, 24 Oct 2008 10:42:00 -0700 (PDT)
In-Reply-To: <20081024142947.GB11568@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99045>

If you are really trying to backup a filesystem, you may want to look
at a filesystem that can do snapshots, it would be a lot more
efficient then a version control system.  Such as NILFS and ZFS.

http://en.wikipedia.org/wiki/NILFS
http://en.wikipedia.org/wiki/ZFS

Both these will allow you to look at changed files over time. NILFS is
slightlly diffrent in that it doesn't take snapshots, because it never
deletes, so you can rollback every change on a file. They both also
allow each user to rollback their own files if they wanted to, so if
this is your goal, source code version control is not for you, and a
good file system is for you.

-G

On Fri, Oct 24, 2008 at 10:29 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Oct 24, 2008 at 12:15:19AM -0400, Edward Ned Harvey wrote:
>
>> Feel free to forward to the list, if anyone's still talking about it.
>> I already un-subscribed.
>
> Posting is not limited to subscribers, so you can happily continue the
> conversation there by cc'ing the list (and I am cc'ing the list here).
>
>> I did my benchmarking at least two months ago, so I forgot the exact
>> results now, so I ran the benchmark once just now.  I also downloaded
>> git, and did "git status" for comparison.  I rebooted the system in
>> between each trial run, to clear the cache.  Here's the results:
>
> Side note: on Linux, it is much easier to clear the cache via
>
>  echo 1 >/proc/sys/vm/drop_caches
>
> than to reboot for each benchmark.
>
>> Local disk mirror "time git status" on the same tree. 17,468 versioned files, so the whole tree is 30,647 including .git files
>>       0m 25s  cold cache
>>       0m 0.2s warm cache trial 1
>>       0m 0.2s warm cache trial 2
>
> Hmm. That's a lot of increase in files for .git. Did you try repacking
> and then running your test?
>
>> I questioned whether svn and git were causing unnecessary overhead.
>
> Sure, they are doing more than just walking. So there is overhead, but
> it's hard to say how much is unnecessary. However, if you were working
> with an unpacked git, then it may have had to open() a lot of files in
> the object db (keep in mind that status doesn't just show the difference
> between the working tree and the index; it shows the difference between
> the index and the last commit. So maybe "git diff" would be a more
> accurate comparison).
>
>> Conclusions:
>> * For "status" operations on cold cache, large file count, Neither the
>> performance of git or svn approaches the ideal.  Both are an order of
>> magnitude slower than ideal, which is still assuming "ideal" requires
>> walking the tree.  A better ideal avoids the need to walk the tree,
>> and has near-zero total cost.
>
> Try your git benchmark again with a packed repo, and I think you will
> find it approaches the time it takes to walk the tree.
>
> That being said, if walking the tree is unacceptable to you, then no,
> current git won't work. You would need to patch it to use inotify (once
> upon a time there was some discussion of this, but it never went
> anywhere -- I guess most people work on machines where they can keep the
> cache relatively warm).
>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
