From: Tony Wang <wwwjfy@gmail.com>
Subject: Re: git bug(?) for commit
 baf18fc261ca475343fe3cb9cd2c0dded4bc1bb7
Date: Mon, 7 Nov 2011 17:48:25 +0800
Message-ID: <841269128C1D4788816CA66A33ED39E5@gmail.com>
References: <BC404302028E4B6F8F2C27DC8E63545F@gmail.com>
 <CACsJy8C25qurZwTLuuZ8X4EUzg-NP_qwFjcPTZoEs7QOOS-WBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 10:48:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNLof-0004am-2N
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 10:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883Ab1KGJs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 04:48:28 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63387 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772Ab1KGJs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 04:48:28 -0500
Received: by ywf7 with SMTP id 7so5085089ywf.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 01:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:message-id:in-reply-to:references:subject:x-mailer
         :mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=8DENf45eP+PBTPvYiHtSLtfNIx+6jPUOyko+n9JHp0Y=;
        b=RNykXVdiIdL76e4zG9MgVZPOaZR0PEop38+ip7XAR3VqnQSuqgLiRTZbvbaXsNNANA
         cpycCbvYpzWBVgUD+x6IQsQMyf55yocEyaxmFdfU9yELkTTfpI0OyrN7gp7HnDD+HVQ/
         1pAqfTxS2ZMjd9PZJTu2qIIEpf4tGYBKEmpXo=
Received: by 10.43.43.130 with SMTP id uc2mr45583668icb.35.1320659307346;
        Mon, 07 Nov 2011 01:48:27 -0800 (PST)
Received: from tony-mac.local (wwwjfy.net. [68.68.99.210])
        by mx.google.com with ESMTPS id jm5sm35103929pbc.1.2011.11.07.01.48.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 01:48:26 -0800 (PST)
In-Reply-To: <CACsJy8C25qurZwTLuuZ8X4EUzg-NP_qwFjcPTZoEs7QOOS-WBA@mail.gmail.com>
X-Mailer: sparrow 1.4.3beta1 (build 977)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184966>

On Monday, November 7, 2011 at 17:30, Nguyen Thai Ngoc Duy wrote:

> Hi,
> 
> On Mon, Nov 7, 2011 at 3:59 PM, Tony Wang <wwwjfy@gmail.com (mailto:wwwjfy@gmail.com)> wrote:
> > Hi,
> > I don't know if a better way to report this, so I write to the author of the
> > commit. Please let me know if I do wrong. :)
> 
> 
> 
> 
> It's good that you bisect to the broken commit and send me. However
> you should always send to git@vger just in case I'm unavailable.
> 
Roger. 
> 
> > The thing is the commit baf18fc261ca475343fe3cb9cd2c0dded4bc1bb7 made an
> > option broken sometimes (it's weird, but it's true that it didn't happen
> > every time)
> > I set "branch.master.mergeoptions=--squash" in config, but when I do "git
> > merge b", the squash didn't work, however, "git merge b --squash" works as
> > expected.
> 
> 
> 
> 
> What was the expection? --squash was not effective or something else?
> 
Yes, it just merged like without "--squash" 
> 
> > I tried to debug, and found after this
> > merge.c:1104
> > head_commit = lookup_commit_or_die(head_sha1, "HEAD");
> > the variable branch becomes "s/origin/b", which is previously "b".
> > I used git bisect and found the
> > commit baf18fc261ca475343fe3cb9cd2c0dded4bc1bb7 caused this.
> 
> 
> 
> 
> Variable "head_sha1"? Strange because lookup_commit_or_die() takes
> "const char *" and the compiler should catch any attempts to change
> the variable.

No, variable "branch". It's declared as "static const char *branch;" in builtin/merge.c 
> 
> If you can reproduce it, can you make a small test case to demonstrate
> it? I'm not sure what "b" is and how you set up configuration for
> branch master. BTW what git version did you use?
> 
I'll try it.
Sorry, "b" is a random branch name, I should use a meaningful one.
I set by "git config branch.master.mergeoptions --squash"

I tried 1.7.7.2 and master of github.com/gitster/git.git (http://github.com/gitster/git.git). 
> 
> > I browsed the diff, and found the function lookup_commit_or_die
> > uses lookup_commit_reference, but not lookup_commit which was used
> > before lookup_commit_or_die replaced it.
> > Was it on purpose or typo?
> 
> 
> 
> 
> It was on purpose. HEAD may contain a tag, in which case
> lookup_commit() would to return a commit fail while
> lookup_commit_reference() can peel the tag to the commit.

However, I tried to make it lookup_commit and it worked as expected. I'll try to read some detail. 
> 
> > If possible, it'll be good that I can know some details.
> > Thanks!
> 
> 
> 
> -- 
> Duy



--
BR,
Tony Wang
