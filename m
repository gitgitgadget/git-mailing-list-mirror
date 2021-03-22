Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121A0C433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 08:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B834161584
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 08:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhCVIqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 04:46:15 -0400
Received: from mail.aegee.org ([144.76.142.78]:38324 "EHLO mail.aegee.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhCVIpp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 04:45:45 -0400
Authentication-Results: mail.aegee.org/12M8jeu92024377; auth=pass (LOGIN) smtp.auth=didopalauzov@aegee.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
        t=1616402742; i=dkim+MSA-tls@aegee.org;
        bh=YSOO88ynjLn/PpF6jBLQ6wTQklBmYc0xlUVLc/BBcow=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=HBIqlf11/hRDebAHM4cicbNGpcjtmwfaZs5QtDBmzh1IHtWjs6mcQIPG2+6ICM5S1
         0pWJGBA3mIQZ/ZsJhlrM/wWEdyx3f+zat89zL/J/uqVCUomWqPuEwG7awKe86VdObq
         GDiwW95IUhY6d0O3XcJy93Pta1aMo+nCoDzYopwCx8/4kKAtTjZRiZVT3C6SsKg4r0
         GKoIBweRVmRrkx+SNWCVmz63VeSNIzx3EZ+aYYmWn+wMtrDzfsHmdUtpCSFXJkvKOe
         xb8080+khVx0ge8Eg6DIZ1yxLgntQEhStm7g/jWl5CuW0DOLTStJewNYcbkB198PlR
         xEj5RSN53gW9d6v2NuYGKt0SAFdzR50y6QhA4koGweLOSU999A6JwgvZk9EO7Iu8Yd
         TV6Je5eMLYgMj54ytvY+6rf05rUPW/kXrjHcKFI3Gv/mMpCzk+Em9tyb8thZeOZDEJ
         y1kYoefsNDS2/HgqG4pLLNFTpMIenCwTiUwh5cL/ivLf78PO1HLD14C2RYUmEVpQLr
         0RdF5pe6drx3kzREj3puo4gNabHzfScFWq4fQg5GnXFugUTPvPlVrHsDs9O0tW5ldA
         4iK0WZqFD1yK0JYwXPDqCFliFsyj0PW+ZuGnz5BkKprA+eyMlAHpKq8x9h3n+hnW6Z
         +pYoI2B7y3YJKFkFoCNMuuhw=
Authentication-Results: mail.aegee.org/12M8jeu92024377; dkim=none
Received: from [192.168.0.125] (87.118.146.153.topnet.bg [87.118.146.153] (may be forged))
        (authenticated bits=0)
        by mail.aegee.org (8.15.2/8.15.2) with ESMTPSA id 12M8jeu92024377
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Mar 2021 08:45:41 GMT
Message-ID: <3807b29f442ab7026418511f058ff9513ee200ec.camel@aegee.org>
Subject: Re: git diff --text does not work during rebase for binary files
From:   =?UTF-8?Q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD_?=
         =?UTF-8?Q?=D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2?= 
        <dilyan.palauzov@aegee.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Date:   Mon, 22 Mar 2021 10:45:39 +0200
In-Reply-To: <4ef94ca7-ec69-f350-1d76-6bb8745786f1@gmail.com>
References: <6afc8f1365627f08247f73da7e7e362c0b8ea560.camel@aegee.org>
         <4ef94ca7-ec69-f350-1d76-6bb8745786f1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.41.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I mean:

git init
echo -e "AB RA\nCADABRA\0" > a.txt && git add a.txt && git commit -
m"Initial"
echo -e "AB2RA\nCADABRA\0" > a.txt && git add a.txt && git commit -
m"Second"
echo -e "AB3RA\nCADABRA\0" > a.txt && git add a.txt && git commit -
m"Third"

git log -pa   show the diffs and handles the file as text.

git rebase -i HEAD~2

I EDIT the “Second” commit (the one before “Third”, not the second in
the editor).


master|REBASE 1/2$ echo -e "AB4RA\nCADABRA\0" > a.txt && git add a.txt
&& git rebase --continue	

[detached HEAD 78408d2] Second
 Date: Mon Mar 22 10:35:57 2021 +0200
 1 file changed, 0 insertions(+), 0 deletions(-)
warning: Cannot merge binary files: a.txt (HEAD vs. 149b67e (Third))
Auto-merging a.txt
CONFLICT (content): Merge conflict in a.txt
error: could not apply 149b67e... Third
Resolve all conflicts manually, mark them as resolved with
"git add/rm <conflicted_files>", then run "git rebase --continue".
You can instead skip this commit: run "git rebase --skip".
To abort and get back to the state before "git rebase", run "git rebase
--abort".
Could not apply 149b67e... Third
master|REBASE 2/2$

And now `git diff` and `git diff --text` both print:

diff --cc a.txt
index ee95164,d7db2f0..0000000
Binary files differ


But git diff --text should show how the files differ.

Greetings
  Дилян

On Mon, 2021-03-22 at 12:53 +0700, Bagas Sanjaya wrote:
> 
> 
> On 22/03/21 00.30, Дилян Палаузов wrote:
> > Hello,
> > 
> > I create a small text file ending with \0 and add it to git:
> 
> Did you mean `echo -e "\0" >> a.txt`?
> 
> > In .gitattributes I specify:
> > 
> > *.txt diff merge=text text
> > 
> > I create several commits by changing the small text file.
> > 
> > The result is at https://github.com/dilyanpalauzov/git-diff-biinary .
> > 
> > I do now
> > 
> >    git rebase -i HEAD~2
> > and before the “second commit” type E to edit that commit.
> > 
> > I change the small file.
> > 
> > git add a.txt && git rebase --continue
> > 
> > git says:
> > 
> > [detached HEAD bc00e34] second commit
> >   Date: Sun Mar 21 19:16:15 2021 +0200
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > warning: Cannot merge binary files: a.txt (HEAD vs. 04c77de (third
> > commit))
> > Auto-merging a.txt
> > CONFLICT (content): Merge conflict in a.txt
> > error: could not apply 04c77de... third commit
> > Resolve all conflicts manually, mark them as resolved with
> > "git add/rm <conflicted_files>", then run "git rebase --continue".
> > You can instead skip this commit: run "git rebase --skip".
> > To abort and get back to the state before "git rebase", run "git
> > rebase
> > --abort".
> > Could not apply 04c77de... third commit
> > 
> > 
> > 'git diff' and 'git diff --text' show:
> > 
> > diff --cc a.txt
> > index 7a61015,dc817ec..0000000
> > --- a/a.txt
> > +++ b/a.txt
> > 
> > The file does not contain <<HEAD===>>> markers, despite having
> > merge=text attribute.
> > 
> > HOW CAN I force git diff to show the differences and git merge to
> > include the <<<===>>> markers?
> > 
> > I have to say, that at different occassions git diff --text does work
> > ass expected (e.g. when I call git diff --cached --text).
> > 
> > I call now
> > git rebase --abort
> > git log -p
> > 
> > git shows the differences in the small text file ending with \0.  So
> > apparently log reads the option, but diff does not.
> > 
> > Using git 2.30.2.
> > 
> > Greetings
> >    Дилян
> > 
> 
> Does `file a.txt` shows it as being binary file? I do the similar and
> it just says "data".
> 


