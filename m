From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: [BUG] git clean -X skips a directory containing only ignored
 files
Date: Tue, 31 Jan 2012 11:20:39 -0500
Message-ID: <4F2814D7.8030504@sohovfx.com>
References: <CA+yLL67J-7U9z7HVvq5wTc1g4_UCtqYfEyqdt7XR5zDqvQN5NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Berry <stereotype441@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 17:40:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsGkz-0006fn-Dd
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 17:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697Ab2AaQk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 11:40:27 -0500
Received: from smtp03.beanfield.com ([76.9.193.172]:56966 "EHLO
	smtp03.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627Ab2AaQk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 11:40:26 -0500
X-Greylist: delayed 1180 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Jan 2012 11:40:26 EST
X-Spam-Status: No
X-beanfield-mta03-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta03-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1.778, required 6, ALL_TRUSTED -1.00, BAYES_00 -1.90,
	URI_HEX 1.12)
X-beanfield-mta03-MailScanner: Found to be clean
X-beanfield-mta03-MailScanner-ID: 1RsGRj-000ALR-HT
Received: from [66.207.196.114] (helo=[192.168.1.112])
	by mta03.beanfield.com with esmtpa (Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1RsGRj-000ALR-HT; Tue, 31 Jan 2012 11:20:39 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101026 SUSE/3.0.10 Thunderbird/3.0.10
In-Reply-To: <CA+yLL67J-7U9z7HVvq5wTc1g4_UCtqYfEyqdt7XR5zDqvQN5NA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189459>

I think there were a bit of discussions on this issues just while ago too:
http://thread.gmane.org/gmane.comp.version-control.git/188605


On 01/30/2012 06:36 PM, Paul Berry wrote:
> I am trying to use "git clean -X" to remove object files (which
> are gitignored) from my source tree, but it appears to miss
> object files that are in a subdirectory without any git-tracked
> files:
>
> $ git init test
> Initialized empty Git repository in /home/pberry/tmp/test/.git/
> $ cd test
> $ mkdir foo
> $ touch foo/bar.o
> $ echo '*.o' > .gitignore
> $ git add .gitignore
> $ git commit -mgitignore
> [master (root-commit) 6b5ffcb] gitignore
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 .gitignore
> $ git status
> # On branch master
> nothing to commit (working directory clean)
> $ git clean -d -X -f
> $ ls foo
> bar.o
>
> It seems to me that bar.o should have been removed, because
> according to the git-clean docs, -X means "Remove only files
> ignored by git", and bar.o is definitely being ignored by git.
>
>
> It looks like a very similar bug was reported back in 2010, but
> not fixed:
> http://git.661346.n2.nabble.com/BUG-git-clean-X-behaviour-when-gitignore-has-sub-directory-entries-td5575307.html.
> I've confirmed that the workaround mentioned by Jonathan Nieder
> in that thread fixes my problem too (removing "dir.flags |=
> DIR_SHOW_OTHER_DIRECTORIES;" from builtin/clean.c).  However I'm
> guessing from Jonathan's comments that it would be better to fix
> this bug elsewhere (somewhere in dir.c perhaps).
>
> Is anyone interested in following up on this old bug?
> Alternatively, if someone could give me some guidance as to the
> best way to go about fixing this bug, I would be glad to submit a
> patch.
>
> Thanks,
>
> Paul
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   
