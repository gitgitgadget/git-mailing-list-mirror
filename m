From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] log: allow to specify diff pathspec in addition to prune pathspec
Date: Sat, 5 Nov 2011 10:25:42 +0700
Message-ID: <CACsJy8CYEN5Li43C0H2hLbkAzEmGSUBiN+qyQ8tcOLx=3Cox0Q@mail.gmail.com>
References: <1320314474-19536-1-git-send-email-pclouds@gmail.com>
 <1320322556-32675-1-git-send-email-pclouds@gmail.com> <7vwrbfa6j6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 05 04:32:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMWzP-0001lr-IV
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 04:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab1KED0P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Nov 2011 23:26:15 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41469 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab1KED0O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2011 23:26:14 -0400
Received: by bke11 with SMTP id 11so2481006bke.19
        for <git@vger.kernel.org>; Fri, 04 Nov 2011 20:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=DW3h63PQF4UmVSEx4ARXlFxiTe2gZVDc2CsT5aT4Yes=;
        b=NMxQo0AQ4V8lALYrwtUv2cAeP5Ocs7JvayFm3cPmpkdKec+wP/otCUVpxf35nSnwXz
         ZaNWG7P0mY/J3BU/FcHNrG2T0YWx6/j6fN+1lmmDTxAEpcGhvrT2tiCJFdFJx8If4j5g
         vgpXxXgnchFAftMGu3OTnpbZoS+Df5w5lZJxo=
Received: by 10.204.147.215 with SMTP id m23mr13403304bkv.84.1320463573153;
 Fri, 04 Nov 2011 20:26:13 -0700 (PDT)
Received: by 10.204.177.79 with HTTP; Fri, 4 Nov 2011 20:25:42 -0700 (PDT)
In-Reply-To: <7vwrbfa6j6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184816>

2011/11/5 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> Pathspec in "git log -p <pathspec>" is used for both commit pruning
>> and diff generation. If --full-diff is given, then diff pathspec is
>> reset to generate complete diff.
>>
>> This patch gives more control to diff generation. =C2=A0The first pa=
thspec in
>> "git log -p -- <pathspec> -- <pathspec>" is used as commit pruning
>> as usual. The second one is used for diff generation. So --full-diff
>> now is essentially "git log -p -- <pathspec> --".
>
> I agree that giving more control to diff generation is a good idea, a=
nd
> this certainly is better than the previous round that nobody reviewed
> before you rerolled this round.
>
> But I have doubts about declaring "--full-diff is equivalent to givin=
g the
> 'output' pathspec that is empty".

The equivalent command should be "git log -p -- <pathspec> -- :/" (in
case you're in subdir). What doubts specifically?

> Have you thought about the interaction between this and -M/-C options=
?

No, yes I may have problems there.

> This is not a new "problem" (and it is probably not a problem to begi=
n
> with).  If you had "--" in the working tree and you wanted to treat i=
t as
> a path, you said either one of these:
>
>    $ git log HEAD ./--
>    $ git log HEAD -- --
>
> The latter is what your patch breaks, I suspect.
>
> Also it forces existing scripts and programs that knew "everything in=
 this
> array is a pathspec" and added "--" before adding the contents of the
> array to form a command line to drive "git log" family of commands to=
 be
> updated.

We could only recognize the second "--" when a new argument is given
so it won't break existing use. But I'll need to look at -C/-M first.
Smells like --follow problem.
--=20
Duy
