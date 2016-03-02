From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] submodule: port resolve_relative_url from shell to C
Date: Wed, 2 Mar 2016 09:34:12 -0800
Message-ID: <CAGZ79kZBXEnXdH1Zm0jg61Gianm6WesAgaf2WA57C63hwOafww@mail.gmail.com>
References: <1455320356-15778-1-git-send-email-sbeller@google.com>
	<1455320356-15778-2-git-send-email-sbeller@google.com>
	<56D7210D.8050708@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Mar 02 18:34:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abAfC-0001qk-0c
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 18:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755815AbcCBReO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2016 12:34:14 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:32880 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbcCBReN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2016 12:34:13 -0500
Received: by mail-io0-f169.google.com with SMTP id n190so64078118iof.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 09:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=Wq/2C3UjyzWKImnFawd55vojL0ROq+WsA0j+gEMUpTw=;
        b=VoEykr/sH5HZjOxGgO9fGVPwR+QYLd8DyW4bsIgJfUFOEsq00GDcv2w+nIld/ncSte
         wZEMd0D4jV8wnVRBOqN8IF6yfZPhkTIqGXDUZfpYoPUoHfBV5meNO8/nZtWMPPlCWVsg
         HytqdYXDffDUrM98mhA6J+fJw/6j3htOXERfMIp4+kYk9U0c21z6xoSQlj5txkUiJMBP
         vvYG5UrS3Rgfb6prXXnMesL1M0B5ZGDuL0Jfn5XTy9ns07BcHKGjQZqY2GmV40EQB0TV
         JSAI4xWpKHy3nchj8Sm0p1iq2iWCLWZHrInlWNefG9mx8bsR0XPwc/emtXy9PNE9Dny6
         KWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=Wq/2C3UjyzWKImnFawd55vojL0ROq+WsA0j+gEMUpTw=;
        b=mh8/Xo7Kt3wvonT2VBDX5X3ODdNmlPDM00C2xWyOnmBQaVR4jU3r7TsUf12UsxFkfv
         iedIFkOVB2JvxyThMfN2Ivc66YcYUWWGWNfmro4GDSyvNq4z+PV2oS/5LjJ4+AN3ZkCq
         ZycoSxZ9PtWK0b3qHUwO4aqaQFDd9sv04vJ0oGh+SKIzhmH9LRGDhSghu/zdpgGy03tq
         68mysGaY8vuMTLrW9bosfoNdqk8RZINwoxyLz6IxFl5HYAe++EhdvOgUxs7f7imLoqJD
         ePaQTHYS5xOhZDi4KhBb+AOjKr24oO0028LbsStw89YF05ONvmK7MSyBgyIz6zjfIXM2
         dLzQ==
X-Gm-Message-State: AG10YOTRIHW7I/SclLT19y65F/HZo9lKtJWVurVmlN7GOw7Kt7GLkXa2mAfXFRtEJoKXQUwlNut5SGDnlfhO8AwO
X-Received: by 10.107.168.149 with SMTP id e21mr31084304ioj.96.1456940052388;
 Wed, 02 Mar 2016 09:34:12 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Wed, 2 Mar 2016 09:34:12 -0800 (PST)
In-Reply-To: <56D7210D.8050708@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288135>

On Wed, Mar 2, 2016 at 9:21 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 13.02.2016 um 00:39 schrieb Stefan Beller:
>> @@ -289,4 +296,39 @@ test_git_path GIT_COMMON_DIR=3Dbar config      =
             bar/config
>>   test_git_path GIT_COMMON_DIR=3Dbar packed-refs              bar/pa=
cked-refs
>>   test_git_path GIT_COMMON_DIR=3Dbar shallow                  bar/sh=
allow
>>
>> +test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c" ".=
=2E/foo/sub/a/b/c"
>> +test_submodule_relative_url "../../../" "../foo/bar" "../sub/a/b/c"=
 "../../../../foo/sub/a/b/c"
>> +test_submodule_relative_url "(null)" "../foo/bar" "../submodule" ".=
=2E/foo/submodule"
>> +test_submodule_relative_url "../" "../foo/bar" "../submodule" "../.=
=2E/foo/submodule"
>> +test_submodule_relative_url "(null)" "../foo/submodule" "../submodu=
le" "../foo/submodule"
>> +test_submodule_relative_url "../" "../foo/submodule" "../submodule"=
 "../../foo/submodule"
>> +test_submodule_relative_url "(null)" "../foo" "../submodule" "../su=
bmodule"
>> +test_submodule_relative_url "../" "../foo" "../submodule" "../../su=
bmodule"
>> +test_submodule_relative_url "(null)" "./foo/bar" "../submodule" "fo=
o/submodule"
>> +test_submodule_relative_url "../" "./foo/bar" "../submodule" "../fo=
o/submodule"
>> +test_submodule_relative_url "(null)" "./foo" "../submodule" "submod=
ule"
>> +test_submodule_relative_url "../" "./foo" "../submodule" "../submod=
ule"
>> +test_submodule_relative_url "(null)" "//somewhere else/repo" "../su=
brepo" "//somewhere else/subrepo"
>> +test_submodule_relative_url "(null)" "/u//trash directory.t7406-sub=
module-update/subsuper_update_r" "../subsubsuper_update_r" "/u//trash d=
irectory.t7406-submodule-update/subsubsuper_update_r"
>> +test_submodule_relative_url "(null)" "/u//trash directory.t7406-sub=
module-update/super_update_r2" "../subsuper_update_r" "/u//trash direct=
ory.t7406-submodule-update/subsuper_update_r"
>> +test_submodule_relative_url "(null)" "/u/trash directory.t3600-rm/.=
" "../." "/u/trash directory.t3600-rm/."
>> +test_submodule_relative_url "(null)" "/u/trash directory.t3600-rm" =
"./." "/u/trash directory.t3600-rm/."
>> +test_submodule_relative_url "(null)" "/u/trash directory.t7400-subm=
odule-basic/addtest" "../repo" "/u/trash directory.t7400-submodule-basi=
c/repo"
>> +test_submodule_relative_url "../" "/u/trash directory.t7400-submodu=
le-basic/addtest" "../repo" "/u/trash directory.t7400-submodule-basic/r=
epo"
>> +test_submodule_relative_url "(null)" "/u/trash directory.t7400-subm=
odule-basic" "./=C3=A5 =C3=A4=C3=B6" "/u/trash directory.t7400-submodul=
e-basic/=C3=A5 =C3=A4=C3=B6"
>> +test_submodule_relative_url "(null)" "/u/trash directory.t7403-subm=
odule-sync/." "../submodule" "/u/trash directory.t7403-submodule-sync/s=
ubmodule"
>> +test_submodule_relative_url "(null)" "/u/trash directory.t7407-subm=
odule-foreach/submodule" "../submodule" "/u/trash directory.t7407-submo=
dule-foreach/submodule"
>> +test_submodule_relative_url "(null)" "/u/trash directory.t7409-subm=
odule-detached-worktree/home2/../remote" "../bundle1" "/u/trash directo=
ry.t7409-submodule-detached-worktree/home2/../bundle1"
>> +test_submodule_relative_url "(null)" "/u/trash directory.t7613-merg=
e-submodule/submodule_update_repo" "./." "/u/trash directory.t7613-merg=
e-submodule/submodule_update_repo/."
>
> The tests with absolute paths all fail on Windows. The reason is that
> git.exe sees mangled paths and 'git submodule--helper
> resolve-relative-url-test' produces mangled paths (that begins with a
> drive letter), whereas the test script expects POSIX paths. The patte=
rn
> I currently use to fix this is
>
> test_submodule_relative_url "(null)" "$PWD/addtest" "../repo" "$(pwd)=
/repo"
>
> (In our test scripts, $PWD is a POSIX style path and $(pwd) is a
> Windows style path).
>
> With this change, the penultimate case above still fails because the
> 'home2/..' gets lost somewhere in the actual output, which I still ha=
ve
> to debug.
>
> The two cases beginning with '/u//' cannot be tested on Windows.
> Are they important? Are the doubled slashes intentional?

The way I got the test cases is by inserting a debug printf into the
shell script
and then running the test suite (as that ought to work correct and
cover everything).

And the double slash is intentional, somewhere in the test suite we hav=
e a case
where that occurs. It may be a calling error?

Thanks for looking into this on the Windows side :)

Thanks,
Stefan

>
>> +test_submodule_relative_url "(null)" "file:///tmp/repo" "../subrepo=
" "file:///tmp/subrepo"
>> +test_submodule_relative_url "(null)" "foo/bar" "../submodule" "foo/=
submodule"
>> +test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/=
submodule"
>> +test_submodule_relative_url "(null)" "foo" "../submodule" "submodul=
e"
>> +test_submodule_relative_url "../" "foo" "../submodule" "../submodul=
e"
>> +test_submodule_relative_url "(null)" "helper:://hostname/repo" "../=
subrepo" "helper:://hostname/subrepo"
>> +test_submodule_relative_url "(null)" "ssh://hostname/repo" "../subr=
epo" "ssh://hostname/subrepo"
>> +test_submodule_relative_url "(null)" "ssh://hostname:22/repo" "../s=
ubrepo" "ssh://hostname:22/subrepo"
>> +test_submodule_relative_url "(null)" "user@host:path/to/repo" "../s=
ubrepo" "user@host:path/to/subrepo"
>> +test_submodule_relative_url "(null)" "user@host:repo" "../subrepo" =
"user@host:subrepo"
>> +
>>   test_done
>>
>
