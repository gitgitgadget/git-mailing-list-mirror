From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] pack-objects: rename the field "type" to "real_type"
Date: Wed, 8 Jul 2015 20:57:35 +0700
Message-ID: <CACsJy8B0OCu3-TKVztj+wCmtqXdeh6iNK5ir4Xi2BXWW14wdOQ@mail.gmail.com>
References: <20150707160630.GA4456@peff.net> <1436356591-8148-1-git-send-email-pclouds@gmail.com>
 <1436356591-8148-2-git-send-email-pclouds@gmail.com> <20150708134713.GA5136@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 08 15:58:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCprp-0006FO-K2
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 15:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934453AbbGHN6Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 09:58:16 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:32875 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932310AbbGHN6N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2015 09:58:13 -0400
Received: by ieru20 with SMTP id u20so12517058ier.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=qBMdMi3waDMxrMSriHxIoUlgz0WdRIE5NgM+85gMj0k=;
        b=WSwSJ1kJJwKUfl68kCPsMrlm1S/zzo3BPVgtKIG6kgF4qP/SSN3CmKz2Gyz9JDWokH
         zbZvaSIfJlk+Y1sNaKEaZ7yZU0wxEDMr9q4mKBugnquU4fidzv0GotWsgPSsiiGHYxWs
         za9Isscmz7oYNlF0+da+yTJxznfOkiVQhvb2xol235IN4uXUnqI035DnwQRtJ3ZCNt5J
         mDgw9M7+iDEBDehpDpHsnfFnP4CvgTlWWUAVXD4VGSuqL09IqbCsQbJRSU2yqHppSAp7
         s90sfdIar1QsMKpFSZkxK4/UhyK1OUL6/lEJfbNYVOA+6CZSG0+wRt4kEeU/itxG+toc
         N1Cw==
X-Received: by 10.50.7.68 with SMTP id h4mr62603082iga.40.1436363884803; Wed,
 08 Jul 2015 06:58:04 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Wed, 8 Jul 2015 06:57:35 -0700 (PDT)
In-Reply-To: <20150708134713.GA5136@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273686>

On Wed, Jul 8, 2015 at 8:47 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jul 08, 2015 at 06:56:31PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>
>> This is to avoid the too generic name "type" and harmonize with the
>> naming in index-pack. There's a subtle difference though: real_type =
in
>> index-pack is what the upper level see, no delta types (after delta
>> resolution). But real_type in pack-objects is the type to be written=
 in
>> the pack, delta types are fine (it's actually markers for reused del=
tas)
>
> Hrm, now I'm confused about whether this change is a good idea.

Oh good :) I found it not-so-good too after seeing the check "if
(real_type =3D=3D OBJ_REF...)"

> The definition of in_pack_type says:
>
>>       enum object_type in_pack_type;  /* could be delta */
>
> so now I am confused about what exactly "type" (and now "real_type")
> means.

I think we just overload "type" with "this delta is detected reusable
already" in write_object(). It only means 'real type in the output
pack' for canonical types. For generated deltas, we already know if
it's ref-delta or ofs-delta, we don't rely on real_type
--=20
Duy
