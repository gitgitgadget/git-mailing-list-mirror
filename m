From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Patch (apply) vs. Pull
Date: Wed, 22 Jun 2005 18:04:47 +0100
Message-ID: <tnx1x6u9vbk.fsf@arm.com>
References: <1119284365.3926.15.camel@localhost.localdomain>
	<7vbr61j631.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Darrin Thompson <darrint@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 19:17:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dl8qN-000262-3g
	for gcvg-git@gmane.org; Wed, 22 Jun 2005 19:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVFVRMj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 13:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVFVRIw
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 13:08:52 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:31972 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261733AbVFVRFd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2005 13:05:33 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j5MH4e6i025101;
	Wed, 22 Jun 2005 18:04:40 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch1.emea.arm.com [10.1.255.57])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id SAA21510;
	Wed, 22 Jun 2005 18:05:03 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 22 Jun 2005 18:05:02 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr61j631.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Mon, 20 Jun 2005 10:22:58 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 22 Jun 2005 17:05:02.0419 (UTC) FILETIME=[877BE230:01C5774C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Have a look at StGIT for this, it might help.

Junio C Hamano <junkio@cox.net> wrote:
> FYI, here is what I have been doing:
>
>  (1) Start from Linus HEAD.
>
>  (2) Repeat develop-and-commit cycle.

Gather the related commits into an StGIT patch. It's actually easier
to only update a set of existing patches, similar to the quilt way.

stg new patch1
modify...
stg commit
modify...
stg commit

stg push/pop/new

etc.

>  (3) Run "git format-patch" (not in Linus tree) to generate
>      patches.

stg export. The problem with this one is that it doesn't preserve any
of the commit information but it can be adapted (though I'm not sure
it is worth since the patch won't be that readable).

>  (4) Send them out and wait to see which one sticks.
>
>  (5) Pull from Linus.
>
>  (6) Throw away my HEAD, making Linus HEAD my HEAD, while
>      preserving changes I have made since I forked from him.  I
>      use "jit-rewind" for this.

stg pop -a. This will remove all your changes grouped in stgit
patches. The HEAD is now Linus' old HEAD. Pull/merge will advance the
HEAD to Linus' latest HEAD.

>  (7) Examine patches that Linus rejected, and apply ones that I
>      still consider good, making one commit per patch.  I use
>      "jit-patch" and "jit-commit -m" for this.

stg push -a. This step will do a diff3 between the current HEAD and
the top of the patch as the two branches, and the bottom of the patch
as an ancestor.

If the patch was merged unmodified, stgit detects this and warns you
that the patch is now empty (it detects it even if a file contains
other modifications apart from yours). If you modified it in the
meantime or the Linus modified it when merged (or some other third
party patch modifies yours), you will get a conflict you can resolve.

>  (8) Go back to step 2.

-- 
Catalin

