From: Chris Patti <cpatti@gmail.com>
Subject: Re: Odd results writing a Git pre-receive hook to syntax check PHP files.
Date: Thu, 2 Sep 2010 10:34:18 -0400
Message-ID: <AANLkTiks+y8edtpkbu+t=22rct_KXv9aOHaG88-MWapK@mail.gmail.com>
References: <AANLkTikktdPoZN8MwJD+Gxus16xBGtScCAqT9W0eiWAb@mail.gmail.com>
	<4C7B8E1E.6050708@drmicha.warpmail.net>
	<AANLkTimqzDO49h40b16gQ_=X42NXN-wZNV7d7f3KYygt@mail.gmail.com>
	<20100830141602.GF2315@burratino>
	<AANLkTim+S87KjFBstBineR02hQHzG=X2VDqgiGNbPQGS@mail.gmail.com>
	<20100830163302.GA13336@burratino>
	<AANLkTi=VPf9CWNJcce6d20HQChi0mHgTG1F=jakzNT-O@mail.gmail.com>
	<4C7C020C.6090907@drmicha.warpmail.net>
	<AANLkTimiSBjifxtDoFXAEAEpYM8bJ18SwJ5Fj8zqh_G6@mail.gmail.com>
	<7vk4n68hpk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 16:40:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrAxk-0006iE-A3
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 16:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744Ab0IBOeV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 10:34:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61823 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460Ab0IBOeU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 10:34:20 -0400
Received: by bwz11 with SMTP id 11so612519bwz.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 07:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pnCUCtWCjtl2LtrtgAPUEaXrYdt5eCejIa4PCVwx6g0=;
        b=qfjM+7TD0cccXEu4pj1FQYg/eVzu/teWa0LlC/InUw67b13FcPOgfMkvFwvzfIoviY
         3MpIQhjdEjQvMhs4sYJr5s6+VmYFVqrmhaYYGUYGsOME79XBYqbtr1PkBBeiJKut7S6D
         fSQ/sqCc8HAGuWQMP/sjTAS2gdLdIyu86xJpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TvHadYW3aWr0wMKu2D12ExJhPO0MR3N+u0Wu8D7gmIPQCGM/WWMVGfEDQT76Y0EJMf
         mqtVgt9M5J/s83Lnpk/ZuImCf9rg/10USn5BYNkADe98eZFwgyzcuw5GwiKgfKobXjLQ
         Dq71/UxHP7dspm2R87Faa+sjgq6PHJwrwoka4=
Received: by 10.204.39.203 with SMTP id h11mr6793390bke.8.1283438059449; Thu,
 02 Sep 2010 07:34:19 -0700 (PDT)
Received: by 10.204.66.196 with HTTP; Thu, 2 Sep 2010 07:34:18 -0700 (PDT)
In-Reply-To: <7vk4n68hpk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155130>

On Tue, Aug 31, 2010 at 7:50 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Chris Patti <cpatti@gmail.com> writes:
>
>> function parseCommit($old_sha1,$new_sha1) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 # if this is the first commit on a new b=
ranch, $old_sha1 will
>> be a bunch of zeroes, and so
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 # git diff --raw will fail, since there'=
s no old ref to
>> compare against. =C2=A0So, we parse the
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 # results of git diff-tree -root=3D$new_=
sha1 instead to get the
>> blob and filename we'll need.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (detectNewBranch($old_sha1,$new_sha1)=
) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $diffcmd=3D"=
git diff-tree --root $new_sha1";
>
> This somehow feels wrong. =C2=A0If the tree of the new commit is flat=
 without
> subdirectory, the above would do, but don't you need "diff-tree -r" h=
ere?
>

I tested with subdirectories, and subdirs with subdirs, and no
failures, worked perfectly.  So, not sure what feels wrong to you, but
for now, it works :) I will seek to better understand the internals
I'm mucking with here so I can figure out why you see the current
implementation as being suspect.

-Chris


--=20
Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
chrisfeohpatti | P: (260) 54PATTI
"Technology challenges art, art inspires technology." - John Lasseter, =
Pixar
