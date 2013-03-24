From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC] test-lib.sh: No POSIXPERM for cygwin
Date: Sat, 23 Mar 2013 22:49:17 -0400
Message-ID: <CAPig+cR0HdQq4P=MWg7xkFLMzNimitty_Bj7mVx+w3eoi9bZ3g@mail.gmail.com>
References: <201303231340.29687.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, j6t@kdbg.org,
	Git List <git@vger.kernel.org>, ramsay@ramsay1.demon.co.uk
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 24 03:49:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJb0G-0005Gl-CI
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 03:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824Ab3CXCtU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Mar 2013 22:49:20 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:48594 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744Ab3CXCtT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Mar 2013 22:49:19 -0400
Received: by mail-la0-f50.google.com with SMTP id ec20so9513898lab.9
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 19:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SDn1hmIUU38CWRfxVRiAkUVIRgMnvR59DiMOufswl+I=;
        b=krfzz5MOF0StdfkpKSUEy+q9iDkNqG+9T9DhbJsSToaQ72tTMRfXvRNNAnToH3tGu3
         EEs0ynhh0KDob1kLyq2v7IzOniJqU82KT9wzSW4VrTnWpTUW34qJnjPNstIsWiuBJTgI
         xGF8DNOw2KbmbyD+T88J0DO+tPpCQFh9FYLwbIxZsKG+obBwRHDjSM216vr30gUhrgO2
         K+wp+FTk5D0kEncenZGbny+/76elADqmRgGaDbjwUB9XlaKKvsgINUjPvrD2LTFRwHwl
         h6gAbwZPukp8NwiDI5BRzlh0gFCibw6/cFhmBUkE7r3aN7fU/qui4QX2/XCIcPwoMc18
         JSJA==
X-Received: by 10.152.123.34 with SMTP id lx2mr3567057lab.52.1364093357482;
 Sat, 23 Mar 2013 19:49:17 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Sat, 23 Mar 2013 19:49:17 -0700 (PDT)
In-Reply-To: <201303231340.29687.tboegi@web.de>
X-Google-Sender-Auth: j6C7ghzfQriHn-uoi3RLu2HOc5A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218930>

On Sat, Mar 23, 2013 at 8:40 AM, Torsten B=F6gershausen <tboegi@web.de>=
 wrote:
> Subject: [PATCH] Make core.sharedRepository work under cygwin 1.7
>
> When core.sharedRepository is used, set_shared_perm() in path.c
> needs lstat() to return the correct POSIX permissions.
>
> The default for cygwin is core.ignoreCygwinFSTricks =3D false, which
> means that the fast implementation in do_stat() is used instead of ls=
tat().
>
> lstat() under cygwin uses the Windows security model to implement
> POSIX-like permissions.
> The user, group or everyone bits can be set individually.
>
> do_stat() simplifes the file permission bits, and may return a wrong =
value:
> The read-only attribute of a file is used to calculate
> the permissions, resulting in either rw-r--r-- or r--r--r--
>
> One effect of the simplified do_stat() is that t1301 failes.

s/failes/fails/

> Add a function cygwin_get_st_mode_bits() which returns the POSIX perm=
issions.
> When not compiling for cygwin, true_mode_bits() in path.c is used.
