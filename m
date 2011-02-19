From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/3] revlist.c: introduce --cherry for unsymmetric picking
Date: Sat, 19 Feb 2011 09:47:48 -0500
Message-ID: <AANLkTinGkT0AJ6qeGi_z7Ck8wWM-jriUTqjDPvumjRwB@mail.gmail.com>
References: <15a90a6606cff7d823fe4afbedd580aadf7b1d1e.1298032360.git.git@drmicha.warpmail.net>
 <7vzkptnn7x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 15:48:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqo6s-0002Wq-44
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 15:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390Ab1BSOsT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 09:48:19 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63046 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541Ab1BSOsS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Feb 2011 09:48:18 -0500
Received: by iyj8 with SMTP id 8so4468085iyj.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 06:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=qcug0+5WhQZ26RszQ6/zQERZP69daBwI91SvQydRUAE=;
        b=SoFnAZkpwJd7ydtMbj1JLqVgXZDVDZ8wQqg47BoQyXWgTdoCf5gKvObpIs9+5tdZX6
         0VxV9cccFUz+QM2lr3v9RbTxFOiij3CD+astMOlzdlw8XSMX8mJKta9LX48s+qptsXY1
         dW0bwk4TIEO0Mi4yF60PObiUNjRziVwA2vkcg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=R8u+Rg2h0QT6VNb3z1BhvQ6xbY0apoKJ85cQELtaKAJ9LU5RV2Tu26rItfDvZuXcei
         XC3pUPTypgxAy1yB37jeXr/MzXGuvYI32uehaE1FFbTp2aeWer525zStmpWg6D2oAdn4
         sbp6PSWmcmcBkLRAOk304I5gzU9IeA1z8g7UU=
Received: by 10.231.36.69 with SMTP id s5mr1398178ibd.167.1298126898129; Sat,
 19 Feb 2011 06:48:18 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Sat, 19 Feb 2011 06:47:48 -0800 (PST)
In-Reply-To: <7vzkptnn7x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167284>

On Fri, Feb 18, 2011 at 2:42 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> By the way, when this feature is properly implemented internally at t=
he
> revision traversal level, we should be able to lose quite a lot of co=
de
> from builtin/log.c, as format-patch in it was the original implementa=
tion
> of the whole thing, and it was done outside the revision walking mach=
inery
> to implement patch equivalence filtering of the traversal result. =C2=
=A0We
> would essentially feed the symmetric upstream...HEAD range with the
> cherry-pick flag, ask it to give only the right hand side (i.e. what =
are
> left after the patch equivalence filter), and emit the result.

Tangent: it occurred to me it would be useful to give the user some
say in how the patch-id is computed. Currently, the patch-id is the
hash of the diff hunks, which is very strict.

I think it would be useful to have a "loose" mode of computing the
patch-id. What I was thinking was to use the hash of certain commit
metadata that is likely to be unique: say, the commit authorship
(name, email, timestamp) + commit subject and/or body.

This would allow rev-list to (optionally) filter out commits that,
modulo conflict resolution, introduce the "same" change. IOW, give the
user of rev-list some say about what a "same" commit is.

(I suppose this is my itch to scratch.) :-)

j.
