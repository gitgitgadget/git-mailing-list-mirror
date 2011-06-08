From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 16/19] transport-helper: change import semantics
Date: Wed, 8 Jun 2011 22:52:22 +0200
Message-ID: <BANLkTi=tfE2GtpSZxY7ir98MDREefSFT1g@mail.gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-17-git-send-email-srabbelier@gmail.com> <20110608204754.GK27715@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 22:53:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUPkS-0007lQ-9n
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 22:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162Ab1FHUxE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 16:53:04 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50259 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103Ab1FHUxC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 16:53:02 -0400
Received: by qwk3 with SMTP id 3so426180qwk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 13:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=BkZMiscOOcGtJqTisIyGndKvGJHTFqXSFPVyOXLk2Qw=;
        b=Zi3h5izieHi4Vu5d2m/ZEE/1+Z8wZrrDANDsPsIBL58jnfK7jMKjymLqTpPQYpbaZO
         d66ZdQ8A4qlo/nv7D1QiZ6A0OcrjnvLXE0rSLe4DEwI0ggM3HZ40f6S1ScUUUoiYrZ0L
         SmDVKXaWeF+n15ploZTvz8p2IjIGIebQA9GOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=V6JZvec0jbCT9jysUJDUZymxE/ztJtQZgR/xSJi7VfK+0WyumnsXG0sEmjnZuh5Wjq
         D3a9Sm8GK/vISdE+SqT8mmt/oaFvmr7xWgpsaFtkcyyOcLNfoHvClWQlK9umnjVhGa14
         Gc19oa3zB54PfqZsRoa+sg/YEJH924Q1T3T/g=
Received: by 10.229.135.12 with SMTP id l12mr5951384qct.53.1307566382079; Wed,
 08 Jun 2011 13:53:02 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Wed, 8 Jun 2011 13:52:22 -0700 (PDT)
In-Reply-To: <20110608204754.GK27715@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175457>

Heya,

On Wed, Jun 8, 2011 at 22:47, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Wait, now that I look there, wouldn't it be more consistent with
> what "push" does to make the semantics
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0... A batch sequence of
> =C2=A0 =C2=A0 =C2=A0 =C2=A0one or more import commands is terminated =
with a blank line.
>
> ? =C2=A0In other words, what was the rationale for making push work l=
ike
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0push +src1:dst1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0push +src2:dst2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0push +src3:dst3
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[... command stream continues here ...]
>
> instead of
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0push
> =C2=A0 =C2=A0 =C2=A0 =C2=A0+src1:dst1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0+src2:dst2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0+src3:dst3
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[... command stream continues ...]
>
> and does it apply for import, too?

I don't know. Shawn added the push capability in ae4efe19 (Move WebDAV
HTTP push under remote-curl, Fri Oct 30 2009) but there is no
rationale for doing it that way there. Shawn, do you remember?

--=20
Cheers,

Sverre Rabbelier
