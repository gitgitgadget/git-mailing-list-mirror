From: =?UTF-8?B?U2ViYXN0aWFuIEfDtnR0ZQ==?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH v8 0/5] Verify GPG signatures when merging and extend %G?
 pretty string
Date: Sun, 31 Mar 2013 17:58:52 +0200
Message-ID: <51585D3C.4000902@physik.tu-berlin.de>
References: <20130331144452.GF2286@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, john@keeping.me.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 31 17:59:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMKfe-0008Pt-Kl
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 17:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755704Ab3CaP7W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 11:59:22 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:39891 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755687Ab3CaP7V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 11:59:21 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-3) with esmtp 
	id 1UMKf6-0005eT-Fb; Sun, 31 Mar 2013 17:59:20 +0200
Received: from [94.45.250.108] (unknown [94.45.250.108])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id 83BE211402;
	Sun, 31 Mar 2013 17:59:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <20130331144452.GF2286@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219633>

On 03/31/2013 04:41 PM, John Keeping wrote:> On Sun, Mar 31, 2013 at 04=
:32:52PM +0200, Sebastian G=C3=B6tte wrote:
>> +	/* Iterate over all search strings */
>>  	for (i =3D 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
>> -		const char *found =3D strstr(buf, sigcheck_gpg_status[i].check);
>> -		const char *next;
>> -		if (!found)
>> -			continue;
>> +		const char *found, *next;
>> +
>> +		if (!prefixcmp(buf, sigcheck_gpg_status[i].check + 1)) {
>> +			/* At the very beginning of the buffer */
>=20
> This seems wrong.  You're losing the "\n" in front of the status stri=
ngs
> above but adding a special first line check skipping the first
> character.  Surely it should be one of these changes or the other, no=
t
> both?

You're right, that does not make a whole lot of sense.

On 03/31/2013 04:44 PM, John Keeping wrote:
>> +		if (sigc->result !=3D 'U') {
>
> This could use a comment; we know now that only GOODSIG and BADSIG
> are followed by a signature, but someone looking at this code in the
> future will probably appreciate an explanation.

=46ixed.

Sebastian G=C3=B6tte (5):
  Move commit GPG signature verification to commit.c
  commit.c/GPG signature verification: Also look at the first GPG statu=
s
    line
  merge/pull: verify GPG signatures of commits being merged
  merge/pull Check for untrusted good GPG signatures
  pretty printing: extend %G? to include 'N' and 'U'

 Documentation/merge-options.txt    |   5 ++
 Documentation/pretty-formats.txt   |   3 +-
 builtin/merge.c                    |  34 +++++++++++++-
 commit.c                           |  70 ++++++++++++++++++++++++++++
 commit.h                           |  10 ++++
 git-pull.sh                        |  10 +++-
 gpg-interface.h                    |  12 +++++
 pretty.c                           |  93 ++++++-----------------------=
--------
 t/lib-gpg/pubring.gpg              | Bin 1164 -> 2359 bytes
 t/lib-gpg/random_seed              | Bin 600 -> 600 bytes
 t/lib-gpg/secring.gpg              | Bin 1237 -> 3734 bytes
 t/lib-gpg/trustdb.gpg              | Bin 1280 -> 1360 bytes
 t/t7612-merge-verify-signatures.sh |  61 ++++++++++++++++++++++++
 13 files changed, 216 insertions(+), 82 deletions(-)
 create mode 100755 t/t7612-merge-verify-signatures.sh

--=20
1.8.1.5
