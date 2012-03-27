From: Kumar Pande <pandekumar023@gmail.com>
Subject: Re: How to setup git repository for internal collaboration, that can
 be rebased easily?
Date: Mon, 26 Mar 2012 22:50:54 -0700
Message-ID: <CANz+fEk0HJBvHM2Z9kA42kXb7Aq-GL9ASQ+HiT3JgRQe_XpJLQ@mail.gmail.com>
References: <CANz+fEmN2qm9Nwk4tyg0eCrKPR6WZg4kvqCkhB7TmYw2JKoJJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 07:51:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCPJM-0008GL-Qe
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 07:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755601Ab2C0Fu4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Mar 2012 01:50:56 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:65171 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353Ab2C0Fu4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2012 01:50:56 -0400
Received: by lbbgm6 with SMTP id gm6so4532046lbb.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 22:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=pGMaa5jM79X5FUr1Xas8mcMqYlDgr1EsfUhc4TlopVY=;
        b=I2vbIZIoHjOQI+2tlzVhtXi7Q/FbeI/xNgmP5ylCaKhvxQYLC+bRiHxekiaWyBvCzc
         C/Y05LadIvlozznEI2dcyncygsE/JFODMsw3V5Kt+92m32TOargY4ZNnL5wdgOnF4yST
         2FIlPQmMOxHhV6wmk77kmWGDDjYn8jD6A6W7t5o6bT4GD68WguDOAwA8v9qDeafmJAIQ
         9L8/zsbxR536BC+LExwreIzEdBAjM9MxbHaW8KJIkiWKhxeQb1crQjrZdP0qA3Vh9FZb
         z0bNYio8VZy8WSRR0q41eB5QwM2xkIqK4yieKRojF67eYRzZfFYWw6ZEgU3wUaREwUML
         nB2A==
Received: by 10.152.135.104 with SMTP id pr8mr17895080lab.27.1332827454715;
 Mon, 26 Mar 2012 22:50:54 -0700 (PDT)
Received: by 10.112.42.8 with HTTP; Mon, 26 Mar 2012 22:50:54 -0700 (PDT)
In-Reply-To: <CANz+fEmN2qm9Nwk4tyg0eCrKPR6WZg4kvqCkhB7TmYw2JKoJJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194013>

On Mon, Mar 26, 2012 at 12:08 PM, Kumar Pande <pandekumar023@gmail.com>=
 wrote:
> Pardon if this embarrassingly simple question, I am new to git haven'=
t
> found git-newbies mailing list.
>
> We have a situation where we want to setup internal git repository th=
at
> will be based on say linux-3.3 kernel.
>
> There are about four engineers working on developing things for custo=
m
> hardware. So would create a development branch say companyx-devel and=
 we
> will commit all of our changes to this compnayx-devel branch.
>
> We also want to keep upto date with latest kernel, so say if we want =
to
> move to latest 3.4-rc4 we could rebase (?) our origin to 3.4-rc4, of =
course
> fix any of the conflicts we may find etc.
>
> We are not sure how to =A0go about setting up the initial import of l=
inux3-3
> kernel into git repository on of my local servers?
>
> We know we should do following on the server:
>
> git init --bare
> git config core.sharedrepository 1
>

So this what we have done so far:

git clone --bare --shared
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git config core.sharedrepository 1

Now on my client side.
1. I checkout and another user John also cloned this repo using command=
:

    git clone ssh://gitserver/opt/git/linux.git

2. Now git remote -v shows me
git remote -v
origin	ssh://gitserver/var/git/linux.git (fetch)
origin	ssh://gitserver/var/git/linux.git (push)

3. created a branch
    git branch testbranch
    git checkout testbranch
    <add some files, edited some files, compile & test>
    git commit -am "Testing"

4. Now I push the testbranch to gitserver using
      git push origin testbranch
(this seems to have worked
     To ssh://gitserver/var/git/linux.git
        * [new branch]      testbranch -> testbranch

5. Now another user john  can clone this repo and make changes to this
testbranch, which I can also pull.

So we are good so far.

Now we are not clear or confused about is, say in one week or two
weeks linus updates the top of linux.git and if we want to rebase our
work to top of that tree. What exactly do we need to do ?

Would REALLY appreciate the help/guidance...

-Kumar
