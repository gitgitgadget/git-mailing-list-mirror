From: Mark Lodato <lodatom@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2009, #01; Mon, 06)
Date: Mon, 6 Jul 2009 22:18:03 -0400
Message-ID: <ca433830907061918s6c674bf6w2f8d166f645d4e33@mail.gmail.com>
References: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Marcus Camen <mcamen@mcamen.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 04:18:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO0G4-0003QH-Rr
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 04:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbZGGCSC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jul 2009 22:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753027AbZGGCSB
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 22:18:01 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:45791 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbZGGCSA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jul 2009 22:18:00 -0400
Received: by fxm18 with SMTP id 18so4571029fxm.37
        for <git@vger.kernel.org>; Mon, 06 Jul 2009 19:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DuhJGiActcZPd2y8ruoAHgBfkj3wRSDvCKKRAB9bABE=;
        b=GEtXv7H8UmshAbaax5Shv510NcRlbDROfavlZvG3JveakKg1Dt1/rSB+sKiaw/zBBI
         /82eP9HZYAl0/+qQiCoFV5SCNXvDLyTDnA7t8Zud4dmCs08Yz+bnEtz2or4leGB+15qN
         iTZRG5WNs/xF1NcvkX24xx5GLtDIeR8Np43j8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GZ2iDCNwyN8V+J2kw+F7ETSw2NhhQzeq8Ep57HyIwwOZtzqd5u7u6AkZZDbCmZPosO
         a76TvzxQFWmEyV0k0Z5PnSV4wzymDdX/SGwJqXvtadi/3nYb/mc1w0IPklU/w/rA19TM
         TuDqv86eVE4Qsr9aMAuIkGIWa91itTC8vz1+I=
Received: by 10.102.247.10 with SMTP id u10mr3010322muh.76.1246933083161; Mon, 
	06 Jul 2009 19:18:03 -0700 (PDT)
In-Reply-To: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122816>

On Mon, Jul 6, 2009 at 2:32 PM, Junio C Hamano<gitster@pobox.com> wrote=
:
> [Stalled and may need help and prodding to go forward]
>
> * ml/http (Wed May 27 23:16:03 2009 -0400) 2 commits
> =C2=A0- http.c: add http.sslCertPasswordProtected option
> =C2=A0- http.c: prompt for SSL client certificate password
>
> I've rewritten these two to (1) move the #ifdef out of the main codep=
ath,
> and (2) use configuration/environment to make the misfeature of alway=
s
> asking for a passphrase even a key/cert is unencrypted optional. =C2=A0=
I tried
> to be careful but extra sets of eyeballs would be nice to check the r=
esult.
>
> Nobody seems to be jumping up-and-down asking for this or helping to =
push
> this forward. =C2=A0Perhaps it's time to drop it?

Sorry for the lack of updates.  After hearing feedback, the consensus
seemed to be that detection of the certificate's encryption (above)
and file type (other patch, not in git.git) should be done
automatically, that is, without user configuration.  I agree, but
neither can be done without great difficulty outside of libcurl.
Therefore, I have started implement the autodetection of both, as well
as the password caching, directly in libcurl.  If my work, once
completed, is accepted by the libcurl folks, then there would be no
need for the above, and we should recommend upgrading libcurl for
those who want to use client-side certificates.

However, in the interim, and for users with earlier libcurl versions
(and especially if my libcurl patch is never accepted), it might be
nice to still have the above commits.  They are unobtrusive - the
patches are small, and they do not affect users who do not enable the
option - yet they drastically improve the experience for those using
password-protected client-side certificates.

Anyway, I am still very interested in getting proper client-side
certificate support in git, and I am glad to see Marcus is as well.
Ultimately, I think the libcurl solution is the proper way to go, but
this patch series might still be good to include in git. The downside
is that it adds extra crap to the git-config man page and it does
increase the code size a little.

--
Mark
