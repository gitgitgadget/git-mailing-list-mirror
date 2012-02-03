From: Kyle Moffett <kyle@moffetthome.net>
Subject: Re: General support for ! in git-config values
Date: Thu, 2 Feb 2012 23:35:14 -0800
Message-ID: <CAGZ=bq+i6t7ik6WoX8B=_uKR6WVvnBk3KuJDngFpWObGWgivzw@mail.gmail.com>
References: <20120201184020.GA29374@sigill.intra.peff.net> <CACBZZX5mX55Rh8b2GYv7wKbCCypCkrn5AiM9BpXydgcYxHWdQA@mail.gmail.com>
 <7v62fq2o03.fsf@alter.siamese.dyndns.org> <CANgJU+X+UZmycwE6xkJ-zHfT7ai6nV9zbeR4WYnAXczL5JtqjA@mail.gmail.com>
 <7vliom13lm.fsf@alter.siamese.dyndns.org> <CANgJU+XQWdFmfmBJ4KX4GBz1a=TrVbp9BphGmhEb5Gphmzogjw@mail.gmail.com>
 <7v7h06109t.fsf@alter.siamese.dyndns.org> <CANgJU+WCdsF+igCWoueYcChYBvNyj5je_kvWorCBOgh5D7Bb9g@mail.gmail.com>
 <20120202023857.GA11745@sigill.intra.peff.net> <CANgJU+X2dRP__PFAywGEisDS3xyF7fSszSQG6BO61j2TMKL3Qg@mail.gmail.com>
 <20120202095432.GA19356@sigill.intra.peff.net> <CANgJU+XoZd6x6jdSHszigZaPgi+6H3Nbf4OG7p0y1_=7m+qntA@mail.gmail.com>
 <CAGZ=bq++R+X+2r2_zQ4UZ6JvDC9W9_4nF23MQ6+612_Qe2RS4Q@mail.gmail.com> <7vmx90say8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: demerphq <demerphq@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 08:35:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtDgK-00053N-8C
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 08:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222Ab2BCHff convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 02:35:35 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43675 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283Ab2BCHff convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 02:35:35 -0500
Received: by qcqw6 with SMTP id w6so1918296qcq.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 23:35:34 -0800 (PST)
Received: by 10.229.78.211 with SMTP id m19mr2255564qck.107.1328254534241;
 Thu, 02 Feb 2012 23:35:34 -0800 (PST)
Received: by 10.229.135.207 with HTTP; Thu, 2 Feb 2012 23:35:14 -0800 (PST)
In-Reply-To: <7vmx90say8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189741>

On Thu, Feb 2, 2012 at 22:11, Junio C Hamano <gitster@pobox.com> wrote:
> Kyle Moffett <kyle@moffetthome.net> writes:
>
>> Alternatively, you could extend the recent proposal for GIT config
>> "include" statements so that something like this works:
>>
>> [include]
>> =C2=A0 =C2=A0 exec =3D echo "deploy.prefix =3D `cat /etc/SERVER_ROLE=
`"
>> =C2=A0 =C2=A0 exec =3D /usr/local/bin/git-config-for-ldap-user
>
> Erh...
>
> Running known stuff from your own .git/config may be justifiable as "=
at
> your own risk", but if we consider sources that are not under your di=
rect
> control, such as /etc/gitconfig and whatever your project encourages =
you
> to include from your .git/config,... eek.

Well yes, but running commands from .git/config is exactly what the OP
requested, and if it applies to .git/config it should also be
applicable to other trusted include sources too, no?

Perhaps allow config files to perform a "trusted" include, EG:
[include]
    trusted_exec =3D /usr/local/bin/site-specific-config-program
    blob =3D v1.0:src/gitconfig

By default, the only files which would be trusted are /etc/gitconfig,
~/.gitconfig, and .git/config (but ONLY if it has the same owner and
mode go-w), and they would only pass trust on to other files if they
use "trusted_*" include lines.

Also, since "include" is intended to introduce a
non-backwards-compatible change in behavior, perhaps a totally
different format should be used, EG:

$include exec_trusted /usr/local/bin/site-specific-config-program
$include blob v1.0:src/gitconfig

Something that would cause noticeable warnings in older versions of
git instead of silently ignoring the desired config includes.

Just a few thoughts.

Cheers,
Kyle Moffett
