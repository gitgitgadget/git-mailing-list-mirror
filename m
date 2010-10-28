From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Bugs in Gitosis
Date: Fri, 29 Oct 2010 05:24:54 +0530
Message-ID: <AANLkTi=pdSyjd5ACu8D_Yio5KX68W2n0e=LXXeTw70mS@mail.gmail.com>
References: <26E9B811E137AB4B95200FD4C950886BA9665D70@orsmsx507.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Olsen, Alan R" <alan.r.olsen@intel.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 01:56:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBcKk-00082d-OM
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 01:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759377Ab0J1Xy5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Oct 2010 19:54:57 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:65167 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759139Ab0J1Xyz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Oct 2010 19:54:55 -0400
Received: by yxk8 with SMTP id 8so1342162yxk.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 16:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vbSVMHg24hYKN2M3pAz72neUYmAadtN4bmjn9uO+pSI=;
        b=Na3OniKU9IOkroGa28UoFI/OLfFX6exAZsawb4wBbPjC+6xGL6e6XYzDh9v6TbIiPl
         Gtt4iOyUsZcUNLQnKFT9vbnHqx5AD5o8RgDcTcL0LyJacuQ1Wfh+/rQwnxCyMhrkEsTO
         yAo6VEWLnmJ7g/JA5EB8qoM/kMoBdl2pwAIdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YwRDEMAsyx6GOKBvqEFlCozXVXygLAvgOvVvCFw5EIMAg9B73sNQUetfR9YP5N1q4i
         b/XSU1Fr3aKMGEkungrA/gluynmrWraPR0IAT3GwABZhs/Nl44p443f6LSTcHF1vN1u6
         gYOHxeubwVZ0P52KA4BHeTw3keWr+AgZlDhRs=
Received: by 10.90.8.40 with SMTP id 40mr3518409agh.17.1288310094785; Thu, 28
 Oct 2010 16:54:54 -0700 (PDT)
Received: by 10.90.70.7 with HTTP; Thu, 28 Oct 2010 16:54:54 -0700 (PDT)
In-Reply-To: <26E9B811E137AB4B95200FD4C950886BA9665D70@orsmsx507.amr.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160253>

I can't speak for gitosis -- I thank my stars every day that
the gitosis author did not reply to my emails back then,
because otherwise there may not have been a gitolite.

But I will try and address a couple of points which strike
me as important, especially ones that affect gitolite also,
just for completeness.

On Fri, Oct 29, 2010 at 2:28 AM, Olsen, Alan R <alan.r.olsen@intel.com>=
 wrote:
> [Sorry this has taken so long. Work was been eating my time.]

> Here is my list of current outstanding issues with
> Gitosis. =C2=A0I do not have fixes for these at the moment, but
> people and web indexes should be aware of the problems.
> The author of Gitosis seems to have been taken off-line.

<wink, wink> I think that is the first issue ;-)

> (The list may not be complete. I may have forgotten
> something.)

> 1. Multiple duplicate keys parsing problem

> This can happen when you have multiple people
> administering a repository. (Especially when those people
> are responsible for separate projects on the same server.

> You have a.pub and b.pub. These are both the public key
> for "Bob". (The same exact key in two files.) =C2=A0Any group
> that a.pub is added to Bob will have access to. Any group
> that b.pub is added to that does not contain a.pub Bob
> will not have access to. =C2=A0(It seems to sort the keys and
> only sees the first occurrence of the key, not all
> occurrences.

Gitolite will do the same thing.  This is an artifact of the
fact that neither of them is looking *inside* the key and
comparing with others, coupled with the fact that sshd does
a linear scan, and when it finds a match it goes with it.

I can tell you that in gitolite, I have no intention of
adding that check by comparing the contents of the keys.

However, gitolite does have "sshkeys-lint" which will catch
the problem and tell you that second key will be ignored by
sshd.  You have to run this manually though.

> 2. Trees with working directories kills Gitosis

> If any of the repositories in the repository have a
> working directory, Gitosis will fail on a push to
> gitosis-admin with a bunch of Python barfage. =C2=A0(I don't
> have an example at hand, but if you look at the code, it
> is looking at ".git".) This usually happens when someone
> tries to shortcut the process by cloning code into the
> repo on the local machine.

Good.  A server side repo has no business having a working
tree ;-)

Gitolite was modelled after gitosis, although it's hard to
imagine that now, seeing how far apart they are today.

Server side repos =3D=3D bare repos.  Bare repos =3D=3D .git suffix
as a convention in git-land.  This convention becomes
"standard" in gitolite.

"cloning code into the repo on the local machine" -- if I
assume git clone, just add --bare maybe?

> 3. Gitosis needs to have access to everything.

> If your mount point for the repository is /repo you have
> to create a directory under this, else /repo/lost+found
> prevents Gitosis for initializing correctly. It is a
> permissions issue.

Gitolite will only care about directories ending in ".git".

> 4. Typos are deadly.

> If you push a gitosis.conf file to gitosis-admin that has
> a non-parseable typo, gitosis will have problems. The
> immediate effect is that the authorized-keys file does not
> get updated. (New keys do not get added to the file, but
> existing ones work up except for the typo areas.) The only
> way to fix this is to hand-correct the copy on the server.
> Rerunning the gitosis-init script on the server will fix a
> lot of problems and does not overwrite existing configs.

What I found more problematic was it would silently ignore
typos such as "member" instead of "members".

Gitolite will show you lots of errors.

You can still push up a botched-config (syntactically
correct but you managed to lock yourself out by typoing your
own name!), but you don't have to throw in the towel --
there is "gl-dont-panic" (written 2 months after "towel
day", to my eternal regret ;-)

Sitaram
