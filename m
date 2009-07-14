From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [ANNOUNCE] Stacked Git 0.15-rc1
Date: Tue, 14 Jul 2009 22:05:04 +0100
Message-ID: <b0943d9e0907141405p317df38fm99f171a3e1d7d118@mail.gmail.com>
References: <b0943d9e0907121540n4b9199e2re3152e71d84a0f5@mail.gmail.com>
	 <20090714175259.GA18250@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 23:05:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQpBw-0007bG-7P
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 23:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490AbZGNVFJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2009 17:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756444AbZGNVFI
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 17:05:08 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:55318 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756349AbZGNVFG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 17:05:06 -0400
Received: by bwz28 with SMTP id 28so1039358bwz.37
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=/s7PF7fXiXAi+x2PxOPSxQgsQ78QcvkvfjbipgGDXj4=;
        b=jzzbZJWOnsIQsV0x/uxSq7gdoKpGOhu+QpVLaJoPEeJwgx3fBzolTJ3yI+Eecgzs3W
         ADRXQ6488C8ZlNSPd32gA2fF/KGCw7Z+8Jqh9acDVobM5oeTA2DyvVxeD6+pXT5XQ9Wj
         fOj0HZSBHtiiesba0eOjKAUtPizN/8/8KyOOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=k/giWuIK54AgNBSMOy6vPZf7kbQReZtwcmwogmz/Mtdscj33udxOma4LvOe6qUSrHR
         7UvDmtVjpOxMLizvjFOlNxaZHKr1/SSvE/jzW4rtYTZHxnw/e9Hg1fXD9f5oI3f79i4e
         DaWVreipmKgqq5EhpzEN6H+aMFusvaKIrIn84=
Received: by 10.223.107.135 with SMTP id b7mr3288604fap.30.1247605504632; Tue, 
	14 Jul 2009 14:05:04 -0700 (PDT)
In-Reply-To: <20090714175259.GA18250@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123270>

2009/7/14 Larry D'Anna <larry@elder-gods.org>:
> * Catalin Marinas (catalin.marinas@gmail.com) [090712 18:41]:
>> - New 'publish' command for maintaining merge-friendly branches
>
> I'd like to know more about that. =A0The documentation doesn't say mu=
ch. =A0What's
> it do exactly?

You basically keep two branches - one with patches where you can
freely update, reorder, add and remove patches (re-writing the
history) but usually private and another public that people can merge.
The history is never re-written on the public branch and you never
need to work on it directly. The tree of the public branch head is the
same as the stgit branch tree (but history may differ).

The publish command checks for any new changes on the stgit branch and
generates commits on top of the public branch (called <branch>.public
by default). It detects new patches added on top of your branch and
adds them as new commits to the public one. If the stgit branch was
rebased, it generates a merge commit on the public branch. If a patch
was modified and you then publish, it may ask for a commit message to
describe the change. If you reorder patches but the final tree is not
modified, no new changes are published.

I also find it useful when maintaining several stgit branches and want
to merge them into a master branch. If there are conflicts, they need
o be resolved every time I rebase the stgit branches. To avoid this,
in the master branch I only merge the published branches (the master
branch on http://www.linux-arm.org/git?p=3Dlinux-2.6.git;a=3Dsummary is
created this way). This also helps with conflicts with upstream as you
only need to solve them in the stgit branch rather than the master
one.

--=20
Catalin
