From: "Paolo Teti" <paolo.teti@gmail.com>
Subject: Re: git-rebase (1.5.0.6) errors
Date: Fri, 18 May 2007 12:31:51 +0200
Message-ID: <34a7ae040705180331x1a86782fh3b2c6a87db32030e@mail.gmail.com>
References: <Pine.LNX.4.64.0705181130570.28356@kivilampi-30.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
X-From: git-owner@vger.kernel.org Fri May 18 12:32:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hozkj-0007ab-GI
	for gcvg-git@gmane.org; Fri, 18 May 2007 12:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788AbXERKb6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 May 2007 06:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755060AbXERKb6
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 06:31:58 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:42012 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788AbXERKb5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2007 06:31:57 -0400
Received: by nz-out-0506.google.com with SMTP id r28so1279394nza
        for <git@vger.kernel.org>; Fri, 18 May 2007 03:31:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GXNF9b52V2kL5J+83f5ET4jC+XnQI7nIIKnq2t5Zto8b4q9bwenES4I70jXNGZlAa0suYHm9PYcKJkk9tWKstAYqGUHvniIRMxRX//vJwbiEl4gShef5TeNN5lzZridRM9/ex1i+WbWF0sv9miZ+d1BlDI5j32ba8UccQs11D6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CdUST4ihuOeMySdvChmiQ0/BUB2AhNr05i93S75I8HuUBYEhms5BJYdASSIwZA21lECWll1/l4woHzE/Dlg634yCQS5XIZcwNlKmEz7/VcaTYyyXbZ17k/OLjXmCPWBjXSljRMg3gnGfDtITTxNiAMKsZm76NEafWu08xcz/7ic=
Received: by 10.114.78.1 with SMTP id a1mr773075wab.1179484311153;
        Fri, 18 May 2007 03:31:51 -0700 (PDT)
Received: by 10.115.58.17 with HTTP; Fri, 18 May 2007 03:31:51 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705181130570.28356@kivilampi-30.cs.helsinki.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47589>

2007/5/18, Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi>:
> Hi,
>
>
> ijjarvin@kivilampi-30:~/work/src/submit$ git-rebase net-2.6.22-origin
> First, rewinding head to replay your work on top of it...
> HEAD is now at d739437... [IPV4]: Correct rp_filter help text.
> fatal: cannot convert from utf-8 to utf-8


Now I can't test or try to reproduce your error,
but looking at the source code (only with gitweb)
I have found another bad use of size_t instead of ssize_t
in the reencode_string(..) that take part at the conversion process.

Using size_t in the next portion of code the check "count =3D=3D -1" is=
 never true.

while (1) {
		size_t cnt =3D iconv(conv, &cp, &insz, &outpos, &outsz);

		if (cnt =3D=3D -1) {
			size_t sofar;
			if (errno !=3D E2BIG) {
				free(out);
				iconv_close(conv);
				return NULL;
			}


Please someone could fixes this bad use of size_t?..

Sorry, but now I can't install/use git because I'm on a customer workst=
ation..
