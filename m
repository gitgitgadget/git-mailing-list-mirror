From: "Johnny Lee" <johnnylee194@gmail.com>
Subject: Re: Error: unable to unlink ... when using "git gc"
Date: Tue, 6 Jan 2009 17:18:21 +0800
Message-ID: <488807870901060118y2dbc7430ocea5cf9ce4bca3c7@mail.gmail.com>
References: <488807870901052300y57f59b90rdc03cc47c790b416@mail.gmail.com>
	 <7vy6xohkt2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 10:19:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK86F-00077L-FS
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 10:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbZAFJS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 04:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbZAFJS0
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 04:18:26 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:6740 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbZAFJSX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 04:18:23 -0500
Received: by wf-out-1314.google.com with SMTP id 27so8052354wfd.4
        for <git@vger.kernel.org>; Tue, 06 Jan 2009 01:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=G7VqasNNEUK0iTW3iUZyCClTKxgYyrwrl4TxbbYUCOk=;
        b=ktgoVCyBzTqQ8cXJi5w9EScEYIqTMsg2b+e89qpGqIvMziV+yqVSh641kaKFBhkDaY
         dFR75l9RJTcLWCjIShFkYX4b/1DBEAJINzCXmwcZP1Uj30dDM98MoKEMyl0gyFLZDtbN
         dTlnkVY92cqJ40Lk8ISUCO29TVxZbPEFfcBaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VNAaZG/2Bs9doOeoJ4zC9ctONXb+8YhJrmkDU28PsD2/XEfIv8b8jVeXxnPq7V7RiN
         kgxt2K+tDnGgZi8S0OA1vryMIWBSxrhATtpIcaazFeWBIlENrPEukHJ3uKlhQFPJ2kob
         rJqC9PCLLqELMni9W3u/ADcYi7u4XLtg8xH74=
Received: by 10.143.18.21 with SMTP id v21mr9075472wfi.336.1231233501731;
        Tue, 06 Jan 2009 01:18:21 -0800 (PST)
Received: by 10.143.15.1 with HTTP; Tue, 6 Jan 2009 01:18:21 -0800 (PST)
In-Reply-To: <7vy6xohkt2.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104670>

Thanks for your consideration Junio,

Peff has already helped me to figure out the root cause of this error
is a possible bad practice on collaboration work.

Here I attached the previous mail.

>>>>>>
Thanks Peff, I've checked the permission of .git/objects/16, it's
created by another user and thus I have no permission to remove it.

In fact, this is coming from a previous bad practice on setting up a
collaboration repository on a SSH server, here is what I've done so
far:
1. I have a server tomato, which has two users: "git" and "johnny"

2. User "git" has cloned a repository from elsewhere as ~git/golf/.git

3. User "johnny" has cloned this repository from git on another
machine, using command:
git clone johnny@tomato:~git/golf/.git localgit

4. It works fine, and user "johnny" has made some local commits and
wants to push the changes to git's repository, so he uses:
git push

5. But it's reported some errors about permissions, like:
error: Unable to append to logs/refs/heads/cupcake: Permission denied
error: Unable to append to logs/refs/remotes/origin/cupcake: Permission denied
error: Unable to append to logs/refs/remotes/origin/cupcake: Permission denied
ng refs/heads/cupcake failed to write
ng refs/remotes/origin/HEAD failed to write
ng refs/remotes/origin/cupcake failed to write
error: failed to push to 'johnny@tomato:~git/golf/.git'

6. That's normal, since the ~git/golf/.git is created by user "git",
and user "johnny" can't write it.

7. Then the user "git" has changed mode for all the files under .git
to writable.

8. This time, user "johnny" can push successfully.

9. But as you can see here, some files are created by user "johnny",
and thus user "git" can't write them.

It seems not a good practice for collaboration work, would you please
share your experiences with us?

Thanks very much and regards,
Johnny

On Tue, Jan 6, 2009 at 4:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Johnny Lee" <johnnylee194@gmail.com> writes:
>
>> While I'm looking at these "unable to unlink" files, it seems they are
>> read only:
>> git@tomato:~/golf$ ls -l .git/objects/16/
>> total 4
>> -r--r--r-- 1 johnny johnny 26 2009-01-05 09:25
>> b14f5da9e2fcd6f3f38cc9e584cef2f3c90ebe
>
>
> Check "ls -ld .git/objects/16" and see if it is owned by you and writable
> by you.
>
> In sane POSIX filesystem semantics, it should not pose with problem with
> respect to removal that a file is unwritable.
>
> What counts is the writability of the parent directory.
>



-- 
we all have our crosses to bear
