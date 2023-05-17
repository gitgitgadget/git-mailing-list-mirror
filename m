Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC60BC77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 16:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjEQQb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 12:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEQQb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 12:31:27 -0400
Received: from mx0a-002e0402.pphosted.com (mx0a-002e0402.pphosted.com [148.163.144.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C256E45
        for <git@vger.kernel.org>; Wed, 17 May 2023 09:31:26 -0700 (PDT)
Received: from pps.filterd (m0165939.ppops.net [127.0.0.1])
        by mx0a-002e0402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H3tiPe018021;
        Wed, 17 May 2023 16:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vcentertainment.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=DKIM20181126;
 bh=4phz4giSvl/sl1fL0VOPfhRtm/xIHTlqFP1YxqVa+2g=;
 b=RlzUJw7qBZ7cWtOWypEFOd4NOwnRFQpZbDsDdLZl9UNmUdGc79KimAegai8f8bD6V3Zk
 nBAqN3WVJ+WalLTiEfikR1lyuDeXxqV5wb/LsWkZ2WFXIWbMx+Q3phjCajEDAQcFg+xd
 kZ/87K9PqAwW1BVrVda0grSTWnnPMLP+MLqYiORvgzXRZcz/CQ4eezj4QtlMkxqDUcSI
 AkBE7Wx5RKVzf4pam9i0VTfjR2Q3S+3ecNzdwJEXGLOUewKegqOeMkeuOikisjZhuDs4
 TW8DrzYfv2gZB7FHZRum99DO2z8TFm4NObysrx+2QkutBZK07p+61fBnh802dQjNRZXr fw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-002e0402.pphosted.com (PPS) with ESMTPS id 3qm66n3u0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 16:31:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVfC2TKFx+b+oBNrr/FvhUIFWXF8BBq5CrTs6ubWWBGY8FLEIh0C9dkJDU56YvpiQTvXx8PGMdThLg5/gNsvIYR2IbGZVGglRXOhe+0Gl2lOLl6yD+86lTNkLS0l56Kfm4mLYd26HKqXZ3aL6mF2HJauzuIISMfvgHJEyQMMiPRBSTOOe5aeHujNotDMq77BqewOZz0oLt+vhDN0IBQyX3wmGe0/bve0eCpnH3FFCCfVPP9/oOvZIq9ATJipmMDFLQP38ZqEf3HoXVU6zZyo7WVdbfC6b1Bkx79eZktdKWGvyZTJEW0twHyTPFW+SlI2ttahsEyBsID5566YdAuQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4phz4giSvl/sl1fL0VOPfhRtm/xIHTlqFP1YxqVa+2g=;
 b=ctpAKL/uJWL9YAHo5/Rihb89xpZSHszInNq3t5UEMJJcYhjPATkRB+uUitxsbMBPgL9m/6EBxHbrVDj3pejbsBhsPIye9F1M/BQTkOICbMgzwOSGkNwnnr8wNO9SN1MrNuB/zNE5OI9CCffTbLNgeQooekOhzROS1rb0PF28K7Vq9bJZLHFtLG+N9UcnM6y56oJEs/Sc3VTpynE5UkpYphjCAEZXZlqRuoi1ONL22pdtw04jpMTQU6Tzxl2ffCcWHNJo9cK0vQkAbir4Dmj+ld1EcCNi5FsM72I4ZYtLAgTHNRA/qAul60yEissTEyHoau1tS3aZIT59nQ1cpoLkcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vcentertainment.com; dmarc=pass action=none
 header.from=vcentertainment.com; dkim=pass header.d=vcentertainment.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vcentertainment.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4phz4giSvl/sl1fL0VOPfhRtm/xIHTlqFP1YxqVa+2g=;
 b=VZ7aOruQXMrdIvomxVXaE6OvuHEw9J+Xdj7EZ2c0Nf6BBbxl0sDWphFtRkqZPI4wNABJvfz94wruhAX3a4yCTie9lRp9INllL0hRHcOokJ0od7Cj5zRrkVYz9GfE9+Qb+ePEjsEbzEC5T+PXQKzojmFn062J/Nq08T1DzQAS8fbOLoC2vheVt93T6/N/WsU/mdbhwXS02WAYrQpC8zMCdn17rmMOelfJ7idadvQLuxm3XgLj0czN7kPe/050kYqCmM0KIPeHOTw55NktpgLw/DhUr6VcXACifLOz+LSLviyOG9jNDKad3nEhYk7bwCuIlcDxPDKm9BxEftQKZctTLA==
Received: from BY5PR14MB3654.namprd14.prod.outlook.com (2603:10b6:a03:1d6::20)
 by MN2PR14MB3486.namprd14.prod.outlook.com (2603:10b6:208:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 16:31:00 +0000
Received: from BY5PR14MB3654.namprd14.prod.outlook.com
 ([fe80::de0e:df1f:c42e:3107]) by BY5PR14MB3654.namprd14.prod.outlook.com
 ([fe80::de0e:df1f:c42e:3107%2]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 16:31:00 +0000
From:   "Tim Walter (Visual Concepts)" <twalter@vcentertainment.com>
To:     Erik Cervin Edin <erik@cervined.in>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git hangs with --separate-git-dir
Thread-Topic: git hangs with --separate-git-dir
Thread-Index: AdmIHwP31fja9miBQ1mB5r1EdFLfegAHqcyAAABVG0AAB6+tgAAMRSqAABNxFCA=
Date:   Wed, 17 May 2023 16:31:00 +0000
Message-ID: <BY5PR14MB365494C9907D93F7C568710DA57E9@BY5PR14MB3654.namprd14.prod.outlook.com>
References: <BY5PR14MB36544D63ECEAB9954C14407FA5799@BY5PR14MB3654.namprd14.prod.outlook.com>
 <ZGP2AzYJSLpI4kGN@tapette.crustytoothpaste.net>
 <BY5PR14MB36541924E1E6E5E912AFE0C2A5799@BY5PR14MB3654.namprd14.prod.outlook.com>
 <ZGQr03G/9swNcHt0@tapette.crustytoothpaste.net>
 <CA+JQ7M8CgqKxMRrR2TTKHLbBsiUbdQs=N_bN=Uv7d9OqbTbXLw@mail.gmail.com>
In-Reply-To: <CA+JQ7M8CgqKxMRrR2TTKHLbBsiUbdQs=N_bN=Uv7d9OqbTbXLw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR14MB3654:EE_|MN2PR14MB3486:EE_
x-ms-office365-filtering-correlation-id: 84fb0a09-4c99-4a5c-6127-08db56f41991
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BSOGlNbl/5CxgO4qWXsQv7itLzlWq533n+c22ahEy0UOaEY07E6jcAmvS5ciwbiKp60bkC4PZNWeOvOT47ohpbZyMLnbfVIVf9N9/YV3u0WjEWs9ZHaM7SvByHLh8XyP2YVtUF22ZkxjzR751cJ4svSfp2UY7UF3eFQuc4G5+7ih47iZMSvlISXsvZtAzM7Uth22DF0VX0CXV3IDQ3eGDCALOt9Am7D0ZTFJyFO21i+o/6xRom+PYVOfmA/3KIbdW76JTN/OVQ3hBba2NidXpC93Bcb+T7BVRojoYMX6dcxPe8Jd0XO7mQPo8SJ/nWel2KC0qUJ4JgmB55AXkYe/EawoVooCBlB61x8uJnsVEUumUzpOAZkNAHwDEy6vVXE31p3F48JkDJqcYakt7ebGKhbPqfODe5lgUqDVxAB9ZTOHv7vnAQCWZzziMAQKkPzTDFcfchrzhZI3GTuq8K/66fIqFtRt3cnpRDKEk45yRYupp5tWMsGGS/a+jrkXo4yB/PwVuRUuADUnlwCTYibkSDSnTZv8v2vcGtmGH9f5q2Ojsq8jdNc9x25tvYon6xK/eMF1U7d36+iJ9jhj/hIf4mp4OEcpekpIB8+otBl1z6w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR14MB3654.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199021)(5660300002)(71200400001)(41300700001)(2906002)(66574015)(83380400001)(33656002)(122000001)(86362001)(38100700002)(38070700005)(186003)(26005)(6506007)(52536014)(55016003)(8936002)(8676002)(53546011)(9686003)(66556008)(66476007)(66446008)(66946007)(76116006)(64756008)(45080400002)(966005)(7696005)(478600001)(110136005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2NMb200bFZOSm1hNjRMVk41Tklya3ZyVjJCdWozUmZZZ0liNWZpQVY4a2lV?=
 =?utf-8?B?SldFUExxKzlIbHMrY2dBeU9QK0ZsS1JOaTAwRTA0QUduY1poWnFFcFlrNTdK?=
 =?utf-8?B?eVNneUU2aTl1RjhmWjhtdEtJR295Q09rdDJHWmc4WUR2enNSRXhlL2c3b2lq?=
 =?utf-8?B?WXRzV3F2cm9kb0Q3bTBPWFlyWHlWUWxrUUpSaEE3RDVoQWZxQzczcmIvbEdj?=
 =?utf-8?B?aStyNmNrb3Z6QTJ5Ym9JZmM0OVV3WjJydE9lVXZqalJ5YzVhL245N05ENG50?=
 =?utf-8?B?aVZRL08rS1FsSkwxdDM3OUEvNlFYSjRjNHVWUVZnTnpiMnZFbmpFcEZrc3hx?=
 =?utf-8?B?T3hkQll4UDBvamd0MkNFS2NuNERMSW9IdWRvUFBYN1RBTTdzT25HRlhuYlEr?=
 =?utf-8?B?R3JoNnVxcU5sODMzNWc4T2tyb28zUDlkeSt5QlMvQjFrVWdNanRBNDFjMnlF?=
 =?utf-8?B?aWpWWC9rNzdQU21XOC9kRFRnYlFacVVHbFBUeHRwdHk2cWp1VEpRd1czcklO?=
 =?utf-8?B?L3JsdklFemdHZUpibnpubzQvM0dYQmNSNFpoU1dUWXJKSlpYenBpMFNCT1JH?=
 =?utf-8?B?QUxBYmMrOVEvU1RyQUpGZkxhQTd2ek9tNXRNZ3FmR3JITHQ5RGhBTC9XT1BM?=
 =?utf-8?B?aUxvRlo0ckxyQUY0dGlYeXBiM1ZrTkY1YTlZSnpacGZ6NFFsd1g5ZUlvYk5v?=
 =?utf-8?B?d1lTbERUWWtHM2pGTnNqMjB3a05xd2FQNENheldrV2NqZlB0TUxCeVJzVkxP?=
 =?utf-8?B?MDZxT0N6VUIxMXFhZFA1QmZWYmZ1TXM0UndzRk43SnJmdFFEUmtxMFZCZnFG?=
 =?utf-8?B?T0lIQVR1dGlxWis4OGhyTUE4V3plbzVjVmVndTV3UktiVUpQNWpnaENydXRr?=
 =?utf-8?B?eDFuMGQzR2dmazlJeVRIMS9RU29MelcvNndYcVczb1ViL2V2bG9NVUtDV0Nr?=
 =?utf-8?B?UFVUMTltbFhsV01HcVNieVpVeEtKUGZtU2xwTys2cTh4UXRDTFdUbUVRMXl3?=
 =?utf-8?B?alFZeG5zNSsxYnRIdnNiRGExaEkvTWNzUXhlSzJ1ZDdyOWs1SFpWaWJMcjZv?=
 =?utf-8?B?SVZVTy9XaTlIZ1BOOFRJZ2VLanllQ0RxekNxYUJPaW5xN0FxcjdmazZIdjM5?=
 =?utf-8?B?TFpJYlRQR2w5Zmp6OTNaRFJwdlVMQWtpQUx1Z0ZVWGNwUk9yT08yQmJoakJ5?=
 =?utf-8?B?OU96RE5oL3Y3clB1cjl5SERpdlhZbDZvQk4yVzRZUFB1NFJPSDlPdXNvQlhC?=
 =?utf-8?B?OFBTVmpieTVaMkw5TlNUTXpSb3FqWnNTYUNaNzB5SnlkVGdJY3hoemwzNjZa?=
 =?utf-8?B?dFFiMzY5ZFp0OEgxMHlCUWFXZFZwTUI2U0s4VDNaaTJyb3FqTTZWaC9CaGtU?=
 =?utf-8?B?RzhWYlhyS0l6anZvWWRXbUl5MHhZNlRVUVlIRjl6enpYN1lxdnZrQlArMFhn?=
 =?utf-8?B?WnZwSjVMQ25qNVh4dXlLeWk3S3pIb294MDhzZ29Xd1pkU0J6Ym9yRkNabFRw?=
 =?utf-8?B?eTA4cjlhOU4zZ0JzL0ZhQ2xyd3IwYWVSL1BneTErL0RWUVhNMUFxaTIvaXBY?=
 =?utf-8?B?cEU2dUUrSXdjbnlyY08wRUpNVTVHY2lsS05yRWplTGJkcGRUMWsxdGRvR2U5?=
 =?utf-8?B?aXlwaWorTVRQbFVWYnRBYlZtUTNqck5hc1lBZWZQaVUzZHFEQVRDZXg4SWRi?=
 =?utf-8?B?Q2NHWlV4NjRJSTdueGpZN0xVTC9ZWVE3ZGV0Wkc5a0NGRm4wU1pWazN3RnFw?=
 =?utf-8?B?QlpwSVJzT256SG90TVlSNm9LUU5wb2hwK1Rtd1cvWmRCMjk4V3k0QllzbXFs?=
 =?utf-8?B?NFRlRXRpb3hWdFJCSFdkbVFlcDZndUljZnhQU1Yyck9rcFZsVWpUTm5OOVRJ?=
 =?utf-8?B?RG9pOHMwV2NESHVVbGdqcjZ4UXp5K2NmdkhpdDgvd3VGN05vVER2VkQyOFFs?=
 =?utf-8?B?eUkwVDVMSXVlK3lvdEc2VVlYaDI4TzZiMW9PSUpaYitxOVdVZU1nL2lxb3JS?=
 =?utf-8?B?bHgvYkZVYkd6Uytyei8yWlkvZVpSYlFSNHBkWFA3ekxZUUZyTGJXV09LUXpO?=
 =?utf-8?B?S0FmNHg3V01nTGtORjJvWFJLMUpGUmoyRTlBVzZ6NHNYanpXZCtxMGhoOUlC?=
 =?utf-8?Q?Qo/AWCvd7j9vBENrccPP4biLt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HkVSKlk/D51jmcbg1Zg8P5SEbL0/uXTizKE+kELaerzInV4X+umEU0zurNJJDLBeMnmzo5qxUzPpTeNd6Y/cle/CGmnBM8a5ZCLcqtKLLSNAK9tvssEdws/g6sjITOXtR5yqYZYtGTGxYgedYwlVib0fvgcRG/abHQp0e6mPMfKCjsjzm7BfAzz9IeltZ8wRIN1UUBB+CsnXLbqX+mdHYGYnvcn0idggGHlfoVw8rHMI84pB5yR7Z1VcaG1mbZiwTyFS+2pNHjjEFYoLnQkFIWAcNyOyLLhQxCkSjtFZMoLI5VO1a/W/oE00eX4XkGviRjQOhhKzhB9+Upas8wOSji3iMRNx82Zd5lUV8Ftis6be69On3CIX/1vFmPY62C+kG3oXDZAJLQX91MO4qRxMv2b6bS4EwV9/4v+qtkX2K8yrAJVxKIrcJKcOgx6C6oVC6eOL4AW3CbgXkAkhrJcqrjFkIwQTAl5a/giqtg1uUDzecbnJwx5+oIjR2EB2T0AhjbYcSdF4mEUeJ+/IjIKf5JfZI/b6ezNU9ZJK/o9Gt6geAR9u3XGC6CxjV8SZq8CPr3pG2IDNDT6Coi3xTHdKOqmG+0YKVfR57UPOs9DqI5WTnhkTb8xvW6FEqmmCQrUo15ExgejgvrgWDYluUZmrEAFaMdFk0UigkVHFCUCcgSoEgn4Ryg5xtkN7R9MKttrYN6DKDyNukCimtKfnIGzLXA89ftmfIw6LJc6hdh1vLkPlxj9dmmTfUUksxTyF/mKi6xJqN4bOQnObrsMldh/18/nNGgo8nnzhmr6VCQjV5AuKdhjS1y7hc+pHEDzTZxCn/ONPwWA12rPjFYPEira1orZNZNOSBd831yhvA/qCXOo=
X-OriginatorOrg: vcentertainment.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR14MB3654.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fb0a09-4c99-4a5c-6127-08db56f41991
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 16:31:00.3972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d91c4a20-dda6-49ce-ab69-53dee8b047a5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WsPHqzLo6XKWEsdWbyIdmio42yOPpvnOuxlWPhBl51KzGH/wd2ck593Vr5tbn0suI2nBlFTXy7tjsOYP6Gx0LZGRlOYSkFR5jYJUfO/di5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR14MB3486
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T2sgVGhhbmtzIEVyaWssDQpJIGRvbid0IHRoaW5rIEknbGwgYmUgYWJsZSB0byBnZXQgb3VyIHNl
Y3VyaXR5IHRlYW0gdG8gbGV0IG1lIHVuaW5zdGFsbCB0aGUgYW50aS12aXJ1cyBzb2Z0d2FyZS4N
CkknbSBnb2luZyB0byBqdXN0IGNyZWF0ZSB0aGUgcmVwbyB3aXRob3V0IC0tc2VwYXJhdGUtZ2l0
LWRpciBhbmQgdGhlbiBtb3ZlIGl0IGFmdGVyDQpXaGljaCBkb2VzIHdvcmsuDQoNCkFzIHlvdSBz
YWlkLCBnaXQgaXMgbm90IGEgc3lzdGVtIGxldmVsIGRyaXZlciBldGMsIHNvIGl0IG11c3QgYmUg
aW4gc29tZSBvdGhlciBkcml2ZXIuDQpDb3VsZCBiZSBhbnl0aGluZy4NCg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogRXJpayBDZXJ2aW4gRWRpbiA8ZXJpa0BjZXJ2aW5lZC5p
bj4gDQpTZW50OiBXZWRuZXNkYXksIE1heSAxNywgMjAyMyAxMjoxMiBBTQ0KVG86IGJyaWFuIG0u
IGNhcmxzb24gPHNhbmRhbHNAY3J1c3R5dG9vdGhwYXN0ZS5uZXQ+OyBUaW0gV2FsdGVyIChWaXN1
YWwgQ29uY2VwdHMpIDx0d2FsdGVyQHZjZW50ZXJ0YWlubWVudC5jb20+OyBnaXRAdmdlci5rZXJu
ZWwub3JnDQpTdWJqZWN0OiBSZTogZ2l0IGhhbmdzIHdpdGggLS1zZXBhcmF0ZS1naXQtZGlyDQoN
Ck9uIFdlZCwgTWF5IDE3LCAyMDIzIGF0IDEyOjI04oCvQU0gVGltIFdhbHRlciAoVmlzdWFsIENv
bmNlcHRzKSA8dHdhbHRlckB2Y2VudGVydGFpbm1lbnQuY29tPiB3cm90ZToNCj4NCj4gaXQncyBT
U0QsIGFjdHVhbGx5IE5WbWUsIGFuZCB0aGUgUEMgaXMgMTI4R0IgcmFtIDY0IGNvcmUgdmVyeSBm
YXN0Lg0KPiBCb3RoIGRyaXZlcyBhcmUgbG9jYWwgU1NEIGRyaXZlcywgdGhlIHdvcmtpbmcgZGly
ZWN0b3J5IG9uIEQ6IGFuZCB0aGUgcmVwbyBvbiBGOi4NCj4gdGhlIDMgaG91ciB0aGluZyBpcyBu
b3QgYSBwcm9ibGVtIGFzIHN1Y2ggIChpdCdzIGEgbGl0dGxlIGZydXN0cmF0aW5nIA0KPiB0aGF0
IGdpdCBpcyBzaW5nbGUgdGhyZWFkZWQsIGJ1dCByZWdhcmRsZXNzLCB0aGlzIGlzIG5vdCB0aGUg
aXNzdWUgSSANCj4gYW0gY29uY2VybmVkIHdpdGgpIGl0J3Mgb25seSAzIGhvdXJzIG9uY2UsIG9u
IHRoZSB2ZXJ5IGZpcnN0IGdpdCBhZGQgd2hlbiBJIGNyZWF0ZSB0aGUgcmVwbyBJIGNhbiBsaXZl
IHdpdGggdGhhdCwgSSB3YXMganVzdCBnaXZpbmcgY29udGV4dC4NCj4NCg0KSSd2ZSB3b3JrZWQg
b24gbGFyZ2UgcmVwb3MgKDEwMGsrIGZpbGVzKSBhbmQgMyBob3VycyBzb3VuZHMgdW5yZWFzb25h
YmxlIHRvIG1lLg0KVGhhdCdzIHdoYXQsIDI3LjcgbWIvcz8NCk15IGd1ZXNzIHdvdWxkIHByb2Jh
Ymx5IGFsc28gYmUgYW50aS12aXJ1cyBvciBzb21lIHByaXZpbGVnZSBtYW5hZ2VtZW50IHR5cGUg
c29mdHdhcmUuDQoNCk1heWJlIHRyeSB1c2luZyBwcm9jbW9uIHdoaWxlIHlvdSBpbml0IGFuZCBt
b25pdG9yIGFsbCB0aGUgcHJvY2Vzc2VzIHRvIGdldCBhIGJldHRlciB1bmRlcnN0YW5kaW5nIG9m
IHdoYXQgY291bGQgYmUgdGhlIHByb2JsZW0gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQu
Y29tL3YyL3VybD91PWh0dHBzLTNBX19sZWFybi5taWNyb3NvZnQuY29tX2VuLTJEdXNfc3lzaW50
ZXJuYWxzX2Rvd25sb2Fkc19wcm9jbW9uJmQ9RHdJRmFRJmM9UktEc3dvYnJPR2RwNXZEQ2JsNVhq
eFc4SHFyc1JTcjgwZEdUdnUzckU5USZyPWxnV3VnT0RWbF8yamVhT2NqSzJiRDVvWEt1d0M3M0RX
RTVvNlJaZFFsSEkmbT1Bd2p2VmhCWktXYXhSVTdsWG4zYmM2VzIwazJXQWhkSmFyYnhJbDJibS10
T29VOVlnY2QxMzdoRXFsQWNDY0J6JnM9YTBmdlIxZ1BzYXhTSE9fTExYVXhXQ3VNTlBscnFTdWhw
Wk5FeHByOXE3QSZlPQ0KSSd2ZSB1c2VkIHRoYXQgc3VjY2Vzc2Z1bGx5IGluIHRoZSBwYXN0IHRv
IGZpZ3VyZSBvdXQgdGhlIHNvdXJjZSBvZiB1bmV4cGxhaW5lZCBwZXJmb3JtYW5jZSBwcm9ibGVt
cyAoc3BvaWxlcjogaXQgd2FzIHByaXZpbGVnZQ0KbWFuYWdlbWVudCkNCg==
