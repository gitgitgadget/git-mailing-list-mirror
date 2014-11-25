From: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH 0/2] pre-commit hook updates
Date: Tue, 25 Nov 2014 23:51:27 +0100
Message-ID: <cover.1416953772.git.oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 23:51:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtOxT-0005lw-Ot
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 23:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbaKYWvk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Nov 2014 17:51:40 -0500
Received: from mail-wi0-f177.google.com ([209.85.212.177]:52269 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbaKYWvj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 17:51:39 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so3111329wiw.4
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 14:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=q8IaO7xqRfFGM6+GZvfNIz340ZudUVVHXfBVRLEVEpk=;
        b=tj+n/9V24hR5X7GHAlnPlRuYpu1GmwCc5+zB1S01r92xBiXawGzHs/KiQ81aE6pRsb
         magQk+5r5FD/yPPxNPNDQEZQ+iXRHWwgjxQHMYNDVlHcqMS3BduaotpkaLkqYbP6bqKW
         qizL+XjsBaitipgx18YqP/gC6Jo9RA0ejTCaDxiltpgldlWz2kM40M/p+AC3tQ3alH6l
         05ivCtsnakuNEmJkGQ887vJGJJoKOZ22j48iQ3vEz2kJ7DjdfUPaOpKAA8MknJAylV/g
         2dPBSd+0wYD4/W03Ocafprbi6foWCDjVjA631kinsVjkWJqyXxHO65oWDU3hpk1OxpSP
         DYnw==
X-Received: by 10.194.187.164 with SMTP id ft4mr42580020wjc.76.1416955897823;
        Tue, 25 Nov 2014 14:51:37 -0800 (PST)
Received: from bigge.localdomain (80.156.189.109.customer.cdi.no. [109.189.156.80])
        by mx.google.com with ESMTPSA id ry19sm3830783wjb.3.2014.11.25.14.51.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Nov 2014 14:51:37 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260245>

The first patch changes t/t7503-pre-commit-hook.sh to use write_script
everywhere, as was suggested by Jeff King in the discussion of the
previous patch.

The second patch is v2 of the patch I sent earlier. I've incorporated
Eric Sunshine's suggestions. I didn't do enough digging; I found
test_expect_failure and assumed this was test_expect_success's twin
brother, but it marked stuff as known breakages so I went with the '!'.
I also found it a bit strange that test_must_fail has a different
signature (to the extent a shell function has one at all). Is my use of
test_must_fail correct?

I agree with Junio Hamano that it's better to provide no argument at al=
l
rather than an empty one. I also agree with Jeff King that "noamend" is
better than an empty argument. I went with the second one since Jeff
seemed to get the last word :)

I'm not sure I like the ternary inside the function call like that, but
I went with it because it gave the smallest footprint (which is probabl=
y
not a good argument). I suppose I could have done:

if (amend)
	hook_arg1 =3D "amend"
else
	hook_arg1 =3D "noamend"
=2E..
=2E.. run_commit_hook(use_editor, index_file, "pre-commit", hook_arg1, =
NULL);

or create a hook_amend variable.

I'm happy to send a v3.

=C3=98ystein Walle (2):
  t7503: use write_script to generate hook scripts
  commit: inform pre-commit that --amend was used

 Documentation/githooks.txt |  3 ++-
 builtin/commit.c           |  3 ++-
 t/t7503-pre-commit-hook.sh | 20 ++++++++++++++------
 3 files changed, 18 insertions(+), 8 deletions(-)

--=20
2.2.0.rc2.23.gca0107e
