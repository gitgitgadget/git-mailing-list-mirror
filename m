From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 01/13] fast-import: add the 'done' command
Date: Sun, 29 Aug 2010 15:23:49 -0500
Message-ID: <AANLkTik7Lw7G=rAmrQ6cx4_s5_JCGmVwmV-vx7bN4kVG@mail.gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-2-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.1008291443030.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>,
	vcs-fast-import-devs@lists.launchpad.net
X-From: git-owner@vger.kernel.org Sun Aug 29 22:24:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpoQW-0007zY-Un
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 22:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987Ab0H2UYL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 16:24:11 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33601 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959Ab0H2UYK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 16:24:10 -0400
Received: by yxp4 with SMTP id 4so60628yxp.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 13:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=GUTcpaNnBsc24V0zW6g8G1xJia1X1MHVpDGCfmEBTo8=;
        b=uf+iq991NPCmlPQdTrU6z4NHHSQi1vDzQZUEAScZbaQf7mz0omg/42Cq80g9QAoHMx
         eCXeMEEHObp0mNQdFr02M+sbk/fXYv9uwEmJuH7uExd8YYiKk9d51lNMv5CqJVwhBjdk
         tgP/y6sOuoTjcPOMU/bpI1Mo9u+7cvJB2sdBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AsSpXmXk7C25pxqkC3BoJLdUzteOg3emj4XfiJa1icXwJnCW1i+vPxyvaErdpkRoVc
         0zzgO/imfrJY4hYgClcGwZ+Nf9NVbraoiFvrm1bAGw/CJlp2B8s46EqY4M8H9KVllRwM
         lKqB4TFm8uy5A3jTqhjkDtfvcIiXwTCNGK5TQ=
Received: by 10.150.49.12 with SMTP id w12mr4446663ybw.251.1283113449214; Sun,
 29 Aug 2010 13:24:09 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Sun, 29 Aug 2010 13:23:49 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1008291443030.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154710>

[+vcs-fast-import-devs, not culled for their benefit]

On Sun, Aug 29, 2010 at 13:59, Daniel Barkalow <barkalow@iabervon.org> =
wrote:
> On Sat, 28 Aug 2010, Sverre Rabbelier wrote:
>> Currently the only way to end an import stream is to close it, which
>> is not desirable when the stream that's being used is shared. For
>> example, the remote helper infrastructure uses a pipe between it and
>> the helper process, part of the protocol is to send a fast-import
>> stream accross. Without a way to end the stream the remote helper
>> infrastructure is forced to limit itself to have a command that uses
>> a fast-import stream as it's last command.
>>
>> Add a trivial 'done' command that causes fast-import to stop reading
>> from the stream and exit.
>
> Yeah, this is definitely worthwhile.
>
>> ---
>>
>> =C2=A0 Very straightforward. It is handled in parse_feature() instea=
d of
>> =C2=A0 in parse_one_feature() because I didn't want to allow '--done=
' as a
>> =C2=A0 commandline argument. Allowing it would be silly, it surves n=
o
>> =C2=A0 other purpose than to indicate up front that the stream will
>> =C2=A0 contain a 'done' command at the end.
>>
>> =C2=A0 I'm fine too with dropping the feature and just adding the ne=
w
>> =C2=A0 command, whichever is preferred.
>
> I think the point of the feature would be to get the error response u=
p
> front, where it might be easier to determine what to do about importe=
rs
> not supporting it. As such, I think the command line option actually =
makes
> at least as much sense, but it's probably not necessary anyway.
>
> I believe there's a gfi mailing list, which ought to hear about this =
bit.

I've added them.

> Not that there are likely to be conflicts, but, when I was thinking a=
bout
> adding this command (for the same reason you're adding it), I'd calle=
d it
> "quit", so it's worth letting people know a de facto standard, so gfi
> implementations don't vary.

Agreed, I've added it to the fastimport python library without much tro=
uble

> The code looks obviously good to me.

Thanks.

--=20
Cheers,

Sverre Rabbelier
