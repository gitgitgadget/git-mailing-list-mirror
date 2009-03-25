From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] init-db: support --import to add all files and commit 
	right after init
Date: Wed, 25 Mar 2009 15:32:17 +1100
Message-ID: <fcaeb9bf0903242132k71e78219xfda5553854df4a2c@mail.gmail.com>
References: <1237946996-5287-1-git-send-email-pclouds@gmail.com> 
	<20090325041934.GA15524@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 25 05:34:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmKpK-0008JV-Cf
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 05:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757811AbZCYEcf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 00:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757835AbZCYEcf
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 00:32:35 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:21103 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757979AbZCYEce convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 00:32:34 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2640896rvb.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 21:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fNvlaU148DwVvQYAFMSPTKiG6HozFzRq5k87OiZv/qg=;
        b=UuwHEonYJm2fpEAti9mAvkLPDj7PHjNsWfnwQs+hrkLjDIcBX02yHBzo/ODlV5ZVOq
         nWfSlQXs8RBnA3iUwAs+1boUWNPf8TXshZ7z0DK8ImD6fEt4yL1BZeXSUJ2S8UYI/zGl
         pAXrKIvyGGS1S5QZh7k7z3wb3q29wGnP24WFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=V29KLG89jUvACY4PQt+c63Sh1zVRfSRDiv78TKjcy/BE4g0o8QeD/nM22gpaZ/vaRn
         maQsu71AM+vw+HojtoFR/kUONZ4BD50lpJdYGXqMkRcax6WEag5emP5EcNklsT0wd1hs
         ST5KvZ8OtoqByyFNkwCtEkDgxFeOnfAmHm7as=
In-Reply-To: <20090325041934.GA15524@coredump.intra.peff.net>
Received: by 10.142.126.6 with SMTP id y6mr3467170wfc.23.1237955552199; Tue, 
	24 Mar 2009 21:32:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114562>

2009/3/25 Jeff King <peff@peff.net>:
>> +-m <message>::
>> +--import=3D<message>::
>> +
>> +Commit everything to the newly initialized repository. This is equi=
valent to:
>
> Maybe this is being too lazy, but I think it would be useful to allow
> just "--import" without a message to default to "Initial commit",
> "initial import from `basename $PWD`", or something like that.

I tend to do "commit -q -m i", not a big deal for two more keystrokes.
My initial version allowed "git init /path/to/workdir" too so it might
be ambiguous for optional message. So all vote for "Initial commit"?
Dynamic message seems overkill because most of the cases, this is a
throw away repository.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (!strcmp(arg, "-=
-import") || !strcmp(arg, "-m")) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (i+1 >=3D argc)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("--import requires an import messag=
e");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 import_message =3D argv[2];
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 i++;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 argv++;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> I seem to recall that we were phasing out "--long-option <arg>" at so=
me
> point, and that all long-options should use "--long-option=3D". But m=
aybe
> I am mis-remembering.

I did not know too. Any reference?
--=20
Duy
