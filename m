From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 12/10] support pager.* for external commands
Date: Sun, 12 Feb 2012 01:46:34 +0100
Message-ID: <CACBZZX596wnk2KE9QzUPMc=A6Mt8HbUs7F4rnAZbw1_RrcKHnw@mail.gmail.com>
References: <20110818215820.GA7767@sigill.intra.peff.net> <20110818220132.GB7799@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	=?UTF-8?B?SW5nbyBCcsO8Y2ts?= <ib@wupperonline.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 12 01:47:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwNbE-0005wS-5r
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 01:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762Ab2BLAq4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 19:46:56 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:59534 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753608Ab2BLAqz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 19:46:55 -0500
Received: by lbom4 with SMTP id m4so1859691lbo.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 16:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=M1e83Z/gBeUem/whSgBSxw4THZrYXH7/gZ/p4tZGw44=;
        b=nDQkPDV8YB6wct38h2/Rwtah0FGBhLb3LZusAO8vZvcleQ97JSR4pfvsVyMsJPh6i0
         3CLzqCNKP1IwmMrB5ytSoUdeXaLUcqRdr9gTOidfejjI5nQRsY2SPckZ5iRF1LeQf2KG
         hPnzdG4fsKk66D3xDVkxCC3KIRwsTMHwsxRHo=
Received: by 10.112.27.165 with SMTP id u5mr3838567lbg.48.1329007614166; Sat,
 11 Feb 2012 16:46:54 -0800 (PST)
Received: by 10.112.1.230 with HTTP; Sat, 11 Feb 2012 16:46:34 -0800 (PST)
In-Reply-To: <20110818220132.GB7799@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190554>

On Fri, Aug 19, 2011 at 00:01, Jeff King <peff@peff.net> wrote:

> +test_expect_success TTY 'command-specific pager works for external c=
ommands' '
> + =C2=A0 =C2=A0 =C2=A0 sane_unset PAGER GIT_PAGER &&
> + =C2=A0 =C2=A0 =C2=A0 echo "foo:initial" >expect &&
> + =C2=A0 =C2=A0 =C2=A0 >actual &&
> + =C2=A0 =C2=A0 =C2=A0 test_config pager.external "sed s/^/foo:/ >act=
ual" &&
> + =C2=A0 =C2=A0 =C2=A0 test_terminal git --exec-path=3D"`pwd`" extern=
al log --format=3D%s -1 &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect actual

=46or reasons that I haven't looked into using sed like that breaks
under /usr/bin/ksh on Solaris. Just using:

    sed -e \"s/^/foo:/\"

Instead fixes it, it's not broken with /usr/xpg4/bin/sh, so it's some
ksh peculiarity.

The error it gives is:

    sed s/^/foo:/ >actual: Not found

Indicating that for some reason it's considering that whole "sed
s/^/foo:/ >actual" string to be a single command.
