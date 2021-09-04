Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF74C433F5
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 08:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E97B60E76
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 08:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhIDIgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 04:36:23 -0400
Received: from pa-mailgate.prudential.com ([12.42.58.8]:22382 "EHLO
        pa-mailgate.prudential.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229618AbhIDIgX (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 4 Sep 2021 04:36:23 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Sep 2021 04:36:22 EDT
IronPort-SDR: mqja4AiHDvR1h0vBOTBE0OiC9OsnZ0UEuYg1im9WNe51FXzWjnMMVYIqMfUiIiSSYpwtC/BUkY
 bH6LPKBAYvwQ==
Received: from p2erscba1085.prudential.com (HELO ironportpaprod.prudential.com) ([161.151.153.21])
  by ironportpaprod.prudential.com with ESMTP; 04 Sep 2021 04:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qmaw.com; i=@qmaw.com; q=dns/txt; s=20210720;
  t=1630744093; x=1662280093;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=FJI0LIDs17jYJPzu3ucln/O1vaA73wO4B7MG9IG9HOQ=;
  b=VlgiEoO9gT3cW7ZtIq3IUr7Ktk5qEV20UqyZwai52gvr9qQxIvAqQWOe
   +eBhZadrhD6L+9O54PXFDot6eiOco8Z4GBT59y+3bwN+H/yUlMfltB9IE
   tWRM3ptSnbu8lxr++BXLNlx8k/N33b3+jaKZ1o6JRBWhD5mW26AiYDSyB
   ULl5ZEYjhAgh7xnX33ZmlH3v2VIP3GIx0Etzevw6SUu0S6kKBFgdNnB+f
   AqxYD0uq9eNRjSdsnYAMqP4XgqqIPiOKNGV2IpLG24m0RW79ZpwNxmuk1
   YAju82T2yfU48EMoHPqZjS9J+HtHK46YusvsDP5vgzy9jM5HDeIoe5+su
   Q==;
IronPort-SDR: h2YBBCNoGGggotSMEhy4oZXNrfD5TBxPJiO61VIrOEo+Uo+W8Mj2gHsVWTVJu2aA+q0AFWccQU
 YU/EvnbUfnHA==
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Abiwwo6+J+PDOoFejuq5uk+HPdb1zdoMgy1?=
 =?us-ascii?q?knxilNoHxuGvBw9vre0cjzuiWZtN98Yh4dcN27UpVoIkm9yXcW2/haAV7KZm?=
 =?us-ascii?q?DbVXOTR72KhbGSoAEIcBeeygcy78ldmpxFeb/N5BVB/LzHCQ+DfurJubK8ge?=
 =?us-ascii?q?iVrNab600oYRBhaqlm4Qs8IjujKEV4SCxHApgiULGd+/VKrSenYh0sH7qG7s?=
 =?us-ascii?q?puZZm9mzVm/KiWByIuNloC0k2jnDmo4Ln1H1yzxREFSQ5Cxr8k7CzsjxH5zr?=
 =?us-ascii?q?/LiYDN9jbsk0voq7hGktrozdVOQOaWjNIOFznqggG0IKx8Rry5uiwvqu3H0i?=
 =?us-ascii?q?dfrDD1mWZXAy1P0QKiQoj1m2qf5+DY6kdf15Y28y7svZONzPaJOA7SRfAxzL?=
 =?us-ascii?q?6w33PimjcdVepHocZ2NlSixuNq5CP77UHADufzJnZXf2qP0AIfeL0o/gdiuM?=
 =?us-ascii?q?0lGc5sRdp1xjIfLKs9?=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+YzCPk37HIlsrvzHv5z+0JTvSH2U488fx37zFxeZjd8jLikLv1Dp2Q8o5jUgpO0lsbZc/HZSf0G3NE58gj+L1yCvs7iBQk+kC+HUXvWsjy8f/+wWm428uC1T+aMFdNmWbx+DhSdle0Jwi7UdslcRDDuHpbDbz6kI1wh//prJYIIBfiC5VIQ2REg6qfNrdQfLE+oW8XEdExnLwAOJJMpQULYlfuC9G61EZQWUkDRdkKbt1cf0qIIBgeqGcUZjaySFDFeXJ1q5EH9msZu3o9CX6JLUL1e+Hq1TEcBQlk3hD4JOs20lNweRuk7D1UDDN4qZv/aXWQ1GLm77fBvFPDI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=2v9htvMy9NM21eD1UIIEwNo+w1in8HKvY3iSU7w2Exo=;
 b=KGckQ47oaS8teycnhvBo5NNCROnavQgaWpst9ouDFIA6Yngkp5lUdKJX7oEASylDEwciDy5hzxFESNed5NDjqFTxmcNsarEsWYG4RO5x/yjGkKIZaCGlRDoKhcT7930i64dMACRxXxaYSidMShfmUNjC9JRf/LgZRqvCUNkiVLbasJw7xdysjjCglpDJZHC53pD4jnxHx3kLvFE4ALXOtchhN5x+Wh8xlyfZaVjosvtk0K5zK4iXBvfLZVe3+FUUT93CrDs9+unLtsbrzIdD04dRnsb5sMGMBrSfxKJnApDKG+n0dJ12UfEfSCf4KJCiBdIRo+3u/JH2AQauWjWDHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qmaw.com; dmarc=pass action=none header.from=qmaw.com;
 dkim=pass header.d=qmaw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prudentialus.onmicrosoft.com; s=selector1-prudentialus-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2v9htvMy9NM21eD1UIIEwNo+w1in8HKvY3iSU7w2Exo=;
 b=JPDE53Z4UplVnOq5CKY8GeH/Ah3iCccjEitzopr5ACBjH1cZQGTGYM9zmo+Op1TYOwk4nVBQbh6K4LFIcAGNbs093O3fphDjsaJamMXbKBAMaVHZuHba9GQzwEvUqSKoUtbtz2ML+nQGLM71UYwKktqi8jv5XV6WvC4b5Godw6g=
Received: from DM4PR11MB5247.namprd11.prod.outlook.com (2603:10b6:5:38a::20)
 by DM5PR11MB1804.namprd11.prod.outlook.com (2603:10b6:3:114::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Sat, 4 Sep
 2021 08:27:26 +0000
Received: from DM4PR11MB5247.namprd11.prod.outlook.com
 ([fe80::7c09:f60b:db82:620a]) by DM4PR11MB5247.namprd11.prod.outlook.com
 ([fe80::7c09:f60b:db82:620a%7]) with mapi id 15.20.4478.022; Sat, 4 Sep 2021
 08:27:26 +0000
From:   Ed Avis <ed.avis@qmaw.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git switch after bisect finished
Thread-Topic: git switch after bisect finished
Thread-Index: AQHXoWaaVyHWZFZL5EiZfQvaovv/KQ==
Date:   Sat, 4 Sep 2021 08:27:26 +0000
Message-ID: <DM4PR11MB524708327BB7F403E29720579DD09@DM4PR11MB5247.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 6a757dd1-8c44-9c17-45d3-889b77db78ac
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=qmaw.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96b9809b-f805-41e6-9c20-08d96f7dd395
x-ms-traffictypediagnostic: DM5PR11MB1804:
x-microsoft-antispam-prvs: <DM5PR11MB18043526C65A1013E8C377E09DD09@DM5PR11MB1804.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C88OCZFmjCuNldMtRxRIECZaFOtaWuQhxURDGfPhYPt41QRmns4OJnTP86ySW1lxn7QbRyTCToO6hLgtkyiibh1X8VLEvaYwP2Hkh0DXPDU8rYA1cjR4Bqg5kS9MFbcdnGli3FYqGnkXMf1JQRA4EfnZtOro5VEyjXLrKSNF9iMhh/MqmIFvp/eNFxga66zkG8BcOTGQz904VGo03dfTZ75pvmTKb4cHKfRTzsfSw17MiB/UXqLl9Vt6UgW9bVsaEmrxdsyevKsh1y5/7kNpqBtkkqG7IvIN3rD41/ltgrdwxnQK9XTth4TrP6mHYgNQ2MDlkqZlHxnVC/xa/d7DSA7y8rpfLG6DLARC5eyKcCgarulyxKanzPlUzWZwiO1sexDdjQD5+TpFJCbXWvn+UEy/+mwXxE8Ch64V23HXRP/7CQDx8zjeAgv3OQPy1RPrNALRXjAv8pYaIxePEUi1AwWPPiPvBh0X9BFKie4JnbjPxuqBVhKBykN8MrI28uKFDB0xPb0YlBySUazpZwfjODHnUEzpf3GHo86dNJSKr13hJM7nKtCZ69yGTLRqVxFAZ9a6w8itA9damWETHQVmeCXIhpWeIUQBWQ36HG8KblgyDhWi1FjUHn8gE8zq21BkQzoLfA27lPthssydbdaZbstyMWNlJTQJf4+jZyB7EHBIyTUDuMgTV9pPhfnvN3KCbCko/5Z8lmWhE9d/CRTfvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5247.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(38070700005)(33656002)(91956017)(66556008)(76116006)(66476007)(316002)(64756008)(66946007)(6506007)(66446008)(8676002)(2906002)(9686003)(508600001)(44832011)(38100700002)(186003)(122000001)(55016002)(6916009)(71200400001)(7696005)(8936002)(5660300002)(52536014)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BhCRRHJ2s1bWXsC9OMA5rmPw4OpP+vqGaUfJPhwCgCCpZ2Jw00Cml65kXI?=
 =?iso-8859-1?Q?dCCBbdQKTWGpiHaPUs4cCuqrcJgfd1919W92hRwX+aSPxhpnWFeH+0Juxk?=
 =?iso-8859-1?Q?EqMUM48fe5j9zJX1rwULc6LGPE1NbRIAxuBZHi0BLMSa/LS0Z/+sgrh/Qb?=
 =?iso-8859-1?Q?7V+4dq7futdlnYUnh2B5moyuWDaJYWGid5J4WlX6RCv3oFeZxDbP03QXl8?=
 =?iso-8859-1?Q?9SBrxt8wne2yB6l2a4PzHkUYM6uk4BxmCI6aiMRDsgm9CmEFUsSoi5SLTJ?=
 =?iso-8859-1?Q?qtSaoGWrS1f7nuEXlwAGOexXTPmvL9mwp3sI1sXBqZNbvBLzv4QSYHdx9h?=
 =?iso-8859-1?Q?ona7nElhgxJf7Ptv+WUdKPeBBxq7s0qci/fmkFZt2VEvE7J2pVJoMQnnmk?=
 =?iso-8859-1?Q?LipStw17Ny6AEtK/DgP6znbJrR9ACSP/MEB07cLvAYiv3WIano+xHIDP8J?=
 =?iso-8859-1?Q?oaCZ3aE15eMuNthZJ9XEUHxafKp5xIl00movXmCWGtao22X0Vw9YRcks1/?=
 =?iso-8859-1?Q?tbSLETptt5eY/3NlLvJD5tFnf1Ruvi2oJPiFaYsrvnkhosdB5FFAM7LQDI?=
 =?iso-8859-1?Q?rmXQSxCBC5ktRKJ3p1IGwq5WaXWo+/+0fc5ny0urTvPjMT0BJkH25JhODk?=
 =?iso-8859-1?Q?wh/57TW6J7BnZPiWYfpHk9PdYBZaWGEH3X2HKwtpdpaCQ7LwAPd7dJVzTh?=
 =?iso-8859-1?Q?CvQwhru9Xr6ahMF88mvOrjj6GftrjumV+DD0v+Yz7kp8RX6SUCygvh/ArT?=
 =?iso-8859-1?Q?Nt7tOa7AFlNKVllQT/eICw27H6lng+c29zYnp/+ZgNEw4z6BufEvd4GY43?=
 =?iso-8859-1?Q?pRhq8wLlyIOS73c5PqG/sz+0IDl+RDBs4mJxzxiMnx1kHUolCxkG35xECh?=
 =?iso-8859-1?Q?QO6JMsVSo1Lnh619YVliFR5tKv8SWIJBEet7o0axJabyILmUkE87Np8+c6?=
 =?iso-8859-1?Q?+mtBoQVEZgF43LSpvkg9M543c4tLbZkBzni2UvynExeXhjFaNA0XHhoMtz?=
 =?iso-8859-1?Q?s1CxQmNWdtDJw6KTuTTR4D5Lihb3cVhQ+ycCTO5906TI4G51Vw63Gho4PM?=
 =?iso-8859-1?Q?iQ6fCkvgChVtplBQX2gTPhrBWYhB0xrsTPINhnkYLYwVbbT+bfuSmNbw2H?=
 =?iso-8859-1?Q?5yj6Q0fx8azhAZWGiWTtUiUAOtdy6nhgB+gb53jMIhh0RPqFgjPGYIjg2f?=
 =?iso-8859-1?Q?HhjXgpWOKFCo+SKi7DbZvMwDABUvxStlbfK5nY4MsOUA7MyP6qXgdl7cib?=
 =?iso-8859-1?Q?pH5XITPo4N251/JPxcPZojqfCLViDQhmcOHZJsX4WmL+P+tWLp5rzJrnvr?=
 =?iso-8859-1?Q?01kaFzvumr4/hbxeYnWIDeSEdL2UMIU9MZqkEwyultCaR1fuEX9TTVLMJN?=
 =?iso-8859-1?Q?04eZCjUK1JghoFm8YFQ72EuVn8dIlcth9a0d606mQEhSEAK2XgFGxGo6ok?=
 =?iso-8859-1?Q?icKs44X7zZ4THRws?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qmaw.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5247.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b9809b-f805-41e6-9c20-08d96f7dd395
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2021 08:27:26.0162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8fde2f5-9392-4260-8a03-0ad01f4746e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QUvE8fc1BvC9YvDDuC55nWlGxQSxXqWO5dYij1n+3qs0iBqy2Irgn9+a1sBykI40PMOaW0o2CYDXbBIxMqTX5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1804
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Normally 'git switch -' switches back to whatever branch you were on last. =
 But if run after bisecting it gives an error:

% git switch mybranch
% git switch master
% git bisect start
% git bisect bad
% git bisect good HEAD~10
% git bisect bad [several times]
% git bisect reset
[goes back to master branch]
% git switch -

I expected it to switch back from master to mybranch but instead it gives a=
n error
fatal: a branch is expected, got commit 'abc...'

I suggest the internal switching done by 'git bisect' should not affect the=
 history saved for 'git switch -'.  Or 'git bisect reset' could also reset =
the history.

If that's not possible, then at least the error message could be improved.

--
Ed Avis <ed.avis@qmaw.com>
Please ignore confidentiality stuff after this point.

This email and any files transmitted with it are CONFIDENTIAL and are inten=
ded solely for the use of the individual(s) or entity to whom they are addr=
essed. Any unauthorised copying, disclosure or distribution of the material=
 within this email is strictly forbidden. Any views or opinions presented w=
ithin this email are solely those of the author and do not necessarily repr=
esent those of PGIM Limited, QMA Wadhwani LLP or their affiliates unless ot=
herwise specifically stated. An electronic message is not binding on its se=
nder. Any message referring to a binding agreement must be confirmed in wri=
ting and duly signed. If you have received this email in error, please noti=
fy the sender immediately and delete the original. Telephone, electronic an=
d other communications and conversations with PGIM Limited, QMA Wadhwani LL=
P and/or their associated persons may be recorded and retained. PGIM Limite=
d and QMA Wadhwani LLP are authorised and regulated by the Financial Conduc=
t Authority. PGIM Limited (registered in England No. 3809039) has its regis=
tered office at Grand Buildings, 1-3 Strand, Trafalgar Square, London WC2N =
5HR and QMA Wadhwani LLP (registered in England No. OC303168) has its regis=
tered office at 9th Floor, Orion House, 5 Upper St. Martin's Lane, London, =
England, WC2H 9EA.

Please note that your personal information may be stored and processed in a=
ny country where we have facilities or in which we engage service providers=
. If you provide personal information to us by email or otherwise, you cons=
ent to the transfer of that information to countries outside of your countr=
y of residence and these countries may have different data protection rules=
 than your country.

To learn about our privacy policies, please use this link<https://www.pgim.=
com/disclaimer/privacy-center> to read the Privacy Notices.
