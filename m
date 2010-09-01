From: Chris Patti <cpatti@gmail.com>
Subject: Re: Odd results writing a Git pre-receive hook to syntax check PHP files.
Date: Wed, 1 Sep 2010 09:43:23 -0400
Message-ID: <AANLkTi=GP-3QV+2cVUV1zCS_n2gPie_rBmBnbXgmmbgn@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Sep 01 15:43:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqnbA-0007vK-WC
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 15:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055Ab0IANn1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 09:43:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54688 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219Ab0IANn0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 09:43:26 -0400
Received: by bwz11 with SMTP id 11so5297204bwz.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 06:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Exdb8unlzHZbTFRdh5hRRSkE3+PQyJ1VvclDwtgCU/0=;
        b=wUcouKkWYbsjh2Ycs5LncfxtD2yxM5ZX91nEnBCZqY0PJyvtmBAe9JYfwxhOeXpJa6
         h1SVq7+HVys7NPbA6iMMxVfOKZuLiiqfE7CZxMK15vxNJ+Ka7HcBza13KadyO9AV5pYh
         cRL0kPtwYEykeIrsYD0Td5jWmH6rca9z1Zd9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=x0Dwgq+KaOKgWJJMBldQ8YFxtVdskww43wrKW05lLHYZxdEHGigg2baHEd9TShGgu6
         5wWmPn7ZDztKw/FUqEWkzAx05DeNQ3IjbJDXK0e0XZGc2pa/ULUpw4+HsKuAvCemID5g
         pdibvJ9iyhWAMDlO0588w5IVt0z3nfLg3pU78=
Received: by 10.204.133.129 with SMTP id f1mr5596245bkt.91.1283348604077; Wed,
 01 Sep 2010 06:43:24 -0700 (PDT)
Received: by 10.204.66.196 with HTTP; Wed, 1 Sep 2010 06:43:23 -0700 (PDT)
In-Reply-To: <7vk4n68hpk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155043>

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

That's a good point, I'll try creating a subdirectory in my testing,
thanks for pointing this out.

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $regex=3D"/\=
:\w+ \w+ \w+ (\w+) \w (.+)/";
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 else {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $diffcmd=3D"=
git diff --raw $old_sha1 $new_sha1";
>
> And you are better off using "diff-tree -r" here instead of "diff --r=
aw"
> here as well, to keep the input to your parser for both cases uniform=
=2E
r> The parser would be easier that way, no?
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $regex=3D"/\=
:\d+ \d+ \w+... (\w+)... \w\t(.+)/";
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>


As you can see, it's just the regex that differs, so I'm not sure what
you mean by 'parser'.  The power of regular expressions handles this
quite nicely, but I'll definitely consider that for a simplifying
rewrite in the future.

-Chris


--=20
Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
chrisfeohpatti | P: (260) 54PATTI
"Technology challenges art, art inspires technology." - John Lasseter, =
Pixar
