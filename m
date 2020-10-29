Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261DDC4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 13:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6ED120709
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 13:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgJ2Nrq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 09:47:46 -0400
Received: from mail-eopbgr670108.outbound.protection.outlook.com ([40.107.67.108]:53184
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727674AbgJ2Nrq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 09:47:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncK1RZ6hlWD8HUM0IWpkplZpDL8vO3LT6X9brBZ6Hhe0/4FEHVf2vRsCxWOrWqt3SBLWpe8NeQqyidmEttjLWTA0f1MOMdXXo2VAt9whxrMUFUcyGYl2GjqP3WgFeAukUKl2vdV7Kby/z+6hyx8u1ZUbG01XYjueX4rugGcH2iNiTAzmcegmIwS0U6g4hzJJ6OQZu+JUZtLd7nP2HDprZ803/MMF4YDnM98ZLjFRByq9cJD/rIvQ/1j6aTksITD3jNEceZvmLhGQSP6oYUPviHPrmG6L0SXCDea2fUdGvtaE4SHhCiWgqnOAsMDt28UPwUsNGaT1n3sY8nX4ryqOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFl3liK/ZyphVJswGj844gZqjUQxSNIpVZjJrMgsUbo=;
 b=ePYsg6HSMutFpiqM0CyxyZzDB7i/kOjeMyx8UB/+CAtGOeQNTEHumcfOoqwxVlZeANzTtI5t2H8uKUk/H/UzUgAJTPoccTi5I+/AIbfbhLPXIeR/r9wOwlpw/nF+WO/1gfwBSF7bx/8r90cIsw7oAnjsR8KpYETHyTLJbTJqylB6VnyRga9rhdHpDlGA6glZ1l/dmwzBVbxeeoxlKitIczK4szKNMuCzd9WGGtesfwWbIpGArAHE9+EIAsOnGPrMoxSeVQEg4QmsitWHcGGwzHS7grQE+1b61It2n1roDgU72CVkAyb0rvguNDm2ZnHl9q/YatD7zbpvdTcPc5BUlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFl3liK/ZyphVJswGj844gZqjUQxSNIpVZjJrMgsUbo=;
 b=O7OPnvvu4hM01GSu6JRLiK99X7Z6cWWCt/3qR+E4FZRzqEIQW8PAxP4AOV8vKtNZjAwTVn2XOzU9Qs4uc9jxs1n1vxAZNoM/LBBegmiW6Av+9VH6+NI488ikZATiOphiblDp3b6PzWn/9TXpF1O317USm9suRe44ZLCASdQWrhJSB+bT/vSND1h+mP0F+qgmlwzRRYQXSHmOYRAcNTVHbBTQlOJwtFDJwGSf4oEKs/+E91/zHuuFJ7H97P+1HBSk19MAz7o7ly2ZUDcpteQDkHIDnjfjhZc3OLQrmgLd4rS2imz+z1zy8CSwextl78dTDwxnGwYUN/hDColq3WRf7A==
Authentication-Results: xiplink.com; dkim=none (message not signed)
 header.d=none;xiplink.com; dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by YQXPR01MB2710.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:48::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 29 Oct
 2020 13:47:44 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5164:12ee:f585:5dbf]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5164:12ee:f585:5dbf%7]) with mapi id 15.20.3499.018; Thu, 29 Oct 2020
 13:47:43 +0000
Subject: Re: git-gui: Why are the main panels no longer white?
To:     Serg Tereshchenko <serg.partizan@gmail.com>
Cc:     git@vger.kernel.org, me@yadavpratyush.com
References: <6a38e92e-ffd5-4b0e-b850-3697e47b2b92@xiplink.com>
 <20201029114400.38284-1-serg.partizan@gmail.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Organization: XipLink
Message-ID: <619dac64-106c-d6df-b121-ce6589b4af3a@xiplink.com>
Date:   Thu, 29 Oct 2020 09:47:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201029114400.38284-1-serg.partizan@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.222.183.158]
X-ClientProxiedBy: YQBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::21)
 To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.222.18] (192.222.183.158) by YQBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 29 Oct 2020 13:47:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 734202e3-ce96-4eb8-6542-08d87c11361b
X-MS-TrafficTypeDiagnostic: YQXPR01MB2710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <YQXPR01MB271093F3AD1749BF995FB76BD7140@YQXPR01MB2710.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KdPhfiBGwrGtjxDziCZMsD3JCpMnPFvdLhqJp8eqbUDvZOeNp4TPGTJodsExHd7t9YyfyQ+pahNduecOQB4TwaLqEYwhHjUMq9Uq3nzxOqBSYggWugTe+bxHfqE5sIR8KjpqM1xktj6iK31drQDzMw2iaTA4NN0jBxijWqTrgC8qttH0LnVW+r4cGgmTc2UQ6u75a5yf032Hll0K7R+uLlzp0YM8TFF4PCwVn7TeCmnfvUmGN4zZDMTq2gRFZSvjoqa61ywR3YZkFwY8ipZx3LNa4Gm3XT2+ebAzD9cOxcEUcXxrEHbEw86l5Y3wZ2Vt0ISBSuJUAjOwmt9HYyvVl8LP9PJRCP2+66TeC+fvZRZUJpCUeD+WraJth88rDEmd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(396003)(39830400003)(136003)(4326008)(4001150100001)(2906002)(31696002)(16576012)(86362001)(316002)(52116002)(6916009)(956004)(6486002)(26005)(186003)(16526019)(2616005)(36916002)(53546011)(83380400001)(478600001)(66946007)(8676002)(8936002)(36756003)(5660300002)(31686004)(66556008)(66476007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: j4622v0vNTjqqa13s+/UVV6wzCB76/0dlRi3UXNvJhyH/c+RvZ4NrU9XStNymtS8T7PiRE55QLO6/dzUkRq2nFfSLWcrMfe3QcBp5yK81bKf2KsvI6Ky43qUZW57fHwotgn16jdlBNNUb6X2dEYxlnyavUGg3jIyL7AE3Bv3csddIQNe+3CGA2WQ+0ZrXmqbnIAuVmpc1uS7IrCrb5JpHGx11JMKXWEsxSSgfJMWzh8SkoWP2yd3rwAacrAaerp46GjN0cDqicbuVHMGCZ+KsZyublK2fPG9V/0OI0maE7eDq72J1by9puENK/rmQpR1/0vt+6Ca62cPxT/nrHLuIPJMgjzBits6A1ORrMrGF0LTLGEr0Mvpz4rWzbNSfCVCODu4lGasT0n58Azdf0CyAC+T2qSvUpWqoUZmBW+mdpns4k3rgdF4B1XrIaajmcdKIN7B7mcUtuzI3xZh+3+hnQH3FPenLZrzULAmKVdScot3DwTGOQhXUniuBBL/l6pXge2LlI0VcHToANgfLMJmAi0eSbSgGgvvwiFGqKWftMZ43hK56ha1vT7n9zQFn6voKvtfbWT9lQQVPjuG0qHafSS1jhzHXDht/w86lpD0wOEHbB7epLC/d6L1pw5Kbz6TBFCw3upX6VjFuFX+6bE0mA==
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734202e3-ce96-4eb8-6542-08d87c11361b
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 13:47:43.8837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Geek0QLKm5mbd15/p9HXmsm/z96xfx/AAX1JeCH7T9WB2qReuJbPLG/QPvth+rD16a92Sxu4mIhAUfjodmprbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB2710
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-10-29 7:44 a.m., Serg Tereshchenko wrote:
> Hi Marc!
> 
> What tcl-tk theme are you using? Autodetection supposed to fetch
> color from TreeView background, and probably your theme using
> that odd gray for TreeViews.

Thanks for your reply!  It's been a long, long time since I've had to 
muck around with a .X* file...

> To set your desired color for background, you can add
> 
> *Text.Background: white
> 
> to ~/.Xresources; and `xrdb -merge ~/.Xresources` to apply it.
> 
> Or, try another theme. This one gives me white background.
> 
> *TkTheme: clam

Unfortunately none of those gives me white panels, although I do see 
other visual aspects change under different themes (also, `xrdb -query` 
shows that the *Text.Background setting has applied).

However, saying
	*background: white
does the trick!

To narrow the scope of that, I'm going with
	git-gui*Text.Background: white

> To list available themes, run `wish`
> 
> ::ttk::themes

I have:
	classic default clam alt
"ttk::style theme use" says I'm using the "default" theme.

Is there some way I can edit/view the theme definitions?

Thanks for the help!

		M.

