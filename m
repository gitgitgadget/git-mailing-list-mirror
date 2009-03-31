From: Pierre Poissinger <pierre.poissinger@gmail.com>
Subject: Re: [PATCH] AIX 5.2 - bug with 1.6.2.1
Date: Tue, 31 Mar 2009 14:20:17 +0200
Message-ID: <3930158b0903310520h1f421518ka67de5f7aad0690b@mail.gmail.com>
References: <3930158b0903301647o790f7381l37ba61089713ce80@mail.gmail.com> 
	<20090331103703.GA1589@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 14:22:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Locyl-0008UA-8C
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 14:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbZCaMUg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 08:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752951AbZCaMUg
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 08:20:36 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:48345 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbZCaMUf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 08:20:35 -0400
Received: by ewy9 with SMTP id 9so2517411ewy.37
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 05:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iD0LiDulfit4vCidhyPqVqofYeDtSH2ayi10HriXng0=;
        b=RxZNxAJ1XJX3rxjW2yFJx5EtWsaydJ3cJmW9l5hHSbK4SrjPHZc8bXKWw7SV6oDbpN
         BsgivVXwV86a8EU7cLNXYOl8NUIqoGDZcdlbd1IeH0AvF7wo1yZIDg4nr5Huc4y9iWV9
         PQYRPjnLv+7/417bQDetf1OcJ4zqnnpFg+Di4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=voeVvICWA4KgoQeOFyVieg4MEpSr/P33bOXiIwLfBgRijEO/nWf6Mm8HISrEPAeQmn
         D4dNNj0u9r5wsNwUscKN+jLz74sNYrTTKVbMz7Z/wmp7bzZPjxlUp4P/ekl+QH01vumd
         uYh0WJlOy3II0vWAlZTjjdLvjVw6YU/kQ+OTE=
In-Reply-To: <20090331103703.GA1589@coredump.intra.peff.net>
Received: by 10.216.11.212 with SMTP id 62mr2034503wex.186.1238502032344; Tue, 
	31 Mar 2009 05:20:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115255>

On Tue, Mar 31, 2009 at 12:37 PM, Jeff King <peff@peff.net> wrote:
> [I'm cc'ing the git-list; please send bug reports there]
[snip]
>> breaks git on AIX 5.2 with gcc 2.9 :-(
>
> Wow, I didn't know people were still using the 2.9 branch of gcc.

Yep, that or "C for AIX Compiler, Version 6" but this one is awol for g=
it
[Hey, it feels cutting edge - I use Emacs 19 and digital C daily on
OpenVMS 7.1...]

> Hmm. Can you confirm the status being passed back by run_command?
>[snip]
0 - that's why I found out the funny enum stuff...

> That seems very wrong. I wonder if it is a problem with the signednes=
s
> of enums in that version of gcc. Can you run the following program an=
d
> report on its output?
Not only to you... just that's what I noticed...

> -- >8 --
-FOO: -10000
0 <=3D -FOO: 1
-10000 <=3D -FOO: 1

This seems to be a "Old GCC'ism" - XLC (version 6...cannot even
understand git code) does it right:
-FOO: -10000
0 <=3D -FOO: 0
-10000 <=3D -FOO: 1

> =C2=A0#define IS_RUN_COMMAND_ERR(x) ((-x) > ERR_RUN_COMMAND_FORK)
oops... works for me with
#define IS_RUN_COMMAND_ERR(x) (-(x) > ERR_RUN_COMMAND_FORK)

> The other option is to rework run_command to just return positive val=
ues
> (which should be fine as long as they remain out of the range of norm=
al
> exit codes).
Change define good enough for me and my oldies...

Regs,
Pierre,
--=20
>>> horsemen =3D ['war', 'pestilence', 'famine']
>>> horsemen.append('Powerbuilder')
