From: Max Horn <max@quendi.de>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Sun, 10 Mar 2013 14:22:58 +0100
Message-ID: <C79E1B20-2C42-49FF-A964-285A7049FDED@quendi.de>
References: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de> <494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de> <CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com> <205D17C4-F737-46E9-BC48-D16D5948C707@quendi.de> <CADgNjan9v++__TSPE55j7+=BBZrVEkMD52O+9kXAm-C8SRV+Ww@mail.gmail.com> <B21B6CEC-7507-47A1-9BBB-FB95EA6B831F@quendi.de> <CADgNja=Ej8jnYn027GX986VrmuqVemM7aE59rynHzUpToPVaEw@mail.gmail.com> <3B5EA38E-9603-4321-AA3C-74354BBC8BFC@quendi.de> <513B8037.7060107@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 14:23:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEgE8-000251-Ry
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 14:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684Ab3CJNXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 09:23:22 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:49337 "EHLO
	merkurneu.hrz.uni-giessen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752616Ab3CJNXV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 09:23:21 -0400
Received: from mailgw82.hrz.uni-giessen.de by merkurneu.hrz.uni-giessen.de with ESMTP; Sun, 10 Mar 2013 14:23:11 +0100
Received: from merkurneu.hrz.uni-giessen.de (merkurneu.hrz.uni-giessen.de [134.176.2.3])
	by mailgw82.hrz.uni-giessen.de (Postfix) with ESMTP id 13D1B4800085;
	Sun, 10 Mar 2013 14:23:01 +0100 (CET)
Received: from [134.176.2.3] by merkurneu.hrz.uni-giessen.de with ESMTP; Sun, 10 Mar 2013 14:23:01 +0100
In-Reply-To: <513B8037.7060107@gmail.com>
X-Mailer: Apple Mail (2.1283)
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: No virus found
X-Envelope-From: max@quendi.de
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217806>

Sorry for taking so long to reply... :-/

On 09.03.2013, at 19:32, Andrew Wong wrote:

> On 03/09/13 06:26, Max Horn wrote:
>> It tends to fail in separate places, but eventually "stabilizes". E.g. I just did a couple test rebases, and it failed twice in commit 14, then the third time in commit 15 (which underlines once more that the failures are inappropriate).
>> 
>> The fourth time, something new and weird happened:
>> 
>> $ git rebase --abort
>> $ git rebase NEW-PARENT 
>> Cannot rebase: You have unstaged changes.
>> Please commit or stash them.
>> $
>> 
>> This is quite suspicious. It appears that git for some reason things a file is dirty when it isn't. That could explain the other rebase failures too, couldn't it? But what might cause such a thing?
> Yea, that's really suspicious. This could mean there's an issue with
> when git is checking the index. Try running these a couple times in a
> clean work tree:
>    $ git update-index --refresh
>    $ git diff-files
> 
> In a clean work tree, these commands should print nothing. But in your
> case, these might print random files that git thinks have been modified...

I did run

  touch lib/*.* src/*.* && git update-index --refresh && git diff-files

a couple dozen times (the "problematic" files where in src/ and lib), but nothing happened. I just re-checked, and the rebase still fails in the same why...

Perhaps I should add some printfs into the git source to figure out what exactly it thinks is not right about those files... i.e. how does it come to the conclusion that I have local changes, exactly. I don't know how Git does that -- does it take the mtime from (l)stat into account? Perhaps problems with my machine's clock could be responsible?


> 
> If the commands do print out some files, check the timestamp from the
> git index and the filesystem:
>    $ git ls-files --debug file1 file2
>    $ stat -f "%N %m %c" file1 file2
> 
> Is this repo on a network drive? Or is it local drive in your Mac?

Local (some more details also described in my first email on this thread, but I'll happily provide more data if I can).

Thanks again,
Max