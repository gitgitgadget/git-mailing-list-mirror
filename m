From: "Micha Wiedenmann" <mw-u2@gmx.de>
Subject: Behavior change in 2.7.0: With core.sparseCheckout some files have
 the skip-worktree bit set after a checkout.
Date: Fri, 8 Jan 2016 11:35:23 +0100
Message-ID: <trinity-5caa2985-5cf1-453b-9a9e-bcce057f8615-1452249323061@3capp-gmx-bs51>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 11:35:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHUOI-0002eA-4X
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 11:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbcAHKf0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jan 2016 05:35:26 -0500
Received: from mout.gmx.net ([212.227.17.20]:53832 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754329AbcAHKfY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2016 05:35:24 -0500
Received: from [80.153.181.229] by 3capp-gmx-bs51.server.lan (via HTTP);
 Fri, 8 Jan 2016 11:35:23 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K0:cAlJXVhAr/P6nd9HW51dPFEMvEazTjE6QsmxT6OJI5p
 bLjquyPLTqgZ4YUMEBp3vXcqmPlA0i6wWV6r3W5k1+2w+mIq6F
 4PDX5PH0WFlDUCo9vGNH185/5tNbDqjIfYVrfN+kxDl7F4GfgN
 qqH9XAZpEdzmXZfzWo6VuCclc7wRcut40puSTnWZwTP4r7JXjm
 onhyL4GSW0utZR12wQy5Md1n55yeQ7Tt6CN2Ic3/Ru9It7YAll
 jsE8jQrIKz71/j0NPBoEnws+gS7w3Gki5Z6SgpOZ6D9DlQ5Va8 g+pSwU=
X-UI-Out-Filterresults: notjunk:1;V01:K0:1MAwzT6XNOg=:fUkpDltufrZiktplj5F78q
 tgYR1p3iHeR+WKh0aNIk/ioyZSE7KIKH/E5bm0NpJYnET3nNBgfg6YuzLjEG+PJsLjetZo9Dn
 hpkj/c2gIFnxoRMb1wGprkAs0NDOHw+4Jxa30EoGo8408IWuD7y7aIaXSVWAXYn+t5NCjyFe6
 HhOWbHZn05fvWKqkPjWZKPaqn8CmlpwYvxDLpcOkYjXyw6eUM2BGcgynYpuLoX6Z0okVUPI8b
 ygLNQn0y+fewCUrS9q5ecjLQTQFoLGWkEGccf9HDaAjvu6MdWaITXGEhi1TdcbYmkjumiAiPr
 PqQqIm2YglmVOONMpkLxskW7io9o26TudFTqYN3cnw6M+0ZkGTP5CJMWN++5i4ZQDU4kXCtSy
 TPiTw6/omEZM3wOfFpG+2zvBel0nBzaN2z2d3Q2B/J0MVCNTlvKvY0Bd2kiWaB66OtSEIIW0N
 BmG2VXGu8Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283532>

Hi,
=C2=A0
I want to report a change in behavior Git 2.7.0. With `core.sparseCheck=
out` set to true, `git checkout` results in some files with a set skip-=
worktree bit, which was not the case in 2.6.4. (I am using Git for Wind=
ows, but assume this is a Git issue, which is why I report it to this l=
ist.)
=C2=A0
Please see my test case:
=C2=A0
#!/bin/bash
git --version
# git version 2.7.0.windows.1
mkdir test-case
cd test-case
git init
mkdir keep
echo keep > keep/keep.txt
echo foo > foo.txt
git add -A
git commit -m initial
git config core.sparseCheckout true
cat > .git/info/sparse-checkout <<EOF
/*
!/keep/tags/
EOF

git checkout
git ls-files -v
# H foo.txt
# S keep/keep.txt
# $ git --version

# git version 2.6.4.windows.1
# $ git checkout
# $ git ls-files -v
# # H foo.txt
# # H keep/keep.txt
# (Note that the result of keep/keep.txt is different)

git read-tree @
git ls-files -v
# H foo.txt
# H keep/keep.txt

I noticed this, when all my tracked files where suddenly missing from t=
he working directory.

Hope that helps,
Micha Wiedenmann
=C2=A0
