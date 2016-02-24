From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git config: report when trying to modify a non-existing repo config
Date: Wed, 24 Feb 2016 14:31:51 -0800
Message-ID: <xmqqlh69spt4.fsf@gitster.mtv.corp.google.com>
References: <c4027d758b0914dbc2e1ff5df344b0669aac4447.1456299545.git.johannes.schindelin@gmx.de>
	<b225aec8c83a184f90dc6bfa821177b52ef4b3f4.1456318031.git.johannes.schindelin@gmx.de>
	<xmqq60xduauv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>,
	Duy Nguyen <pclouds@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 24 23:31:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYhyR-0000ZM-7d
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 23:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758426AbcBXWbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:31:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56954 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753737AbcBXWby (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:31:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C5DFF45E25;
	Wed, 24 Feb 2016 17:31:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DssCkKQEPY8qdoez96mesPyKz4s=; b=lYe+k5
	5OnzMhnG3aEkEMllTP9L6sEALHJ4urntcLGynafRLKc2eMJoWTng2pmm7kr/i62o
	klPhqfubzUM9bvxnEejDZYmp+BRGpEEu39T0vNcIQBxhVKw/OdYot26E9GwlKwcS
	sri1hgUb5hWLtVBPrNvFvBXzkcJDaoGedDypg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K7hOAFYvA5f2udpZwGsha8n9v98Pq1jI
	VKzRnt8nM/TKGiSXjfRd88yhb3RONfAfEY6gXXdXB+XfnugKMHga5Hj5QIG2pLdT
	DlPVoJ351VQkUNxBtt8gxJjQa9PXe3cG4Pd1lITJvkjerHQ7MJfdKA2VOpVxQaUB
	Liuecc9Ugts=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BDF0545E24;
	Wed, 24 Feb 2016 17:31:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3674345E20;
	Wed, 24 Feb 2016 17:31:52 -0500 (EST)
In-Reply-To: <xmqq60xduauv.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 24 Feb 2016 12:11:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 66C4EA72-DB46-11E5-9049-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287239>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
>> index 91235b7..f62409e 100755
>> --- a/t/t1308-config-set.sh
>> +++ b/t/t1308-config-set.sh
>> @@ -218,4 +218,13 @@ test_expect_success 'check line errors for malformed values' '
>>  	test_i18ngrep "fatal: .*alias\.br.*\.git/config.*line 2" result
>>  '
>>  
>> +test_expect_success 'error on modifying repo config without repo' '
>> +	mkdir no-repo &&
>> +	GIT_CEILING_DIRECTORIES=$(pwd) &&
>> +	export GIT_CEILING_DIRECTORIES &&
>> +	cd no-repo &&
>> +	test_must_fail git config a.b c 2>err &&
>> +	grep "not in a git directory" err
>> +'
>> +
>>  test_done
>
> Please make it a habit to run tests that go up/down in the hierarchy
> in a subshell.  It is not a good excuse that this new test happens
> to be at the end _right now_.

I'd squash this in.

Thanks.

 t/t1308-config-set.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index f62409e..9863d0d 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -220,11 +220,13 @@ test_expect_success 'check line errors for malformed values' '
 
 test_expect_success 'error on modifying repo config without repo' '
 	mkdir no-repo &&
-	GIT_CEILING_DIRECTORIES=$(pwd) &&
-	export GIT_CEILING_DIRECTORIES &&
-	cd no-repo &&
-	test_must_fail git config a.b c 2>err &&
-	grep "not in a git directory" err
+	(
+		GIT_CEILING_DIRECTORIES=$(pwd) &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd no-repo &&
+		test_must_fail git config a.b c 2>err &&
+		grep "not in a git directory" err
+	)
 '
 
 test_done
