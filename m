Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8123D20189
	for <e@80x24.org>; Sun, 19 Jun 2016 18:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbcFSS3Q (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 14:29:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54023 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751106AbcFSS3P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 14:29:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4719E24F17;
	Sun, 19 Jun 2016 14:29:14 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6cYFldqx9cYSDZHDIrnYkf1+Dps=; b=LDj5e/
	KHnxg05XJE3lPKvhmVfbzD+y8e5yLOb+sfT42j/7E/hqfjb1tEZ8K7JFjPIu19Uy
	DM4D0Jd6Elc0RYC6D4vcma3MO4XiK1ILuvF+7ibu1ROtsExpDVSfpzPPRU2YvAW+
	LQ0oRvyLv9a6cu2lZjRFZzR06etuFbIpGbjoE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jBb+p1L4PvnwERaVmihJjsn22T0RQlwv
	G77o2PK5ZZGozepqbVmPNPRREEvrZ04raFSTE6KfZ7oFuZ6li+0C7/y0dKcjcOJa
	PH7iOUV3FjxLyY5zi/BnbiLX3IS6g55UICxPQLxGuOZ1GRAI95k3/GXjL8NsE3Ra
	LU6oth6qNsE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F02424F16;
	Sun, 19 Jun 2016 14:29:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BBEA724F14;
	Sun, 19 Jun 2016 14:29:13 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1] travis-ci: enable web server tests t55xx on Linux
References: <1463647511-54811-1-git-send-email-larsxschneider@gmail.com>
	<6C0F6649-C238-475E-BAA5-5F3A0EC5DA2D@gmail.com>
Date:	Sun, 19 Jun 2016 11:29:12 -0700
In-Reply-To: <6C0F6649-C238-475E-BAA5-5F3A0EC5DA2D@gmail.com> (Lars
	Schneider's message of "Sun, 19 Jun 2016 19:05:04 +0200")
Message-ID: <xmqqd1ndvxqf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B921398C-364B-11E6-A266-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Hi Junio,
>
> is there any chance to pick this up? It would enable the web server
> tests on Travis CI.

There always are chances unless a patch was rejected with some
reason, like "no, I do not like it" ;-)

I do not see anybody commenting on it, and suspect that it simply
did not register in anybody's radar.

Folks who actually read the Travis report of their own commits, do
you have any comment (I just reproduced it from the original so that
we can easily apply it when we agree it is a good thing to do)?

Thanks.

-- >8 --
From: Lars Schneider <larsxschneider@gmail.com>
Date: Thu, 19 May 2016 10:45:11 +0200
Subject: [PATCH v1] travis-ci: enable web server tests t55xx on Linux

Install the "apache" package to run the Git web server tests on
Travis-CI Linux build machines. The tests are already executed on OS X
build machines since the apache web server is installed by default.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index adab5b8..3c54080 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -18,6 +18,7 @@ addons:
   apt:
     packages:
     - language-pack-is
+    - apache2

 env:
   global:
@@ -30,6 +31,7 @@ env:
     - DEFAULT_TEST_TARGET=prove
     - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
     - GIT_TEST_OPTS="--verbose --tee"
+    - GIT_TEST_HTTPD=true
     - GIT_TEST_CLONE_2GB=YesPlease
     # t9810 occasionally fails on Travis CI OS X
     # t9816 occasionally fails with "TAP out of sequence errors" on Travis CI OS X
--
2.5.1

