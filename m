From: =?UTF-8?B?U2ViYXN0aWFuIEfDtnR0ZQ==?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH v4 0/5] Verify GPG signatures when merging and extend %G?
 pretty string
Date: Tue, 26 Mar 2013 12:05:33 +0100
Message-ID: <515180FD.7090906@physik.tu-berlin.de>
References: <7vli9bue40.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 26 12:06:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKRhj-0001e1-3v
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 12:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965Ab3CZLFm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Mar 2013 07:05:42 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:31541 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753066Ab3CZLFl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 07:05:41 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-2) with esmtp 
	id 1UKRhD-0003xQ-J8; Tue, 26 Mar 2013 12:05:40 +0100
Received: from [192.168.0.100] (cable-124-189.zeelandnet.nl [82.176.124.189])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id 6A4EF11402;
	Tue, 26 Mar 2013 12:05:34 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <7vli9bue40.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219151>

On 03/26/2013 02:46 AM, Junio C Hamano wrote:> Sebastian G=C3=B6tte <ja=
seg@physik.tu-berlin.de> writes:
>> Rebased it onto the current 'master'. The second patch fixes that th=
e GPG
>> status parser ignores the first line of GPG status output (that woul=
d be caught
>> by the new merge signature verification test case).
>=20
> Thanks.
>=20
> Does it still make sure that it won't be fooled by the expected
> string appearing in the middle of a line, not at the beginning?
I thought that would not be a problem until I noticed it checks for GOO=
DSIG
before it checks for BADSIG. Here is a fix.

Sebastian G=C3=B6tte (5):
  Move commit GPG signature verification to commit.c
  commit.c/GPG signature verification: Also look at the first GPG statu=
s
    line
  merge/pull: verify GPG signatures of commits being merged
  merge/pull Check for untrusted good GPG signatures
  pretty printing: extend %G? to include 'N' and 'U'

 Documentation/merge-options.txt    |   4 ++
 Documentation/pretty-formats.txt   |   3 +-
 builtin/merge.c                    |  35 ++++++++++++++++-
 commit.c                           |  64 +++++++++++++++++++++++++++++=
+
 commit.h                           |  10 +++++
 git-pull.sh                        |  10 ++++-
 gpg-interface.h                    |   8 ++++
 pretty.c                           |  77 ++++-------------------------=
--------
 t/lib-gpg/pubring.gpg              | Bin 1164 -> 2359 bytes
 t/lib-gpg/random_seed              | Bin 600 -> 600 bytes
 t/lib-gpg/secring.gpg              | Bin 1237 -> 3734 bytes
 t/lib-gpg/trustdb.gpg              | Bin 1280 -> 1360 bytes
 t/t7612-merge-verify-signatures.sh |  61 +++++++++++++++++++++++++++++
 13 files changed, 198 insertions(+), 74 deletions(-)
 create mode 100755 t/t7612-merge-verify-signatures.sh

--=20
1.8.1.5
