From: Jean Privat <jean@pryen.org>
Subject: Re: [PATCH RFC] git describe without refs distinguishes dirty working 
	tree
Date: Fri, 16 Oct 2009 17:52:21 -0400
Message-ID: <dffdbd190910161452o4ac0b426i7c48649eafa0d53@mail.gmail.com>
References: <dffdbd190910160812h6d6a876el8261a622b5439b30@mail.gmail.com> 
	<20091016173902.GT10505@spearce.org> <7veip3t6rm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 23:52:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyujA-0005Kg-2W
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 23:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbZJPVwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 17:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbZJPVwh
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 17:52:37 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:49731 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbZJPVwh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 17:52:37 -0400
Received: by pzk26 with SMTP id 26so1909397pzk.4
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 14:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type;
        bh=LVRxy2Wg0mpMxarMLPB+L15Zt2r7ltz0xuDobkudYpQ=;
        b=KGJguQfbufSCl33st6aSo6GHKlg97OlJLHmMW0XPXc7qWFXq3Pbax8GfldayxXS7Uo
         Whs+MwoF8D4am8R95eizZQk2TB2xk8rS0JkW1fEDHBBJz9Uesuan6KW0wSsgUyWGRYZU
         BtCNkPaezutVO/HZHV6cOvXPo5kQ2YH9QrAbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=uceNiNoNesrKOfAjqcWQNa1feRwuPJoeDJBr+DuPiqmDtUn1nbhTvg7ysGmRFQFM+H
         ca2a1uTu7PhnYwtMPgPZVMYA5eoCRyiK3Ew5DcERn9TBXgKUXeADZ1gKo8RKYNm9dgM+
         KHi3sKDl485NVwwohg6Rp6/8V5dy98nLlELbQ=
Received: by 10.140.157.1 with SMTP id f1mr184485rve.228.1255729961098; Fri, 
	16 Oct 2009 14:52:41 -0700 (PDT)
In-Reply-To: <7veip3t6rm.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: b584a4db673e193e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130529>

> I still haven't heard anything that helps me to decide which way the
> default should be.  The only concrete thing I have heard against the
> change of the default is that it will break existing setup, but I haven't
> heard anything concrete for the change yet.

As a said in the comment part of the initial message, I initially
planed to add a --worktree option that means "I want you to describe
my working tree". Knowing that from my naive point of view, the
description of the working tree is what build script wanted :
description of HEAD (on which is based the working tree) + saying that
if the working tree is dirty or not (done manually by scripts).
Moreover, in my naive view with the "--worktree" option, no refs where
allowed (i.e. describe the working tree xor describe some commit
references).

Then, I realized that for some other git commands that can work both
on the working tree and on an arbitrary commit reference, the default
was to work on the working tree and require an explicit HEAD to work
on the HEAD commit. Thus it makes sense to me that "git describe"
alone should describe the working tree and that "git describe HEAD"
should describe the HEAD commit.
Moreover, since build scripts use "git describe" not to describe an
arbitrary commit but to describe the working tree, it is nice to make
what thez really want the default.

Currently, the breaking of scripts is the only reason that makes me
not entirely convinced that default should be to describe the working
tree. But I think that if "git describe" could be redesigned,
describing the working tree by default should be the right thing.
I also think that the breakage should not be so important:
* it could be fixed without requiring/checking a specific git version
* it appears only for people that build on a dirty tree
* the effect may be only to produce a strange version number
* git describe is porcelain :)
* 1.7 may break other things, so some fixing me be required anyway :).

If git people prefers that default remains HEAD, I have no real strong
objection (I still have to resend the patch because of line breaking
anyway).

> How about "describe --dirty" and "describe --dirty=-mod" (the latter
> creates v1.6.5-15-gc274db7-mod")

May be better than "--wortree" (especially because of the value part),
but what happen with
 $ git describe --dirty v1.2.1
should it show an error, output "v1.2.1" anyway, or output
"v1.2.1-dirty" if the working tree is different from v1.2.1 ?

-J
