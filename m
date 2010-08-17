From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v2 0/3] Update compat/regex
Date: Tue, 17 Aug 2010 05:17:10 +0000
Message-ID: <1282022233-32692-1-git-send-email-avarab@gmail.com>
References: <AANLkTik4FL56EM4HdpfZ7ha8GNkbLsJeb415WFWUh+O_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 07:17:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlEYL-0002gF-Sc
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 07:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772Ab0HQFRY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 01:17:24 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42664 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab0HQFRX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 01:17:23 -0400
Received: by wyb32 with SMTP id 32so6575271wyb.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 22:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=TnVkbiSreFwSDNyDHycgfs+fVS/Pj206DUnNpc1/lwY=;
        b=dqcQO9PMdl+tTG4mQjb/eAYI22rSotXrgm6UgGtZRukxc/2NsYWlGvr9Gz4dFPVv2N
         /lkqFXC71p/Vqqr4rDznzeZe5Fb7binFB6ZniPcrNTYjpzkC1YS0r8pMKDUudH4PEe95
         oR9cWIzAWsAWMeEXbuqvGcijMccpFzsmcMJxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HZOTBjSKogrreb1lkHXX01EC130shoOxMrVk6iBP0ooGIlgVhUKa0MJbaZIdaK8l16
         WW24E8Y/+ZHGu+3dC20eD+lZnwapIlzgZGW16PhXJSaj3CUjTSUxE8lT4FohsyVOcg7B
         1iXexuar7/hGeYyoFNu6wsAsTWKmD5nsqXoDg=
Received: by 10.227.134.129 with SMTP id j1mr1325996wbt.79.1282022242330;
        Mon, 16 Aug 2010 22:17:22 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w32sm5362564wbd.1.2010.08.16.22.17.21
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 22:17:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.389.gc3d0b
In-Reply-To: <AANLkTik4FL56EM4HdpfZ7ha8GNkbLsJeb415WFWUh+O_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153697>

This has the following changes:

 * Supply the custom regex.o flags only to regex.o as suggested by
   Jonathan Nieder:
       =20
        +ifdef NO_REGEX
        +compat/regex/regex.o: EXTRA_CPPFLAGS =3D -DGAWK -DNO_MBSUPPORT
        +endif

 * The code is LGPL-2.1, not GPL-3

 * Don't include mbsupport.h, we don't need it, and it can be
   un-included with a flag.

 * Simplify our modifications to regex.h, just include two headers at
   the very top, don't modify any gawk code.

 * Update commit messages
       =20
=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
  compat/regex: use the regex engine from gawk for compat
  compat/regex: get the gawk regex engine to compile within git
  t/t7008-grep-binary.sh: un-TODO a test that needs REG_STARTEND

 Makefile                      |    4 +
 compat/regex/regcomp.c        | 3892 ++++++++++++++++++++++++++++++++
 compat/regex/regex.c          | 5003 +--------------------------------=
--------
 compat/regex/regex.h          |  462 +++--
 compat/regex/regex_internal.c | 1744 ++++++++++++++
 compat/regex/regex_internal.h |  810 +++++++
 compat/regex/regexec.c        | 4377 +++++++++++++++++++++++++++++++++=
++
 t/t7008-grep-binary.sh        |    2 +-
 8 files changed, 11188 insertions(+), 5106 deletions(-)
 create mode 100644 compat/regex/regcomp.c
 create mode 100644 compat/regex/regex_internal.c
 create mode 100644 compat/regex/regex_internal.h
 create mode 100644 compat/regex/regexec.c

--=20
1.7.2.1.389.gc3d0b
