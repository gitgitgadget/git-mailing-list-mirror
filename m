From: Igor Lautar <igor.lautar@gmail.com>
Subject: Re: git-svn multiple branches and merging
Date: Thu, 12 Mar 2009 10:31:36 +0100
Message-ID: <5fdd0830903120231t2ba2f126of41030161869cd33@mail.gmail.com>
References: <5fdd0830903020409j6e2b5269ubfb3ae6fe8266734@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 10:33:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhhHo-0002ys-SX
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 10:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbZCLJbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 05:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbZCLJbk
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 05:31:40 -0400
Received: from mail-bw0-f178.google.com ([209.85.218.178]:43515 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbZCLJbj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 05:31:39 -0400
Received: by bwz26 with SMTP id 26so99048bwz.37
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 02:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=RE3xvAzpJ8vD2wT4DsKhuJzpRYX0uCAjZQCM7N5H8Jw=;
        b=rvKZwXO2tLFEh63pRpzFw4JTd2dHotm2PDTXtsmHs/5v2C90L2oV58BdwsXfA3LGAc
         EiBjNFg/3LXky4VC+GNb909UMWBXcP1INoEnt1jT1Br6jfGlC279f4iRMzUUuejjVton
         Vw6OM+PEgrhXEYDg2jJgX6vgcYA0iGaTNvgEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=Twqi+8yMCkxtbYAeMjfPYt8ebRg2iuwvcHNNkln7DE177/InelNjMS6fMuKUeLWK01
         2Vdx0CpTExXl44OIvVLJgziEKnROl6jDYveLmV3S3i1RmO7OGncVYmEfeJt2avIz0fMY
         VY1PZTawp0lGOqFgUJjtSgqyhu5kaQGTVi7gw=
Received: by 10.204.77.96 with SMTP id f32mr450777bkk.88.1236850296218; Thu, 
	12 Mar 2009 02:31:36 -0700 (PDT)
In-Reply-To: <5fdd0830903020409j6e2b5269ubfb3ae6fe8266734@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113028>

Hi,

Figured out a (little) better way.

Say A is point where last merge was done and B is head of branch we
want to cherry-pick from:

for c in $(git-rev-list --reverse A...B); do git-cherry-pick $c; done

I'm sure for can be replaced with something better, but it works for
me. However, I still need last merge (cherry-pick) point. It would be
nice to hear if anybody has a better idea...

Regards,
Igor

On Mon, Mar 2, 2009 at 1:09 PM, Igor Lautar <igor.lautar@gmail.com> wrote:
> Hi All,
>
> I'm using git-svn to manage quite large svn repository. This
> repository also does not follow 'general' svn rules about how to name
> branches.
>
> So we have something like:
> trunk -> development
> branches\version1 -> version1 maintenance
> branches\custom\version1_fix -> customized version1 with certain fixes
>
> etc.
>
> When importing, I've only imported trunk and branches I'm interested
> in. Thus, I have multiple remotes for which git-svn does not know they
> are related (or how they branched from each other). Also, I have not
> imported whole history, as its just to much trouble.
>
> Now, I want to start a new branch, lets say branches\dev1, which is
> branches from trunk. This will be used for various improvements, which
> do not go to trunk immediatelly.
> I also want to keep this branch in sync with main trunk.
>
> Up to now, I have been doing this by git-cherry-pick all changes from
> dev1 branch point. Is there a better way to do? Note that branch dev1
> in git-svn does not know about previous commits in trunk (git remote
> ref was initialized from branch point for dev1).
>
> Just merging trunk (represented by a remote in git-svn) makes a mess
> (as expected). Basically, what I want to do is tell git-svn that merge
> was already done up to a certain point from that branch so git-merge
> then only picks up new changes from that point on (and the ones that
> have not been cherry-picked).
>
> Is there a way to get out of this mess? I'm fine with cherry-pick, but
> it requires some manual labor (like remembering/finding last
> cherry-picked commit).
>
> Thank you,
> Igor
>
