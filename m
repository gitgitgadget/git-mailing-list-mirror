From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cc/cherry-pick-ff
Date: Sat, 20 Mar 2010 17:09:14 -0500
Message-ID: <20100320220914.GA31098@progeny.tock>
References: <7vhbof4fof.fsf@alter.siamese.dyndns.org>
 <20100317095218.GA6961@progeny.tock>
 <7vwrxaubjy.fsf@alter.siamese.dyndns.org>
 <201003180138.56529.chriscool@tuxfamily.org>
 <7v1vffqdm4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 23:09:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt6rG-0001Xs-Ap
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 23:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025Ab0CTWJK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 18:09:10 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:43845 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab0CTWJI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 18:09:08 -0400
Received: by yxe12 with SMTP id 12so1162746yxe.33
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 15:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Cn1qihGbMbxkmrcd/PQae2TWgly0o6cakULIO7zSpIg=;
        b=JC0R4kliQM0gGgZqSz3XGiRTOfsFKr5FNuiTAFKw1kNizDcJFSEkBwVNNOZtyH4Fh3
         k8brPPWC0ev14/Oaqzmo6YXnPKhSeUdjZ6736JysZw3H9pGAHGa4oVdV4IIqPblcapos
         vY9lHHdF7iCCrHgFHTgO5yoHFY1wD4wEo67c0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=wf/EgEl1us0Y8ONKwkivZZwUnuL0sN20IyHtoFt1z5YrN9mVFARNoyADiSt/+TsrBS
         PNaPa8Z/cr0tHlstxIenQ+pRkrOXeHLnpsyRIKqJgXZSKFufhYvgjLBkUNlUb5LofZ/m
         OC8/ef51nmpun4oA13tClBzhYtEuVz+zKAzPk=
Received: by 10.100.21.9 with SMTP id 9mr11600819anu.215.1269122947183;
        Sat, 20 Mar 2010 15:09:07 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm1743110iwn.11.2010.03.20.15.09.05
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 15:09:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v1vffqdm4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142761>

Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:

>> ... if we implement "git cherry-pick A..B", and if many people=20
>> start to use it, then perhaps it will make sense for --ff to become =
the=20
>> default.
>
> That doesn't make any sense to me.
>=20
> Think why you are saying A..B, with an explicit "A".
>=20
> It is because you know it is different from HEAD; otherwise you would=
 have
> done "git merge B"---slurp all changes between HEAD..B, which would b=
e
> equivalent to "cherry-pick --ff HEAD..B".

In a project that is deeply dedicated to a linear history, the workflow
might be something like this:

 contributor:
	hack hack hack
	git commit
	...
	git pull --rebase upstream; # Rebase for submission upstream.
	git push +HEAD:topic

 upstream:
	git pull --cherry-pick contributor1 topic
	git pull --cherry-pick contributor2 other-topic
	...
	run tests
	git push master

Here, =E2=80=9Cgit pull --cherry-pick remote branch=E2=80=9D is shortha=
nd for
=E2=80=9Cgit fetch remote branch && git cherry-pick --ff HEAD..FETCH_HE=
AD=E2=80=9D.
It is not always a fast-forward because contributors=E2=80=99 changes c=
an be
based on an out-of-date upstream version.

This imposes all the conflict resolution trouble on upstream and blames
the result on the contributors, which may be what some people want
(especially if upstream and the contributors are all the same person).

> But running cherry-pick as the top-level operation is a conscious act=
 of
> "I want to replay the change done by that one", and it would be utter=
ly
> confusing if it fast-forwarded by default.

All that said, I still agree with this conclusion.  It is only a gut
feeling.  I could be convinced in the future, but I do not want to
impose the imagined work of adding --no-ff to scripts until it is clear
it is the right thing to do.

One way to avoid trouble: add a --no-ff option, but make it mean
=E2=80=9Cnegates any previous --ff option on the same command line=E2=80=
=9D.  This
way, _if_ we decide to ask in the release notes for 1.8 for people to
add --no-ff to their scripts in preparation for 1.9, then they can do
so without breaking compatibility with git 1.7.1 (and without adding a
version check).

Cheers,
Jonathan
