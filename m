From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Mon, 17 Aug 2009 23:06:00 +0700
Message-ID: <fcaeb9bf0908170906m739be4abs80ee3a6fc7135fbd@mail.gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> 
	<200908142223.07994.jnareb@gmail.com> <7veird4yyi.fsf@alter.siamese.dyndns.org> 
	<200908160137.30384.jnareb@gmail.com> <alpine.DEB.1.00.0908161002460.8306@pacific.mpi-cbg.de> 
	<alpine.DEB.1.00.0908171101090.4991@intel-tinevez-2-302> <7vtz06xxao.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 18:06:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md4j3-0005aq-4L
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756706AbZHQQGU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 12:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756654AbZHQQGU
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:06:20 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:1385 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756232AbZHQQGT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 12:06:19 -0400
Received: by an-out-0708.google.com with SMTP id d40so2909797and.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 09:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=fomwhwsdBunHuZzvPHsw+dPR1Dx+5b9BTXCPBSQy5OY=;
        b=joob0cH4oWx7TqRgJ2dWC7HWBZARVa8McN0bRRAqL7sRVC+9qt0U7636CXQLciv6H3
         DMKsZwA0cmtqXvXy0CuT8TPRK4ApYLT2bcXlAsi/jIxsPsM7ucL2y4MfDeccgU1caxB6
         HMS0xGlre1OUxDPJ7PwDx7KVHkgl/IKNF80yw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=c/e1FMSZB3PReOJNGRHaXD5nAK8hgk1KWcWZv5sU5hTqjoTIS/GIx1xM0s8HoLC7UG
         FGJcUokUYj0lvWLjN6uaIBkt3X0utGe3O3YeiFvYVNU162YEsLKH5FHndPotywqXxih+
         iDW6zqnT+9oPgGqimz2edgkOdbGY9kFnyY65I=
Received: by 10.101.109.11 with SMTP id l11mr3601983anm.145.1250525180346; 
	Mon, 17 Aug 2009 09:06:20 -0700 (PDT)
In-Reply-To: <7vtz06xxao.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126210>

On Mon, Aug 17, 2009 at 10:41 PM, Junio C Hamano<gitster@pobox.com> wro=
te:
> How should assume-unchanged play with this philosophy?
>
> I'd say that assume-unchanged is a promise you make git that you won'=
t
> change these paths, and in return to the promise git will give you fa=
ster
> response by not running lstat on them. =C2=A0Having changes in such p=
aths is
> your problem and you deserve these chanegs to be lost. =C2=A0At least=
, that is
> the interpretation according to the original assume-unchanged semanti=
cs.

But commit 5f73076 ("Assume unchanged" git) says [1] it favors safety
over performance? Otherwise I'd need to resurrect no-checkout bit.

[1] excerpt from the mentioned commit:
--<--
    Index entries marked with CE_VALID bit are assumed to be
    unchanged most of the time.  However, there are cases that
    CE_VALID bit is ignored for the sake of safety and usability:

     - while "git-read-tree -m" or git-apply need to make sure
       that the paths involved in the merge do not have local
       modifications.  This sacrifices performance for safety.

     - when git-checkout-index -f -q -u -a tries to see if it needs
       to checkout the paths.  Otherwise you can never check
       anything out ;-).

     - when git-update-index --really-refresh (a new flag) tries to
       see if the index entry is up to date.  You can start with
       everything marked as CE_VALID and run this once to drop
       CE_VALID bit for paths that are modified.
--<--
--=20
Duy
