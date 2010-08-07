From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] imap-send: Code correctness flagged by clang
Date: Sat, 7 Aug 2010 22:53:51 +0000
Message-ID: <AANLkTim4CHdVLinkw1EjXB74OJ+YW-ri4GzHMNhRd+Cy@mail.gmail.com>
References: <1281183136-10352-1-git-send-email-avarab@gmail.com>
	<20100807210429.GA2216@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Mike McCormack <mike@codeweavers.com>,
	Benjamin Kramer <benny.kra@googlemail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 08 00:53:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhsH7-0000Hc-P5
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 00:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903Ab0HGWxw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Aug 2010 18:53:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52831 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104Ab0HGWxv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Aug 2010 18:53:51 -0400
Received: by mail-iw0-f174.google.com with SMTP id 33so2525367iwn.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 15:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3xU0VTn+YQTW5uCaRxhj752t5mmkLOk2mCzp+tCfmR0=;
        b=dm4VkpajHhEpNh/ffQz9VDOVhtgI8jpodTMrcpdQhe9f6KWIVEX02czJ65lXD9LFJZ
         o4oLjxSIc54lhZYQXomWVzF5mEuHG7bkaovoEyZTpI1Y2kqMJIyxyrPtrL8nEWXh+xdF
         CC2ovVc0uDs4CGCTgl+vpYwgTsRPNduR05E18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=e/ziLX6FsqZTXYBzIn7D/adERSggIUtUFLa1kN+dFNb2WkApKdcqIUq0/bayh40rAP
         b60wla9Su7OEUtOFezbIsBiUa2N64uvPkc6d6xqP9MKxzcomq0GhHTut3JJwu7Du4xPG
         Mk/mbxi6oQC6OqnLaaHHFSn4OtCMz9dtHgqFU=
Received: by 10.231.183.81 with SMTP id cf17mr16218986ibb.32.1281221631425; 
	Sat, 07 Aug 2010 15:53:51 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sat, 7 Aug 2010 15:53:51 -0700 (PDT)
In-Reply-To: <20100807210429.GA2216@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152869>

On Sat, Aug 7, 2010 at 21:04, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> [Subject: imap-send: Code correctness flagged by clang]
>>
>> Clang 1.1 flagged the following issues in imap-send.c, this change
>> fixes the warnings by moving some code around:
>>
>> =C2=A0 =C2=A0 imap-send.c:548:27: warning: data argument not used by=
 format string [-Wformat-extra-args]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd->tag, cmd->cmd, cmd->cb.d=
len);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^
>>
>> Here the sprintf format didn't use the cmd->cb.dlen argument if
>> cmd->cb.data was false. Change the code to use a if/else instead of =
a
>> two-level ternary to work it. This code was introduced with imap-sen=
d
>> itself in f2561fda.
>>
>> =C2=A0 =C2=A0 imap-send.c:1089:41: warning: conversion specifies typ=
e 'unsigned short' but the argument has type 'int' [-Wformat]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 snprintf(portstr, sizeof(portstr), "%hu", srvc->port);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~^ =C2=A0 ~~~~=
~~~~~~
>>
>> Here sprintf is being given an int with a %hu format. Cast the
>> srvc->port to unsigned short to work it. This code was introduced in
>> 94ad2437 to add IPv6 support.
>
> Nitpick: that this was found by clang is probably not the first thing
> a person trying to figure out what the patch does needs to know.
> Maybe:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Subject: imap-send: Fix sprintf usage
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0When composing a command for the imap serv=
er, imap-send
> =C2=A0 =C2=A0 =C2=A0 =C2=A0uses a single nfsnprintf() invocation for =
brevity
> =C2=A0 =C2=A0 =C2=A0 =C2=A0instead of dealing separately with the cas=
e when there
> =C2=A0 =C2=A0 =C2=A0 =C2=A0is a message to be sent and the case when =
there isn=E2=80=99t.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0The unused argument in the second case, wh=
ile valid,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0is confusing for static analyzers and huma=
n readers.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0v1.6.4-rc0~117 (imap-send: add support for=
 IPv6, 2009-05-25)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mistakenly used %hu as the format for an i=
nt =E2=80=9Cport=E2=80=9D, by
> =C2=A0 =C2=A0 =C2=A0 =C2=A0analogy with existing usage for the unsign=
ed short
> =C2=A0 =C2=A0 =C2=A0 =C2=A0=E2=80=9Caddr.sin_port=E2=80=9D. =C2=A0Use=
 %d instead.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Noticed with clang.

That looks better.

>> +++ b/imap-send.c
>> @@ -543,9 +543,14 @@ static struct imap_cmd *v_issue_imap_cmd(struct=
 imap_store *ctx,
>> =C2=A0 =C2=A0 =C2=A0 while (imap->literal_pending)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_cmd_result(ctx,=
 NULL);
>>
>> - =C2=A0 =C2=A0 bufl =3D nfsnprintf(buf, sizeof(buf), cmd->cb.data ?=
 CAP(LITERALPLUS) ?
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0"%d %s{%d+}\r\n" : "%d %s{%d}\r\n" : "%d %s\r\n",
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0cmd->tag, cmd->cmd, cmd->cb.dlen);
>> + =C2=A0 =C2=A0 if (cmd->cb.data) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bufl =3D nfsnprintf(buf,=
 sizeof(buf),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CAP(LITERALPLUS) ? "%d %s{%d+}\r=
\n" : "%d %s{%d}\r\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd->tag, cmd->cmd, cmd->cb.dlen=
);
>> + =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bufl =3D nfsnprintf(buf,=
 sizeof(buf), "%d %s\r\n", cmd->tag, cmd->cmd);
>> + =C2=A0 =C2=A0 }
>> +
>
> Hmm, maybe this would be easier to read:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cmd->cb.data)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bufl =3D nfsnp=
rintf(buf, sizeof(buf), "%d %s\r\n", cmd->tag, cmd->cmd);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bufl =3D nfsnp=
rintf(buf, sizeof(buf), "%d %s{%d%s}\r\n",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd->tag, cmd->cmd, cm=
d->cb.dlen,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CAP(LITERALPLUS) ? "+"=
 : "");
>
> i.e., putting the easier case first and avoiding a variable format st=
ring.

Yeah, that version looks better.

>> @@ -1086,7 +1091,7 @@ static struct store *imap_open_store(struct im=
ap_server_conf *srvc)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int gai;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char portstr[6];
>>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(portstr, sizeof=
(portstr), "%hu", srvc->port);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(portstr, sizeof=
(portstr), "%hu", (unsigned short)srvc->port);
>
> Why not
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(ports=
tr, sizeof(portstr), "%d", srvc->port);
>
> ?

I wasn't sure whether it needed to be %hu for the purposes of the
snprintf() call. I.e. that the resulting contents of portstr might be
different on some systems.

Maybe they won't be, then we could just use %d.

Another alternative would be to change the definition of port from int
to unsigned short in the srvc struct.

> Thanks for checking the code.

Thanks for reviewing the patch.
