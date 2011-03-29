From: Tor Arntsen <tor@spacetec.no>
Subject: Re: how to squash two commits into only one
Date: Tue, 29 Mar 2011 10:50:57 +0200
Message-ID: <AANLkTikLuGh6VRReWvu4yT1v2VE_FXPBCx+9kXMX1Mni@mail.gmail.com>
References: <AANLkTi=B37GABBc-YWfJN29Mh0kx4Tn8KenD5dJFo9j1@mail.gmail.com>
	<AANLkTi=5e4WUuZHcEJD50yJTw2eyYN_dN1S_7z62qy88@mail.gmail.com>
	<AANLkTin-0cBa293CQSf4kwMUG=w2j5zkSz1oBDhNqaNe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Lynn Lin <lynn.xin.lin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 10:51:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Udk-0006l0-HZ
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 10:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784Ab1C2Iu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 04:50:59 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58582 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab1C2Iu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 04:50:58 -0400
Received: by qyk7 with SMTP id 7so1795664qyk.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 01:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=H/kyxdj9h8BPNlb4nfaeS406cLPN7CZc4/XgOX/DmoY=;
        b=i0sYSLK8mvIw+fN30SGHREBM8MtUyQ59qlLr6A/5ZoJIsxGDEZx6wixkJukAQ42UWs
         taEPoZ9IZiRE6h6mHCe/HCr/WEpA//vEZiQHm7vOMvRo8yu+PHwthMLpce3cRfJgNWOx
         3UQdKKivU8jwT3rYZxERZv4h9NShj20o/eAtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=WQEysT6zMbBkVb6pT1nYOQZzX6chxv0U+GZtFwkxS0Ow+Zl0xyCXM3TFU9CpDaF8yg
         CArDFlSTcezgG6ElC0JqJQmNEfV66R0gNHx+0Ye4J2lT0t9TIFB06iYZEi4CKugvm0fQ
         30LOki9u3R4igsd6syiYqrDsWyszcHvKH7qFs=
Received: by 10.229.22.138 with SMTP id n10mr4230262qcb.175.1301388657555;
 Tue, 29 Mar 2011 01:50:57 -0700 (PDT)
Received: by 10.229.25.15 with HTTP; Tue, 29 Mar 2011 01:50:57 -0700 (PDT)
In-Reply-To: <AANLkTin-0cBa293CQSf4kwMUG=w2j5zkSz1oBDhNqaNe@mail.gmail.com>
X-Google-Sender-Auth: ezL6euOANIUVk10I5n-5over2ag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170247>

On Tue, Mar 29, 2011 at 10:24, Lynn Lin <lynn.xin.lin@gmail.com> wrote:

> Thanks .However my case is like:
> git log
> 1
> 2
>
> I want to squash 1 to 2,what's the commit I should specify with rebase -i

That would be 3, i.e. rebase -i 3

That won't work if there are only two commits in total.. rebase needs
a commit before the one you want to squash to. But in that case you
would do 'git reset HEAD^1' (and end up with only commit 2, and 'M'
for the modifications originally done in commit 1), 'git add' <the
files changed>, 'git commit --amend', which is exctly what Henrik
described earlier.

There is a particular problem if you have this sequence:
git log
 1
 2
 3
 4
 5  (initial commit)

and you want to squash 4 into 5.. there's no hash 6 to rebase -i to.
There are several ways to do it, but what I do is something like this:
git checkout 4
git checkout -b tmp
git reset HEAD^1
<add files>
git commit --amend
git merge master
git branch -M tmp master (<---- rename the tmp branch to 'master')

the new master now has 4 and 5 squashed.

I'm sure others on this list have different ways to do this, but it's
the one method that looked obvious to me so that's what I did when I
needed it (anyway it's more or less how I fixed historic commits in
the past before I learned about 'rebase -i' .. well, rebase -i didn't
even exist with the versions of Git I used back then anyway).

-Tor
