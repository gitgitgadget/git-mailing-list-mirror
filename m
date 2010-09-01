From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: log -L crash (Re: [PATCH V5 13/17] Add parent rewriting to line
 history browser)
Date: Wed, 1 Sep 2010 22:47:11 +0800
Message-ID: <AANLkTik2WgTkjH4nDs2QKSfb+rn4-QioGOeJZJ4NgN9t@mail.gmail.com>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
	<1281539022-31616-14-git-send-email-struggleyb.nku@gmail.com>
	<20100830171007.GC21441@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, trast@student.ethz.ch,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 16:51:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqoeR-0007BL-Kz
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 16:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400Ab0IAOum convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 10:50:42 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50687 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735Ab0IAOul convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 10:50:41 -0400
Received: by eyb6 with SMTP id 6so565415eyb.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 07:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZoyWV174fYa9fE25cozh93NLcj1fJE1itNzk3H1tcBg=;
        b=oQHM1KQ6C8+6icXX99QPhhjD2C61X5PggM+4bO12vv+iW8HDzCZ5DUXUirDT1xfSzI
         i3hmzmUlQtgtLpany1Sb+NndQnalqtxYyeJzAYa7xx1ikzuKpYjbF05siA1GOcPbJmiL
         briEBkreMDD5j7a5v1Py3Qq68ZhmVxwrHmSuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qnE0q0Lgxg7ez90rx+/niRH+SWeqXLe+wdzrCr61dnLyST9fDqJupQLxzbah17b7HV
         UjpPmSVLF7io3lsxnTf3NkOu1GdmB3QpR6TFCdG+Xd9+3sfe2Dc0sOHvBoU6hS71DQHF
         GCSqE0z81wsifC20mCsQ8Tqmkm7rr0VxCEAs8=
Received: by 10.213.29.144 with SMTP id q16mr434740ebc.75.1283352434551; Wed,
 01 Sep 2010 07:47:14 -0700 (PDT)
Received: by 10.220.158.132 with HTTP; Wed, 1 Sep 2010 07:47:11 -0700 (PDT)
In-Reply-To: <20100830171007.GC21441@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155047>

Hi Jonathan,

   Thanks a lot for providing such a detail valgrind trace output, I
will find out what happened to the code in this Friday, and give a fix
then. Thanks again for let me know it. Thanks!

On Tue, Aug 31, 2010 at 1:10 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi Bo et al,
>
> The following test fails (segfaults) for me. =A0It bisects to 83361f5
> (Add parent rewriting to line history browser, 2010-08-11). =A0Notes
> from --valgrind:
>
> =A0 =A0 =A0 =A0Invalid read of size 4
> =A0 =A0 =A0 =A0 =A0 at assign_parents_range (line.c:1069)
> =A0 =A0 =A0 =A0 =A0 by cmd_line_log_walk (line.c:1403)
> =A0 =A0 =A0 =A0 =A0 by cmd_log (log.c:619)
> =A0 =A0 =A0 =A0 =A0 by handle_internal_command (git.c:270)
> =A0 =A0 =A0 =A0 =A0 by main (git.c:470)
> =A0 =A0 =A0 =A0 Address 0x432a90c is 4 bytes inside a block of size 8=
 free'd
> =A0 =A0 =A0 =A0 =A0 at free (vg_replace_malloc.c:366)
> =A0 =A0 =A0 =A0 =A0 by assign_range_to_parent (line.c:964)
> =A0 =A0 =A0 =A0 =A0 by assign_parents_range (line.c:1036)
> =A0 =A0 =A0 =A0 =A0 by cmd_line_log_walk (line.c:1403)
> =A0 =A0 =A0 =A0 =A0 by cmd_log (log.c:619)
> =A0 =A0 =A0 =A0 =A0 by handle_internal_command (git.c:270)
> =A0 =A0 =A0 =A0 =A0 by main (git.c:470)
>
> =A0 =A0 =A0 =A0Invalid read of size 4
> =A0 =A0 =A0 =A0 =A0 at assign_parents_range (line.c:1041)
> =A0 =A0 =A0 =A0 =A0 by cmd_line_log_walk (line.c:1403)
> =A0 =A0 =A0 =A0 =A0 by cmd_log (log.c:619)
> =A0 =A0 =A0 =A0 =A0 by handle_internal_command (git.c:270)
> =A0 =A0 =A0 =A0 =A0 by main (git.c:470)
> =A0 =A0 =A0 =A0 Address 0x0 is not stack'd, malloc'd or (recently) fr=
ee'd
>
> =A0 =A0 =A0 =A0Process terminating with default action of signal 11 (=
SIGSEGV): dumping core
> =A0 =A0 =A0 =A0 Access not within mapped region at address 0x0
> =A0 =A0 =A0 =A0 =A0 at assign_parents_range (line.c:1041)
> =A0 =A0 =A0 =A0 =A0 by cmd_line_log_walk (line.c:1403)
> =A0 =A0 =A0 =A0 =A0 by cmd_log (log.c:619)
> =A0 =A0 =A0 =A0 =A0 by handle_internal_command (git.c:270)
> =A0 =A0 =A0 =A0 =A0 by main (git.c:470)
> =A0 =A0 =A0 =A0 If you believe this happened as a result of a stack
> =A0 =A0 =A0 =A0 overflow in your program's main thread (unlikely but
> =A0 =A0 =A0 =A0 possible), you can try to increase the size of the
> =A0 =A0 =A0 =A0 main thread stack using the --main-stacksize=3D flag.
> =A0 =A0 =A0 =A0 The main thread stack size used in this run was 83886=
08.
>
> Ideas?
>
> diff --git a/t/t0011-crash.sh b/t/t0011-crash.sh
> index e69de29..5cb3ef3 100644
> --- a/t/t0011-crash.sh
> +++ b/t/t0011-crash.sh
> @@ -0,0 +1,11 @@
> +#!/bin/sh
> +
> +test_description=3Dcrash
> +. ./test-lib.sh
> +
> +test_expect_success "doesn't crash" '
> + =A0 =A0 =A0 GIT_DIR=3D"$TEST_DIRECTORY"/../.git \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 git log -L "/while (1) {/,/}/" git.c
> +'
> +
> +test_done
> --
>



--=20
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
