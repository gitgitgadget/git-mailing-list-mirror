Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E0FC43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 01:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99EED21741
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 01:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SDO9K45K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgIOBJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 21:09:16 -0400
Received: from mail-bn8nam12on2078.outbound.protection.outlook.com ([40.107.237.78]:3435
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbgIOBJN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 21:09:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHx8z6gxmOZCrwJcpj4uLOKHrMSzDvwk1rJoyM5qUHV9tQ2P1dAw5LNREx2OY1Hs4DL1GWT4SFmSUOMsdE/qVTUu74EA3Ca//LXEn6UFju/wZjQQg3mu5tONMXE5fvQdzLWeseRq8n4N9dWZQstOuwL9Gsv9+Qm/91r8yGTVNp2oT9+Xt83vljITvJ5z6MwBAgp5/GJGk6UM8xBXM5fAimh3qzL63nIy1W0Pl5pQJ/tsTgrWdaaWyNZyE3o2HXOyFxZen3tXnB78xorLp1+fQ/ykUkQSjeoVOt7vIRbuHKmnmgDtekfWOfuQY2v++QcBsW62CB81bT8rQvEMJOvsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xOPplOrbDTPgx2HDMUqOsCmFRe+wqurBzIRk/jQ+tc=;
 b=XJ2DNt6OtPt8kTbkGtE9wZruwe+toGfG5WGHZ95XVb8T5qZS0qJmSAAmqKIceYx2nwdMdL+jxDcw6FfWo+34XtAVtwXs4kdtAgjChLKOqkYKu0bP2xDWmOAGK/wS8BHVE+DIvNi4JMaGzUL6lQ74OsiApkaNgDq6VVnDSMv48z1TjKCYeV925OZd20w7PyLlX6N5SzIxsDywCnhFX8YdoX0acTbVpFVauAmJ2mclOTIXqX5L0+PY9pdkXaZxRj2ebjFMvZ2ifKCSo4WTSUHp2r+qgnxGKnOqv28MvFHbDn/a1OE0JrAgYbBP0/WI/pc9Ft9OGSvi4fEQuKGRUDtMOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xOPplOrbDTPgx2HDMUqOsCmFRe+wqurBzIRk/jQ+tc=;
 b=SDO9K45KWKFchULQUrDBMvPT7MgHcDQoEm5WD7XDoYMvKL56khLHGpXO/3IU7ijVVkWdg/MpaC30laKMN6c7MRdwgwgKBHaDA14Xz1T7YGB4dPCEIyG/xaJawDIUpU55fKpwQXyD+qX+bwyrQZ5kIHnYnWBk0eZcp/66P7Xie/M=
Received: from DM6PR12MB3194.namprd12.prod.outlook.com (2603:10b6:5:184::13)
 by DM6PR12MB3801.namprd12.prod.outlook.com (2603:10b6:5:1cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 01:09:07 +0000
Received: from DM6PR12MB3194.namprd12.prod.outlook.com
 ([fe80::6538:6091:e95c:2c92]) by DM6PR12MB3194.namprd12.prod.outlook.com
 ([fe80::6538:6091:e95c:2c92%3]) with mapi id 15.20.3370.016; Tue, 15 Sep 2020
 01:09:07 +0000
From:   "Liu, Xuhui (Jackson)" <Xuhui.Liu@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug Report: git-p4 unshelve failed
Thread-Topic: Bug Report: git-p4 unshelve failed
Thread-Index: AdaK/KmQ4o3jE3cQQrWxCdzkqd7x/g==
Date:   Tue, 15 Sep 2020 01:09:07 +0000
Message-ID: <DM6PR12MB3194C9B3A462968FA5A05B4CFA200@DM6PR12MB3194.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Enabled=true;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SetDate=2020-09-15T01:08:03Z;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Method=Privileged;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Name=Non-Business;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ActionId=771b2964-10e8-4643-9528-0000a3d09f71;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ContentBits=0
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_enabled: true
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_setdate: 2020-09-15T01:09:04Z
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_method: Privileged
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_name: Non-Business
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_actionid: b6435944-4fcb-42b2-86ad-0000d0ecff7e
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_contentbits: 0
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 435587f6-28b0-418b-5f46-08d85913f253
x-ms-traffictypediagnostic: DM6PR12MB3801:
x-microsoft-antispam-prvs: <DM6PR12MB380150B943320C78CBD42155FA200@DM6PR12MB3801.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Xo7dSvRt98JyqX5mXmKFOyfpj2KkPqrtiZTJffw/zyASDhJiAyJ8+W1SVR6l3ocuIO+CBTniI+WenS6rBv4KVFe5yGaQELMkg3IQCE6PD3dK0l6JLGEPJztieLH0E+vyu1PFDUNInUhkUebNCZCW8vW00FM7rIVwNQhx6tiKYhqiOyKVUWjNIRfcFAjghNl+AZUUH4w/ziQmJM57SX1NYmOUB6KH5tOEKZHu0GqwAJqyWKk8z79zeYxpmB/0J6/ayUQfdgnq7j7wwIo6/bPpRwWnErkpp2o6EpUk2uGdvObH60sUknjO8B+z/QNxlbrAKTR2epKrz7GT+O/duD+YA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(6916009)(71200400001)(52536014)(8676002)(76116006)(33656002)(5660300002)(86362001)(66476007)(66946007)(64756008)(66616009)(66556008)(66446008)(8936002)(2906002)(186003)(9686003)(99936003)(26005)(6506007)(316002)(55016002)(4744005)(7696005)(478600001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: r1yJ2lAjtczbmj5nYt86aHHTv9xeKkSd03omPqll4ghYmV33EwDPGydQQgAxEnKQwmYInRyhM5pWxMQU48CEB+HiRoBSn98rrjEjLdJOzKUSSEzIuBfshvofdAKH3IJW9DT40BDUIfV3fLUggT+o9F59joH2yAy/GUQesT0DW93wX1+OR+fg8rILXC9uPvFSVYDaPtnjGJmH9yUrxLbHnVVNTi3sPMF8VeiczjxRT+2YW40D03cOPASNL+HrQf5Qh43V3/SVwmdqBBz0D1aErVDjOfG76bLtz11FYhPkRLkGyOlL4C8iCli5oBumsHdednOmngDDT7CBpoMGc7fVofXKv94NRblCVMjahXjm9JtF6WhKjw+6zIf0LlWacVmwmlvH4JaHl0u3LvvTJdLKzKMby0Y5bRujC1bUaMqjBg9WsmpyqqTaNLHZrDMeGyU4mZfZQiL02aPV8D0ouinTossEmOHXLKrdYpyxC7ceVDEhsnH0UFojHemrTB7v7SFvpY9w8aBldS1MrqGtsaW6iuMbURjO8DXtgrVvHM+GhL1/VZTVPJoGkcnctUJBX+60rBbl+50agS5Vhk+H5tzPfyX36/Co3b8PfrhAmA+pVNmMLTljRFCI+CsG0DPHAM+dNLyXgaPUJp0V6e94uiHopA==
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
        boundary="_002_DM6PR12MB3194C9B3A462968FA5A05B4CFA200DM6PR12MB3194namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435587f6-28b0-418b-5f46-08d85913f253
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 01:09:07.6566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZTnZX1OJ16WycVLtWpIz9MONiYqdkW1808454GRMq6KueALzL9Q1H6vtnk7Mc7yzz9lH3jiLMbje6lpoSutBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3801
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--_002_DM6PR12MB3194C9B3A462968FA5A05B4CFA200DM6PR12MB3194namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Git,
            When I use "git p4 unshelve 4495953", it failed.
	I have fixed this issue locally. You can check the attached for details.

What have I done to fix this:
            It's because the line#4240 in function "findLastP4Revision" of =
git-p4.py:
                        log =3D extractLogMessageFromGitCommit("{0}^{1}".fo=
rmat(starting_point, parent))
I think it should be:
            log =3D extractLogMessageFromGitCommit("{0}~{1}".format(startin=
g_point, parent))

Best Regards,
Jackson(Xuhui) Liu

---------------------------------------------------------------------------=
----------
1-14F, Tower 1, Candor Plaza No.669 Huanke Rd., Pudong District, Shanghai 2=
01210, China
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0
=A0


--_002_DM6PR12MB3194C9B3A462968FA5A05B4CFA200DM6PR12MB3194namp_
Content-Type: text/plain; name="git-bugreport-2020-09-15-0828.txt"
Content-Description: git-bugreport-2020-09-15-0828.txt
Content-Disposition: attachment; filename="git-bugreport-2020-09-15-0828.txt";
	size=2778; creation-date="Tue, 15 Sep 2020 01:09:00 GMT";
	modification-date="Tue, 15 Sep 2020 01:09:00 GMT"
Content-Transfer-Encoding: base64

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQ0KUGxlYXNlIGFuc3dl
ciB0aGUgZm9sbG93aW5nIHF1ZXN0aW9ucyB0byBoZWxwIHVzIHVuZGVyc3RhbmQgeW91ciBpc3N1
ZS4NCg0KV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8g
cmVwcm9kdWNlIHlvdXIgaXNzdWUpDQpnaXQgcDQgdW5zaGVsdmUgLXYgNDQ5NTk1Mw0KV2hhdCBk
aWQgeW91IGV4cGVjdCB0byBoYXBwZW4/IChFeHBlY3RlZCBiZWhhdmlvcikNCkkgd2FudCB0byBn
ZXQgc2hlbHZlZCBjaGFuZ2VsaXN0IDQ0OTU5NTMuDQpXaGF0IGhhcHBlbmVkIGluc3RlYWQ/IChB
Y3R1YWwgYmVoYXZpb3IpDQpJdCBmYWlsZWQuDQpIZXJlIGlzIHRoZSBvdXRwdXQgbG9nOg0KUmVh
ZGluZyBwaXBlOiBbJ2dpdCcsICctLWdpdC1kaXInLCAnL21udC9jL3dvcmtTcGFjZS9wcm9qZWN0
L2dpdDRwZXJmb3JjZS9pc3BEZXZlbG9wL3N0Z18zXzAvLmdpdCcsICdyZXYtcGFyc2UnLCAnLS1n
aXQtZGlyJ10NClJlYWRpbmcgcGlwZTogWydnaXQnLCAnLS1naXQtZGlyJywgJy9tbnQvYy93b3Jr
U3BhY2UvcHJvamVjdC9naXQ0cGVyZm9yY2UvaXNwRGV2ZWxvcC9zdGdfM18wLy5naXQnLCAncmV2
LXBhcnNlJywgJy0tZ2l0LWRpciddDQpSZWFkaW5nIHBpcGU6IFsnZ2l0JywgJ2NvbmZpZycsICdn
aXQtcDQubGFyZ2VGaWxlU3lzdGVtJ10NClJlYWRpbmcgcGlwZTogWydnaXQnLCAnY29uZmlnJywg
J2dpdC1wNC5zeW5jRnJvbU9yaWdpbiddDQpSZWFkaW5nIHBpcGU6IFsnZ2l0JywgJ2NhdC1maWxl
JywgJ2NvbW1pdCcsICdIRUFEXjAnXQ0KUmVhZGluZyBwaXBlOiBbJ2dpdCcsICdjYXQtZmlsZScs
ICdjb21taXQnLCAnSEVBRF4xJ10NClJlYWRpbmcgcGlwZTogWydnaXQnLCAnY2F0LWZpbGUnLCAn
Y29tbWl0JywgJ0hFQUReMiddDQpmYXRhbDogTm90IGEgdmFsaWQgb2JqZWN0IG5hbWUgSEVBRF4y
DQpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6DQogIEZpbGUgIi9ob21lL3h1aHVp
bGl1L2dpdHA0L2dpdC1wNC5weSIsIGxpbmUgNDQzOCwgaW4gPG1vZHVsZT4NCiAgICBtYWluKCkN
CiAgRmlsZSAiL2hvbWUveHVodWlsaXUvZ2l0cDQvZ2l0LXA0LnB5IiwgbGluZSA0NDMyLCBpbiBt
YWluDQogICAgaWYgbm90IGNtZC5ydW4oYXJncyk6DQogIEZpbGUgIi9ob21lL3h1aHVpbGl1L2dp
dHA0L2dpdC1wNC5weSIsIGxpbmUgNDI5NSwgaW4gcnVuDQogICAgc2V0dGluZ3MgPSBzZWxmLmZp
bmRMYXN0UDRSZXZpc2lvbihzZWxmLm9yaWdpbikNCiAgRmlsZSAiL2hvbWUveHVodWlsaXUvZ2l0
cDQvZ2l0LXA0LnB5IiwgbGluZSA0MjQwLCBpbiBmaW5kTGFzdFA0UmV2aXNpb24NCiAgICBsb2cg
PSBleHRyYWN0TG9nTWVzc2FnZUZyb21HaXRDb21taXQoInswfV57MX0iLmZvcm1hdChzdGFydGlu
Z19wb2ludCwgcGFyZW50KSkNCiAgRmlsZSAiL2hvbWUveHVodWlsaXUvZ2l0cDQvZ2l0LXA0LnB5
IiwgbGluZSA4NzUsIGluIGV4dHJhY3RMb2dNZXNzYWdlRnJvbUdpdENvbW1pdA0KICAgIGZvciBs
b2cgaW4gcmVhZF9waXBlX2xpbmVzKFsiZ2l0IiwgImNhdC1maWxlIiwgImNvbW1pdCIsIGNvbW1p
dF0pOg0KICBGaWxlICIvaG9tZS94dWh1aWxpdS9naXRwNC9naXQtcDQucHkiLCBsaW5lIDM0OSwg
aW4gcmVhZF9waXBlX2xpbmVzDQogICAgZGllKCdDb21tYW5kIGZhaWxlZDogJXMnICUgc3RyKGMp
KQ0KICBGaWxlICIvaG9tZS94dWh1aWxpdS9naXRwNC9naXQtcDQucHkiLCBsaW5lIDE1NiwgaW4g
ZGllDQogICAgcmFpc2UgRXhjZXB0aW9uKG1zZykNCkV4Y2VwdGlvbjogQ29tbWFuZCBmYWlsZWQ6
IFsnZ2l0JywgJ2NhdC1maWxlJywgJ2NvbW1pdCcsICdIRUFEXjInXQ0KDQpXaGF0J3MgZGlmZmVy
ZW50IGJldHdlZW4gd2hhdCB5b3UgZXhwZWN0ZWQgYW5kIHdoYXQgYWN0dWFsbHkgaGFwcGVuZWQ/
DQpJIHdhbnQgaXQgdG8gc3luYyA0NDk1OTUzLCBidXQgaXQgZmFpbGVkLg0KQW55dGhpbmcgZWxz
ZSB5b3Ugd2FudCB0byBhZGQ6DQpJIGhhdmUgZml4ZWQgaXQgbG9jYWxseS4NCkl0J3MgYmVjYXVz
ZSB0aGUgbGluZSM0MjQwIGluIGZ1bmN0aW9uICJmaW5kTGFzdFA0UmV2aXNpb24iIG9mIGdpdC1w
NC5weToNCiAgICAgbG9nID0gZXh0cmFjdExvZ01lc3NhZ2VGcm9tR2l0Q29tbWl0KCJ7MH1eezF9
Ii5mb3JtYXQoc3RhcnRpbmdfcG9pbnQsIHBhcmVudCkpDQpJIHRoaW5rIGl0IHNob3VsZCBiZToN
CiAgICAgbG9nID0gZXh0cmFjdExvZ01lc3NhZ2VGcm9tR2l0Q29tbWl0KCJ7MH1+ezF9Ii5mb3Jt
YXQoc3RhcnRpbmdfcG9pbnQsIHBhcmVudCkpDQoNClBsZWFzZSByZXZpZXcgdGhlIHJlc3Qgb2Yg
dGhlIGJ1ZyByZXBvcnQgYmVsb3cuDQpZb3UgY2FuIGRlbGV0ZSBhbnkgbGluZXMgeW91IGRvbid0
IHdpc2ggdG8gc2hhcmUuDQoNCg0KW1N5c3RlbSBJbmZvXQ0KZ2l0IHZlcnNpb246DQpnaXQgdmVy
c2lvbiAyLjI4LjANCmNwdTogeDg2XzY0DQpubyBjb21taXQgYXNzb2NpYXRlZCB3aXRoIHRoaXMg
YnVpbGQNCnNpemVvZi1sb25nOiA4DQpzaXplb2Ytc2l6ZV90OiA4DQpzaGVsbC1wYXRoOiAvYmlu
L3NoDQp1bmFtZTogTGludXggNC40LjAtMTgzNjItTWljcm9zb2Z0ICM4MzYtTWljcm9zb2Z0IE1v
biBNYXkgMDUgMTY6MDQ6MDAgUFNUIDIwMjAgeDg2XzY0DQpjb21waWxlciBpbmZvOiBnbnVjOiA5
LjMNCmxpYmMgaW5mbzogZ2xpYmM6IDIuMzENCiRTSEVMTCAodHlwaWNhbGx5LCBpbnRlcmFjdGl2
ZSBzaGVsbCk6IC9iaW4vYmFzaA0KDQoNCltFbmFibGVkIEhvb2tzXQ0K

--_002_DM6PR12MB3194C9B3A462968FA5A05B4CFA200DM6PR12MB3194namp_--
