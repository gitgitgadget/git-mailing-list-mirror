From: Jay Soffian <jaysoffian@gmail.com>
Subject: Help: approach for rebasing to older commits after merging more 
	recent commits
Date: Mon, 14 Dec 2009 15:38:32 -0500
Message-ID: <76718490912141238k4ca1ba55jeff928efe875f020@mail.gmail.com>
References: <76718490912091204u3a4596fdi504005624d5a5bce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 21:38:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKHgn-0005q8-9g
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 21:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060AbZLNUih convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 15:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754106AbZLNUif
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 15:38:35 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:60946 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853AbZLNUid convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 15:38:33 -0500
Received: by iwn1 with SMTP id 1so444789iwn.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 12:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=CmEtYTLL73p9diTlPpaWYPV2ynZNc+OOf6sWImTVl34=;
        b=NDd6GiSMA38JlwpLp+trLJOtEEuTq5MCQFrIQvT9Erwae+++iKrs6F4Afyynp6QLbI
         bpb2YPwdX/Rr2bgJeWA2msMW2GZNkT59F7RpXms3BcCU9ZCVNbMU8TZe76BCiHiJdhrt
         MugS/vjsz0KYJVApWgF0LqvriEEw0/dmKE9HY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=wPZiyrdnf3OR6DJztBeHgIIu4b35lOKpyueIIxXbi27fXUHwxNR3UY2LKvm+MF9eTW
         sW4kW/HdIVgBR01HgWVgBlg7zgfrD4ZedWTAIIhx5QkiGC/tBYmbdKhcRAHxnYNZdB8l
         lWfhmCNqiYDoSKm2/JkBV+pVRE+ezLMffYuC8=
Received: by 10.231.122.139 with SMTP id l11mr328550ibr.53.1260823112966; Mon, 
	14 Dec 2009 12:38:32 -0800 (PST)
In-Reply-To: <76718490912091204u3a4596fdi504005624d5a5bce@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135235>

[He asks again...]

I have an interesting problem I'm not sure how best to tackle.

A small development team is basing its product on an upstream git repo =
that is
itself an svn clone. Currently the process looks like this:

r1--r2--r3--r4--r5 =C2=A0 upstream trunk =C2=A0 (git svn clone)
=C2=A0\ =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 =C2=A0 \
=C2=A0A---B---C---D---E =C2=A0local trunk =C2=A0 =C2=A0 =C2=A0(git clon=
e of upstream)
=C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 /
=C2=A0 =C2=A0 =C2=A0 =C2=A0F---G =C2=A0 =C2=A0 =C2=A0 =C2=A0developerN =
trunk (git clones of local)

So local trunk has both daily merges from the local developers, as well=
 as
less periodic (typically weekly) merges from upstream trunk. The reason=
 being
that it is necessary to remain on top of the upstream bleeding edge.

This works out okay, but there is a minor problem and a major problem.

The minor problem is that the local trunk is cluttered with the develop=
erN
merges. That is easy to solve by having local developers rebase before =
pushing
to local trunk. That would look like:

r1--r2--r3--r4--r5 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0upstream tr=
unk
=C2=A0\ =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 =C2=A0 \
=C2=A0A---B---C---D---E---F'---G' =C2=A0local trunk

The major problem is that local trunk is also cluttered with merges fro=
m
upstream. The is a problem because at some point in the future, upstrea=
m
is going to declare some rN as being officially blessed. And we're goin=
g to
want to rewind any rN changes past that point.

So the question is, what's the best way to do this? Say r2 is blessed b=
y
upstream. The obvious thing to do (I think...) is:

(local-trunk)$ git rebase -i r2

removing C and E from the pick list.

But, occassionally the merges from upstream require much conflict resol=
ution.
Would enabling rerere during merges help with the rebasing? I would wan=
t to
reuse as much conflict resolution as possible.

Is there a better approach altogether? Should we be doing something oth=
er
than merging to stay atop upstream?

Suggestions/comments greatly appreciated.

j.
