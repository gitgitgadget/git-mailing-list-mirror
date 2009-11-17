From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH 1/2] http-backend: Fix access beyond end of string.
Date: Mon, 16 Nov 2009 20:46:38 -0800
Message-ID: <905315640911162046q219c07d9w425f6bde0e1ba870@mail.gmail.com>
References: <1258233058-2348-1-git-send-email-tarmigan+git@gmail.com> 
	<20091116013654.GX11919@spearce.org> <20091116045532.GC14664@coredump.intra.peff.net> 
	<7viqdb0zhs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 05:47:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAFy9-0005XN-2i
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 05:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370AbZKQEqy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Nov 2009 23:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753679AbZKQEqx
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 23:46:53 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:34140 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883AbZKQEqx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Nov 2009 23:46:53 -0500
Received: by pzk1 with SMTP id 1so3303164pzk.33
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 20:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=HUz77+0EQGwDaI9nYONLP1h+8CeKJRMg83kpq1kudqs=;
        b=Gh0Z7ViWa+mR/gdOGOCEoFq+ULVXQtD19F5YTjkywBH2esLBi2PbYxKEadFnr2uLY1
         MDUV0gPamhgwUe9uTpA91RKczzGi8nL61fDhUtRG0ykztJhedwGyX4TLW7Df2u0iZ2nm
         dbvUJfPAqcKCQF8i/ovixf/VaUhQnuZweyHFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=s2keEjubXz71cMhgJl40aswCrgsaJ3X3KdJqd9PSMo5IXTJHUxZ+/+4V9lWyFTLa0Y
         tFmOw5Gf6U6jQ3v1mIWOnV074RYSlSO74aHtnMdGew0ce5XREiViIZJf75+Hf8qS34Rd
         1ZGwqR6V241gqai2/ABBRuKZo7qxuQyEwuioU=
Received: by 10.142.61.19 with SMTP id j19mr234057wfa.201.1258433218929; Mon, 
	16 Nov 2009 20:46:58 -0800 (PST)
In-Reply-To: <7viqdb0zhs.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 189b6f76b295ddeb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133057>

On Sun, Nov 15, 2009 at 10:12 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Jeff King <peff@peff.net> writes:
>
>> On Sun, Nov 15, 2009 at 05:36:54PM -0800, Shawn O. Pearce wrote:
>> ...
>>> Shouldn't this instead be:
>>>
>>> diff --git a/http-backend.c b/http-backend.c
>>> index 9021266..16ec635 100644
>>> --- a/http-backend.c
>>> +++ b/http-backend.c
>>> @@ -626,7 +626,7 @@ int main(int argc, char **argv)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd =3D c;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd_arg =3D xmalloc(n);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd_arg =3D xmalloc(n + 1)=
;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strncpy(cmd_arg, dir + o=
ut[0].rm_so + 1, n);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd_arg[n] =3D '\0';
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dir[out[0].rm_so] =3D 0;
>>>
>>> The cmd_arg string was simply allocated too small. =A0Your fix is
>>> terminating the string one character too short which would cause
>>> get_loose_object and get_pack_file to break.
>>
>> Actually, from my reading, I think his fix is right, because you tri=
m
>> the first character during the strncpy (using "out[0].rm_so + 1").
>
> Your regexps all start with leading "/", and rm_so+1 points at the
> character after the slash; the intention being that you would copy
> the rest of the matched sequence without the leading "/".
>
> So allocating n =3D rm_eo - rm_so is Ok. =A0It counts the space for
> terminating NUL. =A0But copying "up to n bytes" using strncpy(), only=
 to NUL
> terminate immediately later, is dubious. =A0You would want to copy on=
ly n-1
> bytes. =A0I.e.
>
> =A0 =A0 =A0 =A0n =3D out[0].rm_eo - out[0].rm_so; /* allocation */
> =A0 =A0 =A0 =A0... validate and fail invalid method ...
> =A0 =A0 =A0 =A0cmd_arg =3D xmalloc(n);
> =A0 =A0 =A0 =A0memcpy(cmd_arg, dir + out[0].rm_so + 1, n-1);
> =A0 =A0 =A0 =A0cmd_arg[n-1] =3D '\0';
>

I think the strncpy( , ,n) would not harm anything because we won't
overflow dir because it's NUL terminated in getdir(), and the '\0'
shouldn't match the regex. But I agree that strncpy( , , n-1) is
better and memcpy( , , n-1) is better still.

Better eyes than mine have now looked at this and see different things
each time.  I wonder if some parts could be made a little less subtle
(perhaps along with the dir[out[0].rm_so] =3D 0;)?

Thanks,
Tarmigan
