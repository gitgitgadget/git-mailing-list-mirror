Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E171C433E0
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 10:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 110032073E
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 10:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qliktechnologies365.onmicrosoft.com header.i=@qliktechnologies365.onmicrosoft.com header.b="FmaL1a+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgGXK0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:26:17 -0400
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:64352
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbgGXK0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 06:26:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9qNDjKTZzEn0+L7zv3IZyWefszVCPrJ6p8HYIieVm4vtOATY+zMnQsChkVDNEdE0HjAfH9RH0wcXtKmmdFDxJZoltbVKU2PVoN8s9qb1NsAAZSk1ipKibpCJ/2coelkdTEpME3IbcZq3zTXaQOAA4HSUV4g/st9D11YqO0pbY9fl2pCsqGfNn+A4kKDT1L7f+4J3IoKomqv0Bri9pULqvgzeYDeQ0UoEngphOg2L8TT6gmy/XyvGbz1BzlKFEeVEO/Rxic6WF4oAWyWWkjzz+Ox0VjrnOF3Qy+hBA4jkxLpaQ01+b15QgD5S0W9BSRnqSXfMdcjkNYpLVXpG/fkdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XA5+GaBxUhS7wxu6b0TZ5KnsxUCphp5Q3343nWg122g=;
 b=HeGNjNiG8Fr8eI9m8rPZCJF+2bFBbYsuXLe2ug5speYPY+k3liCeKq/K6VfL87Gx9qSJrKDCSpxRLjdXc5B7eGFnoghZUv9eGsEIryf+IAw1DDtZL+Z6fAIMZ34bNg0zxsJ3GeTObD9/2LGscDmHRWdUoARKAaJvaRnAtJjNNQBTrkLB+vBoUeyy1Gs7C17RQfMI3Djnd34gt5u7oSQd6Zx3Az0Gkn06hZPqrtA0cXv5WnGlpqdJ+1LIYa0pfcjePMeyDNITdZARjVshxXp/TRYBtpNvshYCjqxn1npH1epj4r7VYtUTKagBcS04Xayxo34t4k+oPUl8YPLEOXdI6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qlik.com; dmarc=pass action=none header.from=qlik.com;
 dkim=pass header.d=qlik.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qliktechnologies365.onmicrosoft.com;
 s=selector2-qliktechnologies365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XA5+GaBxUhS7wxu6b0TZ5KnsxUCphp5Q3343nWg122g=;
 b=FmaL1a+7FLcQZNNSiSIVoriWiB/yxSoTRCqc6HzX1/6a9MKlp9+k5V6DWXEXpr5AZ9eHVdE77To7P5zWhTB/yWUUybs6XCrepyYWUZ9c9djaodvh+SposIQSpgOQGN/2z4/Gr4zXkHCRauVbLA7fN/fTnxbv9On5itjvit+8fDU=
Received: from DM5PR1801MB2076.namprd18.prod.outlook.com (2603:10b6:4:67::15)
 by DM5PR1801MB2076.namprd18.prod.outlook.com (2603:10b6:4:67::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Fri, 24 Jul
 2020 10:26:14 +0000
Received: from DM5PR1801MB2076.namprd18.prod.outlook.com
 ([fe80::d38:3357:7d56:a2cd]) by DM5PR1801MB2076.namprd18.prod.outlook.com
 ([fe80::d38:3357:7d56:a2cd%3]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 10:26:14 +0000
From:   Tommaso Ercole <Tommaso.Ercole@qlik.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Creation of a branch named that has a directory prefix equal to the
 name of another branch fail.
Thread-Topic: Creation of a branch named that has a directory prefix equal to
 the name of another branch fail.
Thread-Index: AdZhCltmYBIPi/IgS2mYGSlTAcNUJQAmkNBg
Date:   Fri, 24 Jul 2020 10:26:14 +0000
Message-ID: <DM5PR1801MB20762477763E6298C7FE6315F0770@DM5PR1801MB2076.namprd18.prod.outlook.com>
References: <DM5PR1801MB2076F807C0B9F29A152DBEB7F0760@DM5PR1801MB2076.namprd18.prod.outlook.com>
In-Reply-To: <DM5PR1801MB2076F807C0B9F29A152DBEB7F0760@DM5PR1801MB2076.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=qlik.com;
x-originating-ip: [212.124.176.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee4c2d91-36bc-41f9-5377-08d82fbbfe3a
x-ms-traffictypediagnostic: DM5PR1801MB2076:
x-microsoft-antispam-prvs: <DM5PR1801MB2076D330461A5C88DA23FCFEF0770@DM5PR1801MB2076.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gFxZPTGX2Gtr1VHTxqm+8/BsSl6jwN2o5y+bLS5rHk2pEF7MLzFIZuo7H7xutF0YpZbGYvD5gcNXbhKKI4jGXpLOJwAqiUg7ggyTOzMxD1xcYIML8ToHeFv1TF8b4Bsq71UJGBnxoyGnJVoYF82qmk1HnER/AS8GRz8G7USHFNTJmaF3sUfQsGphweuBrWJaVU28mtybXS7YxOGeA3QfWVfiPPXq6HRj56pypGa+OL6uO4BBYhFgikMJoXaqAmP38C39xesbnudqST7pIHJv0nVF+cC2O+qaDFJCNGgVRr2RzXZEyCVYXq28OQkoGHADf6fT/PUfoe3lr+SB9GIcn8lmqv0127QNH/YBnwRf0yYRoeFJJDuGtT7FpU6ybhZvfVRpbbhUu6iWnCZwf0PBPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1801MB2076.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(6916009)(5660300002)(55016002)(52536014)(2906002)(86362001)(186003)(316002)(478600001)(71200400001)(9686003)(8936002)(8676002)(966005)(66556008)(66946007)(64756008)(66446008)(66476007)(4744005)(99936003)(7696005)(76116006)(6506007)(33656002)(83380400001)(66616009)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: br8yQHfjtqqMNyTJdLMluBMw3HD5N6XYwQYuc9P3kCda5o5PYeLbi8V6WjAkTda4jkmTrofbOMw977GCWrpzJjClug31lhZdCYWIvHDV1k4FXosd4Bf15VUExV7+B6ffdIba6Gdn96+e4aJSbEvftGkWJp4OoJu56o48WTZtOMI2nkfDUBmVFI8/TYpN8oAE08IA+tzvZpBoP9LXTW9upQDBXy1wF/vPwH+uUHAiXoqFzGTw2j1U9HNWMgKgOyfznW421I785eb6Tja1wHJbfvS8WdMci7hUYTolynxSY/ZS9xDi6negCCyyL9VRyOVuw31Gn/9zHuCS7Yf6NnSBK0V+cH6zJLJPd6kDwIwX90FyJdiWCvFgRmMwOoDtnYoxRJ04/LaZVRztKF9hAh7zXu0ffadMRNxOmt95wXuPEekzZyW7wee46jld9kHEB3zB/WfOTOiqZ8RE27VcXLuWeSuCvDg2FDUK4WQTd5lh5JxRk33SYO1YvoPZjpQSPzXE
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
        boundary="_002_DM5PR1801MB20762477763E6298C7FE6315F0770DM5PR1801MB2076_"
MIME-Version: 1.0
X-OriginatorOrg: qlik.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1801MB2076.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4c2d91-36bc-41f9-5377-08d82fbbfe3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 10:26:14.1781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c21eeb5f-f5a6-44e8-a997-124f2f7a497c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clm38kw6kvHdhFzmvRu5Cqlf6mIRMhzkRtwTMOnStTjdLwspW8uFw7OJ+D5U6RCz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1801MB2076
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--_002_DM5PR1801MB20762477763E6298C7FE6315F0770DM5PR1801MB2076_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

As per compiled bug report, creation of a branch that has a prefix that map=
 to a folder, when that prefix is just an existing branch in the repo fails=
.

I.E. 'a/b/c' when 'a/b' just exists.

Best regards,
Tommaso Ercole=20
Head Programmer
Content Delivery

Mobile: +39 328 7182833
Email:=A0 mailto:tommaso.ercole@qlik.com=20
Skype:=A0 live:tommaso.ercole

Qlik
via Brescia 31
36040 Torri di Quartesolo - Vicenza - Italy=20

http://www.qlik.com/
http://qlik.com/

The information transmitted is intended only for the person or entity to wh=
ich it is addressed and may contain confidential and/or privileged material=
. Any review, retransmission, dissemination or other use of, or taking of a=
ny action in reliance upon, this information by persons or entities other t=
han the intended recipient is prohibited. If you received this in error, pl=
ease contact the sender and delete the material from any computer.


--_002_DM5PR1801MB20762477763E6298C7FE6315F0770DM5PR1801MB2076_
Content-Type: text/plain; name="git-bugreport-2020-07-23-1754.txt"
Content-Description: git-bugreport-2020-07-23-1754.txt
Content-Disposition: attachment; filename="git-bugreport-2020-07-23-1754.txt";
	size=739; creation-date="Thu, 23 Jul 2020 16:00:38 GMT";
	modification-date="Thu, 23 Jul 2020 16:00:49 GMT"
Content-Transfer-Encoding: base64

Q3JlYXRpbmcgYSBicmFuY2ggYS9iL2Mgd2hlbiBhL2IgZXhpc3RzIGZhaWxzIGNvbXBsYWluaW5n
IHRoYXQgYSByZWYgJ2EvYicganVzdCBleGlzdHMuCgpUaGlzIGlzIHByb2JhYmx5IGR1ZSB0byB0
aGUgZmFjdCB0aGF0IHdoZW4gY3JlYXRpbmcgYS9iIGEgZGlyZWN0b3J5ICdhJyBpcyBjcmVhdGVk
IGluc2lkZSAKJ3JlZnMvaGVhZHMnIGFuZCBhIGZpbGUgJ2InIGlzIGNyZWF0ZWQgdW5kZXIgdGhl
IGEgZGlyZWN0b3J5LCBhdm9pZGluZyB0aGUgc3Vic2VxdWVudCBwb3NzaWJpbGl0eSAKdG8gY3Jl
YXRlIGEgZm9sZGVyICdiJyBpbiB0aGUgc2FtZSBkaXJlY3RvcnkgdGhhdCBpcyBuZWVkZWQgdG8g
Y3JlYXRlIHRoZSByZWYgZm9yICdhL2IvYycKClRoZSBzb2x1dGlvbiBzZWVtcyB0byBhcHBlbmQg
dG8gdGhlIGZpbGUgYW4gZXh0ZW5zaW9uIHRvIGRpc2FtYmlndWF0ZSB0aGUgZmlsZSBmcm9tIHRo
ZSBmb2xkZXIuCgpbU3lzdGVtIEluZm9dCmdpdCB2ZXJzaW9uOgpnaXQgdmVyc2lvbiAyLjI3LjAu
d2luZG93cy4xCmNwdTogeDg2XzY0CmJ1aWx0IGZyb20gY29tbWl0OiA5MDdhYjEwMTFkY2U5MTEy
NzAwNDk4ZTAzNGI5NzRiYTYwZjhiNDA3CnNpemVvZi1sb25nOiA0CnNpemVvZi1zaXplX3Q6IDgK
dW5hbWU6IFdpbmRvd3MgMTAuMCAxODM2MyAKY29tcGlsZXIgaW5mbzogZ251YzogMTAuMQpsaWJj
IGluZm86IG5vIGxpYmMgaW5mb3JtYXRpb24gYXZhaWxhYmxlCgoKW0VuYWJsZWQgSG9va3NdCg==

--_002_DM5PR1801MB20762477763E6298C7FE6315F0770DM5PR1801MB2076_--
