Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F00C55178
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 14:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDCC7221FA
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 14:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgJ3OHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 10:07:03 -0400
Received: from mail-eopbgr660137.outbound.protection.outlook.com ([40.107.66.137]:50976
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbgJ3OHB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 10:07:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WShV/EcxvKap6lCaXxqtjIiQC/8RbpFeGDpRsGevoR+fv1OWMzMgH/MqkxdyxlguWmZ6t8TvVUhbYlUP/jUN0fbxLOi1fsqZIORTNF+va2hLrbxJe55v5GrXbVt3hHl35JSK8qK2pNrG54BYStFK/wkR2K58u/rTfGm4SeO3gGg8F7cGf2ZH+OUa115qP5xgZZz/usr0JY19U4VnPcX1o2uszU6TOqBWUP8H4DP5hXtLfuaZ7beDdaTY05IPKtoebzz6lNiLZCC6fCj/kDlO12PqMRN/GsmsnpMI0JNWkFW4vradoLy+zrIAvdpMqh9impg9adAWJd3mx08szfvduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhxxN4r2jdZHLCW16kr9YnoTAHsd7n8n6/IOcdZUkp4=;
 b=nnsHA3qaJCrtRfzX/LYFVI3QQtapnuc3QWYiqqXZv84SwuZ8Oc/3Q0FBE5RKJv+7yFFB9eOXihdjytReyucjEanZ2X7s0sSQoCyBUb/ivEZx+31M+KGi5sZdrvXYiLklbwd456+tr5nZpttIdrr8Mnhg64HeHQ9lolOtkulBR4TcGC98FhGta6qiXvonzZHCkvNbWwd9Jm2moAjAIoBH/t/VX25txBGdzcfDoVGEnVT/4Nv+MJJto9UqwuoUXG+yA357YtxpyNvzhex4mGKNTRTSCFKdbr0c/9uYYoYvzy1PwmdsLF5vASF6myOoGhbn/nvP+mqtokLx+zPGhfv6Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhxxN4r2jdZHLCW16kr9YnoTAHsd7n8n6/IOcdZUkp4=;
 b=mHGStu4qGqbpqgCIDt6A1Cu9eWjHVOGmrlK2oa80xFQfaGA2BGgOPsErVG9Eiok2iS00KLWGMNxt1c6OmCeEOByvnWzkk2+0P3W/o/xo5kwF34tNTYARjM+u6bL2xxCI+ewArKqJDWI9azAd8tot1hcIh9xprA66G51M8VWMXMEm+m/43ateaFlMsiXogpFiSTVwlcl52zhoObskQJl8Kfr6GVnVtp2QGwzHrB8NC81+rLdnHA5tT/P2E3weyBpr6nug8saMOxcmDZXnuPixLgaUpnc9AIjohEa5Fw4qpHBiNGaKYgV+GuYMyX/MrmsSpnREDRtRoGFK47x0h9krAg==
Authentication-Results: xiplink.com; dkim=none (message not signed)
 header.d=none;xiplink.com; dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 14:06:04 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5164:12ee:f585:5dbf]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5164:12ee:f585:5dbf%7]) with mapi id 15.20.3499.028; Fri, 30 Oct 2020
 14:06:04 +0000
Subject: Re: git-gui: How to configure for use in gigantic projects?
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CAGr--=KpNaPFjMOzXzF382cv1p58nMoOPXAm0MCdA8WZMBznVA@mail.gmail.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Organization: XipLink
Message-ID: <dc3de1d7-43b2-20da-5e68-2652b35ce784@xiplink.com>
Date:   Fri, 30 Oct 2020 10:06:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAGr--=KpNaPFjMOzXzF382cv1p58nMoOPXAm0MCdA8WZMBznVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.222.183.158]
X-ClientProxiedBy: YQBPR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::28) To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:30::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.222.18] (192.222.183.158) by YQBPR01CA0092.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 30 Oct 2020 14:06:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6810fea-e0c0-4cf5-e1d0-08d87cdcf053
X-MS-TrafficTypeDiagnostic: QB1PR01MB2451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <QB1PR01MB24510F6D15A90D6D3FEAD95FD7150@QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M03fSCh/dgMp9tSNXLfemUGXA/1pieTsjKhusGHp1i/OFG55rV3ejrNMAENTvldDPoNpLfvOvQ3s6/3mKBVl1M4sc9h4kIJVr7auxoBStIQMYG9xb+P5/IWQXLngqPCWkDjMQj2h3Z/Id1wSUBJDHubv6OgJFj66GJT7h/p3uFQhRF29DmyHZajXCPIBf/uMNYm2G1ItneUpC/9xnRiOX5l2JRtb/j+Dp2YsDq6jcmfX20D05jhnM6TRXoTUkAa2gTxYelR31LZlcbRwMAfNPrDer/HrEV5CliJR0AaFMqd+Z4c35nvx1V0BFyJ/1Rxvw2DkyzMi9i3stQm8+j9+0PW09+lUXb4sLsn9NVJxmRnKxyM8uz67JElnTct0Wpcw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(346002)(136003)(39830400003)(16576012)(110136005)(66946007)(66556008)(66476007)(316002)(478600001)(36756003)(31686004)(2616005)(956004)(5660300002)(4744005)(53546011)(186003)(36916002)(26005)(52116002)(16526019)(31696002)(2906002)(6486002)(83380400001)(8676002)(86362001)(4001150100001)(8936002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: alxeIQY9MBIrw9CcORFlLd11EMmWbSacu0c/2sZHkVr67bY27jOi/QU0W3oKSZECBcUUvXT87Ky5MF+J24n6QjOr7ubHAZdFZJGRvgkDRoL0uOWUHD7de3YJTq9qd74Tz/PvawNKl5JxaccyKTOMEl+996+8k5vKWqeIc2r6Ghre/eg3xstRzReW1pjeN3/xLmq3NEDdHQAAt1F9Fto9W4xDt27ktEwxChuA+seq8FRGWgfJ3YR3zBTrc8Sdo1M8yBl+h2k5oqofZCFqudX40o5eUKVdsFJiS2zlmdBKDiy5shmu26ZqCSs480wLxVYNY15JMFIcqyNUr0W0imxR6ydYhcChbbSh8YDmuekczddFlEuHYveR4cvrqCZoY2S3M+ezeb9D1xDyH5W3cvEUt+7wUMl9ELMRk/mVshIQ39UzWSl8F0kMsWXvyQqcGkYXM7Ux1d1ZmdUhYdzaeauVmXS7LCFFgJgbgCMqhkJsWl76xAb0Yz1FlphkbB2G24ogQU/y1hyCzHuKAO3+fH9k66Xpia+fMFv0k3C4qaAzUAKa9D/Szq861cLJGyJDA2f9Y4V5V5vIBTk7GFT1Ad2tCBmda8vpV0WvXdN19P1o/Edvs8H+lxsxQprPEE6Lb5grD2E4HhLmj1rDGYKAz9KvBg==
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6810fea-e0c0-4cf5-e1d0-08d87cdcf053
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 14:06:04.0742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bo0l5R56GK05A9GWYRtzwussGHPO8EgvwdNruyBbzux0sxwPNACTEPqvTbUpKvRw8VxGM+kcUbZZ8hi5d7A9Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PR01MB2451
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-10-30 6:16 a.m., Birger Skogeng Pedersen wrote:
> Hi,
> 
> I would like to use git gui for a project. The problem is that the
> repository directory is really gigantic. Doing a scan (F5) takes a
> couple of minutes to finish.

I've found that enabling Trust File Modification Time helps, at the cost 
of git-gui doing (very) occasional rescans when it notices that a file 
it thought was modified turns out to be unmodified.  As Konstantin said, 
things generally improve once the initial scan primes the disk cache.  YMMV.

The setting is in the Preferences, or "git config gui.trustmtime true".

		M.

