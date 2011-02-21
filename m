From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/3] No-op C gettext wrappers
Date: Sun, 20 Feb 2011 22:00:23 -0600
Message-ID: <20110221040012.GB26968@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 05:00:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrMws-0005vi-MS
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 05:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766Ab1BUEA3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 23:00:29 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39958 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755627Ab1BUEA3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Feb 2011 23:00:29 -0500
Received: by iyb26 with SMTP id 26so309650iyb.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 20:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IrKJ26Fyffwa2ZGuRMdZ6AkBjYNbizSrkj1hsjP20G4=;
        b=fGz4vbt2JgG5AEMIoLKM+gw9y2MjBhDmzGxFjDP8jOcgExRh+NbdL/ZNXxezqnhB9B
         UYCA9GigK50gUFDStVBuD+fjDCpuGFUOrGWyntrnYTYfhTbcppsa7po0Gza+XyszM5Kc
         xLH0XmPnsaUlRCZTpaumCtlrj7TH/SVG1zkZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=w9kB7gZz+5Sg9rSaaZxGJK5q/vcF+mgQx4AuQvYTK0abVqxa42ALvSAXbikxb9QkC/
         toSgVuGWjCT+vJ0qH8PG5SG9yXxRFxxJyqQAXIn08/zLJHKFMgLW4+sYkR/UqX/PvC4o
         x395QJYNG9PoNMtSw65xr8gjs+b7INNolj6Qk=
Received: by 10.42.167.71 with SMTP id r7mr1366428icy.220.1298260828567;
        Sun, 20 Feb 2011 20:00:28 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id d21sm4745426ibg.21.2011.02.20.20.00.27
        (version=SSLv3 cipher=OTHER);
        Sun, 20 Feb 2011 20:00:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167436>

Hi,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> As discussed on-list previously I'm remaking the gettext series in a
> form that'll be easier to swallow.

Here's a reroll of the skeleton gettext.h wrapper as requested.
I'll send some gettextization patches in a separate series, time
permitting.

Changes from v1:

 - renamed NO_GETTEXT_POISON prereq to C_LOCALE_OUTPUT.  This should
   make it possible to reuse that prereq is the test suite ever
   learns a --lang option.  Hopefully this will also make it easier
   for authors of new tests to tell whether that prereq needs to be
   set.
 - GETTEXT_POISON can be enabled or disabled at runtime
 - _() is an inline function to catch misuses like

   const char *some_strings[] =3D { _("foo"), _("bar"), _("baz") };
 - combined some patches, tweaked commit messages

Thoughts welcome, as always.
Jonathan Nieder (1):
  tests: let GETTEXT_POISON be disabled at run time

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
  i18n: add no-op _() and N_() wrappers
  tests: add GETTEXT_POISON to simulate unfriendly translator

 Makefile      |    9 +++++++++
 cache.h       |    1 +
 gettext.c     |   14 ++++++++++++++
 gettext.h     |   32 ++++++++++++++++++++++++++++++++
 t/test-lib.sh |    9 +++++++++
 5 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100644 gettext.c
 create mode 100644 gettext.h
