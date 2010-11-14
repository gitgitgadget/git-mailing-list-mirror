From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] Makefile: move "Platform specific tweaks" above
 LIB_{H,OBJS}
Date: Sun, 14 Nov 2010 11:23:31 -0600
Message-ID: <20101114172331.GA26459@burratino>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
 <1289745857-16704-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 18:24:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHgJL-0003Gl-Kx
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 18:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756465Ab0KNRYJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 12:24:09 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58477 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756423Ab0KNRYH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 12:24:07 -0500
Received: by gwj17 with SMTP id 17so670826gwj.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 09:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZFh5DD+1KT8Rg+yZSfOwaVVbP+RBY0GoSwRljEf+ia4=;
        b=OlHn2nra1ZBJj37ged36U7s0OnCGEHH/PE8FQtyWYxQnSCtWG4NV5IYu4xEQtELR1V
         DoRTL8YL84HggUPa416Wdxr9fVM8XpUgnCv2NadbcB3etMd2duhK/RJYljupvg2bUrP5
         h/YBlDrrrkT/8K9W7BYE05J3WLoFqsAvjVsK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=WT2/Ee5CUdxGXtNvq7/Nq/2LKWzty7UCGiHRCwLma/IVrLaYOZKXzjJQPxQiD1IpiR
         IGpd8bUCzp2Lv6lAD12av4RXuTeYZQl2yheiUS2T1zWTEnl3lFY+bgo7s4wruA+uhnWb
         46DvqnoEEYfi+xbOp0amEiePJapsv6oQS3X/o=
Received: by 10.151.39.21 with SMTP id r21mr7993166ybj.104.1289755447025;
        Sun, 14 Nov 2010 09:24:07 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id r25sm3923397yhc.0.2010.11.14.09.24.04
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 09:24:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289745857-16704-2-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161421>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Change the Makefile so that the "Platform specific tweaks" section
> comes before the assignments to LIB_H and LIB_OBJS.

Currently the Makefile is structured like this:

	A. default target
	B. basics
	   1. basic configuration section
	      a. -include GIT-VERSION-FILE and recipe to generate it
	      b. uname_S :=3D $(shell uname -s) and similar variables
	      c. user-facing compilation variables: CFLAGS, LDFLAGS, STRIP
	      d. user-facing paths: prefix, bindir_relative, etc
	      e. program names: CC, AR, etc
	   2. basic cflags and ldflags (almost configurable)
	   3. main list of program targets:
	      SCRIPTS, PROGRAMS, TEST_PROGRAMS, BUILT_INS,
	      OTHER_PROGRAMS, BINDIR_PROGRAMS
	   4. defaults for SHELL_PATH, PERL_PATH, PYTHON_PATH
	   5. main list of library targets:
	      LIB_FILE, XDIFF_LIB, LIB_H, LIB_OBJS, BUILTIN_OBJS
	   6. GITLIBS, EXTLIBS for the linker command line
	   7. platform-specific tweaks
	   8. -include config.mak, config.mak.autogen
	C. preparations
	   1. handling of the various NO_THIS_OR_THAT options.
	      This affects BASIC_CFLAGS, COMPAT_CFLAGS,
	      COMPAT_OBJS, PROGRAMS, EXTLIBS, LIB_OBJ, LIB_H, etc
	   2. machinery for non-noisy build
	   3. shell-quoted and C-quoted variables
	   4. ALL_CFLAGS, ALL_LDFLAGS
	D. main build rules
	   1. all:: targets for the main build, subdirs
	   2. shell sanity check
	   3. building the git binary and built-ins
	   4. scripts and gitweb
	   5. autoconf
	   6. building objects:
	      a. %.o: %.c rule, header deps, dependency checking
	      b. target-specific -D flags
	   7. building non-builtins, remote-curl
	   8. libs
	   9. subdirs
	E. GIT-CFLAGS, GIT-BUILD-OPTIONS, GIT-GUI-VARS
	F. bin-wrappers
	G. tests
	H. installation rules
	I. maintainer's dist rules, check-doc, coverage, etc

This patch proposes moving A5 (main list of library targets) after
A8 (end of configuration).

> In the ab/i18n series I only want to build gettext.o (by adding it to
> LIB_OBJS) if NO_GETTEXT is unset. It's not possible to do that withou=
t
> an ugly hack if we haven't applied our platform specific tweaks befor=
e
> LIB_{H,OBJS} gets assigned to.
>=20
> See <201008140002.40587.j6t@kdbg.org> (subject: "[PATCH] Do not build
> i18n on Windows.") for Johannes's original report, and my follow-up i=
n
> <AANLkTiku5R+idX-C8f0AcCikBLmfEb5ZEhdft+CSRzU0@mail.gmail.com> where =
I
> suggested that the problem be solved in the manner of this patch.

This doesn't motivate the patch all all to me.  Is changing the list
of LIB_OBJS in section C1 really an ugly hack?  It is where
configuration-specific things go and how BLK_SHA1, PROGRAM_OBJS, etc
work already.

That said, I can see another reason to move A3 and A5 lower down in
the makefile.  Namely, they don't seem to have anything obvious to
do with configuration.  Including the basic list of objects that
high up may make the makefile easier to read straight through, but
I don't think anyone is reading it straight through.

So I wouldn't have anything against moving both A3 and A5 to right
before C1, I just think it needs different motivation.

Sensible?
Jonathan
