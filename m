From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH RFC] parse_object: pass on the original sha1, not the 
	replaced one
Date: Mon, 2 Aug 2010 19:31:23 +1000
Message-ID: <AANLkTin0eymuYFv_6hamDuan0TELogtCyW3Xwjm=pAwH@mail.gmail.com>
References: <1280579802-8606-1-git-send-email-pclouds@gmail.com>
	<201008020942.58137.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Aug 02 11:31:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfrMq-0002WH-5a
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 11:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab0HBJb0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 05:31:26 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48410 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095Ab0HBJbZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 05:31:25 -0400
Received: by wwj40 with SMTP id 40so3630149wwj.1
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 02:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4ByK4PjmQhWaNJGkLHrp8qjfa274ngDhZeFvDbFpOQw=;
        b=PjFMSgTYKYsHO349KQGdugsV3qGOkQdgsDJbWiT2IWi+QyIdaDuVE0ixdE/Cf5PXNR
         cXI0b5YOxO++00KncnIUI4DzbkyJ+wCMXkfwKgrzYAcCiOUR/8WKThg7bQbeBXR2EB2L
         zgJkemGnRk6EN1gbitp29F8T+gTB2iBvYtfAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ouiNQBROYE5dNPgf6UNZ+ehX/KdktMPltdTuU2bK0i62DzdQS0Fo+Z40UIAco8L0WY
         sb6BJ8fW57R6e05/ya+JNRo4L9zvXyb1f3PwA4rTaurk8HtnmC9ymemYkgm0xk8qsK/e
         jFPhebhMj+MI5Q3bgy8w1wsKdeWl9E1/TXXu4=
Received: by 10.216.21.204 with SMTP id r54mr4624170wer.95.1280741483855; Mon, 
	02 Aug 2010 02:31:23 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Mon, 2 Aug 2010 02:31:23 -0700 (PDT)
In-Reply-To: <201008020942.58137.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152400>

2010/8/2 Christian Couder <chriscool@tuxfamily.org>:
> On Saturday 31 July 2010 14:36:42 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy wrote:
>> Commit 0e87c36 (object: call "check_sha1_signature" with the
>> replacement sha1) did this. I'm not sure if it's should be done this
>> way.
>>
>> With "repl" as the first argument to parse_object_buffer, the return=
ed
>> obj pointer will have the replaced SHA1 in obj->sha1, not the origin=
al
>> one. I sort of expect that, no matter the object is replaced,
>> obj->sha1 should stay the same.
>>
>> This was observed by replacing commit tip. git log would show the
>> replaced sha1, not the original one.
>
> I am not sure I understand what you are saying. Do you mean that git =
log
> should show the original sha1 but the content of the replacement comm=
it,
> instead of both the sha1 and the content of the replacement commit?

"original sha1, but the content of replacement commit", yes. Isn't
that the intention of git-replace?

> I just tested your patch and indeed with it it seems to me that the r=
esult
> shown by git log is not consistent, as for example the commit message=
 is the
> one of the replacement commit but the commit sha1 is the one of the o=
riginal
> commit.

The consistency is already there. Suppose I want to replace commit A
with B. Depends on what function I call to fetch "A", I get different
object->sha1. (the content is always from B though).

With parse_object(A), I get an object pointer whose sha1 is B.

With  lookup_commit(A), I get an object pointer whose sha1 is A.

> Could you explain why you need the object returned by parse_object_bu=
ffer to
> not have the replacement SHA1 in obj->sha1 when it is parsing the buf=
fer from
> the replacement object?

As I said above, it's inconsistent. I'm not saying my way is correct.
Just wondering.
--=20
Duy
