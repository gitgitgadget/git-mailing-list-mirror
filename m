From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Put quotes around branch names to prevent special 
	characters from being interpreted by the shell.
Date: Mon, 7 Jun 2010 01:10:32 -0400
Message-ID: <AANLkTinZc1jiBmTJRsJXDe7A4ZAe001zJIWILGKQ8YoA@mail.gmail.com>
References: <1275666800-31852-1-git-send-email-bmeyer@rim.com>
	<20100606215505.GB6993@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benjamin C Meyer <bmeyer@rim.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 07 07:10:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLUbg-0005FV-Un
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 07:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042Ab0FGFKe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jun 2010 01:10:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40097 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab0FGFKd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jun 2010 01:10:33 -0400
Received: by mail-iw0-f174.google.com with SMTP id 37so3001501iwn.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 22:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RKmt7aN8ZtFwkGSoZWe1uLfPY4Yr5KPVHdAAH9OVZ0U=;
        b=OqmKV+mRp4nVgGx6KiHCzgy67zV3e59U0zfn1C1gPSrmZCfQgK5Ulw6R/K+9ZanzeU
         Jbgnm3z7OT8lUPUxv4bYy1FCCxjoS5bqSjn3BQ6gkMaeuLZk0d2KNfcS02aIG+4U1gFm
         PUKsFG7Fm1BbIIQWBcgogaRsNCGzhd6N09Vek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tpgOG8kcd+SeF7L5O8aw9Rcp9srC8at2HScNdJW3/wrRDovrk08zlOBg093iwwo0TL
         NF+GiKanUDq/u3QH4QSG51pwNwB5PbdcnHrlQeMaFe+tj56wbwdZ0gxlQlscDMY6yWL3
         jRXv2AmFLhBH+ftFlG0zB9Lm4thoYLtLtEGks=
Received: by 10.231.170.1 with SMTP id b1mr4113461ibz.13.1275887432716; Sun, 
	06 Jun 2010 22:10:32 -0700 (PDT)
Received: by 10.231.16.134 with HTTP; Sun, 6 Jun 2010 22:10:32 -0700 (PDT)
In-Reply-To: <20100606215505.GB6993@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148571>

On Sun, Jun 6, 2010 at 5:55 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 04, 2010 at 11:53:20AM -0400, Benjamin C Meyer wrote:
>
>> Perforce branch names with spaces (and other special characters) wer=
e
>> causing issues.
>> [...]
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0details =3D p4Cmd("branch=
 -o %s" % info["branch"])
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0details =3D p4Cmd("branch=
 -o \"%s\"" % info["branch"])
>
> Won't this still fail if your branch name contains quotation marks or
> backslashes? Does python have some equivalent to perl's quotemeta to
> just shell-escape the problematic characters

from commands import mkarg
mkarg(arg)

will enclose arg in single quotes if it contains none; else it will
enclose arg in double quotes and backslash escape shell meta
characters (any of \ $ " `).

BTW, quotemeta is technically intended for use with regular
expressions, isn't it?

> (or even a way of just
> using a straight list in p4Cmd and avoiding the shell altogether)?

The subprocess module.

> I know those characters may not be common, but if we are going to quo=
te,
> perhaps we should make it foolproof.

+1.

j.
