From: Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>
Subject: Re: [PATCHv2] Add a remote helper to interact with mediawiki, pull &
 clone handled
Date: Tue, 7 Jun 2011 13:33:09 +0200
Message-ID: <BANLkTimTAhi6MZg_COopdyHwNifqmRVy0A@mail.gmail.com>
References: <1307440754-3697-1-git-send-email-jeremie.nikaes@ensimag.imag.fr> <BANLkTik--BAqZxCYQ-ApUn2yKmcr_-hubg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	git@vger.kernel.org, jrnieder@gmail.com,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?ISO-8859-1?Q?Sylvain_Boulm=E9?= <sylvain.boulme@imag.fr>
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 13:33:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTuXO-0005As-RN
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 13:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755Ab1FGLda convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2011 07:33:30 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38799 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590Ab1FGLd3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 07:33:29 -0400
Received: by vws1 with SMTP id 1so3464082vws.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 04:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=QQYHivnzROc3dnk6iopDMjI5W+AL2q/fe4gjqZCuSaY=;
        b=dbSe/JTyyvK56yfr+caiI94xhZKiQCAMznzSWoNRGLcQJZhxjJTRag+mdl/OYDBzjS
         B5cIbIIO1hv0d5Q9XQmFYbvFN6Em2bsRFGx06cvAjmSYVtTTKopTLv0RjqVokcRwiGoZ
         Gs7ENUJhPnLimJaO8a5N4Pi+9brx+wgAYL82g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=T9rSJr5MQ35KnhGw08PO1chy0GKs+13ze2g+rGYPFpM9U1+dyOR19dvPSaz8LG/PDt
         ixddu7Ri0Fm4GnrRuY4Gt+mN9pUTgZRF/l6SfS2/ugb0S9Z7zB0UPFp/WKOEYsyqENvI
         dnCxf1es/7ERUH6t43E7yZz6u2PyvTulXYXxQ=
Received: by 10.52.178.101 with SMTP id cx5mr605143vdc.250.1307446409110; Tue,
 07 Jun 2011 04:33:29 -0700 (PDT)
Received: by 10.220.5.11 with HTTP; Tue, 7 Jun 2011 04:33:09 -0700 (PDT)
In-Reply-To: <BANLkTik--BAqZxCYQ-ApUn2yKmcr_-hubg@mail.gmail.com>
X-Google-Sender-Auth: z5uJSujEO3STWq6AZ2AG6OPDmJA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175198>

Hi,

2011/6/7 Thomas Adam <thomas@xteddy.org>:
> Hmm. =A0What guarantees can you make about the scalar value of @cmd h=
ere
> once the split has happened? =A0Do you not care, or do you have a
> hard-limit for split to use?

The verifications on the different cmd[x] are made in the few lines
"if ... elsif... elsif ... else" right after the split.

> These explicit calls to "STDOUT" here -- why? =A0It's redundant typin=
g
> and unsightly, and certainly not very perl-y. =A0Is there some reason
> why you're using this style?

We wanted to highlight the fact that we are sending those lines to STDO=
UT
which is piped into the caller of the remote helper.

>
>> + =A0 =A0 =A0 print STDOUT "? refs/heads/master\n";
>> + =A0 =A0 =A0 print STDOUT '@'."refs/heads/master HEAD\n";
>> + =A0 =A0 =A0 print STDOUT "\n";
>
> Hmm. =A0Why not just:
>
> print STDOUT '@'."refs/heads/master HEAD\n\n";

Here, we wanted to stick to the convention given by the remote-helper
documentation that indicates the list command should end with a blank l=
ine.

>
> There's certainly a large number of perl-specific clean-ups I'd be
> inclined to do -- and if I get time later, I might show you how. =A0B=
ut
> don't let this necessarily put off this patch for inclusion or
> anything like that.

As said in previous mails, we are relatively new using perl (it's been
roughly two weeks)
so any advice on how to get things more perl-ish are welcome.

Thanks for your feedback
--=20
Arnaud Lacurie
