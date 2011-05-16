From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Bikeshedding advice on the ab/i18n-scripts series
Date: Mon, 16 May 2011 23:13:09 +0200
Message-ID: <BANLkTimuA6-jLAUAMuhVf6FfJ2eNp8ROZw@mail.gmail.com>
References: <BANLkTi==pxyy7OeZT0mn33iJHrc5R7vHBw@mail.gmail.com>
	<7vboz2l6h1.fsf@alter.siamese.dyndns.org>
	<7v62pal5v7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 23:13:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM56K-0006B0-LS
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 23:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387Ab1EPVNM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 May 2011 17:13:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53105 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411Ab1EPVNL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 17:13:11 -0400
Received: by fxm17 with SMTP id 17so3373078fxm.19
        for <git@vger.kernel.org>; Mon, 16 May 2011 14:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=h7XP1ROQYpQr91/grmZV7/0iHddEZFr6BA605gDP7D0=;
        b=rcHq8erSPmBnyWS2PPH7HIvUrvQkMHjkCH0cAos9ENdAG05LsadlbjWxUx7BlFYqpL
         Dle0IRC/PdZ7A2X36B737uUYRF4F1TqhNvCMGxHURTeAcsDo1hUsEhDdhFXNjxa0e8u7
         XfJShaCoMH6GY/nRNjpyWUi+cK91NLbLNazDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jUL906LGXjjyhI48TA7A8+0att3t2aquKkqTKP6NPBBFwbUPZWGmR8KMzxYaf9LpbG
         NiU4w7emzsGUhlxiZ3eJVu2DqLrlrhVadEIHWq9uJJXxAKUV2sC691crG4ugnyzOcxuE
         /FlcXvsFQ3HO0ZWSn5kuicDq1EMcmUKbjwX4c=
Received: by 10.223.73.139 with SMTP id q11mr4463595faj.56.1305580389818; Mon,
 16 May 2011 14:13:09 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Mon, 16 May 2011 14:13:09 -0700 (PDT)
In-Reply-To: <7v62pal5v7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173761>

On Mon, May 16, 2011 at 22:58, Junio C Hamano <gitster@pobox.com> wrote=
:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Ahh, perhaps I was the one who said something stupid like:
>>
>> =C2=A0 =C2=A0 =C2=A0 echo >&2 "$(cmd)"
>>
>> should be equivalent to
>>
>> =C2=A0 =C2=A0 =C2=A0 cmd >&2
>>
>> which is not the case when output from cmd does not end with a singl=
e LF
>> (i.e. either an incomplete line, or with trailing blank lines).
>>
>> Sorry, if that is what you are trying to address, please let me take=
 that
>> back.
>
> Having said that, depending on how the strings are distributed, I hav=
e a
> feeling that we might be better off having two variants:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0say >&2 "<message string>"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0gettext >&2 "<message string>"
>
> The former would be
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0say () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gettext >&2 "$=
1"; echo
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> and minority of callers (they may be an empty set) that care about
> trailing blank lines they output can include their own terminating LF=
s in
> the message to be translated and call gettext directly, letting it ou=
tput
> the translation without stripping trailing LFs they (or their transla=
tion)
> produce.

That would require us to start extracting strings from all "say"
functions. The reason we have only "gettext" and "eval_gettext" is so
xgettext can extract them.

I'd like to keep that simplicity. Let's not go and wrap these
functions for trivial aesthetics at the cost of complexity.
