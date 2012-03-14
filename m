From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: show those involved in a merged series
Date: Wed, 14 Mar 2012 15:12:08 -0400
Message-ID: <CABURp0qE9XRg+a8WRdicojJNqcLnZn_PozFTDO8qZ8BMM1NsJQ@mail.gmail.com>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org> <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org> <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org> <4F57D18B.5090506@lsrfire.ath.cx>
 <7vzkbskr71.fsf@alter.siamese.dyndns.org> <4F58F06A.1070108@lsrfire.ath.cx>
 <7v1up2ew9u.fsf@alter.siamese.dyndns.org> <CABURp0oVn3s27Rtq2JQeLBgcXq1-R-=0qawcXVMxZ8qgOeZGkQ@mail.gmail.com>
 <20120313210357.GC27436@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 20:12:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7tch-0000GI-O8
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 20:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761240Ab2CNTMa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Mar 2012 15:12:30 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:62197 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757440Ab2CNTM3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 15:12:29 -0400
Received: by lahj13 with SMTP id j13so1750030lah.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 12:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=y1iwc3Wg158OeBnr0aFLAYH+U/v2oCZFyPkKL6L/KYY=;
        b=W+jUw70qOz6K5Q9Ll3SYKfGW0XNstntUDlGviVMR+lvwSB4qfh6295bZTe3chaQdG3
         rTfZ272OAFLet+z+bRlFveL9dwEq2g1+95+VN63oveC6b7TiiLs1J0kjO3n2Feby6PsQ
         g33lL64fNH6XWo8WXj7WGEq45wDGj8XatioryyYXctYvNkujaWyb6CJg5wwskSrDBOjt
         4GAnE52p1nQGQW+x52yz4h25yzYa0vS10BQ5/rFfFcvCn0nhxTrnhrxVh94FsqNIKjXr
         d8rJNDU0cAsm99AsMoy6RvblesW7Co0EC4ZpzLjLu66Qcv/N4Eo8+nbHDoiW2Xw0clgL
         fc3A==
Received: by 10.112.38.3 with SMTP id c3mr1342981lbk.94.1331752348419; Wed, 14
 Mar 2012 12:12:28 -0700 (PDT)
Received: by 10.112.55.43 with HTTP; Wed, 14 Mar 2012 12:12:08 -0700 (PDT)
In-Reply-To: <20120313210357.GC27436@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193150>

On Tue, Mar 13, 2012 at 5:03 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 12, 2012 at 05:37:57PM -0400, Phil Hord wrote:
>
>> Subject: [PATCH] Appease compiler pedantry with an extra cast
>>
>> Recently git repurposed a pointer as an integer to hold some
>> counter which git fancies.
>>
>> Casting directly from 'pointer' to 'int' ((int)(void*)&x) causes a
>> possible size mismatch because pointers can be bigger than ints.
>> In such a situation, the compiler complains:
>>
>> =A0 =A0warning: cast from pointer to integer of different size
>> =A0 =A0 =A0 =A0 =A0 =A0 [-Wpointer-to-int-cast]
>
> Yeah, I've been seeing the same warning on my x86_64 box, and came up
> with the same fix. However...
>
>> Cast the value through intptr_t first to quell compiler complaints
>> about how this gun appears to be aimed near our feet. =A0Then cast t=
his
>> value to an int; this path assures the compiler we are smarter than =
we
>> look, or at least that we intend to aim the gun this way for a reaso=
n.
>
> This feels so hacky.

Well, that's because it is hacky.  But it's the original code that's su=
spect.

> One of the callsites does:
>
> =A0 =A0elem->util =3D (void*)((intptr_t)(util_as_int(elem) + 1));
>
> which will truncate the value down to an int before replacing it back=
 in
> the void pointer. And that truncation is ultimately what the compiler=
 is
> warning about, and what we are sneaking around with the extra cast
> (because casting between integer sizes of different types is OK, even
> though it can cause truncation).

I think this one is ok because it's really just "the hacky" bit
storing an integer in a variable meant to hold a pointer.  That's why
it's incrementing here, I suppose, not because it really wants to
point at the next byte.

> I don't think the truncation is a problem in practice, but it just fe=
els
> like we are not just silencing an over-zealous compiler, but actually
> burying type-size assumption behind a set of four (4!) casts.

The compiler is doing its job here to warn us against storing big-ish
pointers in small-ish ints.  But if we know we will never accidentally
use this as a pointer and if the integer will never overflow the
32-bounds of the (int) representation, then it's all good.

But I agree, it is hacky.

Phil
