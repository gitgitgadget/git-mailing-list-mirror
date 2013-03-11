From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Mon, 11 Mar 2013 15:15:41 -0400
Message-ID: <CADgNjanQxMFrQG=7SqgAXv5PW8OEfG+1kZt_Mrq27OcP1uyGtA@mail.gmail.com>
References: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de>
	<494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de>
	<CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com>
	<205D17C4-F737-46E9-BC48-D16D5948C707@quendi.de>
	<CADgNjan9v++__TSPE55j7+=BBZrVEkMD52O+9kXAm-C8SRV+Ww@mail.gmail.com>
	<B21B6CEC-7507-47A1-9BBB-FB95EA6B831F@quendi.de>
	<CADgNja=Ej8jnYn027GX986VrmuqVemM7aE59rynHzUpToPVaEw@mail.gmail.com>
	<3B5EA38E-9603-4321-AA3C-74354BBC8BFC@quendi.de>
	<513B8037.7060107@gmail.com>
	<C79E1B20-2C42-49FF-A964-285A7049FDED@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Mon Mar 11 20:16:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF8Ch-0006l6-7e
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 20:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566Ab3CKTPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 15:15:44 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62302 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461Ab3CKTPn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 15:15:43 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr12so5357608wgb.35
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 12:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=+QHgCYTzRbaKVyD/oQrSF+0ChRxX6TqzPhr9Bytx0zE=;
        b=eANb/f4cbvNQffCS1sD+58+8x6S026cYV+olP7QesaW4FT7SbsH9GTp6DhTXpSm5kG
         AW2dt3+ZtZciuHv+4TJqSSpdXSU7bBJL0ov5hcf26Hvsw2qKl6qEaT2Ufq8rQKf3NtKM
         WUW3TQOKGI7mzIukuaKuSZt2qvGpUQWYl6gIVOodXiyln/Fr2OBaT5lZuKTmYpS9E5ZU
         rbRIehQNv9rgWgFtYUSISGTOZaWrFEp85pwtPrLKrdbvPfiKQO3xoi8W00cvRHbJ5SGG
         M1Zz1Dbs1YU5DO2XVPI+R6t2gwohAKY7XGrB03AIZkjSGwblyFH+pZvyv2E1XMlkkDCH
         wO/g==
X-Received: by 10.194.63.240 with SMTP id j16mr21577997wjs.45.1363029342011;
 Mon, 11 Mar 2013 12:15:42 -0700 (PDT)
Received: by 10.194.138.107 with HTTP; Mon, 11 Mar 2013 12:15:41 -0700 (PDT)
In-Reply-To: <C79E1B20-2C42-49FF-A964-285A7049FDED@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217901>

On 3/10/13, Max Horn <max@quendi.de> wrote:
> I did run
>
>   touch lib/*.* src/*.* && git update-index --refresh && git diff-files
>
> a couple dozen times (the "problematic" files where in src/ and lib), but
> nothing happened. I just re-checked, and the rebase still fails in the same
> why...
>
> Perhaps I should add some printfs into the git source to figure out what
> exactly it thinks is not right about those files... i.e. how does it come to
> the conclusion that I have local changes, exactly. I don't know how Git does
> that -- does it take the mtime from (l)stat into account? Perhaps problems
> with my machine's clock could be responsible?

Instead of using "touch", maybe it'd be better if you run "ls-files"
and "stat" at the point where rebase failed. You should run the
command as soon as rebase failed. Don't try to run any git commands,
as they might change the index state.

And yes, git does make use of mtime and ctime from lstat to some
degree when detecting file changes. Inserting printf's to print the
timestamp might help, but the output might be too overwhelming to make
out useful information, especially during a rebase.

BTW, it looks like "stat" command on OS X only prints out timestamps
in seconds, and doesn't show you the nanoseconds part, which may be
significant in your situation. Instead of using the "stat" command,
try using this python command to print out the nanoseconds parts:
python -c "import sys;import os;s=os.stat(sys.argv[1]);print('%d, %f,
%f' % (s.st_size, s.st_ctime, s.st_mtime))" file1

Perhaps you could hack git-am.sh a bit to get more debugging info too.
Hm, maybe a good place to start is un-silencing the output of "git
apply". Inside "git-am.sh", you should see a line like:
    git apply $squelch
Remove the $squelch, and see what output it generates.

Also, since you're getting the 3-way merge, you could also insert the
"ls-files" and "stat" right after "git-merge-recursive", but before
"die".
