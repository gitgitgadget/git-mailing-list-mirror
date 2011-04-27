From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: move private shopt shim for zsh to __git_ namespace
Date: Thu, 28 Apr 2011 01:48:58 +0300
Message-ID: <BANLkTinKgubAeFy+mJ=hGdG8c-QXjyNTcA@mail.gmail.com>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
	<20110427013534.GA14286@elie>
	<7v62q0b8e0.fsf@alter.siamese.dyndns.org>
	<20110427064033.GB4226@elie>
	<BANLkTinA5hfddqpGwOBjk+2oFDpwqORrSg@mail.gmail.com>
	<20110427091140.GB14849@elie>
	<BANLkTi=3T2B=Gtyk7V_3DB3V+GkbXAaqPw@mail.gmail.com>
	<BANLkTikN7iMa_z7wRN8pUS07SMatpyoDPQ@mail.gmail.com>
	<20110427212704.GB18596@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Haller <lists@haller-berlin.de>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 00:49:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFDXe-0005B1-Ef
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 00:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760142Ab1D0WtA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 18:49:00 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35042 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760125Ab1D0WtA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 18:49:00 -0400
Received: by fxm17 with SMTP id 17so1460159fxm.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 15:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TGENSWYA3YTuErvWPWOdaetpB/YYQp+X1JuYgfb0jP0=;
        b=ZmrQ8ijdJXrCxJvcNOdS5BSLin6mJQNDPZZXvAmilODON9qFoPseMeqdjhU2RwRf57
         RPd3vrgymIrwcUI1bdFNzrSb5nq3s7yB5i66pAN2D1ujB+f+CvEK+otrHszM/XYgoaN+
         nw+ILyZYXIU9lT6hPzKUMrnyxzPZlyWr0GF8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NOlKLf8Z/hG9aS9xPUepj7wlCvpWtgfp65qjxD3+xPx4g/vnI3XpVgDNLzjXsp+0wv
         oyO/HtEjOePBo8zS7pB1JCXw/WtK1P6JyTiKSqrTUZbPXuvO/SzRm+2InJ56fa3nOrKk
         NERz8ihJ3VvRug9LgtIUwDoL7O9mrDQZfPEKc=
Received: by 10.223.77.4 with SMTP id e4mr1494568fak.51.1303944538781; Wed, 27
 Apr 2011 15:48:58 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Wed, 27 Apr 2011 15:48:58 -0700 (PDT)
In-Reply-To: <20110427212704.GB18596@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172285>

On Thu, Apr 28, 2011 at 12:27 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Felipe Contreras wrote:
>> +++ b/contrib/completion/git-completion.bash
>> @@ -75,6 +75,10 @@
>>
>> =C2=A0if [[ -n ${ZSH_VERSION-} ]]; then
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 autoload -U +X bashcompinit && bashcompi=
nit
>> +
>> + =C2=A0 =C2=A0 =C2=A0 # 'words' has special meaning in zsh, and onl=
y typeset -h seems to
>> + =C2=A0 =C2=A0 =C2=A0 # override that
>> + =C2=A0 =C2=A0 =C2=A0 alias local=3D"typeset -h"
>> =C2=A0fi
>>
>> =C2=A0case "$COMP_WORDBREAKS" in
>
> The above would change the meaning of "local" in the user's
> environment and in all shell snippets she sources later. =C2=A0Are yo=
u sure
> that's intended?

Crap. I didn't realize that :(

I have been looking for a way to have local aliases or functions, but
I can't find any.

--=20
=46elipe Contreras
