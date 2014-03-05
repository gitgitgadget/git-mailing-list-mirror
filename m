From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bad git log behavior with multiple glob path arguments
Date: Wed, 5 Mar 2014 17:01:17 +0700
Message-ID: <CACsJy8A28x5m1SLV-R=QrFniPXUbV+x9N27GA-j+Ut_oe_6oGQ@mail.gmail.com>
References: <CA+eQo_21j=GzsvWAjxzr+aFYcPcnnyozySOo0m9bO-xJq_6a9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeremy Nickurak <jeremy@nickurak.ca>
X-From: git-owner@vger.kernel.org Wed Mar 05 11:01:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WL8eD-0005Nb-UK
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 11:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbaCEKBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 05:01:53 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:64793 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120AbaCEKBt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 05:01:49 -0500
Received: by mail-qg0-f49.google.com with SMTP id z60so2303169qgd.8
        for <git@vger.kernel.org>; Wed, 05 Mar 2014 02:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DPTyZnsdzGrI56nhYPVQTZSgNgYXMPRSgaNt6ZAwZqg=;
        b=dR4oeTxK4spxnk2UZ1Q7ryZYtGtri0F59LbP7FUW8GVKx8HJgu0MWFnmsaylq4qM3O
         sVSYyxuuXFKBfn71+yiNR7ofSiWap4TMJOxBlBEO1WPZlpLfUwPoy9s2LKnJfqqas4vM
         EYnlSIYpsx0ADOaWykYuRJn6k94hBlZkfSWs+Cwe4cxN18WhGnbvrDdzr0bWO8jlXM+d
         0j5vPZb82eb4cxlU8pPsw7YbMDIOU+GzOled7eURhDOWUbADb+uP2lZYJ458xuNg2YBP
         dj6F22hT/7QRAEaSbvTb/Yxq5B9+/erRqVXv7uoTbU+omqVuk+z6V1Ay9lDZwcLFtcPn
         /IRQ==
X-Received: by 10.224.161.140 with SMTP id r12mr5652471qax.24.1394013709004;
 Wed, 05 Mar 2014 02:01:49 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 5 Mar 2014 02:01:17 -0800 (PST)
In-Reply-To: <CA+eQo_21j=GzsvWAjxzr+aFYcPcnnyozySOo0m9bO-xJq_6a9A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243432>

On Wed, Mar 5, 2014 at 12:56 PM, Jeremy Nickurak <jeremy@nickurak.ca> wrote:
> git log seems to understand globs in the last path argument, and the
> last path argument only. I didn't see anything in the git log man page
> expressly saying this was to be expected, but it does seem like it
> ought to work for all the arguments or none of them.

What version did you use? We have a fix in the same area,
e4ddb05 (tree_entry_interesting: match against all pathspecs -
2014-01-25), and it's in v1.8.5.5 and v1.9.0

> Here's a little shell script I ended up using to convince myself I
> wasn't going crazy. I'd expect the same output for all of the git log
> test, since they all specify (either with globs or not) all the files
> added to the repository. Alternatively, if globs aren't expected to
> work, I'd at least expect all the glob tests to return nothing.
>
> Note that glob matching doesn't seem to occur unless '--' is included.

do you mean "git log" does not run at all and complains about
disambiguation, or it runs but nothing is filtered?

> I'm not exactly clear on why that is.
>
> #!/bin/sh
>
> TESTREPO="$(pwd)/bad-glob-test-repo"
>
> rm  -rf "$TESTREPO"
>
> echo "Running tests in $TESTREPO"
> mkdir "$TESTREPO"
> cd "$TESTREPO"
> mkdir subdira
> mkdir subdirb
> mkdir subdirc
>
> git init
> echo a > subdira/file.txt
> echo b > subdirb/file.txt
> echo c > subdirc/file.txt
>
> git add subdira/file.txt
> git commit -m 'a'
>
> git add subdirb/file.txt
> git commit -m 'b'
>
> git add subdirc/file.txt
> git commit -m 'c'
>
> echo Glob Test 1: git log --oneline -- 'subdira/*.txt' 'subdirb/*.txt'
> 'subdirc/*.txt'
> git log --oneline -- 'subdira/*.txt' 'subdirb/*.txt' 'subdirc/*.txt'
>
> echo Glob Test 2: git log --oneline -- 'subdira/*.txt' 'subdirc/*.txt'
> 'subdirb/*.txt'
> git log --oneline -- 'subdira/*.txt' 'subdirc/*.txt' 'subdirb/*.txt'
>
> echo Glob Test 3: git log --oneline -- 'subdirb/*.txt' 'subdira/*.txt'
> 'subdirc/*.txt'
> git log --oneline -- 'subdirb/*.txt' 'subdira/*.txt' 'subdirc/*.txt'
>
> echo Glob Test 4: git log --oneline -- 'subdirb/*.txt' 'subdirc/*.txt'
> 'subdira/*.txt'
> git log --oneline -- 'subdirb/*.txt' 'subdirc/*.txt' 'subdira/*.txt'
>
> echo Glob Test 5: git log --oneline -- 'subdirc/*.txt' 'subdira/*.txt'
> 'subdirb/*.txt'
> git log --oneline -- 'subdirc/*.txt' 'subdira/*.txt' 'subdirb/*.txt'
>
> echo Glob Test 6: git log --oneline -- 'subdirc/*.txt' 'subdirb/*.txt'
> 'subdira/*.txt'
> git log --oneline -- 'subdirc/*.txt' 'subdirb/*.txt' 'subdira/*.txt'
>
> echo Explicit Test 1: git log --oneline -- 'subdira/file.txt'
> 'subdirb/file.txt' 'subdirc/file.txt'
> git log --oneline -- 'subdira/file.txt' 'subdirb/file.txt' 'subdirc/file.txt'
>
> echo Explicit Test 2: git log --oneline -- 'subdira/file.txt'
> 'subdirc/file.txt' 'subdirb/file.txt'
> git log --oneline -- 'subdira/file.txt' 'subdirc/file.txt' 'subdirb/file.txt'
>
> echo Explicit Test 3: git log --oneline -- 'subdirb/file.txt'
> 'subdira/file.txt' 'subdirc/file.txt'
> git log --oneline -- 'subdirb/file.txt' 'subdira/file.txt' 'subdirc/file.txt'
>
> echo Explicit Test 4: git log --oneline -- 'subdirb/file.txt'
> 'subdirc/file.txt' 'subdira/file.txt'
> git log --oneline -- 'subdirb/file.txt' 'subdirc/file.txt' 'subdira/file.txt'
>
> echo Explicit Test 5: git log --oneline -- 'subdirc/file.txt'
> 'subdira/file.txt' 'subdirb/file.txt'
> git log --oneline -- 'subdirc/file.txt' 'subdira/file.txt' 'subdirb/file.txt'
>
> echo Explicit Test 6: git log --oneline -- 'subdirc/file.txt'
> 'subdirb/file.txt' 'subdira/file.txt'
> git log --oneline -- 'subdirc/file.txt' 'subdirb/file.txt' 'subdira/file.txt'
>
> --
> Jeremy Nickurak -= Email/XMPP: -= jeremy@nickurak.ca =-
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy
