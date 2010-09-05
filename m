From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH 07/15] cache_tree_update(): Capability to handle tree
 entries missing from index
Date: Sun, 5 Sep 2010 17:54:54 +1000
Message-ID: <AANLkTi=ijbaATavcujUY-WnEfKFKrNue_kP6vSngKSvQ@mail.gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
	<1283645647-1891-8-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 09:55:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsA45-0005Gs-Mp
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 09:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925Ab0IEHy4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 03:54:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64750 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab0IEHyz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 03:54:55 -0400
Received: by wyf22 with SMTP id 22so1770712wyf.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 00:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dwi9MjX38JQurM3rSueO6XRBQSM/HUW6tBLEShddKmE=;
        b=cvrmbBRGZQ9TCE9Tmvnw4rcGH1rnYiBdPfHr74oTZjUIyh7h6UUYdi2wMcZDTVPcPJ
         QgaRY2mRETCtKfdLgPMHbA4LuZyMTw3rJGyxEetP74kMGLvCmdMw+jiM3lfMZB7+bKoh
         o2LEFEbC4WqfOKIiEekKYSqACYWk7ycpgFveg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=j1OinBEuv024HbkEE2hWTa82IiznQL475jLqAhIsLwsTDFtYISIWMotAE5b+soXCzY
         GYrWQoX/lALu9C9xJS4EPC8cjKpzSimPSRh7Gx2MM/YWE1dGOO+2J3fIoSdxR3koJ7Ta
         c0ettbbhusIw0CfrJafdssRgK9OFAtvjpMuMY=
Received: by 10.227.37.8 with SMTP id v8mr654727wbd.37.1283673294062; Sun, 05
 Sep 2010 00:54:54 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Sun, 5 Sep 2010 00:54:54 -0700 (PDT)
In-Reply-To: <1283645647-1891-8-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155448>

On Sun, Sep 5, 2010 at 10:13 AM, Elijah Newren <newren@gmail.com> wrote=
:
> cache_tree_update() will write trees using the index. =C2=A0With spar=
se clones,
> the index will only contain entries matching the sparse limits, meani=
ng
> that the index does not provide enough information to write complete =
tree
> objects. =C2=A0Having cache_tree_update() take a tree (typically HEAD=
), will
> allow new complete trees to be constructed by using entries from the
> specified tree outside the sparse limits together with the index.

You are moving it closer to the index (from my view because I changed
in commit_tree()). This makes me think, why don't you move the base
tree into the index itself?

The index is supposed to save the image of full worktree. While you
don't have all path names, you have the clue to all of them, the base
tree. To me, that means it belongs to the index. That would reduce
code change to
 - cache-tree.c (generate new tree from the base tree and index)
 - read-cache.c (new sparse-clone index extension)
 - index writing operations (save the base tree in index): read-tree an=
d merge
--=20
Duy
