From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Problems with Git's "perl" userdiff driver
Date: Sun, 15 May 2011 20:14:53 +0200
Message-ID: <BANLkTi=OXznTspN-CJjM0YXfqARxL=J+Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 20:15:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLfqG-0000Th-Ci
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 20:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338Ab1EOSO4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2011 14:14:56 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62925 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab1EOSOy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2011 14:14:54 -0400
Received: by fxm17 with SMTP id 17so2625164fxm.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 11:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=i/2O1PS5akGPZcyk8oF/ICGU4F8cz2v2Pk26xqHj0Ls=;
        b=YCFJdTLK3QFmTlt0wItNc2IXGqg6+hTzMJqvlGJRDYlo6EW+x3MAAokpcigqvXuOB8
         lw1surVfxtpoGr53UQ+Qq8SUPtvJzfXGE/D94cZxvNxwAqiytpbGF0dLGw+i8BkvfHYl
         +d7/kQQqypW8DKXoSjnwNjVPj1uTgBEOkfjxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=sIBi11niNCqdt2YZWV7aDHQdaCbPM63i7Blk0XoKWbNyvuuwmlhTSsVKTgC1aPmMQH
         mA0YWf9CNfsFjCxvSuNEu1TURi5Akp1KNXmKT0cDg/Jd9eTRiuRugZChXWDoDldeeylc
         t4lewRkY6GZMiJQbtXhAPWl2xPlmmCfq19DME=
Received: by 10.223.3.132 with SMTP id 4mr3076778fan.132.1305483293710; Sun,
 15 May 2011 11:14:53 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Sun, 15 May 2011 11:14:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173644>

On Wed, Dec 29, 2010 at 06:22, Junio C Hamano <gitster@pobox.com> wrote=
:

[better late than never]

> * jn/perl-funcname (2010-12-27) 2 commits
> =C2=A0- userdiff/perl: catch BEGIN/END/... and POD as headers
> =C2=A0- diff: funcname and word patterns for perl

The POD rule doesn't work properly. I suspect it has to be:

    "^=3Dhead[0-9] .*",

Instead of the current:

    "^=3Dhead[0-9] ",

Since e.g.:

    =3Dhead1 WHATEVER

Will just be shown as:

    =3Dhead1

In the diff context.

And actually it applies very badly to POD in general, since the "sub"
rule will be tried first, so e.g. in Perldoc we'll often end up
finding some "sub" example halfway up the file, instead of the =3Dhead1=
*
or =3Ditem* section a few lines up.

And it looks like the regex only catches:

    sub foo {
    }

Not:

    sub foo
    {
    }
