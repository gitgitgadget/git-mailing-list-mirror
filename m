From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Am able to delete a file with no trace in the log
Date: Wed, 3 Jun 2009 17:59:07 -0400
Message-ID: <32541b130906031459p32640f4dte5e2e079cf4093d7@mail.gmail.com>
References: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net> 
	<20090602213439.GA7584@coredump.intra.peff.net> <alpine.LFD.2.01.0906021439030.4880@localhost.localdomain> 
	<7vfxeidqoz.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906022000040.4880@localhost.localdomain> 
	<7vtz2x6mor.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906031431100.4880@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Graham Perks <gperks@ausperks.net>,
	Git List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 23:59:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MByUh-0000LZ-U8
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 23:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981AbZFCV71 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2009 17:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753875AbZFCV70
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 17:59:26 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:24097 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbZFCV7Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2009 17:59:25 -0400
Received: by yw-out-2324.google.com with SMTP id 5so163679ywb.1
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 14:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=kmATcvTgQIp/HDPSiU0VXvaUtffVUCdhhoUl8ydjXVM=;
        b=WLuot7qu4mFdUcaMnMvsoaMzHXGpkLYnxpjuZIn/wiYgcbcv8BpN9n40fcKelcivK/
         nCJ0KqQsILjVKMf+y1uk/8uNreIWUi7bRB0sZRsmpTNl/7z8UNFRFysoj9P8qNwYXE3X
         pOP76V8CgpCoYFrUC+mwb/JmiSHS1OU+IpdfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tV59Q9z2oAixmmlR6OkRgua4E3B9gMzbvaN83IQYUJoAT/xHDIt/KFXeBpcvG1YKYs
         raakS5znI12MJrJXMELx/t59LBXsHZvX9o0zAD+fSNhUQpdcSzNFo6NGAqtZAEaGInIf
         5+kiTf/Xuovuzqgu6/wuTHrO+qeMRq9BH5lmw=
Received: by 10.151.125.6 with SMTP id c6mr2007372ybn.144.1244066367127; Wed, 
	03 Jun 2009 14:59:27 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0906031431100.4880@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120650>

On Wed, Jun 3, 2009 at 5:33 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, 3 Jun 2009, Junio C Hamano wrote:
>> E.g. "git log --graph --oneline -- git-clone.sh" shows that the scri=
pted
>> version ceased to exist at 8434c2f
>
> Btw, this example misses the whole point of the original problem.
>
> The original problem was:
>
> =A0- create new file 'x' in branch 'a'
>
> =A0- merge branch 'a' into branch 'b', but because of a merge conflic=
t and
> =A0 confurion in the merge, the merge result doesn't contain 'x' any =
more.
>
> =A0- try to find out what happened to 'x' after-the-fact.
>
> Try it. Git really doesn't make it very easy, because git will notice=
 that
> 'x' didn't exist before the branch either (in branch 'b'), so there w=
ill
> be _no_ sign of 'x' actually going away.

Note that full-file deletion is only one particular case of a general
problem.  Consider this script:

=3D=3D=3D

#!/bin/bash
rm -rf testb
mkdir testb
cd testb
git init
echo 'initial a' >a
echo 'initial b' >b
git add a b
git commit -m 'initial commit'

git branch sub

echo 'first a change' >>a
git add a
git commit -m 'modify a'

git checkout sub
echo 'second a change' >>a
git add a
git commit -m 'modify a differently'

git checkout master
git merge -s ours sub

=3D=3D=3D

"git log -p" will show the addition of the line "second a change" to
a, but it doesn't show that, in fact, this line was later deleted
because of a botched merge.  There is no obvious way to find out in
which commit the line was lost.  If someone doing a code review is
reviewing all the patches from "git log -p", then they'll miss the
fact that this patch was lost.

('git log -p -- a" doesn't show that the line was added at all - which
is true, in some sense, but it's equally true that, in the example you
gave, 'x' was never added.)

Have fun,

Avery
