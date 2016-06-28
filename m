Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24EBA2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 18:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbcF1Stc (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 14:49:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63603 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752165AbcF1Stb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 14:49:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 01C5627504;
	Tue, 28 Jun 2016 14:49:30 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jBKR0ZDlYzopCj0ZytYQkdkOe58=; b=QqyNS3
	dtJQLw5RpccT+P3+a9BOwDC0MFF96aV7i3YGB7Sw56Nt7BYjd80/XT+UMhkTrWKf
	Hu1oitP20tH7YcFXUfkEwLVDYhvPXJ7f9bmnKtkCH5xgjYYUvDh2KoqGjRWgCrNg
	+fmxCXtm55h5yTdCne3VDRYzQsFQQKydrUkP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WqkChvYZiRUYJaYa/8+UBoIPPuQIritO
	eoSoBbwMjcHOlE6jvUHDMQYQvpHohw9FfwUTMzoS40vhZyPgvHtgRb625MJrUrxd
	wshqnHEUlCJ31jze6zslwvjNU1ol5ykyWKH6eZODJuUC0jHZdTFSQ/7DW3S6aZLa
	umy2f3H0geE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC22927502;
	Tue, 28 Jun 2016 14:49:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C91A27501;
	Tue, 28 Jun 2016 14:49:29 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	larsxschneider@gmail.com, git@vger.kernel.org,
	mhagger@alum.mit.edu, luke@diamand.org, vitor.hda@gmail.com
Subject: Re: [PATCH v1] git-p4: place temporary refs used for branch import under ref/git-p4-tmp
References: <1467012398-7357-1-git-send-email-larsxschneider@gmail.com>
	<5772C00C.6000403@kdbg.org>
Date:	Tue, 28 Jun 2016 11:49:27 -0700
In-Reply-To: <5772C00C.6000403@kdbg.org> (Johannes Sixt's message of "Tue, 28
	Jun 2016 20:21:00 +0200")
Message-ID: <xmqqeg7h87yg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B6868D4-3D61-11E6-BC75-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 27.06.2016 um 09:26 schrieb larsxschneider@gmail.com:
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -2274,7 +2274,7 @@ class P4Sync(Command, P4UserMap):
>>           self.useClientSpec_from_options = False
>>           self.clientSpecDirs = None
>>           self.tempBranches = []
>> -        self.tempBranchLocation = "git-p4-tmp"
>> +        self.tempBranchLocation = "refs/git-p4-tmp"
>>           self.largeFileSystem = None
>>
>>           if gitConfig('git-p4.largeFileSystem'):
>> diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
>> index 0aafd03..8f28ed2 100755
>> --- a/t/t9801-git-p4-branch.sh
>> +++ b/t/t9801-git-p4-branch.sh
>> @@ -300,7 +300,7 @@ test_expect_success 'git p4 clone complex branches' '
>>   		test_path_is_file file2 &&
>>   		test_path_is_file file3 &&
>>   		! grep update file2 &&
>> -		test_path_is_missing .git/git-p4-tmp
>> +		test_path_is_missing .git/ref/git-p4-tmp
>
> This should be .git/refs/git-p4-tmp, no? Otherwise, this does not test
> what it should test.

Yes, and it probably should use "git show-ref --verify" to
future-proof, instead of assuming the file-based ref backend.

>
>>   	)
>>   '
>>
>> @@ -352,7 +352,7 @@ test_expect_success 'git p4 sync changes to two branches in the same changelist'
>>   		test_path_is_file file2 &&
>>   		test_path_is_file file3 &&
>>   		! grep update file2 &&
>> -		test_path_is_missing .git/git-p4-tmp
>> +		test_path_is_missing .git/ref/git-p4-tmp
>
> Same here.
>
>>   	)
>>   '
>
> -- Hannes
