From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Why is git submodule slow under windows
Date: Fri, 18 Jul 2014 15:02:41 +0200
Message-ID: <20140718130241.GD14720@paksenarrion.iveqy.com>
References: <18956e25b6c14091a64af5a65ce5d13c@FE-MBX1009.de.bosch.com>
 <53C90E44.6030702@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Armbruster Joachim (BEG/EMS1)" <Joachim.Armbruster@de.bosch.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Fri Jul 18 14:58:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X87kX-0002Jx-1Z
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 14:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760970AbaGRM6w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2014 08:58:52 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33883 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758294AbaGRM6w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 08:58:52 -0400
Received: by mail-lb0-f180.google.com with SMTP id v6so2480157lbi.25
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 05:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=stk0fhgsgS1rJ9hjHBuPf0VCXo0gedDZQHIpRFtWfmM=;
        b=rvMTwk/pw/SPg+0h31r0gtr1JVVK6VQU3Hci8xh6QeJ4XGXpHwnnd8niecp0BrbymK
         a2QFMFg7V1E7h+A9SWpI1tZO7rbM7oiMkzBehSY797bmm/eF6O7XaUnFg5mUyVG0tQt1
         gASTAGzEJhfu1IBbX8ME9Tqi4GPqFWlnTvEsZI1pB/i15JCgQDJmbj3CP7gZ04TaJOvy
         6L43i5YUlRuxJfgj+Zwm4c/ghSEX6P+OI1RBjv4YoHh/eOe6g0teaKsWXxBZGeLkZz0T
         EvqYT1TWWjeZLDePyn7ttb+jHfOFNCTeeP+xIMiSJzM0mCiV8nQEe3i7kHrR6+8ZC8uq
         gHsA==
X-Received: by 10.152.8.109 with SMTP id q13mr4915710laa.31.1405688329670;
        Fri, 18 Jul 2014 05:58:49 -0700 (PDT)
Received: from paksenarrion.paks.iveqy.com (c83-250-234-75.bredband.comhem.se. [83.250.234.75])
        by mx.google.com with ESMTPSA id xm1sm9225785lbb.15.2014.07.18.05.58.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 18 Jul 2014 05:58:49 -0700 (PDT)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.82)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1X87o9-00079K-CF; Fri, 18 Jul 2014 15:02:41 +0200
Content-Disposition: inline
In-Reply-To: <53C90E44.6030702@virtuell-zuhause.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253816>

On Fri, Jul 18, 2014 at 02:08:36PM +0200, Thomas Braun wrote:
> Am 18.07.2014 12:14, schrieb Armbruster Joachim (BEG/EMS1):
> > Hello,
> >=20
> > We split a monolithic repository into ~50 submodules. The stored da=
ta
> > has the same size. In the 1:1 comparison to the monolithic
> > repository, the submodule handling is very slow. Under Linux
> > everything remains fast, but windows is slow.
> >=20
> > So, why is git getting slow when it has to deal with a lot of
> > submodules? I read something about the lack of the underlying cygwi=
n
> > to handle NTFS in a efficient way. Is this the root cause, or are
> > there other causes also?
> >=20
>=20
> Hi,
>=20
> I assume you are using the latetst git from https://msysgit.github.io=
 on
> windows.
>=20
> I would guess that submodules on windows are slow because
> git-submodules.sh is a shell script, and bash on windows is not reall=
y
> that fast.

My guess is that because the shell script uses fork() heavily and fork(=
)
is an expensive operation on Windows, that alone causes the slowddown.

I did a quick test a while back when I rewrote part of git-submodule.sh
in lua and runned it on my repo with ~45 submodules. The speedup was
significant and should be even bigger on windows.

--=20
Med v=E4nlig h=E4lsning
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
