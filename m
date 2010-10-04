From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv6 01/16] test-lib: make test_expect_code a test command
Date: Mon, 4 Oct 2010 03:48:43 +0000
Message-ID: <AANLkTinVvmJMEDhPcxa_CiOL2_RsYBdo-JywXi2gKeYp@mail.gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
	<1286136014-7728-2-git-send-email-newren@gmail.com>
	<7vfwwmdbgl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 05:48:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2c2j-00006k-9V
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 05:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889Ab0JDDso convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 23:48:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55517 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab0JDDsn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 23:48:43 -0400
Received: by iwn5 with SMTP id 5so6386274iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 20:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QdZmTaU+gb3TPJamSwBEZU8jnJJdfASByW/CIx08psI=;
        b=WLc+RVSVWqZ17W7kAND9hnRzwSM5GBNIggpNpwET7JnMvLRICN7j5E0GMITO33YWYr
         i6SmrJBS3DZYAK8UGVSX5h/NbQ9o22F7Hzw8Uu0McewQQ7fvknTI+nqnpvULy34p13SI
         kLWpZjuDYQ0u/Y+hD0N/5UpZThv1B5mR7wgdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kdvV4z6qmyghh0KOAclNHcyxpA6LYdmI3+Y5jqocUe85SxeesmLki6fARqRiGucza5
         8rvFSOshGaAqj8ymGIKZIjcdVn09YjvfdUOSZFDGG3QCN2V4m0LaCcnb2plDpO0c5OQ6
         pTs1VZHsXcwPBIBoTD57y9KlpOpgji6f1UDQ8=
Received: by 10.231.166.72 with SMTP id l8mr9486626iby.95.1286164123160; Sun,
 03 Oct 2010 20:48:43 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 3 Oct 2010 20:48:43 -0700 (PDT)
In-Reply-To: <7vfwwmdbgl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157968>

On Mon, Oct 4, 2010 at 00:54, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
>> index f688bd3..c2f5f8d 100755
>> --- a/t/t0000-basic.sh
>> +++ b/t/t0000-basic.sh
>> @@ -130,22 +130,57 @@ test_expect_success 'tests clean up after them=
selves' '
>> ...
>> +#!$SHELL_PATH
>> +
>> +test_description=3D'Failing tests with cleanup commands'
>> +
>> +# Point to the t/test-lib.sh, which isn't in ../ as usual
>> +TEST_DIRECTORY=3D\"$TEST_DIRECTORY\"
>
> Do we know at this point that the string in $TEST_DIRECTORY can safel=
y be
> quoted by just a simple dq pair? =C2=A0I don't think so--isn't the le=
ading part
> of that string whatever the user can choose (i.e. $(cwd))?
>
> This seems sloppy.
>
>> +. \"\$TEST_DIRECTORY\"/test-lib.sh
>
> Once you get the right value in TEST_DIRECTORY, this one is correct.

Wouldn't the issue you and Jonathan are talking about disappear with:

    diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
    index c2f5f8d..69e219b 100755
    --- a/t/t0000-basic.sh
    +++ b/t/t0000-basic.sh
    @@ -58,7 +58,7 @@ test_expect_failure 'pretend we have a known brea=
kage' '
     test_expect_success 'pretend we have fixed a known breakage (run
in sub test-lib)' "
         mkdir passing-todo &&
         (cd passing-todo &&
    -    cat >passing-todo.sh <<EOF &&
    +    cat >passing-todo.sh <<\EOF &&
     #!$SHELL_PATH

     test_description=3D'A passing TODO test
    @@ -139,7 +139,7 @@ fi
     test_expect_success 'tests clean up even on failures' "
         mkdir failing-cleanup &&
         (cd failing-cleanup &&
    -    cat >failing-cleanup.sh <<EOF &&
    +    cat >failing-cleanup.sh <<\EOF &&
     #!$SHELL_PATH

     test_description=3D'Failing tests with cleanup commands'

Note the change to passing-todo, that uses the same setup style.

With that the output of:

    $ rm -rfv trash*; ./t0000-basic.sh --debug; cat trash\
directory.t0000-basic/{passing-todo,failing-cleanup}/*.sh

Is now (cut):

    # Point to the t/test-lib.sh, which isn't in ../ as usual
    TEST_DIRECTORY=3D"/home/avar/g/git/t"
    . "$TEST_DIRECTORY"/test-lib.sh

    test_expect_failure 'pretend we have fixed a known breakage' '
        :
    '

    test_done
    #!/bin/sh

    test_description=3D'Failing tests with cleanup commands'

    # Point to the t/test-lib.sh, which isn't in ../ as usual
    TEST_DIRECTORY=3D"/home/avar/g/git/t"
    . "$TEST_DIRECTORY"/test-lib.sh

Instead of previously being:

    # Point to the t/test-lib.sh, which isn't in ../ as usual
    TEST_DIRECTORY=3D"/home/avar/g/git/t"
    . "/home/avar/g/git/t"/test-lib.sh

    test_expect_failure 'pretend we have fixed a known breakage' '
        :
    '

    test_done
    #!/bin/sh

    test_description=3D'Failing tests with cleanup commands'

    # Point to the t/test-lib.sh, which isn't in ../ as usual
    TEST_DIRECTORY=3D"/home/avar/g/git/t"
    . "/home/avar/g/git/t"/test-lib.sh

I.e. before the TEST_DIRECTORY was always expanded.
