From: Tim Harper <timcharper@gmail.com>
Subject: Re: git submodule remove?
Date: Fri, 10 Jul 2009 23:27:25 -0600
Message-ID: <e1a5e9a00907102227y4ea2b1f6y2e9882afd726a4eb@mail.gmail.com>
References: <32c343770907081241h5925545ah1cb551b31e45ddc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 07:30:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPVAo-0005lk-Ah
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 07:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbZGKF1r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Jul 2009 01:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbZGKF1q
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 01:27:46 -0400
Received: from mail-px0-f193.google.com ([209.85.216.193]:37196 "EHLO
	mail-px0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbZGKF1p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jul 2009 01:27:45 -0400
Received: by pxi31 with SMTP id 31so928566pxi.33
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 22:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=YDB83DJCCTLrABjpmT8/floDKjP37fsJ53FS3DcQ+V8=;
        b=pLkIvMMNBstukCju9ZmBaw5W5k21Z9eGDHl6X2itAPA+Dfs2vibFbAeTL9wctq6idD
         zRfkVu8BRo7tdKeCGicv55Ht3doXK1EMi0Gu5d5soPOTI29+uzWamrfKkcbYmhDxONSJ
         VfacEYiCmoUCCf+rpBgzFsRvIjekjQa60Z0wE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nGJtwFk0qjA2pntJI3EP8c+0Yf3OB+byoTDVqfc9JP6RiICz61etNpkkrdaDnPs/HZ
         7Fml8NgmvV7/ndlKy9OWR2WM1NPxTNZw87qMjWsSDPt5ucffgi79qtqz983L1NoOXjXt
         HCNSKRhU0LymQL8bxpEKf8S3P8sJTOft5mH94=
Received: by 10.141.29.16 with SMTP id g16mr1693578rvj.214.1247290065054; Fri, 
	10 Jul 2009 22:27:45 -0700 (PDT)
In-Reply-To: <32c343770907081241h5925545ah1cb551b31e45ddc0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123100>

On Wed, Jul 8, 2009 at 1:41 PM, Tim Henigan<tim.henigan@gmail.com> wrot=
e:
> Hello,
>
> I recently encountered a situation where a user wanted to remove a su=
bmodule
> from a repository. =C2=A0Searching the mail archive, I found this thr=
ead
> [1], but it does
> not appear that it was ever followed up.
>
> The Git Submodule Tutorial [2] has instructions for removing submodul=
es, but it
> seems natural to teach git how to "submodule rm".
>
> This change would require git-submodule.sh to:
> =C2=A0 =C2=A01. Modify the .gitmodules file (remove the entry for the=
 submodule).
> =C2=A0 =C2=A02. Modify the .git/config file (remove the entry for the=
 submodule).
> =C2=A0 =C2=A03. Delete the newly untracked files.
>

Submodules are tracked by the tree.  You'll need to 'rm -rf' the
submodule, and then 'git rm' the folder to remove it.

> Another option to consider would be a "submodule rm --cached" option =
which would
> keep the newly untracked files. =C2=A0However, with this option, I be=
lieve
> it should still
> descend into the submodule directory to remove the leftover submodule
> ".git" folder.
>
> Is there another way of doing this? =C2=A0If not, does this sound lik=
e a
> reasonable change?

I can think of the only opposition being how blatantly dangerous it
would be. You're creating a command that will nuke the whole
repository, along with any unpushed changes.  There's potential there
for someone to seriously injure themselves without realizing it.

There's also the issue of once you delete a submodule... now what?
Git won't automatically remove them from other repositories when the
change gets pulled.  The folder will show up as untracked.  So far the
current paradigm with git submodules is git is very "hands off" and
leaves as much as possible to you. I think we would have to see a
change in thought consistently around how to approach submodules
before git implements anything of this sort.
