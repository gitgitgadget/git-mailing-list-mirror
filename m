From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] clone: forbid --bare --separate-git-dir <dir>
Date: Sun, 6 Jan 2013 02:19:48 -0800
Message-ID: <20130106101948.GD10956@elie.Belkin>
References: <20130106091642.GA10956@elie.Belkin>
 <1357465670-32766-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 11:20:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrnL5-0000X5-3W
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 11:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234Ab3AFKT7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 05:19:59 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:40383 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754778Ab3AFKT5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jan 2013 05:19:57 -0500
Received: by mail-pb0-f51.google.com with SMTP id ro12so9995830pbb.24
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 02:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=rbSFqgeBoygTFBWFSGNkp5+dRIUw9m7FZ2DKv+8k9tk=;
        b=DhH2apswQvoaX5Z8peH6ZiWWp9PVvrO6BhJTas4RfIeX/2glPq5Bw7q5ScmVuBtVrd
         kFD2kt8AAr2ufVN3jF29JdtpNG0+Rp7jROxIdsPNZx8mL9+u3c66uq2/KV3c1IKDbNf9
         W+2puM4AAxpFtvHKgkfzxF4wUueyNPCfjhsFgSNAyLieNWwEiZT78nuB/CES+67Q6GNI
         jtSbIJl14ID0f3RewI6k9RG9vSmNWgRx/TtPcCxWEs+GOLsNqKA55Aeu9+YSB9KWetpq
         hupxnlnh4y+QzQbiLIUbcyUGMP0eLA7y5jnR8O4K7ObHR79xfHRocK5LKqkHy7NUuT0c
         7p5w==
X-Received: by 10.66.80.202 with SMTP id t10mr168482818pax.81.1357467597329;
        Sun, 06 Jan 2013 02:19:57 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id o1sm36636670paw.0.2013.01.06.02.19.52
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Jan 2013 02:19:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1357465670-32766-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212792>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --separate-git-dir was added to clone with the repository away from
> standard position <worktree>/.git. It does not make sense to use it
> without creating working directory.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

The patch correctly implements the above.  The description leaves out
detail.  I'd say something like

	The --separate-git-dir option was introduced to make it simple
	to put the git directory somewhere outside the worktree, for
	example when cloning a repository for use as a submodule.

	It was not intended for use when creating a bare repository.
	In that case there is no worktree and it is more natural to
	directly clone the repository and create a .git file as
	separate steps:

		git clone --bare /path/to/repo.git bar.git
		printf 'gitdir: bar.git\n' >foo.git

	Unfortunately we forgot to forbid the --bare
	--separate-git-dir combination.  In practice, we know no one
	could be using --bare with --separate-git-dir because it is
	broken in the following way: <explanation here>.  So it is
	safe to make good on our mistake and forbid the combination,
	making the command easier to explain.

I don't know what would go in the <explanation here> blank above,
though.  Is it possible that some people are relying on this option
combination?
