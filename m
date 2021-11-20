Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CD7C433F5
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 15:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbhKTPHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 10:07:20 -0500
Received: from mail-am6eur05hn2201.outbound.protection.outlook.com ([52.100.174.201]:55837
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231660AbhKTPHU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 10:07:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSzGldkCD3DqOzWMrX3N5u1BFiBKQeGZbz7nGl0wcTzLPxoQeapBgVeK+LBMQqkUb2sYekVCqPY62lvM3NMpoAIlkrGigG7cDwetQ8cH0WsA8GvXOz9r6B8EEoTBi+ykLMHjhsfhdJdvR9B0H8tnCbEmr70GfbYCXueed/hDfALKVs5LajGTyg+0HFN9VIOpkVLutxJBBW03SoMQUI1GL1afO3Syx1qyxfiPCWQ0dbXQeNrelPc3PjBDFtcHe6GOgwv9ProYGDfC4E6gFM0UHbHiNaSQ+4E3/a357pcKP40mDPBOxuScfHeEAQ8yT4v5URWSoWsVRW8wSYVQ2v5SMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qM68hl48WJ9/9eG/rbPUg7maEMzgigSk53t8+ZOcZo=;
 b=AMj9vYp8iTjSsq1kFYWaBnep/4QFo4CorwcfBQKXiznGviKi94zkYvcX+13fKLPus9lB83jl2cVwkh7/EDXYbFZqY3MkuXov2zvphsk+896f+TlrBjIpSK+6qttQTa6sk0DtcJ7ep+YPFLhX2X0c/lpbFMhUWxW71bEKK9pUTCIc3e7a1yD7RJXWFEePvyHXTnpCrerj4CGFKuSnA7MGf1paQGX6XiK4qfbWMpc25KLwwei2eFqmMX1ZroRJgL6IzWO9J3UqIhBoVagiQYfNfYUSLbCAF+QTgRT7alA1cwjFtMcokyGARaTaVYxAZt04D5Z0vJBekvfpvEa5du5nbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qM68hl48WJ9/9eG/rbPUg7maEMzgigSk53t8+ZOcZo=;
 b=VTlXf7VNe60ewos49sDiAhXPIQswdqMUVfiCKO2WWjm6OqolkMsahpwcP2tIuLOvwpKHZ28C+IeojaruWAF23skSOkh5m5FWodgxNCFb1M0DmCoXFml1hSTmeTREIJ2v5u81NoPeKsWdkDEZwKCtetS+F/LqfbRBHOhTNQEcSo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4799.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:156::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Sat, 20 Nov
 2021 15:04:12 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.024; Sat, 20 Nov 2021
 15:04:12 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v3 0/3] test-lib: improve missing prereq handling
Date:   Sat, 20 Nov 2021 16:03:58 +0100
Message-Id: <20211120150401.254408-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211117090410.8013-3-fs@gigacodes.de>
References: <20211117090410.8013-3-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::35) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AM6P192CA0022.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Sat, 20 Nov 2021 15:04:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f32834be-f103-40cf-ba54-08d9ac3702c0
X-MS-TrafficTypeDiagnostic: PAXPR10MB4799:
X-Microsoft-Antispam-PRVS: <PAXPR10MB4799AF5E55BF27340AB36B9AB69D9@PAXPR10MB4799.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dbOtR9Yy8jDnwLkUBflCpZTLX0EJSm1XdbAT1qJwA3j/T0G3CLX1KbAl+UPa?=
 =?us-ascii?Q?UFrXlQKc57jm9NVGtjBkrQYpW6Y/dSufe2Ky3cHD0Hd1e9UylVlfFd6RZ3AU?=
 =?us-ascii?Q?VLLmeBW5MzocpElYMlZurpIoZdK/tpqBstsCCTe1Xd0BXUtHtz8XIRFUoWYF?=
 =?us-ascii?Q?GZAOeQg+p5I7SxOy57hv36XvPPLUv7m8hMpGionE1HhNBnQJ4RaQqPhgy8yT?=
 =?us-ascii?Q?YVHXobKEVMSzzwj2BqW+0pWBN6BC96bNreRh8Ey2cVk3p3dmnn1fedrC9c2W?=
 =?us-ascii?Q?+HOxuT/nKtc+3W/g3gUqI4Y5bVpmDhgvH477SoWVJ2POSijZVGcLhs+AzE1i?=
 =?us-ascii?Q?Zyz/FXnC17ayc9g0AiQuu3mZGzIDQ74I9Q0flU+pnpqC6KnPelg0L4XuWkjw?=
 =?us-ascii?Q?mdizmvLJSJXaxhniCeS2zt9G4+c+8pOf8XEDu4X96oB5P5L7ofu6oxS3/K1d?=
 =?us-ascii?Q?eoDn3JsXfbY87GI2ezFlnAjXFgMasiaax/hykLovr541Ep57R2dFML5NDdct?=
 =?us-ascii?Q?6tvlbjSifXx2QpmH/bQevQ6vcf6GtYpZM/TI44ehsb4tZyMfD6up+TcbGNMo?=
 =?us-ascii?Q?7ALKw8CmqR+CmMhVAFVMcl1IfLY9ABftJWUIi5sl4+gn+AGdVAQtfqUyiCwS?=
 =?us-ascii?Q?4Q4GeLVwqABRvHwQacalpomzmNTp61rcUShDrY49HiGom8AqZXfGZR/oXkuE?=
 =?us-ascii?Q?mDIi1fJqK7wWCOA73TYKaar4Eq1xqCKyMWlQKD81gwXzknl0UQDTZknM4Cf0?=
 =?us-ascii?Q?Z98q40VaYPF7TWdcuVsabByqqizgnB+r4N+K5fAfGWNudNe+4rT0b72AP1gl?=
 =?us-ascii?Q?kIEe+HN3l9Uq7vA9DXWICHKG/6zmuKNptQpCuoSMmuQQa7C9gMjeteyhKijw?=
 =?us-ascii?Q?4t+dB6LnIXYEtjmBHb9OwctwNHfxk/KFqw9UuR4XhTKzarqtC/ZnxT/4T8Qk?=
 =?us-ascii?Q?L8LoTb76aoxq/zmpusO3y77PORap7praDxDAoY/qgwE9WsknVmpR8q7eL2A0?=
 =?us-ascii?Q?NgL0AlLfTq0Gh13VT5CTR4Y8hKS8iPXIjESep777UNnOW9eT9eWx+9/VL8n2?=
 =?us-ascii?Q?+Nxmkckp/EiHJrIvDEwrg/tlOa8dsladAOpsyiGwg/tL7tGvhs8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39830400003)(6666004)(107886003)(2906002)(66476007)(316002)(6486002)(2616005)(83380400001)(66946007)(66556008)(186003)(5660300002)(38100700002)(36756003)(8676002)(54906003)(4326008)(6496006)(86362001)(966005)(8936002)(508600001)(1076003)(6916009)(52116002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RarKNVyh9TvO5fjUB3SQ78AeoGuQO78fM5yu08H5BM+kKzk0MbIGyUZVJv+h?=
 =?us-ascii?Q?TbFtnPXsgqSXgAw85KX8afCrlmBGUSn4Mn+GTiQK4L9j4HbQvjD4IJDW6puE?=
 =?us-ascii?Q?fbkuyQUwfmOB1uhPPv3LUg7mUWrKRsCBj4q8hoTpeeaOYwU3QwAd8OPD//YC?=
 =?us-ascii?Q?1Y3zVwFLzfNrkpvCbaJYUqN6ttQOG8kDWWcVgwc1xSAaD0Mo1biyA2R1Y+8h?=
 =?us-ascii?Q?CJ8USfZ6svl0eFgsNlJRzvJutyLLqhMczNnH/w+uc3x9Q0bhTHeHGqeovLfg?=
 =?us-ascii?Q?ovnVuQFgA39IqUiF0IXQGegmm5aMZeQYbCAdpcOn4V/ROQrcvMgqWqC4Ks1w?=
 =?us-ascii?Q?P90duLYhjmUK1VmFpC7ygYGftqG7MSEEw5/c07mIp+9DBbZ8s6WwZurbKCVS?=
 =?us-ascii?Q?gNa9Mt/QOyjwK8yYXp2vjW8svO7Ba6+g0gkKfWMDd/z5tUY20z5LA62sEPeP?=
 =?us-ascii?Q?SCHM7kCZZszO31foVbkWNpgcyVXbK9cc75yQCNWAhI7jaNZx4OmVPERDjnEw?=
 =?us-ascii?Q?2dvf7NS+idxaIgtIHiXZBovhPOft2VOZQrVN6mUGeeM8RtvAJfkix6rScZ/3?=
 =?us-ascii?Q?m8r/LxgsxnVXY5Y3KELP6Jv1cIXvgOgZuyq0/yo86pWAH/lAnx8IfyOflQqY?=
 =?us-ascii?Q?/f0Fl920uRQ3Z294EOUU6quIKCF+K3BEKBMBv4PxJnQSqozk71LKn3GHUSuE?=
 =?us-ascii?Q?m192uUGBFBeEnk3OKZCq0zhF47ZaIt1c6+hQJVooYS1Qb8KRJLj1IWmxTIT6?=
 =?us-ascii?Q?fm92E7jTIOSj9rjl03VAt4YYyWEeHlwunSXqRohKN7EE7u0cbCfhxvHlMXf9?=
 =?us-ascii?Q?4BZjoPXBBMOaCd1XBiiRYjfL6U/BGuqLruv0czfy93Pr2cv2bt07ukpaTkcA?=
 =?us-ascii?Q?gfr4jFFLeHUvKPmUcTb4NSB8d//d1bFaF4ZXtdEZ9aWujMKx1Cot/aFdAuZX?=
 =?us-ascii?Q?NxK7VsklighwX5UYzYei3T378YoXi9bWV3BL48flNM4sPSPJjSWQIYq1xnpI?=
 =?us-ascii?Q?Uxj8jf/ePpzBb2040q4Gu8HJoI19yczqlw+noeRj/5zMngXGDN/iDO3vp27j?=
 =?us-ascii?Q?95UX3k1dz0H1yTPxMim81ECDnIFHdmxPk/UqSzDvAS8uVNZDvXclID+3G5tF?=
 =?us-ascii?Q?V/JMAEsBirImT2wmcToTPqbTkR/jZMg/+Io0+cMRTtMBHp1GmEQ/6Q1k6qMI?=
 =?us-ascii?Q?w589ER3dxWLO1LXeb7hGTGV1kNnaT2y9ank/cn1YEAKfXxhE+8Mxuza57rVQ?=
 =?us-ascii?Q?rR5xf39f+zwAfkvMZwRQq7mGD8ya4tkGpN8+15orvWFPi7umN8irM6KxIz4e?=
 =?us-ascii?Q?5le9BtV+g33WBkuX1ord3HcMu4xWRh2SlC97zxPZObYjsD/Aqnj1XFUTOcth?=
 =?us-ascii?Q?ksi5vfN1vf7Q7DRbh8AIgZ6yL7xhKXNb7zZw53s1O94Hk6eTPEYZzggcfeoI?=
 =?us-ascii?Q?qbYOEgmE+eN0JUeEJL+iz4+Eam/MrwHFQojGgW+MWqa54kbVzX30RIsrrqS/?=
 =?us-ascii?Q?J2SjleNi744YK9oQtMaap1NIDAZAayz6Lhrh/4r1DE25NEBmA5hd29fZr8Z7?=
 =?us-ascii?Q?3ljCUiK9bdUI8InMQAeIgUdi3LHAbZk+MoBpDrPYXlcp5lYfhDEnuAFQB2Bi?=
 =?us-ascii?Q?C+BG/1VbxvhER/S4v0pHiNYtnmJFBpz7xQg4IS/nsLEO5iAmaSDYNVYHF6Jg?=
 =?us-ascii?Q?n9vh5WPwQ3pcWcFdoRjzX+LzSKJ3+SFo1vxWMUo0im04/4kMBdJ72h6tMZ45?=
 =?us-ascii?Q?wczcFPBW4w=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f32834be-f103-40cf-ba54-08d9ac3702c0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2021 15:04:12.0831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seBh8G5UTPTQrNUDNPNSMrilatQWsJSiVKqfWVTJQuGWFR7MV4QE6OtLqAIGlClTRO3y8X+lfKa4VAa8PNR8HHdD6fWmIPGFT7dtEbMjNgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4799
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ssh signing feature was breaking tests when the broken openssh-8.7
was used. We have now fixed that by checking for this exact case in the
GPGSSH prereq and I will improve that check further in a future patch.
However we are now in a situation where a broken openssh in the future
will result in successfull tests but not a working git build afterwards
(either not compiling in the expected feature or like in the ssh case
runtime failures) resulting in a false sense of security in the tests.
This patches try to improve this situation by showing which prereqs
failed in the test summary and by adding an environment variable to
enforce certain prereqs to succeed or abort the test otherwise.

See also:
https://public-inbox.org/git/xmqqv916wh7t.fsf@gitster.g/

changes sinve v2:
 - use a space separated list for GIT_TES_REQUIRED_PREREQ like we do for
   GIT_SKIP_TESTS
 - use BAIL_OUT() insted of just error()
 - make BAIL_OUT() print errors even when used within prereq context

changes since v1:
 - use \012 instead of \n for possible portability reasons
 - fix typo in commit msg

Fabian Stelzer (3):
  test-lib: show missing prereq summary
  test-lib: introduce required prereq for test runs
  test-lib: make BAIL_OUT() work in tests and prereq

 t/README                |  6 ++++++
 t/aggregate-results.sh  | 17 +++++++++++++++++
 t/test-lib-functions.sh | 11 +++++++++++
 t/test-lib.sh           | 21 +++++++++++++++++----
 4 files changed, 51 insertions(+), 4 deletions(-)

Range-diff against v2:
1:  69e77cd854 ! 1:  35c92671e5 test-lib: show missing prereq summary
    @@ t/aggregate-results.sh: do
     +		tr -s "," "\n" |
     +		grep -v '^$' |
     +		sort -u |
    -+		paste -s -d ',')
    -+	if test -n $unique_missing_prereq
    ++		paste -s -d ' ')
    ++	if test -n "$unique_missing_prereq"
     +	then
     +		printf "\nmissing prereq: $unique_missing_prereq\n\n"
     +	fi
2:  12bd18c5ce ! 2:  d6a53f0980 test-lib: introduce required prereq for test runs
    @@ Commit message
         test-lib: introduce required prereq for test runs
     
         In certain environments or for specific test scenarios we might expect a
    -    specific prerequisite check to be succeed. Therefore we would like to
    -    trigger an error when running our tests if this is not the case.
    +    specific prerequisite check to succeed. Therefore we would like to abort
    +    running our tests if this is not the case.
     
         To remedy this we add the environment variable GIT_TEST_REQUIRE_PREREQ
    -    which can be set to a comma separated list of prereqs. If one of these
    +    which can be set to a space separated list of prereqs. If one of these
         prereq tests fail then the whole test run will abort.
     
         Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
    @@ t/README: explicitly providing repositories when accessing submodule objects is
      complete or needs to be abandoned for whatever reason (in which case the
      migrated codepaths still retain their performance benefits).
      
    -+GIT_TEST_REQUIRE_PREREQ=<list> allows specifying a comma speparated list of
    ++GIT_TEST_REQUIRE_PREREQ=<list> allows specifying a space speparated list of
     +prereqs that are required to succeed. If a prereq in this list is triggered by
     +a test and then fails then the whole test run will abort. This can help to make
     +sure the expected tests are executed and not silently skipped when their
    @@ t/test-lib-functions.sh: test_have_prereq () {
      			prerequisite=${negative_prereq:+!}$prerequisite
     +
     +			# Abort if this prereq was marked as required
    -+			if test -n $GIT_TEST_REQUIRE_PREREQ
    ++			if test -n "$GIT_TEST_REQUIRE_PREREQ"
     +			then
    -+				case ",$GIT_TEST_REQUIRE_PREREQ," in
    -+				*,$prerequisite,*)
    -+					error "required prereq $prerequisite failed"
    ++				case " $GIT_TEST_REQUIRE_PREREQ " in
    ++				*" $prerequisite "*)
    ++					BAIL_OUT "required prereq $prerequisite failed"
     +					;;
     +				esac
     +			fi
-:  ---------- > 3:  de21c484d6 test-lib: make BAIL_OUT() work in tests and prereq

base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
-- 
2.31.1

