From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: t5516-fetch-push.sh fails with current master (74301d6)
Date: Wed, 21 Oct 2015 03:40:43 +0200
Message-ID: <CAA787rnfwVgE=40WF6co4cfMi0gNa8oT7dL-Wy1Gnto_gEF8AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 03:41:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoiP8-0000wh-0Q
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 03:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbbJUBlQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2015 21:41:16 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:35193 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbbJUBlO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2015 21:41:14 -0400
Received: by lbbes7 with SMTP id es7so27933602lbb.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 18:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=i6BKoqMaCPdvYfWwOkh1Yne4vjqXuYOYRUxs1yxNmjs=;
        b=XuQRTDWgLoLsDEMkVbyJ8I3cVKqcYKaQjZVHR6HA2a6ghjJBJVBr1jULC8bfNZmP0J
         3DJryyIJwLRJIXAyD2FmF1+Z86PMue5TmUp/pRnMuD2ME3j5ESU41s1ZolbKMpiMCqsC
         3MMZa5yblmr0B71jRNggG6Mh9lJfLr48iJN8jHFV1xCJ1EOZIbP5kP6p5JD9yUPxiCEi
         4lFgnd2oYec6kYCPJAY4lS57fkzHY5bftnVTcVstMbbtSlLeIZnY7i65E/fQN+RHnUy8
         /3/3xi0WwZRwzhmtqfgB2R3rsbek8V7toEqtNh351tN8y0TG6JdXLhJWDqUKyUSC9NLs
         p5tQ==
X-Received: by 10.112.140.4 with SMTP id rc4mr3631933lbb.26.1445391672521;
 Tue, 20 Oct 2015 18:41:12 -0700 (PDT)
Received: by 10.25.25.137 with HTTP; Tue, 20 Oct 2015 18:40:43 -0700 (PDT)
X-Google-Sender-Auth: vae8VQGVjUn6O_VrgoiUwzkyPAY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279959>

When building from current master (74301d6, "Sync with maint",
2015-10-20), test #75 in t5516-fetch-push.sh fails:

*** t5516-fetch-push.sh ***
ok 1 - setup
ok 2 - fetch without wildcard
[Snip 70 lines]
ok 73 - fetch exact SHA1
ok 74 - shallow fetch reachable SHA1 (but not a ref), allowtipsha1inwan=
t=3Dtrue
not ok 75 - deny fetch unreachable SHA1, allowtipsha1inwant=3Dtrue
#
# mk_empty testrepo &&
# (
#         cd testrepo &&
#         git config uploadpack.allowtipsha1inwant $configallowtipsha1i=
nwant &&
#         git commit --allow-empty -m foo &&
#         git commit --allow-empty -m bar &&
#         git commit --allow-empty -m xyz
# ) &&
# SHA1_1=3D$(git --git-dir=3Dtestrepo/.git rev-parse HEAD^^) &&
# SHA1_2=3D$(git --git-dir=3Dtestrepo/.git rev-parse HEAD^) &&
# SHA1_3=3D$(git --git-dir=3Dtestrepo/.git rev-parse HEAD) &&
# (
#         cd testrepo &&
#         git reset --hard $SHA1_2 &&
#         git cat-file commit $SHA1_1 &&
#         git cat-file commit $SHA1_3
# ) &&
# mk_empty shallow &&
# (
#         cd shallow &&
#         test_must_fail git fetch ../testrepo/.git $SHA1_3 &&
#         test_must_fail git fetch ../testrepo/.git $SHA1_1 &&
#         git --git-dir=3D../testrepo/.git config
uploadpack.allowreachablesha1inwant true &&
#         git fetch ../testrepo/.git $SHA1_1 &&
#         git cat-file commit $SHA1_1 &&
#         test_must_fail git cat-file commit $SHA1_2 &&
#         git fetch ../testrepo/.git $SHA1_2 &&
#         git cat-file commit $SHA1_2 &&
#         test_must_fail git fetch ../testrepo/.git $SHA1_3
# )
#
ok 76 - shallow fetch reachable SHA1 (but not a ref), allowtipsha1inwan=
t=3Dfalse
ok 77 - deny fetch unreachable SHA1, allowtipsha1inwant=3Dfalse
ok 78 - fetch follows tags by default
ok 79 - pushing a specific ref applies remote.$name.push as refmap
ok 80 - with no remote.$name.push, it is not used as refmap
ok 81 - with no remote.$name.push, upstream mapping is used
ok 82 - push does not follow tags by default
ok 83 - push --follow-tag only pushes relevant tags
ok 84 - push --no-thin must produce non-thin pack
ok 85 - pushing a tag pushes the tagged object
ok 86 - push into bare respects core.logallrefupdates
ok 87 - fetch into bare respects core.logallrefupdates
ok 88 - receive.denyCurrentBranch =3D updateInstead
ok 89 - updateInstead with push-to-checkout hook
# failed 1 among 89 test(s)
1..89
make[2]: *** [t5516-fetch-push.sh] Error 1
make[2]: Leaving directory `/home/sunny/src/other/git/build-git/t'
make[1]: *** [test] Error 2
make[1]: Leaving directory `/home/sunny/src/other/git/build-git/t'
make: *** [test] Error 2

(Removed indents to reduce email wrapping)

OS: Debian GNU/Linux 7.9 (wheezy)
gcc (Debian 4.7.2-5) 4.7.2

Regards,
=C3=98yvind
