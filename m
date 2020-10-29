Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDE4C2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB9042087D
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 21:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgJ2V6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:58:49 -0400
Received: from mail-eopbgr670105.outbound.protection.outlook.com ([40.107.67.105]:62037
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbgJ2V6s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 17:58:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvS9BfizAeOjUM/YUHFn+mzfxceHYJT/PGO72wjWRMwlNTAU5e983HhGQnnNKtKGbbgz3a2dEKLftWTtQm48Mc5ERtW8A2UX/BkiLDwRbmaroZGvlcwXM3gQ9VAAYZ5kMrBWkKo/BwbMpHXnPi7jj58VKwTRs0XuCKEra2y1ioxtq+1GSDnF3d56sfguNk0ihsGA8wRdBHHAACfOffHp3uLTJhsrPikSjg1HzRPF9zZlT0z2Eis/j1rgCVdRmdqVotJVyTcG5xL/irqbKsQb90L7VXKj/3NCy3J3VABcQQYIvMrYd7ULi3Lddx8XZVpvEb0aS4v7e+VtCnk1K2hEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wOj1JIfTQouVmKz8HtB+MA0hlhxU2q34aiLyQFF+vQ=;
 b=BbA6dHmEgGCMtX/MGVaI++zjuaxh0HPSdlV8Ph5vBfVGabHvie46K3/bj1vZpJ3N1O0eWPA2ArmxUklhQB+oFgylTvxrCHhiog6WrFHYvqkx730u2oYGfZKYpWApBztzeK0sv8msaDolRyaCYfTbVblBRvx2ao/elzgsW6ifu5YRLnFX697ICbh3mXolmrgX3sO56wjA60tFwdJ1FYDxbO9XhkTQ72REETWpvPeSJqN2IAObmqHD60q/wE3SflWQwrMIwfVQca9pNZiFUOYopJ5OtTyg5YUAsfsXjDnHxaL5uZpSJ2CwXO4sYiEIlsiKYlNkRjVwS56i3iAM7M3oMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wOj1JIfTQouVmKz8HtB+MA0hlhxU2q34aiLyQFF+vQ=;
 b=Ajs7FgQJy/qxJxEif1UkrfPy1ue4BbZ4NKvFJmTjlaKDQN85U3NatJw8wS5SDxJzSATE4Lz3poqNpyLghoB+kWsBk6K99/X5X8xi7E+OGkNxmrFOLelL5yUOJqf/beHSn3oPYcnxLXrphfaRgSgCamSYJfUzPuNQoaUkM3DpZhwbJWWcEvEa1rrdYD1mMhHLi9PyadYsFrTA9GUavT5xMV5PgfpjUJ1PlzglazR1QazLVmkIxfqvn3QSzWl8wN7PkGL7SxqUU47WTGBuukaCrvFFf+cAMOSk7Zzh1TjFYgoC9U7NxyXTM+nkpjZk88chAmYkOvgZLz8gTJjGDq/haQ==
Authentication-Results: xiplink.com; dkim=none (message not signed)
 header.d=none;xiplink.com; dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by YQXPR01MB3687.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:45::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Thu, 29 Oct
 2020 21:58:33 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5164:12ee:f585:5dbf]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5164:12ee:f585:5dbf%7]) with mapi id 15.20.3499.018; Thu, 29 Oct 2020
 21:58:33 +0000
Subject: Re: git-gui: Why are the main panels no longer white?
To:     Serg Tereshchenko <serg.partizan@gmail.com>
Cc:     git@vger.kernel.org
References: <619dac64-106c-d6df-b121-ce6589b4af3a@xiplink.com>
 <20201029204149.20232-1-serg.partizan@gmail.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Organization: XipLink
Message-ID: <b85e0713-81d6-fcf2-6292-1b5acf86650a@xiplink.com>
Date:   Thu, 29 Oct 2020 17:58:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201029204149.20232-1-serg.partizan@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.222.183.158]
X-ClientProxiedBy: YQBPR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::26) To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:30::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.222.18] (192.222.183.158) by YQBPR01CA0090.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 29 Oct 2020 21:58:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d39ce62-7296-4875-0bcb-08d87c55c761
X-MS-TrafficTypeDiagnostic: YQXPR01MB3687:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <YQXPR01MB36874F60129B6469D2A46F3FD7140@YQXPR01MB3687.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7D25bx30UH7qPfVWioSmAGhqtj673Ds2PYbsub7T43J8bCCZtOAkCpBkyl/nuejITUnVkvM/T+ZIcgGYRJO/qbhyCC0kuFEwpmw6G/HEM3jXOGgC6rdxw2SuCpSdLOw3SQKDC2ZrWlXt/Zz/7AH/Uq167LlIbrpWUboSXpON5M77+R3L1+fH69gu3CmQpPLA0XvhrRUT5PMiudDzywX8I0xCT+XVPS0iLJVQS6HiDaImQ+of6XeRznoQUM/hDZDs4L/qrP69dVDQlhTz2rvC/9uAqNqY2PZlz9QXbwV2Fi+S+LAnfmbRPffFofycscVy5B5ETZkjhG+XPPZFo+RjuqhZyT+x6+nxLRE0lN4kZhdGyWYaJl0NKzvT7SmWeEjH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39840400004)(376002)(396003)(346002)(136003)(52116002)(36916002)(66476007)(66946007)(16576012)(4001150100001)(66556008)(6486002)(36756003)(53546011)(31696002)(8936002)(5660300002)(316002)(83380400001)(4326008)(26005)(186003)(16526019)(956004)(30864003)(2616005)(6916009)(86362001)(31686004)(2906002)(8676002)(478600001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 2PrRDzFfOyZ5gKj3joZDivMS0UKWkvl6M8lpTx+dSyG7Vxr2SdFU9BzMr83GHzVPR7opAQWaUPQYSPngIFTKMjhxz7vfK5bjVEL6y3Xy4jsklwv9LZ2jqp7DLZKgOD9VB3EJsHWfpPnSdjaq13px6l6rHhh7R2v3zo/2YccWDwIEh1+wn3DAM9aFubxR/yzPjWeYpiYPq4YTkEg4hebVB2ppj20RNTdhpZU9aD0oZd9vl1HUWe4CBRQUYeCoumB+WKMJJ1mpDWxIdRZm8bBIMcGJP4ThQ4jTcvsSjy8QcxA8500ebX3mqSHrSHicwU1M1WLUyXlUSXlBiWvTksthtOGw4yqpCR4tjwOZuT2pg72zighRshwXGTOlYzIMLCcvlqU/S8yClWxRR1qe6SaI4Y5Wb9ReDvZgLe8eJk6bqXeQycxROfQbkaEWNR9bsRDo/pEH3eZBbrLwwZxkkz6588JwHyV06xV9KWJ75SWJpt3CWkrfx4Hx26YgH6J/QYHbfEDam7GrxzWPnerMnV3UeZWasbPF+lyFniX3rNndFm72mPmdMQCNC0N27pE8sybHPyVs8Fh6Boa82MWu9Baz228YH2ZVpeO1ZmxGenCh4lPyYcycPD4HGHePTBz+jq/3oHlRCSZ90Gdho6Y9PnO3OA==
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d39ce62-7296-4875-0bcb-08d87c55c761
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 21:58:33.3874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W08VoRNupXurMmbvRYgpDQYw85YCHJ6OW43eQiOEduL2ZEGcAn5zjoP1pVxPdKd1zj1obmiTXOi139hJd3maqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB3687
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-10-29 4:41 p.m., Serg Tereshchenko wrote:
> Oh, this git-send-email is terrible. Is there good email client supporting
> plaintext messages which i can use for replying here?

I recommend Thunderbird, if you're a GUI type.

> I tried to send message, but only footer is delivered. Second try:
> 
>> Is there some way I can edit/view the theme definitions?
> 
> Themes is inside /usr/lib/tk8.6/ttk/, *Theme.tcl

Thanks.  Seems to be /usr/share/tcltk/tk8.6/ttk on my box.

Nothing in that directory sets that greyish color (#d6d2d0).

Perhaps it's some kind of KDE-theming-GTK-apps thing.

>> Unfortunately none of those gives me white panels, although I do see
>> other visual aspects change under different themes (also, `xrdb -query`
>> shows that the *Text.Background setting has applied).
> 
> This is strange.
> 
> I just checked `default` theme, and in my case panels are white by default.
> 
> I will check it on kubuntu later.
> 
> Can you show your `xrdb -query`?

*Box.background:        #d6d2d0
*Box.foreground:        #221f1e
*Button.activeBackground:       #d6d2d0
*Button.activeForeground:       #221f1e
*Button.background:     #d6d2d0
*Button.foreground:     #221f1e
*Button.highlightBackground:    #d6d2d0
*Button.highlightColor: #221f1e
*Canvas.activeBackground:       #ffffff
*Canvas.activeForeground:       #1f1c1b
*Canvas.background:     #ffffff
*Canvas.foreground:     #1f1c1b
*Canvas.highlightBackground:    #ffffff
*Canvas.highlightColor: #1f1c1b
*Canvas.selectbackground:       #43ace8
*Canvas.selectforeground:       #ffffff
*Checkbutton.activeBackground:  #d6d2d0
*Checkbutton.activeForeground:  #221f1e
*Checkbutton.background:        #d6d2d0
*Checkbutton.foreground:        #221f1e
*Checkbutton.highlightBackground:       #d6d2d0
*Checkbutton.highlightColor:    #221f1e
*Command.background:    #d6d2d0
*Command.foreground:    #221f1e
*Dialog.background:     #d6d2d0
*Dialog.foreground:     #221f1e
*Entry.activeBackground:        #ffffff
*Entry.activeForeground:        #1f1c1b
*Entry.background:      #ffffff
*Entry.foreground:      #1f1c1b
*Entry.highlightBackground:     #ffffff
*Entry.highlightColor:  #1f1c1b
*Entry.selectBackground:        #43ace8
*Entry.selectForeground:        #ffffff
*Form.background:       #d6d2d0
*Form.foreground:       #221f1e
*Frame.activeBackground:        #d6d2d0
*Frame.activeForeground:        #221f1e
*Frame.background:      #d6d2d0
*Frame.foreground:      #221f1e
*Frame.highlightBackground:     #d6d2d0
*Frame.highlightColor:  #221f1e
*Label.activeBackground:        #d6d2d0
*Label.activeForeground:        #221f1e
*Label.background:      #d6d2d0
*Label.foreground:      #221f1e
*Label.highlightBackground:     #d6d2d0
*Label.highlightColor:  #221f1e
*List.background:       #ffffff
*List.foreground:       #1f1c1b
*Listbox.activeBackground:      #ffffff
*Listbox.activeForeground:      #1f1c1b
*Listbox.background:    #ffffff
*Listbox.foreground:    #1f1c1b
*Listbox.highlightBackground:   #ffffff
*Listbox.highlightColor:        #1f1c1b
*Listbox.selectBackground:      #43ace8
*Listbox.selectForeground:      #ffffff
*Menu.activeBackground: #d6d2d0
*Menu.activeForeground: #221f1e
*Menu.background:       #d6d2d0
*Menu.foreground:       #221f1e
*Menu.highlightBackground:      #d6d2d0
*Menu.highlightColor:   #221f1e
*MenuButton.background: #d6d2d0
*MenuButton.foreground: #221f1e
*Menubutton.activeBackground:   #d6d2d0
*Menubutton.activeForeground:   #221f1e
*Menubutton.background: #d6d2d0
*Menubutton.foreground: #221f1e
*Menubutton.highlightBackground:        #d6d2d0
*Menubutton.highlightColor:     #221f1e
*Radiobutton.activeBackground:  #d6d2d0
*Radiobutton.activeForeground:  #221f1e
*Radiobutton.background:        #d6d2d0
*Radiobutton.foreground:        #221f1e
*Radiobutton.highlightBackground:       #d6d2d0
*Radiobutton.highlightColor:    #221f1e
*Scale.activeBackground:        #d6d2d0
*Scale.activeForeground:        #221f1e
*Scale.background:      #d6d2d0
*Scale.foreground:      #221f1e
*Scale.highlightBackground:     #d6d2d0
*Scale.highlightColor:  #221f1e
*Scale.troughColor:     #d6d2d0
*Scrollbar*Cursor:      left_ptr
*Scrollbar*background:  #d6d2d0
*Scrollbar*cursorName:  left_ptr
*Scrollbar*height:      15
*Scrollbar*pushThumb:   false
*Scrollbar*shadowWidth: 2
*Scrollbar*width:       15
*Scrollbar.activeBackground:    #d6d2d0
*Scrollbar.activeForeground:    #221f1e
*Scrollbar.foreground:  #221f1e
*Scrollbar.highlightBackground: #d6d2d0
*Scrollbar.highlightColor:      #221f1e
*Scrollbar.troughColor: #d6d2d0
*ScrollbarBackground:   #d6d2d0
*ShapeStyle:    Rectangle
*SimpleMenu*background: #d6d2d0
*SimpleMenu*foreground: #221f1e
*SmeBSB*shadowWidth:    3
*Text.activeBackground: #ffffff
*Text.activeForeground: #1f1c1b
*Text.background:       #ffffff
*Text.foreground:       #1f1c1b
*Text.highlightBackground:      #ffffff
*Text.highlightColor:   #1f1c1b
*Text.selectBackground: #43ace8
*Text.selectForeground: #ffffff
*Toggle.background:     #d6d2d0
*Toggle.foreground:     #221f1e
*Toplevel.activeBackground:     #d6d2d0
*Toplevel.activeForeground:     #221f1e
*Toplevel.background:   #d6d2d0
*Toplevel.foreground:   #221f1e
*Toplevel.highlightBackground:  #d6d2d0
*Toplevel.highlightColor:       #221f1e
*XmCascadeButton.background:    #d6d2d0
*XmCascadeButton.foreground:    #221f1e
*XmCascadeButtonGadget.background:      #d6d2d0
*XmCascadeButtonGadget.foreground:      #221f1e
*XmDialogShell.background:      #d6d2d0
*XmDialogShell.foreground:      #221f1e
*XmFileSelectionBox.background: #d6d2d0
*XmFileSelectionBox.foreground: #221f1e
*XmForm.background:     #d6d2d0
*XmForm.foreground:     #221f1e
*XmFrame.background:    #d6d2d0
*XmFrame.foreground:    #221f1e
*XmLabel.background:    #d6d2d0
*XmLabel.foreground:    #221f1e
*XmLabelGadget.background:      #d6d2d0
*XmLabelGadget.foreground:      #221f1e
*XmList.background:     #ffffff
*XmList.foreground:     #1f1c1b
*XmMenuShell.background:        #d6d2d0
*XmMenuShell.foreground:        #221f1e
*XmMessageBox.background:       #d6d2d0
*XmMessageBox.foreground:       #221f1e
*XmPanedWindow.background:      #d6d2d0
*XmPanedWindow.foreground:      #221f1e
*XmPushButton.background:       #d6d2d0
*XmPushButton.foreground:       #221f1e
*XmPushButtonGadget.background: #d6d2d0
*XmPushButtonGadget.foreground: #221f1e
*XmRowColumn.background:        #d6d2d0
*XmRowColumn.foreground:        #221f1e
*XmSash.background:     #d6d2d0
*XmSash.foreground:     #221f1e
*XmScrollBar.background:        #d6d2d0
*XmScrollBar.foreground:        #221f1e
*XmScrolledWindow.background:   #d6d2d0
*XmScrolledWindow.foreground:   #221f1e
*XmSelectionBox.background:     #d6d2d0
*XmSelectionBox.foreground:     #221f1e
*XmSeparator.background:        #d6d2d0
*XmSeparator.foreground:        #221f1e
*XmSeparatorGadget.background:  #d6d2d0
*XmSeparatorGadget.foreground:  #221f1e
*XmTearOffButton.background:    #d6d2d0
*XmTearOffButton.foreground:    #221f1e
*XmTearOffButtonGadget.background:      #d6d2d0
*XmTearOffButtonGadget.foreground:      #221f1e
*XmText.background:     #ffffff
*XmText.foreground:     #1f1c1b
*XmTextField.background:        #ffffff
*XmTextField.foreground:        #1f1c1b
*XmToggleButton.background:     #d6d2d0
*XmToggleButton.foreground:     #221f1e
*XmToggleButtonGadget.background:       #d6d2d0
*XmToggleButtonGadget.foreground:       #221f1e
*background:    #d6d2d0
*beNiceToColormap:      false
*borderColor:   black
*foreground:    #221f1e
*rvplayer*Command.BorderColor:  #1f1c1b
*rvplayer*Command.background:   #d6d2d0
*rvplayer*Command.foreground:   #221f1e
*rvplayer*Label.BorderColor:    #1f1c1b
*rvplayer*MenuButton.BorderColor:       #1f1c1b
*rvplayer*MenuButton.background:        #d6d2d0
*rvplayer*SepLine.BorderColor:  #d6d2d0
*rvplayer*SepLine.bottomShadowPixel:    #ffffff
*rvplayer*SepLine.topShadowPixel:       #615f5e
*rvplayer*SimpleMenu.BorderColor:       #615f5e
*rvplayer*SimpleMenu.background:        #d6d2d0
*rvplayer*SimpleMenu.foreground:        #221f1e
*rvplayer*SmeBSB*fgInsensitive: #ffffff
*rvplayer*Vslider.thumbPixel:   #ffffff
*rvplayer*authortext.background:        #d6d2d0
*rvplayer*authortext.bottomShadowPixel: #ffffff
*rvplayer*authortext.topShadowPixel:    #615f5e
*rvplayer*background:   #d6d2d0
*rvplayer*copyrighttext.background:     #d6d2d0
*rvplayer*copyrighttext.bottomShadowPixel:      #ffffff
*rvplayer*copyrighttext.topShadowPixel: #615f5e
*rvplayer*proptext.background:  #d6d2d0
*rvplayer*proptext.foreground:  #221f1e
*rvplayer*statusback.background:        #d6d2d0
*rvplayer*statusback.foreground:        #221f1e
*rvplayer*statustext.background:        #d6d2d0
*rvplayer*statustext.foreground:        #221f1e
*rvplayer*timeinfotext.background:      #d6d2d0
*rvplayer*timeinfotext.bottomShadowPixel:       #ffffff
*rvplayer*timeinfotext.foreground:      #221f1e
*rvplayer*timeinfotext.topShadowPixel:  #615f5e
*rvplayer*timeslider.bottomShadowPixel: #ffffff
*rvplayer*timeslider.foreground:        #d6d2d0
*rvplayer*timeslider.thumbPixel:        #ffffff
*rvplayer*timeslider.topShadowPixel:    #615f5e
*rvplayer*titletext.background: #d6d2d0
*rvplayer*titletext.bottomShadowPixel:  #ffffff
*rvplayer*titletext.topShadowPixel:     #615f5e
*rvplayer*volumeslider.bottomShadowPixel:       #ffffff
*rvplayer*volumeslider.topShadowPixel:  #615f5e
AcroRead.XmScreen.background:   #ffffff
AcroRead.XmScreen.borderColor:  #1f1c1b
AcroRead.borderColor:   #1f1c1b
Acroread.background:    #ffffff
Acroread.foreground:    #1f1c1b
Config*Text*background: #d6d2d0
Config*channel.background:      #d6d2d0
Config*key.background:  #d6d2d0
Config*list.background: #d6d2d0
Emacs*Background:       #ffffff
Emacs*Dialog*background:        #d6d2d0
Emacs*Dialog*foreground:        #221f1e
Emacs*Foreground:       #1f1c1b
Emacs*XlwScrollBar.Background:  #d6d2d0
Emacs*XlwScrollBar.Foreground:  #221f1e
Emacs*backgroundToolBarColor:   #d6d2d0
Emacs*bottomToolBarShadowColor: #d6d2d0
Emacs*menubar*background:       #d6d2d0
Emacs*menubar*foreground:       #221f1e
Emacs*popup*Background: #d6d2d0
Emacs*popup*Foreground: #221f1e
Emacs*toolBarShadowThickness:   0
Emacs*topToolBarShadowColor:    #d6d2d0
Emacs.default.attributeBackground:      #ffffff
Emacs.default.attributeForeground:      #1f1c1b
Netscape*XmLGrid.background:    #d6d2d0
Netscape*XmLGrid.foreground:    #1f1c1b
Netscape*XmList*background:     #ffffff
Netscape*XmList*foreground:     #1f1c1b
Netscape*XmText*background:     #ffffff
Netscape*XmText*foreground:     #1f1c1b
Netscape*XmTextField*background:        #ffffff
Netscape*XmTextField*foreground:        #1f1c1b
Netscape*background:    #d6d2d0
Netscape*bottomShadowColor:     #615f5e
Netscape*defaultBackground:     #ffffff
Netscape*foreground:    #221f1e
Netscape*highlightColor:        #d6d2d0
Netscape*power.LED.background:  #d6d2d0
Netscape*power.LED.foreground:  #43ace8
Netscape*selectBackground:      #43ace8
Netscape*selectColor:   #d6d2d0
Netscape*selectForeground:      #ffffff
Netscape*thermo.slider.background:      #d6d2d0
Netscape*thermo.slider.foreground:      #43ace8
Netscape*topShadowColor:        #ffffff
Netscape*urlLabel*background:   #ffffff
Netscape*urlLabel*foreground:   #1f1c1b
Netscape*urlText*background:    #ffffff
Netscape*urlText*foreground:    #1f1c1b
Streamer*Text*background:       #d6d2d0
TopLevelShell*background:       #d6d2d0
TopLevelShell*foreground:       #221f1e
UXterm*background:      #ffffff
UXterm*foreground:      #1f1c1b
UXterm.SimpleMenu*background:   #d6d2d0
UXterm.SimpleMenu*foreground:   #221f1e
WPFMShell*MenuBar*background:   #d6d2d0
WPFMShell*MenuBar*foreground:   #221f1e
WPFMShell*XmDialogShell*XmDrawingArea*background:       #ffffff
WPFMShell*XmDialogShell*XmDrawingArea*foreground:       #1f1c1b
WPFMShell*XmDialogShell*XmList*background:      #ffffff
WPFMShell*XmDialogShell*XmList*foreground:      #1f1c1b
WPFMShell*XmDialogShell*XmScrolledWindow*XmDrawingArea.background: 
#ffffff
WPFMShell*XmDialogShell*XmScrolledWindow*XmDrawingArea.foreground: 
#221f1e
WPFMShell*XmDialogShell*XmText*background:      #ffffff
WPFMShell*XmDialogShell*XmText*foreground:      #1f1c1b
WPFMShell*XmDialogShell*XmTextField*background: #ffffff
WPFMShell*XmDialogShell*XmTextField*foreground: #1f1c1b
WPFMShell*XmDialogShell*background:     #ffffff
WPFMShell*XmDialogShell*foreground:     #221f1e
WPFMShell*XmDrawingArea*background:     #ffffff
WPFMShell*XmDrawingArea*foreground:     #1f1c1b
WPFMShell*XmList*background:    #ffffff
WPFMShell*XmList*foreground:    #1f1c1b
WPFMShell*XmScrolledWindow*XmDrawingArea.background:    #d6d2d0
WPFMShell*XmScrolledWindow*XmDrawingArea.foreground:    #221f1e
WPFMShell*XmText*background:    #ffffff
WPFMShell*XmText*foreground:    #1f1c1b
WPFMShell*XmTextField*background:       #ffffff
WPFMShell*XmTextField*foreground:       #1f1c1b
WPFMShell*background:   #d6d2d0
WPFMShell*foreground:   #221f1e
WPFMShell*menubar*background:   #d6d2d0
WPFMShell*menubar*foreground:   #221f1e
XWp*MenuBar*background: #d6d2d0
XWp*MenuBar*foreground: #221f1e
XWp*XmDialogShell*XmDrawingArea.background:     #ffffff
XWp*XmDialogShell*XmDrawingArea.foreground:     #1f1c1b
XWp*XmDialogShell*XmList*background:    #ffffff
XWp*XmDialogShell*XmList*foreground:    #1f1c1b
XWp*XmDialogShell*XmScrolledWindow*XmDrawingArea.background:    #ffffff
XWp*XmDialogShell*XmScrolledWindow*XmDrawingArea.foreground:    #221f1e
XWp*XmDialogShell*XmText*background:    #ffffff
XWp*XmDialogShell*XmText*foreground:    #1f1c1b
XWp*XmDialogShell*XmTextField*background:       #ffffff
XWp*XmDialogShell*XmTextField*foreground:       #1f1c1b
XWp*XmDialogShell*background:   #d6d2d0
XWp*XmDialogShell*foreground:   #221f1e
XWp*XmDrawingArea.background:   #ffffff
XWp*XmDrawingArea.foreground:   #1f1c1b
XWp*XmList*background:  #ffffff
XWp*XmList*foreground:  #1f1c1b
XWp*XmScrolledWindow*XmDrawingArea.background:  #d6d2d0
XWp*XmScrolledWindow*XmDrawingArea.foreground:  #221f1e
XWp*XmText*background:  #ffffff
XWp*XmText*foreground:  #1f1c1b
XWp*XmTextField*background:     #FFFFFFFFFFFF
XWp*XmTextField*foreground:     #1f1c1b
XWp*background: #d6d2d0
XWp*foreground: #221f1e
XWp*menubar*background: #d6d2d0
XWp*menubar*foreground: #221f1e
XWp*popmenu*background: #d6d2d0
XWp*popmenu*foreground: #221f1e
XWp.form.controlbar.menubar.CBHlpButton*background:     #d6d2d0
XWp.form.hscrollbar.background: #d6d2d0
XWp.form.rulerframe.ruler*background:   #d6d2d0
XWp.form.scrollbar0.background: #d6d2d0
XWp.mainWindowForm.mainWindowMenubar*background:        #d6d2d0
XWp.mainWindowForm.mainWindowMenubar*foreground:        #221f1e
Xawtv*Dialog.value.background:  #d6d2d0
Xawtv*background:       #d6d2d0
Xawtv*foreground:       #221f1e
Xcursor.size:   0
Xcursor.theme:  Breeze_Snow
Xft.antialias:  1
Xft.hinting:    0
Xft.hintstyle:  hintnone
Xterm*background:       #ffffff
Xterm*foreground:       #1f1c1b
Xterm.SimpleMenu*background:    #d6d2d0
Xterm.SimpleMenu*foreground:    #221f1e
editres*Panner.Background:      #d6d2d0
editres*Tree.Background:        #ffffff
editres*Tree.Foreground:        #1f1c1b
editres*Tree.Toggle.Background: #d6d2d0
editres*Tree.Toggle.Foreground: #221f1e
git-gui*Text.Background:        white
ml*XmCascadeButton.marginHeight:        2
ml*XmCascadeButton.marginWidth: 8
ml*XmForm*bottomOffset: 0
ml*XmForm*topOffset:    0
ml*XmForm*verticalSpacing:      0
ml*XmList*background:   #ffffff
ml*XmList*foreground:   #1f1c1b
ml*XmList*highlightThickness:   0
ml*XmPushButton.marginHeight:   1
ml*XmRowColumn*marginHeight:    1
ml*XmRowColumn*spacing: 0
ml*XmRowColumn.entryBorder:     0
ml*XmText*background:   #ffffff
ml*XmText*foreground:   #1f1c1b
ml*XmTextField*background:      #ffffff
ml*XmTextField*foreground:      #1f1c1b
ml*XmToggleButton.marginHeight: 1
ml*background:  #d6d2d0
ml*borderWidth: 0
ml*focusPolicy: pointer
ml*foreground:  #221f1e
ml*helpwin*textSW.text.background:      #ffffff
ml*helpwin*textSW.text.foreground:      #1f1c1b
ml*highlightColor:      #d6d2d0
ml*log*textSW.text.background:  #ffffff
ml*log*textSW.text.foreground:  #1f1c1b
ml*marginHeight:        2
ml*marginWidth: 3
ml*selectColor: #d6d2d0
ml*textSW.text.background:      #ffffff
ml*textSW.text.foreground:      #1f1c1b
ml.form.height: 550
ml.form.width:  650
nedit*background:       #d6d2d0
nedit*foreground:       #221f1e
xcalc*background:       #d6d2d0
xcalc*bevel.screen.LCD.background:      #ffffff
xcalc*bevel.screen.LCD.foreground:      #1f1c1b
xcalc*foreground:       #221f1e
xdvi.background:        white
xosview*background:     #d6d2d0
xosview*foreground:     #221f1e
xosview*meterLabelColor:        #221f1e
xosview*usedLabelColor: #221f1e
xpdf.background:        #d6d2d0
xpdf.foreground:        #221f1e
xpdf.urlCommand:        kfmclient exec %s

		M.

