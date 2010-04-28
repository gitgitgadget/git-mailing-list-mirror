From: Marin Atanasov Nikolov <dnaeon@gmail.com>
Subject: Re: Git and cvsimport
Date: Wed, 28 Apr 2010 08:27:28 +0300
Message-ID: <k2r717f7a3e1004272227g256c42fei6951180db855ad9f@mail.gmail.com>
References: <i2l717f7a3e1004260727wd87900a5tcfb61a3142d0ba@mail.gmail.com>
	 <4BD69450.8040608@drmicha.warpmail.net>
	 <l2w717f7a3e1004270341lea6cfe2aqdf8d2b490b1ec067@mail.gmail.com>
	 <r2xd2d39d861004270458v2e1cb73by78f53d71103b47e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Wed Apr 28 07:27:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6zo7-000710-3P
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 07:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479Ab0D1F1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 01:27:30 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:53343 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab0D1F13 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 01:27:29 -0400
Received: by wwi14 with SMTP id 14so460460wwi.19
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 22:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Jxn7JCmIMiWn/IRziaZUh34nPsF8I923XXNSe+5F/UU=;
        b=cJZGcqtXuG5rzHLp1VzOgu9CHl0gsu4P+phD/ZDwoxcpz2EoXgSaCiQC1391YyY+hU
         uJPTOYQphRgslEGdvj6n61usMbR60yEFsd/OiWiFU6+Mvhi9WfDNFt2JcHKwxFZSWCOZ
         52B+ZipkW44k/8v6vLUzoPu019XHqTUKzKV70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=R/d1XgSYtSbVYI1Qu4AEor7k/g7mTw3Xxvc01oZoKWFm+ksrMiX7X8Ky7Wb3+uEU2+
         xOYuKsOMFmA0T9ar6jEEIOFijDu+jJ4v6MBh80N8ekGtMAmP7CI3DfyRdhiPz8H+qDOZ
         F3nizl5UNK+y10KRSBCmo7YrbGAhkLiuOfnUU=
Received: by 10.216.91.9 with SMTP id g9mr2753554wef.194.1272432448256; Tue, 
	27 Apr 2010 22:27:28 -0700 (PDT)
Received: by 10.216.19.10 with HTTP; Tue, 27 Apr 2010 22:27:28 -0700 (PDT)
In-Reply-To: <r2xd2d39d861004270458v2e1cb73by78f53d71103b47e6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145970>

Hello,

On Tue, Apr 27, 2010 at 2:58 PM, Tor Arntsen <tor@spacetec.no> wrote:
> On Tue, Apr 27, 2010 at 12:41, Marin Atanasov <dnaeon@gmail.com> wrote:
>
>> Perhaps I didn't explain better what I want to accomplish :)
>>
>> I want to convert CVS repo to a Git one.
>
> But the above statement..
> [..]
>> What I want to do is to checkout from CVS the files which are tagged
>> RELEASE_1_0 for example, and then import the files to a Git repo.
>> Files tagged as RELEASE_1_0 differ from HEAD files, so I want only
>> those files with that tag for example.
>
> .. seems to be in conflict with the above paragraph. Files tagged with
> RELEASE_1_0 sounds like a revision tag (i.e. not a branch). If you
> want to checkout that snapshot and insert into a Git rep you could as
> well just 'cvs export -r RELEASE_1_0 <module>; git init; git add .;
> git commit'
> but that obviously won't give you any CVS history in the Git repo.
>

Yes, I could do that, but then I'll lose the history, which is the worst case.

The import will be a one-time action. Once we import everything from
CVS to Git, we don't use CVS anymore, so no need of incremental
imports.

> Is RELEASE_1_0 instead a branch tag? I.e. a CVS branch?

RELEASE_1_0 is just a CVS tag you create using `cvs tag <tag-name> <file>`.
The CVS repo does not contain any branches at all.

We have a lot of test and production systems, where production systems
fetch from a central repository the files tagged as STABLE, and test
systems fetch the files tagged as TEST.

Another workaround that I'm thinking of might be:

 1. git-cvsimport the whole CVS repository.
 2. create a new bare repo, and fetch the files previously imported by
git-cvsimport to master branch - that way we'll have all the history
we need in the master branch.
 3. checkout from CVS files tagged as STABLE, TEST, etc... to a new
repo, and then add, commit them to a git repo.
 4. fetch again the repo in point 3. to the bare repo from point 2.,
in the specified branch -> TEST, STABLE, etc..
 5. I won't have the history in the STABLE, TEST, etc.. branches, but
I'll have it in the master branch then.
 6. From later on we'll be using after all the TEST, STABLE, etc.
branches, so master will be kept untouched.
 7. On the central repository we'll just clone the already created
bare repo that contains the master, TEST, STABLE, etc.. branches, and
we'll set it to track TEST, STABLE, etc. for example.

What do you think about this? Is it a good approach at all?

Regards,
Marin
>
> -Tor
>



-- 
Marin Atanasov Nikolov
dnaeon AT gmail DOT com
daemon AT unix-heaven DOT org
