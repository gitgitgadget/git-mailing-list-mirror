From: "Yojem Mejoy" <yojem@gmx.com>
Subject: BUG REPORT: gitk displays diffs with angle brackets incorrectly
Date: Wed, 19 Aug 2015 21:57:02 +0200
Message-ID: <trinity-67046fdf-65d7-4ab9-a391-709a73002fee-1440014221975@3capp-mailcom-bs12>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 19 21:57:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS9Ty-00055e-Eg
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 21:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbbHST5G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2015 15:57:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:49993 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751940AbbHST5F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Aug 2015 15:57:05 -0400
Received: from [173.174.96.53] by 3capp-mailcom-bs12.server.lan (via HTTP);
 Wed, 19 Aug 2015 21:57:02 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K0:S4vp2lUEdh9Db/XJkeD/djQ8T5a7CDoLlU6HshiBgHr
 VzHYC94XitGoE91ECquzf2xWJtGMW05eJ1aSugHcti4SPyGPgz
 HFcLD0qXwFD8GQp7jlnfIkU2DBI/Ox70anjPEkLHYoiWa5p+3N
 2EhOmpesSiLzfXQdYBLnU18U/SJegw+VOxkK69dhpNdukLjj/8
 aKUjL98JlDah4CpavU7uANa3Z2PmIl+JoZdPDOqO1ibouPr9Qq
 7bmL/YIyTbHKoIysQtrvbVkJNh2EsOwr79wVFbaB8aPY0Gfnen
 ecwskikJdd+ayttd7OVaX5sAyCY
X-UI-Out-Filterresults: notjunk:1;V01:K0:Z1V5ksxn4qg=:CGppzw3MFq74fEfE4Z3nmv
 XM4r1cIzRL7NRfo8YbLNdqKaqBsuiZNfnwOKfXjp1Wmrw85JuGWnrN0QgzjbFKO2bl3JuvMQq
 gkfdkmzadPx5fMGS6RMviG3rjQzWjM1MxeSVPT4omdh8+mttHERiwC2g/mZyTT9mbEGKKbTr1
 cyCIwBf76+LQSjzFS/xlE8rmRv7JCUQt4YMpw6vHry/Y3Noc4+kDIfD72Rkr7FU53wzEE1omE
 CeimSk71UcjsCdkVTP7SrojGYe2My+2aBFObb/HtZi7DiPj1bJEbLV1OpWqJGBhz45cm8letN
 g5PJLxfGh6qybS1mOGueMUYZaQEFPPVU9fGrMx87RPhNmbpDlCeREX88KpRKaGHk0xH7GlI3X
 hEGsO95jq0YQMrzjUWImpjOzJjfWrIdJPpQHpJqtIqdkVJg0sYHYXkBICS5vmWG1mKk7Le3PH
 Y89DOOgqUw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276219>

Summary: Certain diffs containing angle brackets ('<' or '>' characters=
) are displayed incorrectly in gitk's "markup words" and "color words" =
modes. The bug is caused by a feature that isn't aware of the formattin=
g difference for the word diff modes.

How to reproduce the bug:
=C2=A0
Create a file with the following, and commit:
x < 1
y > 2
=C2=A0
Modify it to this, and commit:
z < 1
w > 2
=C2=A0
Then view the results with:
gitk --color-words
=C2=A0
You will see:
 * "Diff" shows bogus removal on 1st line and bogus addition on 2nd lin=
e.
 * "Old version" cuts off at right angle bracket.
 * "New Version" cuts off at left angle bracket.

I personally use a 2-line patch to fix this by disabling/breaking the f=
eature that does string comparisons for "=C2=A0 >" and "=C2=A0 <", but =
I know that's not the correct fix, so I'm not including it in this post=
=2E
