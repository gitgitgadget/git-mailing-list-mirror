From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: builtin command's prefix question
Date: Thu, 6 Dec 2007 22:26:29 +0700
Message-ID: <fcaeb9bf0712060726r383c3a36j798a439b9dbb0cae@mail.gmail.com>
References: <fcaeb9bf0712050856t5d730779q82783fdb9876f41@mail.gmail.com>
	 <7vlk88n648.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 16:27:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Icu-00060H-HY
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 16:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbXLFP0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 10:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752546AbXLFP0c
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 10:26:32 -0500
Received: from mu-out-0910.google.com ([209.85.134.186]:63115 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbXLFP0b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 10:26:31 -0500
Received: by mu-out-0910.google.com with SMTP id i10so355652mue
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 07:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6FGFlm2OYLhdDE6SNUgRQnHXsp+yGNhzcLFiz6SODgY=;
        b=oorfRSiGkJy6vpUdMTHJ0PA+EzI3dwnF97IyLiIKMk4D6vQavXOodGw9kQ48W3vt4rP1G8ip1Fh4zEtlAIZMepi80G2ETJN6+zXXi2t8volgwwxqy9dqfR3y++tB88BG1RQaAFbrFebf5b/c0qtaJv01Jytz0Bqe0j+DP885Nko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=vLLQMQvKpYX0q5nU0Qul9yUq2fiiN2kjL+leoRuoWmHQLFGh21Kuc8Hn4n8smLd15SfNT3GFGZjmrFV1L/fg7xfZqmdHQA5iBGHHZSjs7rXAzz1k/CEoFMzpamrNlE+TuG2zLdF29T564GZmLDZeca8J1JY3P84VOBTN5wnHEII=
Received: by 10.86.49.13 with SMTP id w13mr1136405fgw.1196954789510;
        Thu, 06 Dec 2007 07:26:29 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Thu, 6 Dec 2007 07:26:29 -0800 (PST)
In-Reply-To: <7vlk88n648.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67294>

On Dec 6, 2007 5:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The intention is:
>
>  * If GIT_DIR is set but not GIT_WORK_TREE (nor core.worktree in
>    config), you are either inside project.git/ directory of bare
>    repository or at the toplevel of worktree-full directory.  This has
>    been the traditional behaviour before GIT_WORK_TREE and we shouldn't
>    break the existing setups that assume this behaviour.  So in that
>    sense, with this combination:
>
>    - If the repository is bare, the value of the prefix should not
>      matter; the command that wants to look at prefix by definition
>      wants to run from a subdirectory but there is no notion of
>      "the user directory being a subdirectory of the top of the work
>      tree" in a bare repository;
>
>    - If the repository is not bare, the user directory _MUST_ be at the
>      top of the work tree, as that is what the traditional behaviour is.
>      Anything else would break existing setups.
>
>      IOW, if you use GIT_DIR and still want to run from a subdirectory
>      of the worktree, you must have either GIT_WORK_TREE or
>      core.worktree to tell where the top of the worktree is, and if you
>      don't, then you must be at the top.
>
>    So the right thing to do in this case is not going anywhere and using
>    prefix=NULL.

You are right. It is quite obvious from the code. No idea why I had
that in my mind.

>  * I would say it is a misconfiguration if GIT_DIR is not set and
>    GIT_WORK_TREE is, as the sole purpose of GIT_WORK_TREE is so that you
>    can work from a subdirectory when you set GIT_DIR.  I may be missing
>    an obvious use case that this is useful, but I do not think of any.
>    Dscho may be able to correct me on this, as he fixed up the original
>    work tree series that was even messier quite a bit during the last
>    round.

On Dec 6, 2007 6:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> However, if we define setup() to behave this way when GIT_DIR is not
> defined and GIT_WORK_TREE is:
>
>  (1) internally pretend as if GIT_DIR was specified to be the
>      directory where the command was started from (iow, do getcwd()
>      once upon startup);
>
>  (2) chdir to GIT_WORK_TREE (which means "callers of setup() always
>      run from the top of the work tree");
>
>  (3) set prefix to NULL;

(1) is fine by me, even if it goes up to find a gitdir. But (3), no,
prefix should be set as relative path from worktree top directory to
user current directory, not NULL.

> ...
> While I still think the combination is simply crazy and does not make
> any sense, if enough users on the list agrees that it makes sense, I
> wouldn't mind setup() did (1) to (3) mentioned above.  The alternative
> is simply to declare GIT_WOR+1 on whatever way that makes worktree less complicated. so your alternative ++K_TREE without GIT_DIR is a nonsense and
> either error error out or ignore GIT_WORK_TREE, which might be easier to
> explain to people.

I don't use either way you mentioned. So no comment here. But again,
no (3) please.
-- 
Duy
