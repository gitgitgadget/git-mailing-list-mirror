From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Respect core.autocrlf when preparing temporary files for 
	external diff
Date: Sun, 22 Mar 2009 23:48:20 +0100
Message-ID: <bdca99240903221548y38f31177q6abb88c2f7f87a73@mail.gmail.com>
References: <cover.1237635609u.git.johannes.schindelin@gmx.de>
	 <7vocvuekjb.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0903220053260.10279@pacific.mpi-cbg.de>
	 <7v8wmybf06.fsf@gitster.siamese.dyndns.org>
	 <7vzlfe9ynj.fsf@gitster.siamese.dyndns.org>
	 <20090322061046.GA14765@coredump.intra.peff.net>
	 <7v63i281py.fsf@gitster.siamese.dyndns.org>
	 <20090322074643.GA4826@coredump.intra.peff.net>
	 <bdca99240903220830u50999dfcnee0f0091b4dec835@mail.gmail.com>
	 <7vljqxcj84.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 23:49:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlWUL-0007ag-P3
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 23:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013AbZCVWsY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 18:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755853AbZCVWsX
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 18:48:23 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:41372 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818AbZCVWsX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 18:48:23 -0400
Received: by yx-out-2324.google.com with SMTP id 31so1885829yxl.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 15:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TncvPujA/frlyC3Ypu59BmeqTC0dC+LUhTPNqCn0x+c=;
        b=ElFp6SeiVZQBKB95lQlHmLhsCdBnH0hdG0hxCZpkabt1qJo5S+7dz/MIg/wxnluzoh
         +NecbeJ79nZB/R74M2un4AOjNZ/JAQyRSMHL+G6dgSBpLRNboENkZYEmQ5MxF4BMB2Oo
         jE4jZzF8J2qje1iXh/38f6XsH/ulzdx/MrNZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BpkVkFKlv2PQGLmjdNYzi7WlP7F64wFcjAzkT3UZj2NCAgC82UWeLAVEvlwy/nuCBx
         e/a8gUkr7XN+6bp4wj4+Xaxudgr21UB+DdmCjnjFo1PaBqJhx26JnfXfyvR1mopq5LVg
         5oLo/GRpWls2GejZjxMGTm6bdu0LCKEHjfibY=
Received: by 10.150.124.2 with SMTP id w2mr11556694ybc.155.1237762100620; Sun, 
	22 Mar 2009 15:48:20 -0700 (PDT)
In-Reply-To: <7vljqxcj84.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114192>

> If you run "git diff <filename>" after cloning, I expect that no temp=
orary
> files are involved, _unless_ you have some settings that force "git d=
iff"
> not to use the internal diff. =C2=A0Do you use GIT_EXTERNAL_DIFF? =C2=
=A0Do you use
> "textconv" attribute? =C2=A0What external program do you invoke from =
these
> mechanisms, and what does it expect to see as its input?

As I prefer graphical diff tools, I do not use internal diff, but
Beyond Compare [1]. In order to do that I have configured
diff.external to point to a wrapper script that contains the following
lines:

---8<---

#!/bin/bash

# diff is called with 7 parameters:
# path old-file old-hex old-mode new-file new-hex new-mode

"C:/Program Files/Beyond Compare 3/BCompare.exe" "$2" "$5" | cat

---8<---

As Beyond Compare is a stand-alone diff / merge tool, it expects to be
working on regular files in the file system. And to be hostest, I did
not know about the "textconv" attribute until now.

> The discussion in the last few messages in this thread speculates tha=
t the
> external programs are more likely to expect representations suitable =
in
> the work tree, aka "smudged", than "clean" one. =C2=A0It would be nic=
e to get a
> datapoint from you as the original reporter to confirm or refute that
> speculation.

I agree to the speculations. IMHO calling an external diff tool with
two revisions of a file should result in the same as e.g. checking out
the two revisions in two different working trees and then launching
the user's external diff tool on the two working tree files.

[1] http://www.scootersoftware.com/

--=20
Sebastian Schuberth
