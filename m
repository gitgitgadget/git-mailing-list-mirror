From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: git-rebase -i prunes commits with empty commit-message
Date: Wed, 10 Mar 2010 14:34:39 +0100
Message-ID: <40aa078e1003100534j189eef5kd60855f80e9dd626@mail.gmail.com>
References: <40aa078e1003081207u20046916yda5a62d44ce7a401@mail.gmail.com>
	 <4B979AEF.5010201@alum.mit.edu>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 10 14:34:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpM3i-0000oA-Fm
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 14:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756479Ab0CJNel convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Mar 2010 08:34:41 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55989 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756357Ab0CJNek convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Mar 2010 08:34:40 -0500
Received: by wyb38 with SMTP id 38so97337wyb.19
        for <git@vger.kernel.org>; Wed, 10 Mar 2010 05:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sa8ulKRg4ysjtGmBiYgEml1YL89Fc0UrZT1JR1D2Enw=;
        b=kkLPutOhuIytNb4RvxqDLysTR82Q2kv0I+h1K4rTPpHt6Fe6G1pliZY+cw6S2nSHvI
         O0vG4B8Pu04Lt8AU/C20w1pDqgOpZrqqfMcJKEZc3GAMsiksAyBvCZr/cmh83tHM2zNe
         7XMJC1l1RuLYSS6Ht9RkjECZkHCLcGZEFoGnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=N30qpqwkxOpxWMra5JXPqAfMLp43tU/sfQFL5ETf+0ODpcrg6td8AcAUvSIfkplGeF
         rD04y8ykstTp5sDqB7cOs7A7fh8m95cSPNVuW5XSVIvm/C2U4cw4+EABceEGBxe8tMbE
         IP7Cem7ZPAg/UgeEGzkh7W73siAhXcwe87bFc=
Received: by 10.216.90.208 with SMTP id e58mr943905wef.57.1268228079138; Wed, 
	10 Mar 2010 05:34:39 -0800 (PST)
In-Reply-To: <4B979AEF.5010201@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141887>

On Wed, Mar 10, 2010 at 2:13 PM, Michael Haggerty <mhagger@alum.mit.edu=
> wrote:
> Erik Faye-Lund wrote:
>> I'm in the process of converting an SVN repo to Git, and in the
>> process I found one quite disturbing feature of
>> git-rebase--interactive.sh: It discards commits with empty commit
>> messages!
>>
>> Here's a recepie for reproducing the issue:
>> --->8---
>> git init
>> git commit -m "dummy" --allow-empty
>> git commit -m "dummy" --allow-empty
>> git commit -m "dummy" --allow-empty
>> git filter-branch -f --msg-filter 'sed -e "s/dummy//"'
>> git rebase -i HEAD~2
>> --->8---
>
> Does git really claim to handle commits with empty commit messages?
> That you have to use git-filter-branch to create the test case sugges=
ts
> that the answer is "no", but I don't know. =A0(git-commit, for exampl=
e,
> refuses to create a commit with an empty message.)

If git didn't, I'd expect it to be impossible to create them. This was
just a minimal example on how to reproduce it, and it's a silly
use-case. I think my original way of getting into the state was a tad
more legitimate:
1) I had an SVN-repo with empty commit-messages
2) I imported that SVN-repo into git through git-svn, and git-svn
appended it's meta-data to the otherwise empty commit-message.
3) I used git-filter-branch to remove the git-svn metadata (as the
git-filter-branch man-page suggest)

I don't know what happens when git-svn encounter empty commit-messages
with the --no-metadata option enabled. In my case, the decision to
fully migrate the repo to Git (instead of just using git-svn as a
nicer svn-frontend) came long after 1) and 2) were done.

> If indeed git requires commit messages to be non-empty, then the faul=
t
> here seemingly lies with git-filter-branch for allowing commit messag=
es
> to be completely deleted.

If there is some decided-upon restriction that commit-messages cannot
be empty, then I agree with you.

=46rom experiments, it seems that git-commit does not seem to allow
empty commit-messages. But I can't find this documented. I'm not sure
what git-commit-tree allows, but I think it should deny creating
commits with empty messages (possibly unless some option is given) if
there should be a restriction, because most scripts use this to
generate commits AFAIK.

But to be honest, it seems to me like in this precise instance it's
probably better to just fix git-rebase--interactive.sh. There's no
good reason for it to barf on the commits -- especially since
noon-interactive rebase handles them just fine. Unless someone screams
out loud, I might take a stab at it when I get time.

--=20
Erik "kusma" Faye-Lund
