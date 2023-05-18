Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38E1C77B7F
	for <git@archiver.kernel.org>; Thu, 18 May 2023 01:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjERBLd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 21:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERBLc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 21:11:32 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702963AB6
        for <git@vger.kernel.org>; Wed, 17 May 2023 18:11:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsyMFp6oY052yiAuYmJHmajnARYkfeE9tfs2OG+i4kHutHSWE3tsqrANxd5jOL8q3SKZB/WRQyjIGeWPfOeWkf7WaUnGRiTzN4Pop/rvkmzIDv2a56nh9W1pUdr39+zi94kqmVI9ENKiq4grTok23cFitZyNg7OywkphPcOMIUbxj4GdDKhIGuoB5KFvqgSmGttxCwsgpkqpeAdkJQVAIQ8S+149MnsM6w+C/sMntjOn4c6zWQyQWzTJrK1X77hrleMCDwZaKAP2mymCd3k4n6A4FZKBlAKNowBX5xxej66sqLjaDGimfHwTH06Qks76/pLooPGf2lDoHBvj2TuocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0C1DxkhH8aLFa+SP5pWwWrYZi3PlGVap7e5rFcI6Z8=;
 b=Od0km6XE+cfHrtczgtUS/6rXMhQMSqhMQWPNW3PX0WN5MusRF/ezUdYZhozzM/GgDRSeXjoxf2FmL0PEYQS+4VYfT7BNDA5jM471bPmditevxFXDzUPZCe354QSjo3BS/3e5QiWrjD3lywGlT8QegoskMH86TCRnT23fh24H9gFUBeCCzM9m3uMlmuiCt3uVuRooLK77gywVhSkn6O20awMLc5LUaj4wileDtxJi//Jmx2xVXiB5Xv+JIm2MWKjZnjGK1CwMX4SErwa6+6eY8DipFTYfuXP6kkASUw+SX5kP/wfDGu7IRDDWbEuRTMwGYrKPolXfk3pnpHzcoN2OtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0C1DxkhH8aLFa+SP5pWwWrYZi3PlGVap7e5rFcI6Z8=;
 b=vH3DHPtcWXy+lUdxreXwZbA97mdBANBeCVou4VQZ7KdDQmWl/YdBEZPoBIob6+CJXSXIiPgw3sBXK8U4wah0pVw2mOuV99AqDIhmhpaGF9bCDYhFCtXmvZqOoPF3+1pF/99fEg4saUQgvpk1upxxWHNXzu9qYVStjFD4iDBOvNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 CH2PR12MB4923.namprd12.prod.outlook.com (2603:10b6:610:6a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.33; Thu, 18 May 2023 01:11:24 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::677d:1c63:3ccd:acde]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::677d:1c63:3ccd:acde%4]) with mapi id 15.20.6387.033; Thu, 18 May 2023
 01:11:24 +0000
Message-ID: <4f35223e-b7ec-8c0c-dc67-b419e47f7f5d@amd.com>
Date:   Wed, 17 May 2023 21:11:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] send-email: clear the $message_id after validation
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Doug Anderson <dianders@chromium.org>,
        Emily Shaffer <nasamuffin@google.com>
References: <xmqqzg62oe9c.fsf@gitster.g>
From:   Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <xmqqzg62oe9c.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1P288CA0007.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|CH2PR12MB4923:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7d17ba-6785-40bb-09b8-08db573ccca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zXTHBLH/GBrirjPovgQMFXFERfFX2Pm4IonojdvpT74oa8QdjjCGiVBpwP22USXxx3/ztAEiJrVKZ/TL3VEW2pY2BHuxmmv2T47V8Ysqu5nzL0zRzRzy2AhVR3n294g+ifaoVKIxJb+eMHto30OdrFzBROXmtcllrBtvPq2pMhcA6mdYv+dSmoqjV6TKDWo1RfAq4aRlziN50mk+nnqGnkJkcdAwLXSjWxQl7ccKPPRy+Vj0KhNahu0LhzKyzKFtz27mwOgWy+yXfcZnyouWugFNvc62xmocaqoOuet+9DdNBhFYM0ok+xeJneLsLK1AJBybccJKFboe1+sCqKwxbsLxDC1Oz5cq7pzk+wJjdoFH2j1Xg1f1arvsfgB7N6RUSlBQrHRIn9loc87Xi5ngNw4tGq+25xxKbhFW5nfL2N4X6IVHGqkmEgovD813ypptITNQ0HMu27Lew/9r+i622ZrkXnRIZ8jEGcmyE6WoCWAhl4rlvJu8YYnm2E4rAhQQw6fGnbe7+p0Gsy4kY/Vcspnaysuzt9zug7ACDn5CnDeWyMgrt7E2XY+QdoO7B64Rlh7b7L6Ectq/a5792G8cjH2Wg3Ai+fzmSLKGySIQhvWiOkvARZC3H+iH4NC/2PcC7bi84Tftq7uaFuvJYQUb1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199021)(36756003)(86362001)(31696002)(54906003)(4326008)(66476007)(66946007)(66556008)(478600001)(316002)(6486002)(15650500001)(8676002)(8936002)(5660300002)(44832011)(2906002)(38100700002)(41300700001)(2616005)(6506007)(53546011)(6512007)(186003)(26005)(83380400001)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGRJODhocTdlbm1CRTJ2bHR4TFFNWWEzSWs2MGFybEZGS2loV2d6WFBZNTBC?=
 =?utf-8?B?d1F4UzB0bnBtZE9PazMwcGlMc0FabGR3UE9ySUhRYjBaRGZScHJDblFGcEhG?=
 =?utf-8?B?TVFpb3NYQUIzVGtNcGVSR3JjRmw3ZlJTSHpJMThmR1l1ZTVOVDEzdzdLY1Aw?=
 =?utf-8?B?aG4zaEFrL1FwRnNnN2YxWm1zbEtZYUI4WDZ3OHVJS2Zta1Q2c3ZYWDhETkNu?=
 =?utf-8?B?MHd4cDRoNE5RU0FmMFVIa2gwMDdYbk51NE9qaE1WSEJJY242Ri9tRTlsdERE?=
 =?utf-8?B?aFRIWkFyRVZzcmpIandqVkY4eFVBOWF4QXg1ZWVnVFlud3RKb1lQdWZhWnMz?=
 =?utf-8?B?amlCeitVMTdXS293OS9objQ2LzEzRWVnOWpsUHBSQkxmQ2hKZjNVdkxaU0Fr?=
 =?utf-8?B?VE5NT2Q3c2t0b1g1UjNYbUZWNVJYcTIxSi9xakFKZmt1cXhrdGFDS011MCtl?=
 =?utf-8?B?WUJTcmhuVVhYS0JXcFlhYmd4dTVaOVF0VjV4bjV3M2FkQm50NkEyN0UrSkl2?=
 =?utf-8?B?WEw1eU1DUUpaRHA1a1dnYSt4Nm9zUytnYWpKR0JPRjEzQmk0UTBmUzFyZzlr?=
 =?utf-8?B?SjBuWUFCZ0w1Z2h3TzREUCtsb1NhTng4VnJlMjBlaVRCTGIwTUl6OEx4Q2lj?=
 =?utf-8?B?RTVlQmx1cnRMekhtbGtlVk9MMXltTm1KSWxlaU0rejg2aWVrTk9WSkJweCtC?=
 =?utf-8?B?bjVGZk5iUTNUWXFvTVNNdDRIamdIWVBlUi9kRDBRRTM3WGF2N0JPeGNZalZU?=
 =?utf-8?B?d1drT0pqVndxc3NKdkdCRUY4OVY5b280d01KRFR3bzZrY3JrSVVVMXcyU3NU?=
 =?utf-8?B?ZjRIQmlyRlhuTzQrUHRZdXBsb28xTEp2c2U0SDUvd21HREV5Q3BSS0VmaHpz?=
 =?utf-8?B?YVNMbFA0K25KYTZ2Q0ZTb2MraEREcVBPQUpuWnd0UXJseDBUc2Z2WjJzQWwy?=
 =?utf-8?B?c0ozWC82eGxDc25pQmFXMDlCMnZlZDIrS0VNQ3dzeEFxTmR6U3U2Y0hPdUo3?=
 =?utf-8?B?dS9xcDhpSkJmeExVbWsrcjQ5SVBQMXlNc3F0K01TWmd3bkZWdWNsbVNaQmRT?=
 =?utf-8?B?UzJybDlmMDY4a1YvSlNBRlNSQnQ2Q2M0eCswYzdNZEh1b0h3NG8zOHZmSWRo?=
 =?utf-8?B?RzRwTkRlai9CVGdBZnQ4WWJhN1Z5QklMR2NKME5hZENyS0dubVRXNDg1RDVI?=
 =?utf-8?B?WkNmQSsvaStTY3pyaTdUaDNObk45WWhWNnJpWkxhaDV0eGdRU3pmMFJHRWh0?=
 =?utf-8?B?eGRZK0dNWjlVR3UyRy9xNDl1VmppVE94MlN1cmJ5ekJRVFdiTWpHbnpDTWxi?=
 =?utf-8?B?NXpWN0NQTWFnQ3dueFVzaUxkaUtNYVlXQVFIaGlaWUlTaFpJVEczbU5pVDh0?=
 =?utf-8?B?UUt1MU1IWExmZ2gxcW9RNEgrUHNwVXRjblFxYWpjcmtPSTZVK2l2ellOOGJz?=
 =?utf-8?B?dDBUZlI3NzlpeUVSdld4VmpwWHR3dmExblJMNWNCNE9pYmtidEx0VXNQNm5u?=
 =?utf-8?B?SldMczN4cEVIZG9jbjUvRklpOFpvWTduU0lEeE8vUklESXEwRzZrcW1zMTll?=
 =?utf-8?B?YzkxdmZWY093WVc2ai9nMzJ4a3hwOWZtemdsUXJ5VmdMcnBTdURmcDFpcjBo?=
 =?utf-8?B?dFBMTUcrNDJLVjE4TFJhKy9iYUpXY0pjUHh6MHZsTFFiZ21uWm1zZjJNc05X?=
 =?utf-8?B?OEwwQTNienFuMUhzOC9UUWRaTG5hV3lVemE2Q0g3aURGL213OU1iRjRWdWNX?=
 =?utf-8?B?emdQN20xNE1SMzJXU2p2YjVYNDZpL3R6Q0xTT2dZNGFzc1VtSTNGNmFrY2Ey?=
 =?utf-8?B?eHpKVjEyZ25rOEhqcEwyMC8wV292UDVlNDVLalA3YUs3SDZDeEdicHJDNW8x?=
 =?utf-8?B?V093ME55NEFaekg5bm5FOFhvaTZCYVppcndGREU1a1NDbGtlMlFoNlNaM1VR?=
 =?utf-8?B?ekFqWkVUTTlEWFJVei9DcmtCa0c2VU5CUHY4QTB6d2Iza3p2dlN5blAxbXdE?=
 =?utf-8?B?UERkdHdyRnhudmRFL09XM0RHb1Y3N0FIMGd6bzhDNjlNcXZTUjNNRVhpaVBQ?=
 =?utf-8?B?K2wrSGZQTVV0Ykg4V08rbXVHa1Q4RWc2M1ZFeXdnZHROT0dRQXlpK1hjWHBG?=
 =?utf-8?Q?mOq3RNgYTCW//ZjydRt7F3l03?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7d17ba-6785-40bb-09b8-08db573ccca8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 01:11:24.7813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JyRMOpNw1VmFGSn4OkoTVbYrPR1jIHJGOxDsdB5AJ7B2nuuOEX0iFOUsmNFjtuOwNZLXL3g1+dDG6VqSl3GlMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4923
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-05-17 17:10, Junio C Hamano wrote:
> Recently git-send-email started parsing the same message twice, once
> to validate _all_ the message before sending even the first one, and
> then after the validation hook is happy and each message gets sent,
> to read the contents to find out where to send to etc.
>
> Unfortunately, the effect of reading the messages for validation
> lingered even after the validation is done.  Namely $message_id gets
> assigned if exists in the input files but the variable is global,
> and it is not cleared before pre_process_file runs.  This causes
> reading a message without a message-id followed by reading a message
> with a message-id to misbehave---the sub reports as if the message
> had the same id as the previously written one.
>
> Clear the variable before starting to read the headers in
> pre_process_file.
>
> Tested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * This time with a minimum test.  I eyeballed what variables are
>    assigned in pre_process_file and it _appears_ to me that most of
>    them are cleared in the function before it processes one file
>    (except for $message_num that gets incremented per invocation for
>    obvious reasons---and it does get reset to 0 before the real loop
>    calls the function before sending each message).  So $message_id
>    may indeed be the only one that needs fixing.
>
>    But that can hardly qualify as an exhaustive verification X-<.


After going through this again - I came to the same conclusion that
$message_id seems to be the only one that must be fixed.

It is true that $in_reply_to, $references, and $message_num get set
outside the pre_process_file function.  I suppose if we wanted to be
more robust, we could move a copy of those to:

1) before the validation loop

<<here

    foreach my $r (@real_files) {
        $ENV{GIT_SENDEMAIL_FILE_COUNTER} = "$num";
        pre_process_file($r, 1);
        validate_patch($r, $target_xfer_encoding);
        $num += 1;
    }

2) before the process_file loop

<<here

foreach my $t (@files) {
    while (!process_file($t)) {
        # user edited the file
    }
}

However, if we do that there becomes a few more cascading changes with
the declaration of the variables being after their use if we do the above.

ie.

# Variables we set as part of the loop over files
our ($message_id, %mail, $subject, $in_reply_to, $references, $message,
    $needs_confirm, $message_num, $ask_default);

I'm not sure the full repercussions of moving all that around.  There
could be further cascades. I think a minimal change here may be best.

Acked-by: Michael Strawbridge <michael.strawbridge@amd.com>

>  git-send-email.perl   |  2 ++
>  t/t9001-send-email.sh | 17 ++++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 10c450ef68..37dfd4b8c5 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1768,6 +1768,8 @@ sub pre_process_file {
>  	$subject = $initial_subject;
>  	$message = "";
>  	$message_num++;
> +	undef $message_id;
> +
>  	# First unfold multiline header fields
>  	while(<$fh>) {
>  		last if /^\s*$/;
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 36bb85d6b4..8d49eff91a 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -47,7 +47,7 @@ clean_fake_sendmail () {
>  
>  test_expect_success $PREREQ 'Extract patches' '
>  	patches=$(git format-patch -s --cc="One <one@example.com>" --cc=two@example.com -n HEAD^1) &&
> -	threaded_patches=$(git format-patch -o threaded -s --in-reply-to="format" HEAD^1)
> +	threaded_patches=$(git format-patch -o threaded --thread=shallow -s --in-reply-to="format" HEAD^1)
>  '
>  
>  # Test no confirm early to ensure remaining tests will not hang
> @@ -588,6 +588,21 @@ test_expect_success $PREREQ "--validate hook supports header argument" '
>  		outdir/000?-*.patch
>  '
>  
> +test_expect_success $PREREQ 'clear message-id before parsing a new message' '
> +	clean_fake_sendmail &&
> +	echo true | write_script my-hooks/sendemail-validate &&
> +	test_config core.hooksPath my-hooks &&
> +	GIT_SEND_EMAIL_NOTTY=1 \
> +	git send-email --validate --to=recipient@example.com \
> +		--smtp-server="$(pwd)/fake.sendmail" \
> +		$patches $threaded_patches &&
> +	id0=$(grep "^Message-ID: " $threaded_patches) &&
> +	id1=$(grep "^Message-ID: " msgtxt1) &&
> +	id2=$(grep "^Message-ID: " msgtxt2) &&
> +	test "z$id0" = "z$id2" &&
> +	test "z$id1" != "z$id2"
> +'
> +
>  for enc in 7bit 8bit quoted-printable base64
>  do
>  	test_expect_success $PREREQ "--transfer-encoding=$enc produces correct header" '
