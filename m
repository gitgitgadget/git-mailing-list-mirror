From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t1450-fsck (sometimes/often) failes on Mac OS X
Date: Wed, 19 Sep 2012 11:30:48 -0700
Message-ID: <7va9wlhnl3.fsf@alter.siamese.dyndns.org>
References: <5001644F.10901@web.de>
 <20120715090849.GB18385@sigill.intra.peff.net> <5059ED25.9090002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Sep 19 20:31:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEP37-0008Kk-Kt
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 20:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755168Ab2ISSaw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Sep 2012 14:30:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57333 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753629Ab2ISSav convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Sep 2012 14:30:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C644D8A9A;
	Wed, 19 Sep 2012 14:30:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=csatnYF6PgZ2
	v0p6jJS09C4Fyy0=; b=JIvspvNyW5762GJjpYXwRqcBM+V6SNfifynLIPyvkxo1
	BC4KRVzH0mGC+lCAB5kEj/H9Fo1uukwPfTUm6/hBQWLJvRTg5RtPVB9wr4YCEc6q
	BNgQkTZnS89NKZ1Sh2ofyMD4DIRpYfwft6sQiHXg8UKlfZiUg6wyWvRL/GF7bog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nZOmow
	SMl3oF/BuA78AHBTErpWnzUMByRtRmQOT4gL/IMcxq9d9PhZTuiHlhla6KjXxEAU
	8YGzvI+9g4AW82QLhDgkUaq05MQlpHYHMEb3FTmX7t7b1uOzEnL3r7wtLJXQGWjt
	Gb5UGAF6Oq/GB2yZ1WqimEcU0PgGw1DKKXfmU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1E958A99;
	Wed, 19 Sep 2012 14:30:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D89E68A98; Wed, 19 Sep 2012
 14:30:49 -0400 (EDT)
In-Reply-To: <5059ED25.9090002@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Wed, 19 Sep 2012 18:04:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 22E7D48A-0288-11E2-BE2A-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205972>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>>> Linux:
>>> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a blob, n=
ot a commit
>>> error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: broken links
>>> error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: could not lo=
ad tagged object
>>>
>>> Mac OS X:
>>> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit,=
 not a blob
>>> error: 63499e4ea8e096b831515ceb1d5a7593e4d87ae5: object corrupt or =
missing

Interesting difference.

>> That seems very broken. That sha1 can have only one type, so OS X is
>> actually mis-parsing the object type? Weird. I would suggest a memor=
y
>> error or race condition, but the test is valgrind-clean, and fsck sh=
ould
>> not be threaded at all.

"is a blob, not a commit" is likely to come from validating of the
tag 66f6581d that presumably point at 63499e4; it reads the tag,
learns the name of the object that is tagged and the type of it,
remembers that the object pointed at (which it hasn't and is going
to validate next) _must_ be a commit (because tag says so) and then
realizes when it reads 63499e4 it is a blob and barfs.

And that is what _should_ happen in that test.  It crafts a
malformed tag that points at a blob and claims that it is a commit.
The test makes sure fsck catches that, and it does.

On the other hand, "is a commit, not a blob", unless you have a tag
that directly points at a blob, is more likely to come from
validating some tree object.  It reads the tree, learns the name of
the object contained in the tree and infers the type of that object
from the mode bits in the tree (100644 or 100755 would mean the
object must be a blob), goes on to validate that object and realizes
it is a commit and barfs.

It is veriy unusual to get, even on two different platforms, both
messages for the same object.

Could it be that you have i18n on "Object %s is a %s, not a %s" with
a wrong .po file that swaps the latter two parameters in the output?

>> What does "git show 63499e4" show when the test has failed?

Was this question ever answered (I would prever "cat-file -t"
followed by "cat-file <type>" instead of "show" for things like
this)?  It should show that it is a blob whose contents is "blob\n".

> Checking tag 66f6581d549f70e05ca586bc2df5c15a95662c36
> Checking commit 134756353796a5439d93586be27999eea3807a34
> Checking blob 5626abf0f72e58d7a153368ba57db4c673c0e171
> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit,
> not a blob
> error: 63499e4ea8e096b831515ceb1d5a7593e4d87ae5: object corrupt or mi=
ssing
> Checking tree bd04fbdc74c1ad468ee1cc86d49860490ab3e6c7
> Checking commit c9145d6720f85544cc4bb6009a2e541660aa156b
> Checking tree c9176b0dd1a95c80ad8de21784b1eeffd3681f49
> Checking blob f719efd430d52bcfc8566a43b2eb655688d38871
> Checking cache tree
> Checking connectivity (32 objects)
> Checking 63499e4ea8e096b831515ceb1d5a7593e4d87ae5
> Checking 66f6581d549f70e05ca586bc2df5c15a95662c36
> Checking c9145d6720f85544cc4bb6009a2e541660aa156b
> Checking c9176b0dd1a95c80ad8de21784b1eeffd3681f49
> Checking 134756353796a5439d93586be27999eea3807a34
> Checking 5626abf0f72e58d7a153368ba57db4c673c0e171
> Checking f719efd430d52bcfc8566a43b2eb655688d38871
> Checking bd04fbdc74c1ad468ee1cc86d49860490ab3e6c7
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> diff failed passed
> diff out ../../../git.next/t/trash_directory.t1450-fsck2_120912_20530=
5/out
> 17a18,20
>> Checking blob 5626abf0f72e58d7a153368ba57db4c673c0e171
>> Checking blob 63499e4ea8e096b831515ceb1d5a7593e4d87ae5
>> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a blob, no=
t a commit

This is the correct behaviour.

> 18a22,23
>> error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: broken links
>> error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: could not loa=
d tagged object

This too.

> 20,22d24
> < Checking blob 5626abf0f72e58d7a153368ba57db4c673c0e171
> < error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit,=
 not a blob
> < error: 63499e4ea8e096b831515ceb1d5a7593e4d87ae5: object corrupt or =
missing
