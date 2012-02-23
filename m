From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] merge: use editor by default in interactive sessions
Date: Thu, 23 Feb 2012 21:31:25 +0100
Message-ID: <CABPQNSagJ+vDcrcVTJdPc0i+ODeNZ21hUmRO9LBNzS9xFXg_zg@mail.gmail.com>
References: <7vipk26p1b.fsf@alter.siamese.dyndns.org> <CABPQNSZVOjOKpqv4s1ZCEQRd_yT3us3mqC9aN-KK5PHqztYQQg@mail.gmail.com>
 <7vd3954ame.fsf@alter.siamese.dyndns.org> <7vlint2t5h.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 21:32:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0fKm-0006H4-U4
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 21:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755835Ab2BWUcH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Feb 2012 15:32:07 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65387 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755201Ab2BWUcG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2012 15:32:06 -0500
Received: by daed14 with SMTP id d14so1655448dae.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 12:32:05 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 10.68.219.130 as permitted sender) client-ip=10.68.219.130;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of kusmabite@gmail.com designates 10.68.219.130 as permitted sender) smtp.mail=kusmabite@gmail.com; dkim=pass header.i=kusmabite@gmail.com
Received: from mr.google.com ([10.68.219.130])
        by 10.68.219.130 with SMTP id po2mr8255914pbc.140.1330029125289 (num_hops = 1);
        Thu, 23 Feb 2012 12:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=4gmGx34mbQA5BMqt7k2YZ+UBtbmwQx81rKVaO8SKaSQ=;
        b=UPRR3xaP8YW92FALxrTysgizNbNY1v+DXyTGhV9yuESFMR45flGKGV0hpQ1+cSyICu
         L3NwyvR0nUf47qZFWhQvh7yY2VhOFLo6vAffJq8WmcAn7d4utTVEqaR160FYziBNLBvi
         1ULMolS2fslK5Zt3zVSMvdj6iYDscTHXuF89A=
Received: by 10.68.219.130 with SMTP id po2mr6753550pbc.140.1330029125193;
 Thu, 23 Feb 2012 12:32:05 -0800 (PST)
Received: by 10.68.12.194 with HTTP; Thu, 23 Feb 2012 12:31:25 -0800 (PST)
In-Reply-To: <7vlint2t5h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191398>

On Thu, Feb 23, 2012 at 9:26 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>
>>>> + =A0 =A0 =A0 /* Use editor if stdin and stdout are the same and i=
s a tty */
>>>> + =A0 =A0 =A0 return (!fstat(0, &st_stdin) &&
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 !fstat(1, &st_stdout) &&
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 isatty(0) &&
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 st_stdin.st_dev =3D=3D st_stdout.st_=
dev &&
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 st_stdin.st_ino =3D=3D st_stdout.st_=
ino &&
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 st_stdin.st_mode =3D=3D st_stdout.st=
_mode);
>>>
>>> I just stumbled over this code, and I got a bit worried; the
>>> stat-implementation we use on Windows sets st_ino to 0, so
>>> "st_stdin.st_ino =3D=3D st_stdout.st_ino" will always evaluate to t=
rue.
>>>
>>> Perhaps we should add a check for isatty(1) here as well? ...
>>> Or is there something I'm missing here?
>>
>> No, the intention was ...
>
> s/No,/No, you are not missing anything./;
>
> I'll queue it with this explanation:
>
> =A0 =A0merge: do not trust fstat(2) too much when checking interactiv=
eness
>
> =A0 =A0The heuristic used by "git merge" to decide if it automaticall=
y gives an
> =A0 =A0editor upon clean automerge is to see if the standard input an=
d the
> =A0 =A0standard output is the same device and is a tty, we are in an =
interactive
> =A0 =A0session. =A0"The same device" test was done by comparing fstat=
(2) result on
> =A0 =A0the two file descriptors (and they must match), and we asked i=
satty() only
> =A0 =A0for the standard input (we insist that they are the same devic=
e and there
> =A0 =A0is no point asking tty-ness of the standard output).
>
> =A0 =A0The stat(2) emulation on Windows port however does not give a =
usable value
> =A0 =A0in st_ino field, so even if the standard output is connected t=
o something

Shouldn't that be "emulation _in the_ Windows port" and "in _the_ st_in=
o field"?

> =A0 =A0different from the standard input, "The same device" test may =
incorrectly
> =A0 =A0return true. To accomodate it, add another isatty() check for =
the standard
> =A0 =A0output stream as well.
>
> =A0 =A0Reported-by: Erik Faye-Lund <kusmabite@gmail.com>
> =A0 =A0Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Thanks.

I just sent a mail with a proper-ish commit message, but I like yours
better as it explains the symptom a bit.
