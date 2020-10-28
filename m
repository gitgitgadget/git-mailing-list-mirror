Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F277BC4363A
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 21:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955BD2064C
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 21:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgJ1VsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:48:23 -0400
Received: from mail-eopbgr670094.outbound.protection.outlook.com ([40.107.67.94]:17002
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727421AbgJ1VsU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 17:48:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZFC7j/fjdkHadgTzPA+t4i/qfLPwr4Xl7Bsgzv4azLWc2sfnPRc/yv8rMcTzxupvtP18LosR7RRbQDCOXq+zCYgQ8HVLXgz6TJymlLNJRwYzWTYfqUavd2sudorCp8FpmP7y9D96cHVKGmFykBsgbMXQPKFMEJ4KlPIztb4f8z1ncnewkjCZo9NRp6WIAZjdH7jVLsPOtCpFUMOudtXbCdnc+FUSr/qE+z981jLvv6uVwJNxP1s4ND2UKnoKJkS9yDJ9E+FheUyzXT8sVzdYHR1q1mY8KPWDQqrMDjFgEMTxNjqR5+209WqOE12WzwCJHH2f2gkQFm06NHVt2RddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8Ubk3ZDSaqApUD2s4uiH5sO3D3HaTu3lMJT7NoPc8Q=;
 b=W9bSQy/j5d3elB4peJzmnch9sbwYhqIYeY8ERc6zscotpOtrQMReVXK/k3WE5Ph4/AIk/1x61GIvTD/P/WY5KfDBJycoIh0q0KiKrh/i89UHBuDA+PboxZDrujkxQzT5BlJcYPmDZoKSmTHvm4pqq0c43bJzeDsJyiFm1ofN5terRK73x6HAhElon6G0KMSt+yS4lTQyGBkPQp1sQ7Unqo0RzV5T1b+23JV2kYT8cm//jeARE1v+YS9zRNByBuCCi+i0gROThmQQ59XmnjoDF27jdi/eR2WFtwkQu/gaAf74OE9KcM+MFSqnScZhhsQkTu5mDWPPoNxo9Gi8AX0PEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8Ubk3ZDSaqApUD2s4uiH5sO3D3HaTu3lMJT7NoPc8Q=;
 b=Ktx9Cczd/GeJkneEeqXnBeMRg3/ioD9ZCfjtPfApWJkUPBMAOs9qZngzmrkFGxWUxdSuIUATntDpEA1M9ua7wCJud8ULKG8ZmNw9Bb6ZLW4+hFZzXgCHOtFceMnO0sbtgwZfNGc8bZGd/6s5/bSmlz5LaQXj9sJVYT3qUnMckwDJ6YbNeZog+Agl/OPyWlXUO2WETx5Wymii+hyWtDPY29h4rxgyCpUtCq0CgtuTKhSV6soj+Tfey7PldTdTPVb9m2/1ASBEhQ3BamWsHt2COx3ItnWW8NMsPb1eB/+qAEy1DVpttp+kcAmVhYxjGfy/mKFFv3/VOluanuwlsRr63w==
Authentication-Results: xiplink.com; dkim=none (message not signed)
 header.d=none;xiplink.com; dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by YQXPR01MB2485.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.22; Wed, 28 Oct
 2020 21:15:25 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5164:12ee:f585:5dbf]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5164:12ee:f585:5dbf%7]) with mapi id 15.20.3499.018; Wed, 28 Oct 2020
 21:15:25 +0000
To:     Serg Tereshchenko <serg.partizan@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
From:   Marc Branchaud <marcnarc@xiplink.com>
Subject: git-gui: Why are the main panels no longer white?
Organization: XipLink
Message-ID: <6a38e92e-ffd5-4b0e-b850-3697e47b2b92@xiplink.com>
Date:   Wed, 28 Oct 2020 17:15:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.222.183.158]
X-ClientProxiedBy: YQBPR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::35) To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:30::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.222.18] (192.222.183.158) by YQBPR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 21:15:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6595c25-7a04-4aae-037d-08d87b869619
X-MS-TrafficTypeDiagnostic: YQXPR01MB2485:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <YQXPR01MB2485DF3CA7EE61F5D119E844D7170@YQXPR01MB2485.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5f7e1gaEvDavGQ/X2V2l3qrek1ZD2MprZrRSfwM24aDZIwnD6r07VG55Eyu5O5lDMDv2yfoguycWw2Fpc32/1XK77sCbGae4oDybE+7YhBfR47NV8Adk3vvUCNEu92gUxJ2GKzoU8451ZEKD3W/0mbKFx1er2dPne1MRKAgfZ5hAmnMZT8eN4IRwJSYuPaG9JxyGeTnz5OxJMgm9zp26hEMZ6iLvOjfvQaO41NYqoSGoeaCe7qcY43AB/5x0E7HsN577qMXpfbMPSQjq88f+7hITenKM3estst6vDAypM08ORaMlc069+wAJuxJ1Fy7hDs15LJmmQE5WgFaDlNhAtroQm9im6JcmEfA9DcIQgk71OOUPCoGcCJaC9+8LXhfM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(346002)(376002)(396003)(136003)(366004)(478600001)(16576012)(8936002)(36756003)(31686004)(6486002)(4744005)(8676002)(316002)(110136005)(26005)(31696002)(66946007)(186003)(16526019)(66476007)(66556008)(86362001)(4326008)(2616005)(956004)(2906002)(5660300002)(52116002)(36916002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Xyi7yx/ymy54TinItYwdqZjtYDwjHXm69F7kWiYrTPzABq4ox14RbzXP2ZUAru2MXKDU4SAvt2G+A8AChdu9bMwomdnC2gW2qRV/LLV2RRauWM9ohbiv0yV1CXhjbWJB4zWuj4OFUR3LduCCfZxnlD82aQnZb9sd5w2R9eYSEpbMm0eAQWba9G6Whs8oXMuXvCukrJaOqaKnHlOd7TuDMIIDLcya63+WgYBovbcB82vZIpvHu5szJKDnXjSGcTUt/n5iDAd1xaZHdsRig8hPgSmHDT/JAhxM9sYAqCnzpEnG9M3hujrhGCySaqMzuezf8DyZfgN4RuNykwtLLGWSI3mS9hr4uPQUeF44XtVJTiFk72F3dbb9YprXzR77F5oIXJslAxGp1dBaKBDAJKNQe7JF7nTWtDWQnmLohxfFrcpgNPzM3ONj/vq1eo0JJCxyl4h86f090XRI/RfUjEoEYpJF9oL33Hfh/ignr8NDCu6OsC+69MMuo/kCQK06mK0m5E9GlGn8OV60pF1rj+pfxjZRz40rHar5U6dw63gasBzOGHlgw6Jd57kmVoXSm/zRjiBxno3Ak3HHQ7VvxvH92E91Ta0pEzoMX49oQmpy/RPQSFOcAujWjtCDnjS4PV4bpeGdZr2ipUrbDcYDRKQDKg==
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6595c25-7a04-4aae-037d-08d87b869619
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 21:15:24.8979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9q3LGN3eYhVJ/XacGByPlFhx+jgBxvzEGQKMGvgNJgqGI2xEPNlpO17W1d3/y37u0BkgGa7V/OVeN/jjeb/SUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB2485
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I'm using git-gui compiled from git v2.29.0 under Kubuntu 10.04, and the 
git-gui's four main panels are now some odd grey colour instead of white.

If I revert git-gui commit c02efc13638447 (git-gui: improve dark mode 
support) I get my white panels back.

I'm hoping there's some magic setting I can tweak somewhere to make the 
panels white, instead of hacking git-gui's code.  But for the life of me 
I can't figure out where this grey-ish colour is coming from, what 
"theme" I might be using (I don't bother with "dark mode" stuff), or how 
to specify the colours *I want* for things like Text.Background "from 
the option database" (whatever that is).

Can someone direct me onto the right path to fix these colours?

Thanks!

		M.
