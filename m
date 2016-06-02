From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2016, #09; Tue, 31) t1308 broken
Date: Thu, 02 Jun 2016 14:31:50 -0700
Message-ID: <xmqqwpm7s2ex.fsf@gitster.mtv.corp.google.com>
References: <xmqqzir53mdc.fsf@gitster.mtv.corp.google.com>
	<712e0755-6008-21f5-0ee6-25ed9d97fd45@web.de>
	<xmqq1t4ftheu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 02 23:31:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8aDe-0002oB-Ek
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 23:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932887AbcFBVbz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2016 17:31:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64761 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932215AbcFBVby convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2016 17:31:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 44E7221D7A;
	Thu,  2 Jun 2016 17:31:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/kxE0++qrBjb
	dzgITNtXg4n0H60=; b=VgtNsV7h7wgdiiUubKi9nlCcbryYsPiJpP+x2ubo39VQ
	MU9PlplbWcFgyAV4zO+Sk5yNc5hf5a7lN8dLo1OjYym+gg0qMlGPzZ+EPLoR74nF
	V8qpRKy6f7hxSS1dCxU4cKHxbZYbr3cw+8i/nDvIVAsuLsYGsq7wkxXe6aaaLDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eAWaXn
	+pZlatRpp35myBKz6/Mm5vnO3v8zFaOIThQuO+/BJqT0NEJ0yonbakekPaDMRFkn
	dYB69qT+GAmuHuulyMWNEaJHTyfCQzGtLCpoQrhZEXY2qdiz6oS3wVuJIUWNG3WQ
	N/Aq8A7mH+mGxGha5FhK7Z20CqwKiX1oER48s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E8B921D79;
	Thu,  2 Jun 2016 17:31:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C015121D78;
	Thu,  2 Jun 2016 17:31:52 -0400 (EDT)
In-Reply-To: <xmqq1t4ftheu.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 02 Jun 2016 14:22:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6C31017E-2909-11E6-8310-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296240>

Junio C Hamano <gitster@pobox.com> writes:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> It seams as  ./t1308-config-set.sh is broken,
>> when the the directory is a soft link:
>>
>> -name=3D/home/tb/NoBackup/projects/git/git.pu/t/trash
>> directory.t1308-config-set/.gitconfig
>> +name=3D/home/tb/projects/git/git.pu/t/trash directory.t1308-config-=
set/.gitconfig
>>  scope=3Dglobal
>
> It does seem that way.  Somebody is affected by $PWD when we should
> be consistently using the physical / real path.
>
>>
>>  key=3Dfoo.bar
>> not ok 28 - iteration shows correct origins
>>
>> I havent't digged further, too many conflicts in the config code, ma=
y be
>> somebody knows it directly ?

Perhaps like this, taking hint from the log message of 6eafa6d0
(submodules: don't stumble over symbolic links when cloning
recursively, 2012-07-12)?

 t/t1308-config-set.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 065d5eb..1ba9ecb 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -237,7 +237,7 @@ test_expect_success 'iteration shows correct origin=
s' '
 	key=3Dfoo.bar
 	value=3Dfrom-home
 	origin=3Dfile
-	name=3D$(pwd)/.gitconfig
+	name=3D$TRASH_DIRECTORY/.gitconfig
 	scope=3Dglobal
=20
 	key=3Dfoo.bar
