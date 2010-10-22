From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 07/15] daemon: use run-command api for async serving
Date: Fri, 22 Oct 2010 02:20:09 +0200
Message-ID: <AANLkTikL-uWKUtcB=NS+42ajAGrLH1B9CEE6B-0Ykeiq@mail.gmail.com>
References: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
 <1287705944-5668-7-git-send-email-kusmabite@gmail.com> <20101022001010.GB13779@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com, schwab@linux-m68k.org,
	patthoyts@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 02:20:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P95N6-0007MX-Rz
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 02:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838Ab0JVAUb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 20:20:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45502 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab0JVAUa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 20:20:30 -0400
Received: by fxm16 with SMTP id 16so200824fxm.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 17:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=bKxmqkle2nq+v1N6H5ql63R2DCnaaU1l+EM7CclqL6k=;
        b=GwIwgqWogGs9yDdikJduHWNRl2hLgDzXVb73abjqhTQ3WJ4YTnFg5JKlQO9KkbLV6t
         QsNhxLN2H2Cft/YOBFb6Qy4Rf8vC1nSv0tDY6TvEm/w2Bkw/Yf2C7MMLd+ywSj7S6wk1
         ajDR+dlDj6d8JOKx7ZtCv7fnLcAJneACyf8O8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=di5EM0vHX1iWXXaEFOemG/uYrbK40h8jW6db7bQvMzhQa0mBPetPr2FKoZkjQuKAf5
         s1XroVWILE2zoKaQZ8kjl47loKWgLOGCoPtHi5CD9NGsEvUyKlisKrML2p0s4fVgf5ft
         RbeVYkDiQ6WauHao+vRt2/Ma/Zl0lby0/5Swc=
Received: by 10.103.181.5 with SMTP id i5mr2423161mup.48.1287706829253; Thu,
 21 Oct 2010 17:20:29 -0700 (PDT)
Received: by 10.223.112.146 with HTTP; Thu, 21 Oct 2010 17:20:09 -0700 (PDT)
In-Reply-To: <20101022001010.GB13779@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159609>

On Fri, Oct 22, 2010 at 2:10 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Erik Faye-Lund wrote:
>
>> --- a/daemon.c
>> +++ b/daemon.c
> [...]
>> @@ -671,18 +658,26 @@ static void check_dead_children(void)
>> =C2=A0 =C2=A0 =C2=A0 int status;
>> =C2=A0 =C2=A0 =C2=A0 pid_t pid;
>>
>> - =C2=A0 =C2=A0 while ((pid =3D waitpid(-1, &status, WNOHANG)) > 0) =
{
>> + =C2=A0 =C2=A0 struct child **cradle, *blanket;
>> + =C2=A0 =C2=A0 for (cradle =3D &firstborn; (blanket =3D *cradle);)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((pid =3D waitpid(bla=
nket->cld.pid, &status, WNOHANG)) > 1) {
>
> What is this change (> 0 =E2=86=92 > 1) about?
>

Oooh, that's a typo, nice catch! I'll throw in a hot-fix when reposting=
!
