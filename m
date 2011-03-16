From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] make_absolute_path: Don't try to copy a string to itself
Date: Wed, 16 Mar 2011 21:04:11 +0700
Message-ID: <AANLkTimvVd8VrAvcuT9Qww07-Gg1JtyA=+8nr4EeU0_D@mail.gmail.com>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
 <1300130318-11279-2-git-send-email-cmn@elego.de> <7v39mpcuv9.fsf@alter.siamese.dyndns.org>
 <1300140128.4320.39.camel@bee.lab.cmartin.tk> <7vpqptb976.fsf@alter.siamese.dyndns.org>
 <1300190396.19100.31.camel@bee.lab.cmartin.tk> <1300192832.19100.35.camel@bee.lab.cmartin.tk>
 <7vd3lsb9m3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 15:05:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzrLt-0005tn-0g
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 15:05:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211Ab1CPOFY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 10:05:24 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47540 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab1CPOFX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 10:05:23 -0400
Received: by wwa36 with SMTP id 36so2175407wwa.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 07:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=YvS66hyYyFNt04CKFZL9hDTAWm3JGqsxlDwHp+4+2Ys=;
        b=l6QL6I88RkPM9RojhxazWgfkFkya73zoiUA/tfh5J8zPG9cZmm7RzbPUF1N7WLjqh3
         Lp3PqXMh1zrGNgBuHwZZSdqjmzB+QRtxxfmN4iLlpgjCt1YZzg+rVSpOyI0sE9pO2hpY
         uldAdVcQwhRu1DhQSFsJwQ5ZXojbQrP1WNODM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Vz8LmvjbTEnDAiGOLYUMQT63f8hTFTLvIY913YLgZVc6VjSVA7qhTmpZFDmqCCDY1B
         Gw5QHA2wITEXu/TGvi1qhdEc4AmxssIHrRgDjzQHV7olLMdfw4bBmvdZGTu1dDSFNZ+c
         HV5WV/ad4iRwWY+D0Fn2AMwgt/67KYok0NKmM=
Received: by 10.216.66.131 with SMTP id h3mr869393wed.111.1300284319199; Wed,
 16 Mar 2011 07:05:19 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Wed, 16 Mar 2011 07:04:11 -0700 (PDT)
In-Reply-To: <7vd3lsb9m3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169153>

On Wed, Mar 16, 2011 at 12:02 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>
>> On mar, 2011-03-15 at 12:59 +0100, Carlos Mart=C3=ADn Nieto wrote:
>>> On lun, 2011-03-14 at 15:58 -0700, Junio C Hamano wrote:
>>> > Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>> [...]
>>> >
>>> > > =C2=A0There is however the extra functionality the function off=
ers, namely
>>> > > resolving links. It might be good to split it into two function=
s so each
>>> > > caller can specify what it wants.
>>> >
>>> > Probably.
>>>
>>> =C2=A0With the changes mentioned earlier, if you want an absolute p=
athname,
>>> you'd call absolute_path/make_nonrelative_path and if you want to m=
ake
>>> sure you have the real path of the target file, you'd use real_path=
 just
>>> as you'd use realpath on a sane system, with
>>
>> =C2=A0... a comment on the functions and maybe some documentation in
>> Documentation/techncal, as it doesn't seem to exist yet.
>
> We probably should involve Nguy=E1=BB=85n in this thread as his finge=
rs are
> everywhere on the codepaths related to setup.

Thanks, my attempt to fix up setup code leaves more traces that I expec=
t.

Splitting functions is fine, but is there any use of
absolute_path/make_nonrelative_path alone? Most setup code uses
make_absolute_path() for $GIT_{DIR,WORK_TREE}. For GIT_DIR, a
resolved/normalized path is preferred. For GIT_WORK_TREE, I'm not
sure. I tend to treat it the same way as GIT_DIR, but you guys may
have a special case.
--=20
Duy
