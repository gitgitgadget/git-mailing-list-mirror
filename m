From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] docs: add a basic description of the config API
Date: Wed, 8 Feb 2012 11:01:10 +0700
Message-ID: <CACsJy8AU3ZA1=Q3vahhP6Nr=FZNKd7oRJ04mtKVs+uvNqJeVaw@mail.gmail.com>
References: <20120206095306.GA2404@sigill.intra.peff.net> <20120206095346.GA4300@sigill.intra.peff.net>
 <7vbopb61cd.fsf@alter.siamese.dyndns.org> <20120207180625.GA27189@sigill.intra.peff.net>
 <7vlioe1o1g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 05:01:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ruyj5-0002CJ-0F
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 05:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558Ab2BHEBm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 23:01:42 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40340 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753935Ab2BHEBl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2012 23:01:41 -0500
Received: by wgbdt10 with SMTP id dt10so151786wgb.1
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 20:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=BNbyfxjNS2DC+26xZ1NJrGVoVoG2DPGzqx/bbW9X3FQ=;
        b=ZR8smGdUtjbe9Y+v+iIaS38EAywTjfb1uK/IH0Fc6B+d4xm55r1FYLi0/sPvKgHIem
         LDCUy8br4Pbm0PDfeWCGpS/6YZLE46FquXJmC5bAFdVUmxACml7Q4Gi5kdBGDJ/nGNRG
         9i1AQ0FwSpH84Zns/r17zC7zWir/hseGlUlaw=
Received: by 10.216.136.17 with SMTP id v17mr9586437wei.26.1328673700304; Tue,
 07 Feb 2012 20:01:40 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Tue, 7 Feb 2012 20:01:10 -0800 (PST)
In-Reply-To: <7vlioe1o1g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190218>

2012/2/8 Junio C Hamano <gitster@pobox.com>:
> Jeff King <peff@peff.net> writes:
>
>>> > +A config callback should return 0 for success, or -1 if the vari=
able
>>> > +could not be parsed properly.
>>>
>>> This matches what I have always thought, but I think I recently saw=
 a
>>> series that adds callbacks that return 1 to mean "I have understood=
 this
>>> variable, so callers should not look at it any more". =C2=A0It felt=
 wrong, but
>>> I did not find anything in the config.c API framework to prvent suc=
h a
>>> local calling convention.
>>
>> ...
>> The "1 means I understood this" convention is used by userdiff_confi=
g. I
>> don't like that it is unlike every other config callback,...
>> Looking at the code again, though, ...
>> Hmm. Yeah. The userdiff calling convention dates back to late 2008..=
=2E.
>> So I think we could go back and simplify the userdiff_config code no=
w.
>
> I remembered where I saw the new "offender"; it was nd/columns
> topic (Cc'ing Nguy=E1=BB=85n).

nd/columns does use "1" convention in git_column_config(), but the
direct config callback function does not return 1 to config machinery.
All call sites follow this pattern:

int ret =3D git_column_config(key, var, "command", &colopts);
if (ret <=3D 0) return ret;

I think it's ok.
--=20
Duy
