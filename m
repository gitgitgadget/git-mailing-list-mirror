From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix a false negative in t5512 when run using sh -x
Date: Mon, 10 May 2010 13:03:25 +0200
Message-ID: <4BE7E7FD.7080607@viscovery.net>
References: <1273475946-2079-1-git-send-email-j6t@kdbg.org> <AANLkTilaZlku8eQpAjMPCPkzeVyg2u21KOcsZkxn4Kxd@mail.gmail.com> <20100510103427.GA4806@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 13:03:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBQlr-0000iN-Q7
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 13:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756714Ab0EJLDa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 07:03:30 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:64980 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab0EJLDa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 07:03:30 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OBQli-0000Dj-FY; Mon, 10 May 2010 13:03:26 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 34B751660F;
	Mon, 10 May 2010 13:03:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100510103427.GA4806@progeny.tock>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146796>

Am 5/10/2010 12:34, schrieb Jonathan Nieder:
> Sverre Rabbelier wrote:
>=20
>> Don't we do this ('test_cmp' on expected output) in many other place=
s
>> as well? Why is this different?
>=20
> The problem arises with test_cmp on expected output from stderr, sinc=
e
> sh -x will mingle the trace of a function with the standard error
> stream.  bash provides BASH_XTRACEFD to work around this misdesign,
> but other shells might not be so helpful.
>=20
> Here=E2=80=99s a workaround, ugly as sin.  It overreaches a little be=
cause I
> did not bother to check which tests grep and which tests test_cmp
> their output.
>=20
>  t/t0040-parse-options.sh       |    6 +++---
>  t/t1300-repo-config.sh         |    2 +-
>  t/t1450-fsck.sh                |    2 +-
>  t/t1503-rev-parse-verify.sh    |   20 ++++++++++----------
>  t/t1506-rev-parse-diagnosis.sh |   24 ++++++++++++------------
>  t/t2204-add-ignored.sh         |    8 ++++----
>  t/t3030-merge-recursive.sh     |    6 +++---
>  t/t3400-rebase.sh              |    2 +-
>  t/t3501-revert-cherry-pick.sh  |    2 +-
>  t/t3800-mktag.sh               |    2 +-
>  t/t4011-diff-symlink.sh        |    2 +-
>  t/t4014-format-patch.sh        |    6 +++---
>  t/t4120-apply-popt.sh          |    2 +-
>  t/t4124-apply-ws-rule.sh       |    2 +-
>  t/t4133-apply-filenames.sh     |    6 +++---
>  t/t5300-pack-object.sh         |    2 +-
>  t/t5400-send-pack.sh           |    2 +-
>  t/t5406-remote-rejects.sh      |    4 +++-
>  t/t5505-remote.sh              |    4 ++--
>  t/t5510-fetch.sh               |    2 +-
>  t/t5512-ls-remote.sh           |    2 +-
>  t/t6024-recursive-merge.sh     |    2 +-
>  t/t6030-bisect-porcelain.sh    |    6 +++---
>  t/t7110-reset-merge.sh         |   10 +++++-----
>  t/t7201-co.sh                  |    2 +-
>  t/t7610-mergetool.sh           |    6 +++---
>  t/t8003-blame.sh               |    4 ++--
>  t/t9001-send-email.sh          |   14 +++++++-------
>  t/t9108-git-svn-glob.sh        |    2 +-
>  29 files changed, 78 insertions(+), 76 deletions(-)

/me slaps forehead

I carry around a patch that logs "set -x" output to a file on Windows t=
o
help debug difficult to reproduce test failures. I had already inserted
"set +x" in all test cases where it matters, but t5512 is a new case si=
nce
I have this patch.

I can just amend my patch, no problem, and we solve the issue as you
propose (or perhaps not - it *is* ugly as hell).

=46WIW, test scripts that need this treatement are only:

t/t0040-parse-options.sh
t/t1503-rev-parse-verify.sh
t/t4014-format-patch.sh
t/t5505-remote.sh

and now t/t5512-ls-remote.sh as well.

-- Hannes
