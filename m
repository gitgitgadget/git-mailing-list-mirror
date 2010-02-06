From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [gitolite] repo config for delegated projects
Date: Sat, 6 Feb 2010 06:20:50 +0530
Message-ID: <2e24e5b91002051650k3c7cf14ev8752d36b5616e9a4@mail.gmail.com>
References: <20100203035718.GA30644@lapse.rw.madduck.net>
	 <2e24e5b91002022222h5ca3ebe6k75854a9a056f0ed1@mail.gmail.com>
	 <20100203202249.GA27125@lapse.rw.madduck.net>
	 <20100204011842.GB497@atcmail.atc.tcs.com>
	 <20100204040812.GC13411@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sitaram Chamarty <sitaram@atc.tcs.com>,
	git discussion list <git@vger.kernel.org>,
	Teemu Matilainen <teemu.matilainen@iki.fi>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Sat Feb 06 01:56:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdYy9-0000qR-Ag
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 01:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933285Ab0BFA4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2010 19:56:12 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:53216 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933128Ab0BFA4K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2010 19:56:10 -0500
Received: by pxi12 with SMTP id 12so4889070pxi.33
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 16:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WofhmQ1diwuSfgDYHCnffrInD+U+bHAxaE/zTwhw7kU=;
        b=xHl3FcZKIBYmAicNrxLc3d+xNY2zTEcfcx9LtK2o+wTZs6exbykoAaHCrU4C8pItHa
         98hb88YcNZPQl8qf/HvPJQiQng0nngC7Cglez9a5DmTNkM+lXmQ0HcU1w2zyf6CYXGLE
         QhcsKfChE6OlvJKobVQjRFjP+BQuLiYnGIgpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SX6irM9N+utrzB/Yx3/cu5SRE1hguIu3Rt3fLyP0zuyGMrmtsZYLkbhVscdsa1eLQz
         mTUtCZpPacL4Ch5rexq8IplKkl00KCeFMfSdtMFHEo92KZ3DdmrWvQdxPdWJJ9qDTr55
         uBfOADABnnbvZUGuYltVkTnMTLnFbuEelpl30=
Received: by 10.114.188.8 with SMTP id l8mr2276119waf.12.1265417451018; Fri, 
	05 Feb 2010 16:50:51 -0800 (PST)
In-Reply-To: <20100204040812.GC13411@lapse.rw.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139132>

On Thu, Feb 4, 2010 at 9:38 AM, martin f krafft <madduck@madduck.net> w=
rote:
> also sprach Sitaram Chamarty <sitaram@atc.tcs.com> [2010.02.04.1418 +=
1300]:
>> how about
>>
>> =C2=A0 =C2=A0 $DELEGATED_CONFIGS =3D "hooks.mailinglist,hooks.showre=
v";
>
> Excellent idea.

OK I've run into a little decision-point here.

The problem above is of making sure that a delegated admin cannot
misuse the gitconfig mechanism to do stuff he's not allowed to do, but
it's actually worse than that :(

=46irst some background.  For a long time I treated the "main" admin
(anyone who has RW/RW+ rights to gitolite.conf) to be eqvt to having
shell access.  Then we started moving away from that, and that is good
because having shell access allows him to bypass the logging that
gitolite does, thus polluting the audit trail.  Preventing that makes
a lot of sense in a corporate environment, and lets you allow a lot
more people to manage the gitolite access list.

Now I just looked up hooks.showrev, and it's supposed to be any shell
command.  Clearly this means anyone who can set that gitconfig option
now has shell capability, and it's game over.

Regardless of how I look at it, I can't think of a cure for this short
of either:
  - putting all the allowed gitconfigs in the RC file, and not in the
config (writing the RC file requires shell access, and we presume the
"root of trust" person has enough smarts to know what to allow and
what not to allow), and allowing repo admins to *refer* to them to use
whichever they want
  - someone coming up with a list of gitconfig's that are "safe", and
specific values for those that are unsafe (like saying "if you use
showrev, you can only use this command  as the value", and forcing
only those.

I'm leaning toward the former; easier for me ;-)  Meanwhile, I'm
punting this to Teemu until the morning fog in my brain clears :)
