From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/9] i18n: add PO files to po/
Date: Mon, 3 Oct 2011 17:06:59 -0500
Message-ID: <20111003220659.GA19537@elie>
References: <1317668297-2702-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Marcin =?utf-8?Q?Cie=C5=9Blak?= <saper@saper.info>,
	Sam Reed <sam@reedyboy.net>,
	Jan Engelhardt <jengelh@medozas.de>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 00:07:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAqfT-0004oP-6a
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 00:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647Ab1JCWHS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 18:07:18 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34698 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757680Ab1JCWHP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2011 18:07:15 -0400
Received: by gyg10 with SMTP id 10so3871188gyg.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 15:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CFZL1E2uPVHWC6MjKhM7amcbgcBXE0nBAj80kTOyvWE=;
        b=eGr3AWmf00tCRO9E0aZER0iOud2/s0dokNf/BVYnrzubx2QlQ1UfwhHhQBUT1bLv/o
         7A8SsiRTtTooe341iWVsqBSRU7qbZfZpWiildL5xj5IZkl8fksu5SQZ+vaSdt2ZF3nSA
         tc71V+WlPLsaEJSyKM/2hp9xvE6dB+ehk8NXU=
Received: by 10.236.177.2 with SMTP id c2mr2670007yhm.102.1317679635201;
        Mon, 03 Oct 2011 15:07:15 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id u21sm5066084yhe.1.2011.10.03.15.07.13
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 15:07:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1317668297-2702-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182716>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> It's been a long time coming, but here's an initial submission of PO
> files to the po/ directory. This adds some initial and as of yet
> unused translations.

Neat.  I think it's good to figure out what we will do with these
anyway, and we don't have to wait for the infrastructure to do that.

So, basic questions:

 1. which branch will be translated?
 2. who keeps track of incoming translations?
 3. how can we avoid this making "git log -p" output unusable?

Some strawman answers:

1. I have two ideas (each pretty different from the other).

    If the gettext tools provide a way to take a union of po template
    files, it would be possible to keep the union of all maintained
    branches translated.  In other words, when a message changes,
    until that change propagates to "master" or "maint", translators
    would be able to translate _both_ the Before and After versions.

    Otherwise, I'd say, it's simplest to only take ordinary
    translation updates through the "master" branch (and to update
    translations of "maint" when important fixes come).

2. If there is a git-i18n.git tree, Junio could pull its "master"
branch from time to time.  An i18n coordinator could even take
advantage of zealous translators that want to translate topics in "pu"
if wanted, without having to bother Junio until it is time to pull the
cooked translations from 'master'.

3. Maybe some hero will implement

	git log -p --exclude=3Dpo/
	# or
	git log -p -- :(not)po/

to complement "git log -p -- po/". ;-)

If you wonder why I'm asking these questions, it's because I have
noticed that normal branching practice (fixes rippling up from more
stable branches to less stable ones) can fall apart in projects with
translations, since there is no tool that I am aware of that works
like rcs merge to combine changes.  Hence question (2), which puts the
burden to get things right on some other person who can experiment to
find a workflow that works well. :)

Two interesting patches (#2 and #9) didn't hit the mailing list
archive, probably because of length limits.
