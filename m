From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix wrong failures in config test
Date: Mon, 10 Jan 2011 10:30:17 -0800
Message-ID: <7vhbdg6286.fsf@alter.siamese.dyndns.org>
References: <4d2b3198.674034bb.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Mon Jan 10 19:30:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcMVi-0002rw-IN
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 19:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110Ab1AJSa0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jan 2011 13:30:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49551 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab1AJSaZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jan 2011 13:30:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DA7762298;
	Mon, 10 Jan 2011 13:31:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sn5CH2idKfjT
	79Igobp9yIy3Mfo=; b=jtRHMTKkeEJcNyL+oY0wnUVqHpmb6xBdm3NdAbcNjC3s
	cspTCVSTdjs7RXB2mkxg6Hac6enoMfyZLfkWa6LbC+WlHEa3cN/UebKF4lGfxtMO
	HauyyU3lYVYu8RfMZEY7KY0iTx+qvH+8pz7G/joNLcOjMut9x7Xy4Z+xv+ER6qc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IcCOZA
	BuoQXKZHmfafUoDgr36fQMGGAj6S++PiJ7x6qC8Q45jgP8tTBW6kQHuRl1U1peqh
	9g2w4OXKpjhXHIxZANrWPjEemGpuX7l73OvTyUqQze64mJC3WAHEysK0cjH18Djg
	OMboXd6yWRl7N9+DaT9cSzBDUXyOmOfQ8gJXI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B7DB12296;
	Mon, 10 Jan 2011 13:31:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 994DB2292; Mon, 10 Jan 2011
 13:30:58 -0500 (EST)
In-Reply-To: <4d2b3198.674034bb.bm000@wupperonline.de> ("Ingo =?utf-8?Q?Br?=
 =?utf-8?Q?=C3=BCckl=22's?= message of "Mon\, 10 Jan 2011 17\:13\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C6A9AC70-1CE7-11E0-9C34-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164892>

Ingo Br=C3=BCckl <ib@wupperonline.de> writes:

> The tests after '--set in alternative GIT_CONFIG' failed because
> variable GIT_CONFIG was still set.
>
> Signed-off-by: Ingo Br=C3=BCckl <ib@wupperonline.de>
> ---
>
> Is it only me (bash 3.2.48(1)-release) experiencing these failures?

>
>  t/t1300-repo-config.sh |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

t1300 first sources test-lib.sh that explicitly unsets GIT_CONFIG and t=
he
tests that might touch GIT_CONFIG all do so by a single-shot assignment=
 to
be exported, i.e.

	GIT_CONFIG=3Dother-config git config anwohner.park ausweis

that shouldn't affect the later test, unless the shell is broken.

With this patch, can you check which one of the new tests barf on you?

 t/t1300-repo-config.sh |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index d0e5546..c91d166 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -7,6 +7,10 @@ test_description=3D'Test git config in different setti=
ngs'
=20
 . ./test-lib.sh
=20
+test_expect_success 'is GIT_CONFIG set (0)?' '
+	test "z${GIT_CONFIG+set}" =3D z
+'
+
 test -f .git/config && rm .git/config
=20
 git config core.penguin "little blue"
@@ -399,8 +403,17 @@ cat > expect << EOF
 ein.bahn=3Dstrasse
 EOF
=20
+
+test_expect_success 'is GIT_CONFIG set (1)?' '
+	test "z${GIT_CONFIG+set}" =3D z
+'
+
 GIT_CONFIG=3Dother-config git config -l > output
=20
+test_expect_success 'is GIT_CONFIG set (2)?' '
+	test "z${GIT_CONFIG+set}" =3D z
+'
+
 test_expect_success 'alternative GIT_CONFIG' 'cmp output expect'
=20
 test_expect_success 'alternative GIT_CONFIG (--file)' \
@@ -419,6 +432,10 @@ test_expect_success 'refer config from subdirector=
y' '
=20
 GIT_CONFIG=3Dother-config git config anwohner.park ausweis
=20
+test_expect_success 'is GIT_CONFIG set (3)?' '
+	test "z${GIT_CONFIG+set}" =3D z
+'
+
 cat > expect << EOF
 [ein]
 	bahn =3D strasse
@@ -426,6 +443,10 @@ cat > expect << EOF
 	park =3D ausweis
 EOF
=20
+test_expect_success 'is GIT_CONFIG set (4)?' '
+	test "z${GIT_CONFIG+set}" =3D z
+'
+
 test_expect_success '--set in alternative GIT_CONFIG' 'cmp other-confi=
g expect'
=20
 cat > .git/config << EOF
