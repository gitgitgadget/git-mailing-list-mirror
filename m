From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] use xstrdup, not strdup in ll-merge.c
Date: Mon, 15 Jun 2009 17:21:11 +0200
Message-ID: <81b0412b0906150821x30eb621ctcddc7691192b5270@mail.gmail.com>
References: <87bpoqoavp.fsf@meyering.net>
	 <81b0412b0906141503v14484d9fyea56198910305bfc@mail.gmail.com>
	 <87fxe2lybr.fsf@meyering.net>
	 <81b0412b0906150145j7c717a6ar33bb4f2ebd6095e1@mail.gmail.com>
	 <87vdmxluj8.fsf@meyering.net>
	 <81b0412b0906150439r755a7498ldddbca911b2fd36e@mail.gmail.com>
	 <877hzdlnt6.fsf@meyering.net>
	 <81b0412b0906150546p34ff53ceo81ea59785cf9d18a@mail.gmail.com>
	 <20090615142648.GV16497@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 15 17:21:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGDzw-00084i-Br
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 17:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758235AbZFOPVM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2009 11:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755942AbZFOPVM
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 11:21:12 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:65077 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815AbZFOPVL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2009 11:21:11 -0400
Received: by bwz9 with SMTP id 9so3406101bwz.37
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 08:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZFs5sSwempc/I/00+KeZt+EMp85GlLn3hvBvdsF4jbs=;
        b=NqoR/LuxnIvnMZbm6oY9LU1zix1eVRCoM+ZcYECOnM+7ZEh7aPzN8yDvTyGw80om3D
         pLdGBdXwQNzxfPHgGngKpx3UTEi0o1r1qRndJxxHe8F+UUU+Nz+N6wP+ERhm99mNCyCa
         Op2ha3+zry27HLLeQwX4+agHUEBapcIHzE/WQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Mk6U9UgrA71IXE7pqwDHePRVQCnuWS84uArExrz+TJsY08vEIzEODeNXzCzDYufoWP
         J8EKxSg+t++N8Z+246j+qC5n+fnTs51a9gKt0D/UU5tGH5nLkf0ajvWMfcQrsBW6Ep2O
         yZgvSqzDP9volFaP0Tjf03f8+zsf2nbZqi1po=
Received: by 10.204.59.76 with SMTP id k12mr7141505bkh.136.1245079271092; Mon, 
	15 Jun 2009 08:21:11 -0700 (PDT)
In-Reply-To: <20090615142648.GV16497@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121614>

2009/6/15 Shawn O. Pearce <spearce@spearce.org>:
> Alex Riesen <raa.lkml@gmail.com> wrote:
>> As much as I'd like to know as much as possible about why something
>> failed, I can't make a failure handling automatically simple (given =
the tools).
>> I do suggest using goto to handle this particular OOM (below), but i=
t looks
>> almost too ugly. Maybe I am just paranoid, and am overdoing this par=
ticular
>> case.
>
> Yes, this is horrible. =C2=A0Its a huge amount of code for checking a
> strdup failure that is unlikely to occur out of a configuration file.
>
> Really, how big is that config file? =C2=A0It can't be so large that =
a
> strdup() is likely to run out of memory pulling a value from it.

Oh, I don't worry about config files being too big (it is noticeable
without this checks). I'm worried about our bugs triggering the
conditions where allocation routines return NULL, like heap corruption
which is hard to notice without valgrind.

>> The "goto oom" patch:
>
> NAK. =C2=A0We don't do this anywhere else in git. =C2=A0Please don't =
start now.

We'll have to start paying more attention to memory management sometime=
=2E
Although, this particular case may be not the best case for it.
