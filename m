From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH/RFC 01/11] mingw: add network-wrappers for daemon
Date: Thu, 26 Nov 2009 11:46:43 +0100
Message-ID: <40aa078e0911260246j47fa36d5t421de7c1d07d5cca@mail.gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
	 <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
	 <alpine.DEB.2.00.0911261015140.14228@cone.home.martin.st>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: =?ISO-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>
X-From: git-owner@vger.kernel.org Thu Nov 26 11:46:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDbsB-0006Xc-E3
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 11:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758576AbZKZKqj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Nov 2009 05:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752512AbZKZKqj
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 05:46:39 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:60927 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbZKZKqi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 05:46:38 -0500
Received: by ewy19 with SMTP id 19so296359ewy.21
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 02:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8fulscYjpOeGkKSkp1Mb1s2NRsDVg/Gc6rYf9pNwrVA=;
        b=Ha4FuTfucQ2zLykxXZmtSyLhDxAbRnlZfLXU1UmHCCrNdsSebroHjnY/jE7YOZJ0TB
         9osOaO7HeFjwpyBEr0aBW2Y9Zd71kz3a1pqF6KScVzQiCYi+84Vv+yhdGzjKSOjFi07e
         /XtF98ZZpDzGPv4JySKSUgmCrmupVCXiLP+tk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=f0M68ha32n0dapn0XtfI+iWP9khwmH+oU7F2ETDLKLKAi/jgSIFQ1kZ8yqB3H291XL
         qqxH47oKJZ5HRA2sfOahXMmYRfmSNl1EhUqVNhmrbze3BjdpDjLhaWh3PO+KS19tn0NR
         GLfAlvyWi/YvfmHhHGb7xllNURUjAr7V76aR8=
Received: by 10.216.89.84 with SMTP id b62mr584089wef.227.1259232403845; Thu, 
	26 Nov 2009 02:46:43 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0911261015140.14228@cone.home.martin.st>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133782>

On Thu, Nov 26, 2009 at 9:24 AM, Martin Storsj=F6 <martin@martin.st> wr=
ote:
> Hi,
>
> First of all, great that you're working on adding daemon support for
> windows!

Thanks. I meant to send this out a couple of weeks ago, but I wasn't
able to find the time until now.

Also, I wouldn't have come this far without going tired of it without
Mike's patches, so some credit should go to him for doing good initial
work!

> On Thu, 26 Nov 2009, Erik Faye-Lund wrote:
>
>> +static void wsa_init(void)
>> =A0{
>> + =A0 =A0 static int initialized =3D 0;
>> =A0 =A0 =A0 WSADATA wsa;
>>
>> + =A0 =A0 if (initialized)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> =A0 =A0 =A0 if (WSAStartup(MAKEWORD(2,2), &wsa))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("unable to initialize winsock subsys=
tem, error %d",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WSAGetLastError());
>> =A0 =A0 =A0 atexit((void(*)(void)) WSACleanup);
>> + =A0 =A0 initialized =3D 1;
>> +}
>
> Something similar to this was merged into master recently as part of =
my
> mingw/ipv6 patches, so by rebasing your patch on top of that, this pa=
tch
> will probably get a bit smaller.

Yeah, I saw your patches, and realized that I needed to rebase my work
at some point, but none of the repos I usually pull from seems to
contain the patches yet. Rebasing will be a requirement before this
can be applied for sure.

>
> Also, the getaddrinfo-compatibility wrappers perhaps may need some mi=
nor
> updates to handle the use cases needed for setting up listening socke=
ts.

I expect you're referring to IPv6 support in the wrappers this patch
adds? Unfortunately IPv6 isn't something I'm very familiar with, but
I'll give it a go unless someone else provides some patches...

--=20
Erik "kusma" Faye-Lund
