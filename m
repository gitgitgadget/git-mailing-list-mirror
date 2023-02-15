Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1E0C636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 19:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjBOTc0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 14:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBOTcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 14:32:25 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2069.outbound.protection.outlook.com [40.92.48.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25A13C79F
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 11:32:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0q7TFj7t5P2mQqTP0hy135u8R0lhqFP8IS1R0ANKaigcPp7lCOoQpMZYOVLw//R0l6J5kx7CKs3LMaWKBdFIJ9JyzQMjGIioqeXtHJC7AgSMHUpf8kPedSV7Wu+OUGG8RifdrC8NsvBDUP2q8I7otFm3AR1EReTZnBmlSNI//4ScUY+n0SKOONCqO4TmGaF9abzkr3FqU4lvSAMyuLXT1n7aerZrsbqqaipvMp4i3lZMdZB4s+rXZswtjgf3nIujGs7Qlqp3yciJRCi29OV8Ica6PKuAevKOscSAa0I8heDavqyjZjcjfU/pJHJkpyH2GWeBfMyo51cXdnoOq4rXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVkT80QddLxAu0x9Iy8c2GmrjXwtH8GbVSzokq7q8bU=;
 b=YzSdjMfDx5hudVFBWZELrXCvanqUWSacCp2camzkibGcqRQ3TyDREvQMOt4v6WkHIW4112oz1gXOQBqxwuTpph+fB6rJjKIVvAVsfdYNzR3Rk5jD0KETcn8KBgOT8HnnEMxHDupiCfezqml6yVnfpFUxJ+4Wx/asjnsy6b6zQSgYWtOUSu4/nDaIocmt0OpODpHJO9b25P1fM/FoC4Fv0RzYUy0kkXfwz/dbkM5N9X6kdANWujcHk9zWCfe1d1k3fcQhU3BAjP6m5kOdCZgcI+Giw3vtuwWzbfXJJ5goCSyPWp1N5a4XSDM1lB3NQGFvDHUNK05YWeLmCD6i25LD1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVkT80QddLxAu0x9Iy8c2GmrjXwtH8GbVSzokq7q8bU=;
 b=j77+2CM41guF1vrDkiCkohRv62/LJrOXL0LtDX3ihxrNDk9MPXdEcSH5q3iuoSvQSoQVAyo32akEscEBC3jZPKSFPvQx4ypGD+LooKwSKF5m25ZMFvgvxIqYqaAGsSHL/UqwqQ4Vsf87Hxs2gZjs7ei48Dgn008uWEIc/0nA9VrOAWXgaYzHeAsoITU4Yeb0oz7VRGvB3o53i4/b0tGhBPFc74ZYKTPpkrj47rdv4Rdowg61S1/rPRLo62ruQV7BIoMSCdYgMxvkpw1EM59Hz5N0qyAg7QXjFlTu+uHuiowMhech6gJ1oqr98x6GKMNI3LYDNuEGu6fp9H2Hb6g1BQ==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by DBBPR03MB6715.eurprd03.prod.outlook.com (2603:10a6:10:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 19:32:19 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::7674:1fe5:785:a469]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::7674:1fe5:785:a469%8]) with mapi id 15.20.6086.023; Wed, 15 Feb 2023
 19:32:19 +0000
Message-ID: <AS2PR03MB981540DF75A83F637F715463C0A39@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Wed, 15 Feb 2023 11:32:11 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v8 1/3] t5563: add tests for basic and anoymous HTTP
 access
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>
Cc:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
 <d362f7016d34c4803adf42a88012997c66e0bde8.1675711789.git.gitgitgadget@gmail.com>
 <87f79e79-1591-ca28-4975-3bca5b8f7266@github.com>
 <230209.86v8kbvz51.gmgdl@evledraar.gmail.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <230209.86v8kbvz51.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [2zRJiOf/RZC+55PHqSFoq6AmGKU+BtyxSwDwKvDKvWDSz0TgZFkaL9qIhIGfdW+1]
X-ClientProxiedBy: SJ0PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::13) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <6338c441-66b1-94e2-2cc8-b48dbdff5d32@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|DBBPR03MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b839eb-55a1-41dc-77b1-08db0f8b5a34
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYIcQK8y9Sg1aXDvQIkKZTxXCRSpWZUZvDqZ7O0oUurli83I+0Vn9Q54kqdaUxrBuRH50y8F/n/z6ioK+7HdNXLCdg8q2S1iRfKTbFTRvA/ZMtRT8N4pOVxDDiXsQDtemzjekM+GnOjTAaKNXXiDZHWzqC2l5dRD/5xLTvlV5UBasXWJz1nlc1uhcA6c7qCxuopT2dJPKwkpQhlZnj4MXJgUvTFj4j2hIU5qQhc3AXnD/SLLHCNSKJH8g4lcpxXuBqYjBAD+sUtTNNxYgncutvcnrku04D690UkXtkMBjdNbLreo/iJuWbd5zqC/YDUM0BCTUOmLLgGUtJFGuSVg7h19PBNskHV18Trhtg8NjT7njnrE00PbvT9KMkFeQ+WjTZFgrBUBlNe5lQRparCGL5rK6GNyPz1PbsiWcooElcsJj/e0qEcx3caUPryKyJwbcuz5ll3kf57bbOSFjWQHxvmB/AC2xogP6JUmXe6y+MJppg1uK1Y8MncFFuQ2De7/ahWF6ggPjA1MMKXBFAY+KT5nISyY9/lTPEtTrlCZQDE0VTRk0zVgctAILxNOHZ5U9fv3zVHcim7Ej8ng2UyJXfBKwmodwtrF810jhNvACO5B53y1WXMCgdbfuBzfyS0oDNVXygyeEavFsw+6NV4NASn2oLifevDaAwyPPWK+Qv8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlVRQ0dpSXA0TEMxb3NmOEcyUXNKcGxna3JqdkJjZWhNai9CUkZHejZpRXNR?=
 =?utf-8?B?T2Vrby9mSlRTazNseUE4Y3BXMUVDZTdERlk2SWExNHpRZ1RoNThFY0pQMlpK?=
 =?utf-8?B?Z0Qwbm9GbjhNRm9jMENaQ3FVOFJqTEp3TE15YitBTTdpWkxGV3AyaWYrNVg1?=
 =?utf-8?B?Zi8wV3k0RnphTG9reWZucy9wVzZOYVBjbEdMWVlVMWJTNkVYcWZ1TFJxQzFF?=
 =?utf-8?B?V2RMdzNRa29HamVKbngwNDBxQWp0UFVvb2w0RXBxVUJ4Q2kzN0t5RW5mbVFK?=
 =?utf-8?B?NWNFaGFMTVRQTnlydFlqYnRvY3VLbk1RM2taMjJST2dVMnJ6WW9YZzBKM1d5?=
 =?utf-8?B?Ymx2SXZ1aUthZlFmZHVmVzQxQTY4SVJsb0k3c1poL2x2TlZpekY2V1hjaWh4?=
 =?utf-8?B?cEZQUlVGMkJSR3ZySTZBOFFpbWk4cS83K2FwZ1hCU29xUHh3a2dlWWRrZTBU?=
 =?utf-8?B?L3IzZnJ3RDltTDhNUVA1dGFTQWJmeFAzMjRIL3lzSnRKZVJwMHFmTmx5NXdn?=
 =?utf-8?B?THFkTngvL2UyQlBoZDNmcStFZmNtZjlZSTFPR2JmSmZ4MUFPbGx4SXZFbUN5?=
 =?utf-8?B?M0F4eVFVYmU1cXVaZk15cXRrYlptWXhNSVZsS05yekdkUjFuT2ZneEtPUDBB?=
 =?utf-8?B?Q1FKYUxWNUhhbGdKdkppZTQzQWRuMzdmT0NJQVZ4ZnJocGpUVmhtb1F4SWta?=
 =?utf-8?B?WUFlTWdCSzBXdnRxRnlUZExuZk5XODJkMkxwWEw0OFJNZG1RMnNYWmZhR3Jk?=
 =?utf-8?B?aFpsTnVTZXZTOHNPUis4cCtMLzh4VzVadlV4TjR6d3V2eHI4bndKUFNWTTkx?=
 =?utf-8?B?YkZBTW9TaERmdGEwcUd1SGMrVk12cTVXc2UwWStIYndKNEVrSjBIb0t1c3NF?=
 =?utf-8?B?VnNmOG9mMkRZUEJITUljSzNGNVlJaml5QUJFQXFwTkxvNUlnWXdEV3MrK3ps?=
 =?utf-8?B?TEFkWUtUZDhDN2tQOEhsZFVwWFpWZW83YlNGNmxYZ2xiU1ZJazBmY09IVStq?=
 =?utf-8?B?eDNSV0JHYXhraDE5WnhoT0QyYUMvd3VDSjNaWlU5ZzAvYm9ScitpLzVzMXNG?=
 =?utf-8?B?dlc3aFNpcnpxNkpTYVo4RVBKQlc5VHFLVms4K250S2h5ZkNWWGJrd2tEOE9F?=
 =?utf-8?B?ZjZRNWkxRFduN2c2VXNDNGlWV3BQMWlMWkNYbEhhZTQyOFZWZ3hnclpUUW5R?=
 =?utf-8?B?TjJ5NnRtTTdmbytTaUY3ZDdsRlZoS2hzNGVMa3p2RmJlekVnYXoyVG1TYVVB?=
 =?utf-8?B?TUFHQ1dtSTZCaWJzeExWYmtIektRMlMwY0RKam5Xekwya2JVYnlRWVcyUlc3?=
 =?utf-8?B?YUFNUDFFVjM1M29pMjJGZUwzOFpVcC9OWVd2VTBCZk9MQ1dmaEZiZFdYQTV5?=
 =?utf-8?B?eUpEWUxGUkpCOG5vOGlXVnEyMmV5Rml6ZlcvL1paVmw1QlI1VCtoMXpBSGJk?=
 =?utf-8?B?OVF4alJxdHdBTldQcVNXa0VjVmlpSklrcVR1VjVzdEsxb1UwMitHd1VHOWth?=
 =?utf-8?B?dkZFdjdzZkFSRFJiZWRWZmgzZlpDcG1HeVFIaGVpVmgycUlIWkx1ai84TWZZ?=
 =?utf-8?B?WUt6MSs1Nk9TRUhuYW9QTnk0WDdRWmlFVHNidUE3L0dQRmQ1TUJQMHpPS3My?=
 =?utf-8?B?ai9Sd1V1Nlhxcjg1b3o2TGxOQ0NUYlBFRWZMbjBwODh1N3lBRDdoalF6c0dj?=
 =?utf-8?B?QkhQZHlKbFdaT1VTeHgxY1V1S29Rdy9IWW1NYVhIUXFZclFiNXhFZlFQTUlM?=
 =?utf-8?B?KzRGbXlxRGV4eWZvREo5T2JseVZLcDVDZnNXNjlMTSsyRGE1clpDdGNWMkJo?=
 =?utf-8?B?cEZNcVZ2Z0Z1YWtjZ1U0dz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b839eb-55a1-41dc-77b1-08db0f8b5a34
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 19:32:19.8660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6715
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-02-09 03:19, Ævar Arnfjörð Bjarmason wrote:

> 
> On Wed, Feb 08 2023, Victoria Dye wrote:
> 
>> Matthew John Cheetham via GitGitGadget wrote:
>>>  ScriptAliasMatch /one_time_perl/(.*) apply-one-time-perl.sh/$1
>>> +ScriptAliasMatch /custom_auth/(.*) nph-custom-auth.sh/$1
>>
>> This setup (redirecting '/custom_auth/' routes to the 'nph-custom-auth.sh'
>> script) is nice and straightforward. 
> 
> *nod*
> 
>> [...]
>>> +if test -f "$ANONYMOUS_FILE" || (test -f "$VALID_CREDS_FILE" && \
>>> +	grep -qi "^${HTTP_AUTHORIZATION:-nopenopnope}$" "$VALID_CREDS_FILE")
>> [...]
>>     if test -f "$ANONYMOUS_FILE" || (test -n "$HTTP_AUTHORIZATION" && \
>>     	grep -qsi "^${HTTP_AUTHORIZATION}\$" "$VALID_CREDS_FILE")
>>
>> Note the addition of '-s' to 'grep' - it seems cleaner than redirecting to
>> '/dev/null' (as Ævar suggested [1]) while achieving the same result.
>>
>> [1] https://lore.kernel.org/git/230206.86fsbi5y63.gmgdl@evledraar.gmail.com/
> 
> I wondered if it's in POSIX, turns out it is!:
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html
> 
> But we don't have any existing use of it, even for things in POSIX it's
> often a gamble what the exact semantics are on our long tail of *nix,
> e.g. old AIX.
> 
> In general I'd think we could just avoid "-s" or piping to "/dev/null"
> here, i.e. under "-x" or whatever it's informative to know it doesn't
> exist from the stderr, but on second look I think both of us long track
> of a larger issue here...
>> [...]
>>> +fi
>>> +
>>> +echo 'HTTP/1.1 401 Authorization Required'
>>> +if test -f "$CHALLENGE_FILE"
>>> +then
>>> +	cat "$CHALLENGE_FILE"
>>> +fi
>>
>> In contrast to Ævar's comments in the review linked earlier, I like having
>> the explicit 'test -f' (to sort of "self-document" that the challenge is
>> only issued if $CHALLENGE_FILE exists). I think you're fine keeping this
>> as-is or changing it, depending on your preference.
> 
> Looking at this again I think we should just have it be unconditional
> here. I.e. it looks like we both assumed that this needs to be a
> conditional, but actually every /custom_auth/ test also sets up this
> "$CHALLENGE_FILE".
> 
> So this "test -f" seems to only serve the purpose of burying an error
> under the rug if things have already gone wrong.
> 
> But if we're making these requests why are we writing a script that
> handles the combination of 3 parameters, and needs to second guess
> things? We can just create N urls and N scripts instead. So I tried this
> fix-up instead:
> 	
> 	diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> 	index 7979605d344..c25e3000db0 100644
> 	--- a/t/lib-httpd.sh
> 	+++ b/t/lib-httpd.sh
> 	@@ -141,6 +141,7 @@ prepare_httpd() {
> 	 	install_script error.sh
> 	 	install_script apply-one-time-perl.sh
> 	 	install_script nph-custom-auth.sh
> 	+	install_script nph-custom-auth-anon.sh
> 	 
> 	 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
> 	 
> 	diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> 	index 2aac922376c..7a63a9169c3 100644
> 	--- a/t/lib-httpd/apache.conf
> 	+++ b/t/lib-httpd/apache.conf
> 	@@ -140,6 +140,7 @@ ScriptAlias /error_smart/ error-smart-http.sh/
> 	 ScriptAlias /error/ error.sh/
> 	 ScriptAliasMatch /one_time_perl/(.*) apply-one-time-perl.sh/$1
> 	 ScriptAliasMatch /custom_auth/(.*) nph-custom-auth.sh/$1
> 	+ScriptAliasMatch /custom_auth_anon/(.*) nph-custom-auth-anon.sh/$1
> 	 <Directory ${GIT_EXEC_PATH}>
> 	 	Options FollowSymlinks
> 	 </Directory>
> 	diff --git a/t/lib-httpd/nph-custom-auth-anon.sh b/t/lib-httpd/nph-custom-auth-anon.sh
> 	new file mode 100755
> 	index 00000000000..3c7a24fed6b
> 	--- /dev/null
> 	+++ b/t/lib-httpd/nph-custom-auth-anon.sh
> 	@@ -0,0 +1,4 @@
> 	+#!/bin/sh
> 	+
> 	+echo 'HTTP/1.1 200 OK'
> 	+exec "$GIT_EXEC_PATH"/git-http-backend
> 	diff --git a/t/lib-httpd/nph-custom-auth.sh b/t/lib-httpd/nph-custom-auth.sh
> 	index 8f851aebac4..e3ee61c8c9e 100755
> 	--- a/t/lib-httpd/nph-custom-auth.sh
> 	+++ b/t/lib-httpd/nph-custom-auth.sh
> 	@@ -1,28 +1,15 @@
> 	 #!/bin/sh
> 	 
> 	+set -e
> 	+
> 	 VALID_CREDS_FILE=custom-auth.valid
> 	-CHALLENGE_FILE=custom-auth.challenge
> 	-ANONYMOUS_FILE=custom-auth.anonymous
> 	 
> 	-#
> 	-# If $ANONYMOUS_FILE exists in $HTTPD_ROOT_PATH, allow anonymous access.
> 	-#
> 	 # If $VALID_CREDS_FILE exists in $HTTPD_ROOT_PATH, consider each line as a valid
> 	 # credential for the current request. Each line in the file is considered a
> 	 # valid HTTP Authorization header value. For example:
> 	 #
> 	 # Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
> 	-#
> 	-# If $CHALLENGE_FILE exists in $HTTPD_ROOT_PATH, output the contents as headers
> 	-# in a 401 response if no valid authentication credentials were included in the
> 	-# request. For example:
> 	-#
> 	-# WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
> 	-# WWW-Authenticate: Basic realm="example.com"
> 	-#
> 	-
> 	-if test -f "$ANONYMOUS_FILE" || (test -f "$VALID_CREDS_FILE" && \
> 	-	grep -qi "^${HTTP_AUTHORIZATION:-nopenopnope}$" "$VALID_CREDS_FILE")
> 	+if grep -qi "^${HTTP_AUTHORIZATION:-nopenopnope}$" "$VALID_CREDS_FILE"
> 	 then
> 	 	# Note that although git-http-backend returns a status line, it
> 	 	# does so using a CGI 'Status' header. Because this script is an
> 	@@ -31,12 +18,15 @@ then
> 	 	# This is only a test script, so we don't bother to check for
> 	 	# the actual status from git-http-backend and always return 200.
> 	 	echo 'HTTP/1.1 200 OK'
> 	-	exec "$GIT_EXEC_PATH"/git-http-backend
> 	+	exit 1
> 	 fi
> 	 
> 	+# Output of our challenge file as headers
> 	+# in a 401 response if no valid authentication credentials were included in the
> 	+# request. For example:
> 	+#
> 	+# WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
> 	+# WWW-Authenticate: Basic realm="example.com"
> 	 echo 'HTTP/1.1 401 Authorization Required'
> 	-if test -f "$CHALLENGE_FILE"
> 	-then
> 	-	cat "$CHALLENGE_FILE"
> 	-fi
> 	+cat custom-auth.challenge
> 	 echo
> 	diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
> 	index a7b1e5bd1af..feb8149de8f 100755
> 	--- a/t/t5563-simple-http-auth.sh
> 	+++ b/t/t5563-simple-http-auth.sh
> 	@@ -47,8 +47,7 @@ test_expect_success 'setup repository' '
> 	 
> 	 test_expect_success 'access anonymous no challenge' '
> 	 	test_when_finished "per_test_cleanup" &&
> 	-	touch "$HTTPD_ROOT_PATH/custom-auth.anonymous" &&
> 	-	git ls-remote "$HTTPD_URL/custom_auth/repo.git"
> 	+	git ls-remote "$HTTPD_URL/custom_auth_anon/repo.git"
> 	 '
> 	 
> 	 test_expect_success 'access using basic auth' '
> 
> I think that's much better, now we just have a 2-line script to handle
> this "anon auth" case. Instead of creating a "custom-auth.anonymous"
> file to communicate how the remote end should behave, let's just
> communicate that by requesting a different URL, one that accepts
> anonymous authentication.

Actually, we don't really need to test the anonymous auth case at all
because all other tests that try accessing a remote repository over HTTP
are already exercising this. See t5551-http-fetch-smart for example..
here we're performing various requests without auth.
Should we be erronously issuing credential helper challenges in these
scenarios then the tests would fail with an askpass prompt.

I will drop the anon auth test and script support.

> I did insert a deliberate bug here, or:
> 
> 	-	exec "$GIT_EXEC_PATH"/git-http-backend
> 	+	exit 1
> 
> So aside from your "exec" comment it seems both of us missed that this
> "exec" does nothing useful, the test will fail if we emit different
> headers, but it doesn't matter that we execute the git-http-backend.
> 
> Or maybe it does, but the tests aren't good enough to spot the
> difference.
> 
> The above is a rough WIP, I'm leaving it here for Matthew to follow-up
> on. I think it might benefit from being further split-up, i.e. we know
> which URLs we expect to fail auth, so if we just had another URL for
> "the auth response fails here" we'd have 3x trivial scripts with no
> if/else; but maybe that sucks, I didn't try it.
