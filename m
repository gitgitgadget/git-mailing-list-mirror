From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2] do not depend on signed integer overflow
Date: Tue, 5 Oct 2010 00:46:36 +0200
Message-ID: <AANLkTim-DRC6k7wg=orYzVS81JRD7D6_UOr+w1ti_Owr@mail.gmail.com>
References: <1286227522-5468-1-git-send-email-kusmabite@gmail.com> <20101004223331.GB9994@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 00:47:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2toJ-0004gW-Ok
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 00:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687Ab0JDWq7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 18:46:59 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43778 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab0JDWq6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 18:46:58 -0400
Received: by qwh6 with SMTP id 6so3378506qwh.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 15:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=zVC0Ld6RzsoUFeV+AKwnJFq6dD1j0hlqkG44l3hjBJU=;
        b=wEGoY5rT1/DWKgd+bO7DY0HgGmP0Eg/K9Zmk6UVgw3Lu9apXcRUg/i76s+THLzRjHY
         FHCV34lkg9bUmMK1wnzp5oigwOaqjZpJPVIEi/bf1ysNgvooq56UlSGCS79gwupU4fwP
         YJ0ZfvrNgRoTSQqQR/fVwAInL/WNIyxeicn+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=gscBpOB1WcmJHQ0fUczp130F3xCDrspwNwIwwI3uOSvyzjIsEzOTLok3ejxk0O7icZ
         ODHhw6lYQv5CCwzcO7TavTE6uUoCjCb+yw/TviSDis4PtylNhx/FebbZlVRl2BAMQVgk
         uUx483vp3EYKweZPPt56Bad0Dyo2w2UgG6FBA=
Received: by 10.224.67.132 with SMTP id r4mr7454502qai.54.1286232417190; Mon,
 04 Oct 2010 15:46:57 -0700 (PDT)
Received: by 10.220.100.135 with HTTP; Mon, 4 Oct 2010 15:46:36 -0700 (PDT)
In-Reply-To: <20101004223331.GB9994@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158136>

On Tue, Oct 5, 2010 at 12:33 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Erik Faye-Lund wrote:
>
>> +++ b/git-compat-util.h
>> @@ -28,6 +28,15 @@
>> =A0#define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
>> =A0#define bitsizeof(x) =A0(CHAR_BIT * sizeof(x))
>>
>> +/*
>> + * Signed integer overflow is undefined in C, so here's a helper ma=
cro
>> + * to detect if the sum of two integers will overflow. The bitsize =
to
>> + * overflow at is taken from the first parameter, which must be zer=
o
>> + * or positive.
>> + */
>> +#define signed_add_overflows(a, b) \
>> + =A0 =A0((b) > ((INTMAX_MAX >> (bitsizeof(intmax_t) - bitsizeof(a))=
) - (a)))
>
> Yes, I still like it. =A0This could be made closer to self-documentin=
g
> like so:
>
> #define maximum_signed_value_of_type(a) \
> =A0 =A0 =A0 =A0(INTMAX_MAX >> (bitsizeof(intmax_t) - bitsizeof(a)))
>
> /*
> =A0* Signed overflow is undefined in C, so here's a helper macro
> =A0* to detect if the sum of two signed integers will overflow.
> =A0*
> =A0* Requires: a >=3D 0, typeof(a) equals typeof(b)
> =A0*/
> #define signed_add_overflows(a, b) \
> =A0 =A0 =A0 =A0((b) > maximum_signed_value_of_type(a) - (a))
>

I like that. Thanks for the suggestion, I'll roll a new version.
