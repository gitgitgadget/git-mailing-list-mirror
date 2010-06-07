From: =?UTF-8?Q?Cl=C3=A9ment_Poulain?= <clement.poulain@ensimag.imag.fr>
Subject: Re: [RFC/PATCH 1/4] sha1_name: creating context cache
Date: Mon, 7 Jun 2010 10:34:01 +0200
Message-ID: <AANLkTimLzfmF060d_8mNjrXwTV72A9KudtpEeJUkMWJt@mail.gmail.com>
References: <1275823848-7151-1-git-send-email-clement.poulain@ensimag.imag.fr>
	<1275823848-7151-2-git-send-email-clement.poulain@ensimag.imag.fr>
	<vpqpr045f46.fsf@bauges.imag.fr>
	<20100606221557.GF6993@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 07 10:34:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLXmd-0007N2-TV
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 10:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400Ab0FGIeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jun 2010 04:34:06 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:55341 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666Ab0FGIeE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jun 2010 04:34:04 -0400
Received: by wwe15 with SMTP id 15so195399wwe.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 01:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=FJlMoBp+vxhpzWVoE0idqqqhXakQW6JHJMVTb6htII4=;
        b=SggYdYEozJp4geGZvQUihp27vjK7fjnDzSICJbjxzqBf93Qtj/RLOrEq8AuZZlHh9N
         +z+M5SEPi+I5E5hNDexAh4L0ysgd87jSwoBxdL/wbxiZnGF9fqetvskmJrldHmNkPT7S
         U4C8kmiWX9sZ0bV7kame0XMiQw+MDfroXvAko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=FLGisiWQX9XyMXdxgPCgXb3tBe+X8h6QT7HaMLDduottWADjROFpZ0y+3xpYo5TJcY
         4nTXS3a6yC4/tH3pS8BKcEVK/gAgvKjT53RfY2wuiMS/wKFPZ2ZX2ybCdS0A5kZPLtWx
         iRzx8FPwjsWWFxkLq3N1LE1DE4yGPjKvYPzgo=
Received: by 10.216.187.131 with SMTP id y3mr2002536wem.34.1275899641575; Mon, 
	07 Jun 2010 01:34:01 -0700 (PDT)
Received: by 10.216.90.149 with HTTP; Mon, 7 Jun 2010 01:34:01 -0700 (PDT)
In-Reply-To: <20100606221557.GF6993@coredump.intra.peff.net>
X-Google-Sender-Auth: E2-vaBbzbItmkIjBgpSkv_KbAm0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148585>

2010/6/7 Jeff King <peff@peff.net>:
> On Sun, Jun 06, 2010 at 05:56:41PM +0200, Matthieu Moy wrote:
>
>> > +struct object_resolve_context {
>> > + =C2=A0 unsigned char tree[20];
>> > + =C2=A0 char path[PATH_MAX];
>> > + =C2=A0 unsigned mode;
>> > +};
>> > +extern struct object_resolve_context object_context;
>>
>> Is it really a good idea to make this a global variable? As I
>> understand it, the semantics of this variable is that it contains
>> information on the last sha1 name parsed (BTW, you probably want to
>> add a comment here explaining that). Wouldn't it be more robust to
>> have this value returned by the function doing the parsing?
>
> This is straight from my earlier patch, but I think I said in that
> thread that it could use some cleaning up. You added the 'mode' field=
,
> but it probably makes sense to then get rid of the distinction betwee=
n
> get_sha1 and get_sha1_with_mode, and just have:
>
> =C2=A0get_sha1_with_context(const char *name, unsigned char *sha1, st=
ruct
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0object_resolve_context *orc) {
> =C2=A0 =C2=A0 /* basically get_sha1_with_mode, but set mode in orc */
> =C2=A0}
> =C2=A0get_sha1(const char *name, unsigned char *sha1) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct object_resolve_context orc; /* to =
be thrown away */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 return get_sha1_with_context(name, sha1, =
&orc);
> =C2=A0}
>
> -Peff
>

Yes, we've already thought about it (you've said it, Jeff ;-) ), and we=
 have
actually changed it with something very close to what you say.
We'll soon propose a v2 for this part of the patch.

Thank you
