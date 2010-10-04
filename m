From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v4 2/4] Add testcases for the --detect-dir-renames
 diffcore flag.
Date: Mon, 4 Oct 2010 03:03:35 +0000
Message-ID: <AANLkTi=B-aJJ1Q3grmea_YWQCgBkaHoYj0Rym4rqY19C@mail.gmail.com>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
	<1286138529-6780-2-git-send-email-ydirson@altern.org>
	<1286138529-6780-3-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Yann Dirson <ydirson@free.fr>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Oct 04 05:03:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2bL3-0000Mw-7g
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 05:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497Ab0JDDDh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 23:03:37 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55732 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab0JDDDg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 23:03:36 -0400
Received: by iwn5 with SMTP id 5so6348614iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 20:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=g6vNSNNCrqZX3SbvDaF29LjFAYIAUa0W+k+50DQ49eE=;
        b=ZxZuRynm4gfZx069mqgRjpPkMJB5TCHipdUWdm7U/zt9YDHqPNdHNC492wCL7C67QT
         eZRSd5ONQ/Xk0sWVV+9qKsUmaxAClpqSuPDB6vMNA6vKZPOiSEmK5D4MR1AM6ZMFb2pH
         6WNBm5W0sMMiypAqFFmx+OISxDKBqzFO9zHcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=D49FkTjj3Aziz4ir0LzQkSgQdvB3IWKRKQMDn2n5DPkJ4mdCoS7PnJbFXLHTaEhsGO
         5GlF/OCM5XUzA0sqH4OGsKITyj70qhoeKkiJErv+LTgUAkbUp21OVJ4YmEnZ7/c6Z+Wd
         dGuqn4ATWNmDxcjQt/05qdHXilixXJzhO7Dw8=
Received: by 10.231.193.81 with SMTP id dt17mr7690515ibb.177.1286161415558;
 Sun, 03 Oct 2010 20:03:35 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 3 Oct 2010 20:03:35 -0700 (PDT)
In-Reply-To: <1286138529-6780-3-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157962>

On Sun, Oct 3, 2010 at 20:42, Yann Dirson <ydirson@altern.org> wrote:
> From: Yann Dirson <ydirson@free.fr>
>
> This notably includes a couple of tests for cases known not to be
> working correctly yet.
> ---
> =C2=A0t/t4046-diff-rename-factorize.sh | =C2=A0326 ++++++++++++++++++=
++++++++++++++++++++
> =C2=A01 files changed, 326 insertions(+), 0 deletions(-)
> =C2=A0create mode 100755 t/t4046-diff-rename-factorize.sh
>
> diff --git a/t/t4046-diff-rename-factorize.sh b/t/t4046-diff-rename-f=
actorize.sh
> new file mode 100755
> index 0000000..51b0b0b
> --- /dev/null
> +++ b/t/t4046-diff-rename-factorize.sh
> @@ -0,0 +1,326 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2008,2010 Yann Dirson
> +# Copyright (c) 2005 Junio C Hamano
> +#
> +
> +# TODO - missing tests:
> +# * two dirs or more moving all their files to a single dir
> +# * simultaneous bulkmove and rename
> +# * add a new file under a dir that was moved in the same commit
> +
> +test_description=3D'Test rename factorization in diff engine.
> +
> +'
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/diff-lib.sh
> +
> +test_expect_success \
> + =C2=A0 =C2=A0'commit the index.' =C2=A0\
> + =C2=A0 =C2=A0'git update-ref HEAD $(echo "original empty commit" | =
git commit-tree $(git write-tree))'

Since this is a new test it should use the nominal style:

    test_expect_success 'commit the index.' '
        git update-ref HEAD $(echo "original empty commit" | git
commit-tree $(git write-tree))
    '

> +mkdir a
> +echo >a/path0 'Line 1
> +Line 2
> +Line 3
> +Line 4
> +Line 5
> +Line 6
> +Line 7
> +Line 8
> +Line 9
> +Line 10
> +line 11
> +Line 12
> +Line 13
> +Line 14
> +Line 15
> +'
> +sed <a/path0 >a/path1 s/Line/Record/
> +sed <a/path0 >a/path2 s/Line/Stuff/
> +sed <a/path0 >a/path3 s/Line/Blurb/

Should be in a test, see "Put all code inside test_expect_success and
other assertions." in t/README.

> +test_expect_success \
> + =C2=A0 =C2=A0'update-index --add file inside a directory.' \
> + =C2=A0 =C2=A0'git update-index --add a/path*'
> +
> +test_expect_success \
> + =C2=A0 =C2=A0'commit the index.' =C2=A0\
> + =C2=A0 =C2=A0'git update-ref HEAD $(echo "original set of files" | =
git commit-tree $(git write-tree))'
> +
> +mv a b

likewise here, and throughout the test of the test.
