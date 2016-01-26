From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [BUG] typo DWIMery with alias broken (cd to random dir)
Date: Tue, 26 Jan 2016 08:37:25 +0100
Message-ID: <56A72235.9080602@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 26 08:37:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNyBx-00012B-0A
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 08:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595AbcAZHha convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2016 02:37:30 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48340 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755703AbcAZHh2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2016 02:37:28 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 39BB4203FC
	for <git@vger.kernel.org>; Tue, 26 Jan 2016 02:37:27 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Tue, 26 Jan 2016 02:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=TqP
	ZMVMUvArGV+5g2n0V3n5SnlQ=; b=XZ22t8beJxjiN+oyvg10Ogh3Fy1D4Qo3yMN
	fhaYWsYKYiND9PGRGI4dX8pEJQYxfgTumCnvwHRJB8WUDGcmNZ9y5S6SEf4wFQ8A
	Dw2VX23DgB5qZcxwNc2w2qw5VJ6+eWU2yPS5M9Jj2LW+ximhlVugrvhQ5Rwmi5Qb
	rKGVXF6A=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=TqPZMVMUvArGV+5g2n0V3n5SnlQ=; b=uT83N
	SnFxGYKj9hifniPYYOowYjqbzHdCIa11FJIVthBPUZuchw4ApMNoGzWnJIXx6UNS
	NoCi0uZAKiVsFFZWmPMotW9Vq/ujFKl4jVfvA8rmSGmwNWTNo5G6YU3kzFqp4HWa
	hqtbSR0SidTJGoDKdtboCOAHq1jKRp6Iw9regc=
X-Sasl-enc: y70ICjTgZb/7lr+WcSxzE8K/fOrjYVSytjugIlVQnDUt 1453793846
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id B3571C01715;
	Tue, 26 Jan 2016 02:37:26 -0500 (EST)
X-Mozilla-News-Host: news://news.gmane.org:119
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284784>

Hi there,

with current next (989ee58 plus local additions) it seems that typo
DWIMery with aliases is broken, see below.

It appears that the typo DWIMery is broken only when there is a unique
automatic DWIM substitution for a mistyped alias.

I haven't bisected yet, but I suspect this to be related to recent
changes regarding the environment in which commands/aliases are started
(though this happens without extra work trees), so I'm cc'ing an expert
in that area. Funny, though, that my user name shows up...

I think the reason is that git.c's handle_alias() (or something else)
calls restore_env() multiple times, and restore_env frees orig_cwd such
that subsequent restore_env(0) with external_alias=3D0 tries to cd to a
random location.

I have no idea whether orig_cwd=3D0 after freeing or something else wou=
ld
be the proper fix.

Michael

LANG=3DC git sss
WARNING: You called a Git command named 'sss', which does not exist.
Continuing under the assumption that you meant 'ss'
in 2.0 seconds automatically...
fatal: could not move to git@drmicha.warpmail.net: No such file or dire=
ctory
[mjg@skimbleshanks git]=E2=9C=97 LANG=3DC git ss
## HEAD (no branch)
?? a
?? a.patch
?? c2d.sh
[mjg@skimbleshanks git]=E2=9C=93 LANG=3DC git statu -sb
git: 'statu' is not a git command. See 'git --help'.

Did you mean one of these?
        status
        stage
        stash
[mjg@skimbleshanks git]=E2=9C=97 LANG=3DC git statuss -sb
WARNING: You called a Git command named 'statuss', which does not exist=
=2E
Continuing under the assumption that you meant 'status'
in 2.0 seconds automatically...
## HEAD (no branch)
?? a
?? a.patch
?? c2d.sh
