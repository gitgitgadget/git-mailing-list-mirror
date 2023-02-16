Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F220C61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 22:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjBPWZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 17:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjBPWZf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 17:25:35 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn0823.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::823])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3F13D0A3
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 14:25:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjuAFm1MfNYNMgeoEX2jYKEO9a5aOGSJewfTCiBdP+Q/np2gza9OYq8fP88HAAM3E9Bxva5Z7TevQAX8/+bHzsYUW8by6qqtJwn+D6yJcdVDQ5ov8LMyEQHQZ1wQsLoRPk9RJhG43TXCUc37C/Sdw/wMw/4dkh/Kj/OCm0kGtdtckOAh2peeOZegN7C++tYUTTlIFVKvW7In+kLecoFFadnuOCVwUbIz1W6ymkfJEWnbPnHdEU3gz7q3oNNFXUGSfmiY8jYhSUZgCmDN5YStqhnpgntwz2EbsmD4q61g9gn16Uq9U3X20RWEBte5k9kuKYIXDhMVyBDs+FR1GEXL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJKuZJ9Im1OQzplp0Sd+VYK56cubxPyn5D7VJ5NnsfQ=;
 b=nRnhwwaaQeYmTHV94CaKwbgOyEpq36mEkf8vxS8ZHIDxYECWAooLof6L0tq8rJvbkdYqLKp/jLyg62LZMZQ6PXUclrptCDRPtha73PH/kljDHPgFzSyHXbIE13RVVZN8hgrq9FszDRTXc7LLxz2ykUOMAOKH4mq7yHGm4W6s3k0/tYrc97JYpzZLK4pDG9Q+2IOifwARxamRDGjqmHlEWyV7h0iaN6ZAoTnLz5x8czRsJsJNiYao8lG8rJHh0rg+WQzhg3WDEnFmjnv2OuqFjqtrHGmDA8xN2EHeGls3JRVg2XHfFYEyhdRyyvzMjngkl9bTJTp3MfDmKGitqFIYeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJKuZJ9Im1OQzplp0Sd+VYK56cubxPyn5D7VJ5NnsfQ=;
 b=hXj4rUtdhygQIF2guiuuwf+aAHnO96cYfepGt2im4mIxkULFImEGJZt4tEVoTwtf67aqFgiWgsSQkVWTMwev1yE0oQaXCcorZceIcCsKCZhfgaXiGc26NY1P2vw53VOwzzHh/BPRPI0vpIvEnTUURU3HcNDdJT0vyuwNHD65iXo3Z0CA5UVPeLFv5RpODuB9lji0Pu9nO+eDmu4ZuwSaTtJl9H6lRvCUtX/XIV4rRlouKjBUOOnmFPpKPenqb9yqEpTzt+bvhguGVbNkBzsOJ4xTcWt4+P8K9M+KMFYglIvS8NTIRohTfO8xACkYYyFoRcub2woL88zlouqPKIWjPg==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by DB9PR03MB7195.eurprd03.prod.outlook.com (2603:10a6:10:1ff::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 22:25:25 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::7674:1fe5:785:a469]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::7674:1fe5:785:a469%8]) with mapi id 15.20.6086.023; Thu, 16 Feb 2023
 22:25:25 +0000
Message-ID: <AS2PR03MB9815447A4B519DE1ECC29595C0A09@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Thu, 16 Feb 2023 14:25:16 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v9 1/3] t5563: add tests for basic and anoymous HTTP
 access
To:     Junio C Hamano <gitster@pobox.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
 <pull.1352.v9.git.1676496846.gitgitgadget@gmail.com>
 <05449ec892b1205c1e1c90d15facd812b5cbbe3c.1676496846.git.gitgitgadget@gmail.com>
 <xmqqy1oywp78.fsf@gitster.g>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <xmqqy1oywp78.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [25pireOQ8YijUV1M1dlr+qiH2Ju+mJZrOuRvSzs8I21xmMWq4BlM0ulKz9GMkb5Z]
X-ClientProxiedBy: BY5PR17CA0045.namprd17.prod.outlook.com
 (2603:10b6:a03:167::22) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <cae964d6-fab4-8505-4359-3b13cfc4d2dd@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|DB9PR03MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: 67050d7f-3adc-426d-c63d-08db106cb2bb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnjtWSgr5y1MSbDqCu0bXAHHMPSO8fO8ZzCWkMpsnj11jZtZmg10MdcM8gl28W4a7Gn/nm66ok9KTTmfnPjeha9O3dWVYSrMqlugVATo+UgPqdhsKPcR2QfIMJUIYdItSMspwTTfxi4STM+6k81/iR/7F2ejVLFghnO20VbHtz8V7BtzfLRd63yHuNBFzOTNlmgziQPZkVKiarjJlbt/A+PbrC3rwMBuBllFWhmVHgm1yGHBNKW22qAlGuo182xf+GHa85i6lP9nzx8FDpdxGsf95WHJ459bpXmc92SrfJDjIU6y4dSfHy1QcTH+ojYF0bzHFI/HCOI+ySivcU35/CkQYo9eV088RcQoDNa/yMT1wJDyh7KAQbzYNGNLny3f3YE6zF/CzwpSE3G7n1JpHzoHXBOwvXIBR8oQN+S6Qh4ImGIpEjjv0E7o7vCILECrRXvyBxTA0b7LpLo1KU1IuWzDjhVqFa505fJPkD2dqScof5O/FNvi1kHGxT8538My8SPv9IvBsAd9nRtL6OThhDo5StEdtrU5d9gLIWiBU3lxS2eDjyJrMLXWDYJd8KQO9EFtivnDFUhmJdg1HPJySQ2Q9NLKaRGfogJw9kgSqHuBxEX4wzI3rJV2tMrVBdFWpYm4JEtYc/ZXg9mMqnm0/A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmYrSWJMRHFiS1FRL2tQUWFpeklWWGZnR1NieW5KNS8wYVhwNlZaQWpyOS9Y?=
 =?utf-8?B?cFRpTEJEMUhoci9LbFE0eGpaMFlIMEsvS2V2Ni92VlFvNG9WNzR3WHE4SVhs?=
 =?utf-8?B?VE5lT3oxa3loYVVqTjRsRWRUV0dlQ1IybGZPcmZjMlRKNXVxRmtzV245RDJn?=
 =?utf-8?B?R3hyS0R4Skd0dnVEdElyNFA3dHp0NndHNUpuOWk0Nm1SRms2RjBwS1BESHJu?=
 =?utf-8?B?MEZqWjRFRGI3TnRMUFJ2TmwrQXdwZXlkZ1RHOExaTC85WW41T3ZGaklVRmVk?=
 =?utf-8?B?STNYNjh1OG1KZzFxdWROWWV4eHNOeXhEaHNlczNDalRIZlM3RjZYRjdCZWVl?=
 =?utf-8?B?c1FiSXFmMk9NMFZnQ2E5aUMzOVlOOTBoTndERC82QyttRWtNK0ZSSmJTR1li?=
 =?utf-8?B?emJUKzNtNlJIUjduZWhmcnYrdDdkQzltS2ZlbC9ta0dkeCt5VW9GNW1LeURR?=
 =?utf-8?B?cUtKUWZPV1ZiT0MrcFJLb0NRMThZZFdFUWZiSGQxeWFCdlNkUi8vK3VERWla?=
 =?utf-8?B?QmdoV1FrVkhRTHM1L3hYeEhJaGxPZXhsQ1hvRkw5RmlBY21WNys0ZkQrbEU5?=
 =?utf-8?B?a25LNGRJT1lieTFaMng4UmNqVGdodm00YzFzVm5XRXpzQU5VZGVWWllCVUo2?=
 =?utf-8?B?OWxJUFhnb2tBa1cwdVZaSzRQL0JEUXNBUW5ORFdOdG1za05UeTcwTjRKZmRQ?=
 =?utf-8?B?RlpJNlBoRXRIVVFNbFpXVkRGeEwzV2crZHcrWHp1UFZJQ0xUZHJMcVVoYjNW?=
 =?utf-8?B?N3RCNVZ4QlJqbGFEV2dxc3VFZmQ5WHRreEpzUDBDZ2VwcTBMZzFVTXhQRTcy?=
 =?utf-8?B?cG9PZG5LV2htaHlKQ0NjdVRyeDVmRHNNcStQVXFNOWVaRW9GZTlDRUR3Q25P?=
 =?utf-8?B?a0hBSjNmeXlCTWFGNlloci8zeGVKRmgvSkRRcnZvOW9hZVhCREkwdzB0N0RD?=
 =?utf-8?B?V0dVUndxR21jU3k5eEk4NUJKdTJSZGFNdU5aL1d3UHRzaGtFVU91OGFIdGhF?=
 =?utf-8?B?YTZZWlFvTTNFTU9FcHZ0Q1lUcjRTWWZ6UkxLbzBCZGhtdlRMTkFUeEFzOGN6?=
 =?utf-8?B?UStVZDgvVXY3RDJJQWZaTklaR1oxRjQ5TDNHT0hVWVdjWFI1a1JRSldWWFFN?=
 =?utf-8?B?ZzNlQ0pWMHFJME9GcmpPaWRZdzZRSXVXdnNST1BRbm1oRUhUVzFwVFhFMHAv?=
 =?utf-8?B?VzV2SUFnai9aZnpPb2VLWjRicCt6ZWpXVHRtb08wZk90amJZNmZFUHRCWUFM?=
 =?utf-8?B?UDFFbWF2RUgreEZuWnRTTzJMV2xCaWxWbXBVRmZzcjg5ODBIUEtsNzhFaURS?=
 =?utf-8?B?dTdXSFdTNEdyY1doSHFHeE8vM29VRXJTQ2Fmc01uOTFjREE0ZmVnOGhWNFpp?=
 =?utf-8?B?cUdVR2F5Q21MSlNQWGdxbTZJM2t2ODRjYW5qeEdkWlJ2YTlEeVAyS201MXRr?=
 =?utf-8?B?dTBMaHVBaXAxNkRud3YzdXJ0SVRUUEJETFBjT0JDTlNFSVUzbEJ2NVAzR2FY?=
 =?utf-8?B?OW81YmRFOThFL3lhTE5ZelkwZ1BSdExYZXFHbzFCYVl4Z2ZxUzJCZjg0QXh5?=
 =?utf-8?B?bHNBSWtLSm40U2pvcFd6aHA3ckpwQ0lXQ3gwTW9IMDZpSmxhLzJQQW00eTE4?=
 =?utf-8?B?SjVxMFJFVHdzQjEwcHpJTXJjaVU4Qi9hbDVSVVhRZEJpR1dJVmd5THVUY2dP?=
 =?utf-8?B?ZC9rRGM1ampuNzBlWStJVTZCYlJyay9YREZja091QmFSUUVldlZaazdQY0sw?=
 =?utf-8?B?MjQyeENFMEtKS3cybUlyWUxVMHVCNUhGKy9COG51QWZRWE1EM0xuM3lqTjU0?=
 =?utf-8?B?b2J6NHhnZlNLUnJZODV4QT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67050d7f-3adc-426d-c63d-08db106cb2bb
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 22:25:24.9390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7195
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-02-15 14:15, Junio C Hamano wrote:

> "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
>> +if test -n "$HTTP_AUTHORIZATION" && \
>> +	grep -qsi "^${HTTP_AUTHORIZATION}\$" "$VALID_CREDS_FILE"
> 
> Do we require a regexp match (and worry about metacharacters in
> HTTP_AUTHORIZATION variable), or would we want to use "grep -F -x"
> here to force match with the entire line?

You're right. We don't need a regex match here. Will fix.

>> +then
>> +	# Note that although git-http-backend returns a status line, it
>> +	# does so using a CGI 'Status' header. Because this script is an
>> +	# No Parsed Headers (NPH) script, we must return a real HTTP
>> +	# status line.
>> +	# This is only a test script, so we don't bother to check for
>> +	# the actual status from git-http-backend and always return 200.
>> +	echo 'HTTP/1.1 200 OK'
>> +	exec "$GIT_EXEC_PATH"/git-http-backend
>> +fi
> 
> OK.  That's the successful auth case.  Otherwise ...
> 
>> +echo 'HTTP/1.1 401 Authorization Required'
>> +if test -f "$CHALLENGE_FILE"
>> +then
>> +	cat "$CHALLENGE_FILE"
>> +fi
>> +echo
> 
> OK.  We'll just give a challenge.
> 
>> diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
>> new file mode 100755
>> index 00000000000..e0682039de7
>> --- /dev/null
>> +++ b/t/t5563-simple-http-auth.sh
>> @@ -0,0 +1,81 @@
>> +#!/bin/sh
>> +
>> +test_description='test http auth header and credential helper interop'
>> +
>> +. ./test-lib.sh
>> +. "$TEST_DIRECTORY"/lib-httpd.sh
>> +
>> +start_httpd
>> +
>> +test_expect_success 'setup_credential_helper' '
>> +	mkdir "$TRASH_DIRECTORY/bin" &&
>> +	PATH=$PATH:"$TRASH_DIRECTORY/bin" &&
>> +	export PATH &&
>> +
>> +	CREDENTIAL_HELPER="$TRASH_DIRECTORY/bin/git-credential-test-helper" &&
>> +	write_script "$CREDENTIAL_HELPER" <<-\EOF
>> +	cmd=$1
>> +	teefile=$cmd-query.cred
>> +	catfile=$cmd-reply.cred
>> +	sed -n -e "/^$/q" -e "p" >>$teefile
>> +	if test "$cmd" = "get"
>> +	then
>> +		cat $catfile
>> +	fi
>> +	EOF
>> +'
>> +
>> +set_credential_reply() {
> 
> Style. Have SP before "()" as well as after.

Will fix.

>> +	cat >"$TRASH_DIRECTORY/$1-reply.cred"
>> +}
>> +
>> +expect_credential_query() {
> 
> Style. Have SP before "()" as well as after.

Ditto.

>> +	cat >"$TRASH_DIRECTORY/$1-expect.cred" &&
>> +	test_cmp "$TRASH_DIRECTORY/$1-expect.cred" \
>> +		 "$TRASH_DIRECTORY/$1-query.cred"
>> +}
>> +
>> +per_test_cleanup () {
>> +	rm -f *.cred &&
>> +	rm -f "$HTTPD_ROOT_PATH"/custom-auth.*
>> +}
>> +
>> +test_expect_success 'setup repository' '
>> +	test_commit foo &&
>> +	git init --bare "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
>> +	git push --mirror "$HTTPD_DOCUMENT_ROOT_PATH/repo.git"
>> +'
> 
> OK.
> 
>> +test_expect_success 'access using basic auth' '
>> +	test_when_finished "per_test_cleanup" &&
>> +
>> +	set_credential_reply get <<-EOF &&
>> +	username=alice
>> +	password=secret-passwd
>> +	EOF
>> +
>> +	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
>> +	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
>> +	EOF
> 
> Perhaps we want to note that this matches the "alice:secret-passwd"
> we prepared earlier?

Good point. It's helpful. Will re-introduce.

>> +	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
>> +	WWW-Authenticate: Basic realm="example.com"
>> +	EOF
> 
> OK.
> 
>> +	test_config_global credential.helper test-helper &&
>> +	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
>> +
>> +	expect_credential_query get <<-EOF &&
>> +	protocol=http
>> +	host=$HTTPD_DEST
>> +	EOF
>> +
>> +	expect_credential_query store <<-EOF
>> +	protocol=http
>> +	host=$HTTPD_DEST
>> +	username=alice
>> +	password=secret-passwd
>> +	EOF
>> +'
> 
> OK.
> 
>> +test_done
