From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [WIP PATCH 0/5] support --exclude for diff/log commands
Date: Mon, 21 Mar 2011 11:02:02 +0700
Message-ID: <AANLkTimWPoMEYdLCwTTit6AeuJegOc96gE1JsO8B4fh=@mail.gmail.com>
References: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
 <7vmxl37bdp.fsf@alter.siamese.dyndns.org> <7vvczr5pw6.fsf@alter.siamese.dyndns.org>
 <AANLkTimsv9bO+Go6Mqrrp_1-AZ=sC3ndyAuskPYLVbkv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 05:02:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1WKJ-0006ei-FH
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 05:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805Ab1CUECg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 00:02:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55826 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab1CUECe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 00:02:34 -0400
Received: by wya21 with SMTP id 21so5421269wya.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 21:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=NLbj3teROy++ndf7guYXHxR0RxBVReCzg/qB9DehRoE=;
        b=w76nYusczdfXeSwswOqsQIoLS60AM3fDLhXJD/t+JORXkCq7dIvtZwG1Gnyx4xpYV3
         pFea7cN7iHE4GA8dBewRmbYKqLiw39wF0GG2W+3l4RF3q+FcjCOnJHoxzcMpFjb8lgp6
         iJtdw8dLD7gMs3px73XAr6IpArgpPdVSJD3wI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xCzQUSsOXd58Ea618bfAWcKU6Ejuv8uNGWeInJLiyxfH4fM8r2eOa8WRyqbOFPXibn
         a7QBCVH3z6WteXOvhseW4pBKXapbSdm1wSJPm+DqarGVlMBdtHPRCKgpt4BuLLOPATxl
         dEusMJuOcyqlNRio1RZ2BR13OxS4M454A6w+4=
Received: by 10.216.66.131 with SMTP id h3mr3854565wed.111.1300680153238; Sun,
 20 Mar 2011 21:02:33 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Sun, 20 Mar 2011 21:02:02 -0700 (PDT)
In-Reply-To: <AANLkTimsv9bO+Go6Mqrrp_1-AZ=sC3ndyAuskPYLVbkv@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169553>

On Thu, Mar 10, 2011 at 5:05 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> 2011/3/10 Junio C Hamano <gitster@pobox.com>:
>> Let's step back a bit.
>>
>> We chose to use ":/<regexp>" as one new form of extended SHA-1 expre=
ssion
>> to name an object for two reasons: (1) no normal <ref> can have a co=
lon in
>> it, because of check-ref-format restriction; (2) ":" is an unlikely =
letter
>> to appear at the beginning of a pathname, and people with such a pat=
h can
>> work around by saying "./:frotz" or "\:xyzzy".
>>
>> There is a disambiguation logic to check a list of arguments that la=
cks an
>> explicit "--" separator to make sure that each element early on the =
list
>> can only be interpreted as an object name but not as a pathname that
>> exists on the filesystem, and all the remaining elements are pathnam=
es
>> that exist on the filesystem.
>>
>> If we introduce an extended syntax for pathspec and make the prefix =
magic
>> character ":", and if we choose to use ":/" as one kind of magic, I =
was a
>> bit worried that this may affect the disambiguation. =C2=A0The users=
 must use
>> an explicit "--" when feeding a pathspec with the magic so that the =
parser
>> knows which kind of magic (either object name magic or pathspec magi=
c)
>> they are talking about.
>
> Or.. we can consider this ':' a special form of wildcard and interpre=
t
> the same way:
>
> =C2=A0- first try exact match. If it matches, the leading ':' is
> interpreted literally as part of file name.
> =C2=A0- magic.

One thing that makes it different from Michael's approach is, :/foo
will match ':/foo' literally in every directories and foo at top-tree.
I feel mildly uncomfortable with it, but it makes it consistent with
other wildcards. If no one objects, I'll try to make a patch with this
approach.
--=20
Duy
