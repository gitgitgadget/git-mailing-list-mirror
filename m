From: Max Horn <max@quendi.de>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Sat, 9 Mar 2013 12:26:54 +0100
Message-ID: <3B5EA38E-9603-4321-AA3C-74354BBC8BFC@quendi.de>
References: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de> <494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de> <CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com> <205D17C4-F737-46E9-BC48-D16D5948C707@quendi.de> <CADgNjan9v++__TSPE55j7+=BBZrVEkMD52O+9kXAm-C8SRV+Ww@mail.gmail.com> <B21B6CEC-7507-47A1-9BBB-FB95EA6B831F@quendi.de> <CADgNja=Ej8jnYn027GX986VrmuqVemM7aE59rynHzUpToPVaEw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 12:27:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEHwG-0006Vx-9P
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 12:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148Ab3CIL1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 06:27:18 -0500
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:54361 "EHLO
	merkurneu.hrz.uni-giessen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757198Ab3CIL1Q convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Mar 2013 06:27:16 -0500
Received: from mailgw62.hrz.uni-giessen.de by merkurneu.hrz.uni-giessen.de with ESMTP; Sat, 9 Mar 2013 12:27:11 +0100
Received: from merkurneu.hrz.uni-giessen.de (merkurneu.hrz.uni-giessen.de [134.176.2.3])
	by mailgw62.hrz.uni-giessen.de (Postfix) with ESMTP id E36E96800524;
	Sat,  9 Mar 2013 12:26:55 +0100 (CET)
Received: from [134.176.2.3] by merkurneu.hrz.uni-giessen.de with ESMTP; Sat, 9 Mar 2013 12:26:55 +0100
In-Reply-To: <CADgNja=Ej8jnYn027GX986VrmuqVemM7aE59rynHzUpToPVaEw@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: No virus found
X-Envelope-From: max@quendi.de
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217722>


On 08.03.2013, at 20:20, Andrew Wong wrote:

> On 3/8/13, Max Horn <max@quendi.de> wrote:
>> Same result, it works fine.
> 
> Just shooting in the dark here... I wonder if there's some background
> process running in OS X that's messing with the files/directories
> while rebase is working... backup, virus scan, etc? Or maybe some
> programs that you're using at the same time? Maybe also make sure you
> don't have any programs (shells, editors, etc.) opened that's
> accessing those files/directories?

I am pretty sure no other programs are accessing those files at the same time. But just to make sure I quite most programs. No virus scanner running. No backup running -- although, OS X automatically runs hourly backups as part of Time Machine... So just to be triple certain, I black listed the repos dir in both the "Time Machine" backup service and the "Spotlight" indexing service.

No diference. In the end I even did a reboot, but that made no differences either (which I am quite relieved about, I must say ;-).


> 
> Does the error always happen at COMMIT A and COMMIT B? Or is it all
> over the place?

It tends to fail in separate places, but eventually "stabilizes". E.g. I just did a couple test rebases, and it failed twice in commit 14, then the third time in commit 15 (which underlines once more that the failures are inappropriate).

The fourth time, something new and weird happened:

$ git rebase --abort
$ git rebase NEW-PARENT 
Cannot rebase: You have unstaged changes.
Please commit or stash them.
$

This is quite suspicious. It appears that git for some reason things a file is dirty when it isn't. That could explain the other rebase failures too, couldn't it? But what might cause such a thing?


I checked with "git st" and it reported no changed files. Executing the "rebase" once again then "worked" as before... I.e. it got stuck in commit 15. The next time it got till commit 16. Then back to commit 15. Etc. Now it is getting stuck on commit 17 (but it doesn't always go up as it did right now).


> 
> In cases where COMMIT A succeeded, did it say it did a 3-way merge? Or
> was it exactly as the output in your original message? i.e. no message
> at all

It's always a variation of the same message as shown in my original email. I.e.:

Applying: ...
...
Applying: commit XYZ
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
error: Your local changes to the following files would be overwritten by merge:
	some/file
Please, commit your changes or stash them before you can merge.
Aborting
Failed to merge in the changes.
Patch failed at 0015 commit XYZ
The copy of the patch that failed is found in:
   /path/to/repos/.git/rebase-apply/patch





Thanks,
Max