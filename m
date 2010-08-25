From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFD PATCH 00/32] subtree clone v2
Date: Wed, 25 Aug 2010 14:43:10 -0600
Message-ID: <AANLkTi=rt5ho9EXg7_NF+JqPW=cs8yqAHqm5+mPooYcC@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<20100824223741.GB2376@burratino>
	<AANLkTikipryFVf_XvvbHopWSo5Ey_mvgTevY2NAvhygQ@mail.gmail.com>
	<AANLkTinsNvVup43B6nQtU6dvJy789n8kQm6N6na0J9oa@mail.gmail.com>
	<7vpqx6qypx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 22:43:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoMoZ-0005cB-H7
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 22:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977Ab0HYUnO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 16:43:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50026 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183Ab0HYUnM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 16:43:12 -0400
Received: by fxm13 with SMTP id 13so649865fxm.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 13:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PnpJDE1u9Dm+FClryopNIRkcEKrfp80tyiIk4qQe8nA=;
        b=kzqNAqmT2ji4HzxdzKk01tmtN1T814oTT1/1mE1vP1kCneSYkJWT3UxbCQbCohMGR7
         pBZxaC7Q/qWLw6z5aLDB1NgSE2Nfs2p2D5KhI+wzXQgv1agA9fgC5GiFJRU4NnZjII43
         R3NHzr0CaCDqvM7PSmsKNcm9EeMw/e+gKZCRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VOh0D1FUUhjHH9GIL/UQDRGjh9lls98hpdMfQXi9W7nx7vTEi8++kB61Zfz3zl1Zsp
         BE9lv9Tf2Vu888P4WiQXuNqO4L+9N6yv27G9B8SpPCQaYOkAPBUSHLoo0FgOamOGYIvg
         67gNcfLbVa+VMmmk2D9YSzE7pkYm4xAhxSlc8=
Received: by 10.223.105.197 with SMTP id u5mr8219835fao.14.1282768990800; Wed,
 25 Aug 2010 13:43:10 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Wed, 25 Aug 2010 13:43:10 -0700 (PDT)
In-Reply-To: <7vpqx6qypx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154469>

On Wed, Aug 25, 2010 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
<snip>
>> If you have a narrow/subtree clone, it means that you only have the
>> data for a certain paths. =C2=A0I'm assuming that also meant you wou=
ld only
>> allow modifying those paths. =C2=A0In other words, you have no chang=
es
>> outside the narrow tree. =C2=A0Because of that, I think you can hand=
le
>> paths outside the narrow region using trivial-merge logic ...
>
> I think you can do a merge only once, but after that you would be los=
t.
>
> Suppose you forked from commit A, narrowed to one subdirectory and cr=
eated
> B (iow, diff(A, B) contains only changes to that subdirectory). =C2=A0=
Somebody
> else worked on the whole tree and queued commit C on top of A.
>
> =C2=A0 =C2=A0 =C2=A0B---?
> =C2=A0 =C2=A0 / =C2=A0 /
> =C2=A0---A---C
>
> Your merge between B and C that uses A as the common ancestor can tak=
e all
> changes outside the subdirectory from C (but you need to know all the=
 tree
> object names in C near the top outside your area). =C2=A0So far, so g=
ood.
>
> While this was going on, somebody else also forked from A and made ch=
anges
> that touch both inside and outside your area, and its tip commit is E=
=2E
>
> =C2=A0 =C2=A0 =C2=A0B---D---?
> =C2=A0 =C2=A0 / =C2=A0 / =C2=A0 /
> =C2=A0---A---C =C2=A0 /
> =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 /
> =C2=A0 =C2=A0 =C2=A0o---E
>
> Now you want to merge changes made on the branch that leads to E to y=
our
> copy. =C2=A0How would we do that?
>
> You cannot merge D and E without having enough information necessary =
to
> make a merge between C and E with full tree, can you?

Ah, now I think I see what Duy was getting at; thanks for making that c=
lear.

You are correct, of course[1].  Failing merges with
"not-enough-information-available" will sometimes be a fact of life
with sparse/narrow/subtree/partial/whatever clones[2] -- either that
or "server-side merging" as Duy suggests (though I personally am not a
fan of that).  I was just pointing out that I think we're not limited
to a single merge ever; for example, if I understand correctly, if
someone else merges C & E then you'll be able to merge from them[3]
(and thus, you'll be able to merge "more than once").

Elijah


[1] Outside your subtree, D does not match the merge-base A, thus so
you can't employ 'trivial merge' logic and you don't have the data for
any other kind of merge.

[2] As noted as item 7 at
http://article.gmane.org/gmane.comp.version-control.git/152020.

[3] This is because outside your subtree, D would match the new
merge-base (C), allowing you to use trivial merge logic again.
