Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2DFC38147
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 23:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjAQXcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 18:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjAQXbf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 18:31:35 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1DA8CE6B
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 12:57:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVcDd+bm1nO1cdM8mqbrHAG7FaqUX1oZPlzWYV02r1sulv6X12fRfvl7JEEzBbvgKbMKoNqLVttSeoqzouUgAdoXb8GN0Rg+U6Z5FSu2nh1J4rGwNPWDFLP5E71jyqxJYUSN2Pv185ah2Wu53pBA+dafqdsGCxi+JNN1TXt098y99mQmBIScb+mTRGjWTd6bOOlwCf+cAqbciPiOV8UHZU47dpsJs4iGAci4HW4GhrEGxBNxNaKtmqy+09/c3oC0SX/oHO5O9HL2Goe/iYhAxXJcbJ+TbEgFjzIF+oM61nYNUa5dUgAOkkZQg2Ci896IhWqiuf1+OD1G/s0q0e0D0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tObVxBFFMq+KNhElOQfLJr2Jo7ljsDadlxBg/CMO5yw=;
 b=nW53ze/8rhdguEI7RydG5W0usBpoHBM8X3GkzncOo3QAoQzxkt5b5taz0D2cq/lir1S3pxEyDO1UIPuSHU/X0yt6geebxwHlYvAaKYCvp/bQnUY5ogMFkZrQQFkHv384usizNzsgymPKPfMTy4crUFQX819VHo+9tXInx+LbBZEVEQ4sGflUCYdMD56DQM7WSe7wEfyDRRqEsv1v5jpYvmLxFibDE14Y+ZywMP5NLAuHr+mbhEna2EQLL/bLHKeph4dEzceCI8BN96bgyA1kjjcup+hsG1+8/bzdn5SD6ORDU9JVPTbeNDhxi7orAmeIs0F005jDHKEedohpWKMqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tObVxBFFMq+KNhElOQfLJr2Jo7ljsDadlxBg/CMO5yw=;
 b=b7ueVcetm3NxkqWkXrsXpnkJWgOiYHIeTGYbkY3oZLA1TPZUqn4xdvqb3VkAcjTj0vodEmzBkNcYWfVgVKYSv1SFZwpZEftSnjxm5+8Qq3lpV7FgAvz8ff6yklfvFicIOoIgilQvW/IB3WmPmN/RA4HKZWCSxmtWfWjovixIrPM=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 CY8PR12MB7097.namprd12.prod.outlook.com (2603:10b6:930:63::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 20:57:11 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77%3]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 20:57:11 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>
Subject: Re: [PATCH v7 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Topic: [PATCH v7 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Thread-Index: AQHZKn/P6HNrNIjDP0url1PLFspUOK6ixLkfgABSmAA=
Date:   Tue, 17 Jan 2023 20:57:11 +0000
Message-ID: <87pmbc3mmx.fsf@amd.com>
References: <20230117142706.230404-1-michael.strawbridge@amd.com>
 <20230117142706.230404-3-michael.strawbridge@amd.com>
 <xmqqedrt9mmt.fsf@gitster.g>
In-Reply-To: <xmqqedrt9mmt.fsf@gitster.g>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.9.11; emacs 28.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|CY8PR12MB7097:EE_
x-ms-office365-filtering-correlation-id: dbcb343f-0bd0-4552-01e7-08daf8cd676d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9dDo+L28Gl/9hKA11QsK2I/cNXEJAu7+1FdrgeTlM61VTfIpAFQ3/cbdm24vom+NNQdLFnx9o269xnJdcTqYoiFPTL3dWic9f9fS6/6bkkmgBDFpYiyNyRF6PWir/zha1SBHdJWBsy7Mvts1SZk46GWZxPL5FDS0wBP9uKpA3qheP65th8pUrBRAtNgyegctZ0w7o4Ed40DRXxuOmPXK8O5x78niwXVAhzcZ+V/qUIMLt7vheneci4hgGxViCzJYAuzM/aYH4cLXYwgH2bzTiI+YYo63/nWoQcpcTouiVaxkgDWdeH477xPtKoLMbTpU4b+BPBaa7H31oZsLWi5cyEpcv/HW6luQlsgSpZ6aLjbiNMTPPj3mmcBxc1DyD6ESACw6/RDFenBWUaCF4PKiVG5wQ6GAFdt7LLDeZ+AcPg4DC+vw7XNCx3YV4a69A0WTmsx94B9nP18woXeVm44juMHrrSL5gilbKyTiFTOuSMCqae1YypFznUOE5eq4YJL3/aEkQXXvX0KydgJGrvbe2w9YML/xTBovooUVFCYqDutveX+Pore6Tl6QHnoPgEn5QHGrCYgL7T7/w8pHq67gmClBldDi65C05wyiGO06RWo4VqokNab+nR9RYEbxkH7pH5GkmnfcHo8g/z0OXVLSBnIuuOdN89JPFb2aJyHZdsX8K2s7mdzCYEApJmIKX4OTX9b9Ef3n+FSq6aiYvUWZIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199015)(36756003)(478600001)(71200400001)(6486002)(54906003)(6512007)(6506007)(26005)(15650500001)(316002)(5660300002)(41300700001)(76116006)(6916009)(64756008)(66556008)(66446008)(91956017)(8936002)(8676002)(4326008)(66946007)(66476007)(2906002)(122000001)(2616005)(186003)(38070700005)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nSATNa9eGv5g3jm5jMTUzTdA7mgnfxaW4QNW6trMSPeN2SCOHGOyeKfweq?=
 =?iso-8859-1?Q?lvVVVs1BinBE++RhH5E9Ex8Y7mZJDoeawG9nwa8qO/fQMaFdVOE23/RxY3?=
 =?iso-8859-1?Q?HVJ0Svcizi7QSVQJ88pcqN+WHWjZJqORFrsJMDZ09Z5UmgxxhntITpU/RQ?=
 =?iso-8859-1?Q?i+rF+2MyYsHMW7ASPwQ74DezKyhgdjWpOITLtWSC+e87HRfX+Oe9P6p1Bv?=
 =?iso-8859-1?Q?iijtY8x6rUmsK/LlrHCEJTVnFPSCp42qqjCZf+cQ+Vi/13J01HYTcIXnRQ?=
 =?iso-8859-1?Q?WPApDZzY2QAHNYo2IfAL3sAy1rFZ7mzH4QP/nsMf1RQRVBwNiWmngXT+LA?=
 =?iso-8859-1?Q?JC3ngwVrw/BwbebBBXGngkmE+tXR+cFaepmWtNVbGDtrkqBBc5AqRpCDD5?=
 =?iso-8859-1?Q?dOH0K44LeV5o9T1uoiudB34zw3Pa4+2fzO8Lg7XDJa88jpCq5/CItTRGsI?=
 =?iso-8859-1?Q?qU6j3n21bsag/pYA+EnovKofFD89SZ0NpB98LWC65uC18m1dkv39f/44wK?=
 =?iso-8859-1?Q?OQkqnW7bCBpgeOmamN7hXBweOPjOX9fxJUIdubMg9IZPlQBnffMzWDDU0O?=
 =?iso-8859-1?Q?kAmVYLoqneKWW4bVxI8tWSUdw7LVDbas9+MTiuUkoDFURk8LxDHY9PhVH3?=
 =?iso-8859-1?Q?GbPexYzOae8/KqE4a4SYG6iSf55QYt10VnzrAJFjG4FTLo7gY1ZZYX71eS?=
 =?iso-8859-1?Q?b/lMw7c9bqpEOWM9ESKXAYZ0Xxb+PW0WRaZI1C8H2aNpwsbe7RukWNd4E1?=
 =?iso-8859-1?Q?BP3HE/jaPBUmoaJvMVfXQwLaQV6Duw/JgUYQPgDoARTzMISq448LtSe0fP?=
 =?iso-8859-1?Q?4D8Z0OfClfyHvFYbQkib5+SoHb2emCRo3v4XuOLjNmnja/PnfemOq2sYi7?=
 =?iso-8859-1?Q?w0GswChvPiCF5BE/NCuVGcyqBToB5BjY9q+pAM2fHm70Po2j/ttpzfy2LA?=
 =?iso-8859-1?Q?NVD4YRvl0eJ1Qv3M3i1VcTahUd/Lf9PCMkx1y5Tu9X9nW9ygu5YehldQLH?=
 =?iso-8859-1?Q?Dh935NfmsaiccCegjs9GaYGhyPBvdrwYpbu/8KyD4ni5w1/1MJDrKux8H9?=
 =?iso-8859-1?Q?h6OPSshx/+VIbPTj3U/4NvQOC+gHXK8BKFdEdZDwXp+25hnD24JhO5FZMI?=
 =?iso-8859-1?Q?FVO7KS1Y+zH8csZ9E/OBlNKBv4pVbbKmj2pMVnRgAqDgicAXs789GvMbVG?=
 =?iso-8859-1?Q?cMStgA7FoE/FTkyoEjBdFogjxAOfR1nZcH1NNPcjccOWW/YJPpJjxoaN0O?=
 =?iso-8859-1?Q?sArLBbfsnLk7toUl3cOzuWGY14KvlDMF+qKQeGIz1/OjhggcWub2maL2gi?=
 =?iso-8859-1?Q?OcRujObK4Kz3D7dXvputW2BnO+fQUCjw9djDO4IxiNdwp1/XvgeOaWOqDp?=
 =?iso-8859-1?Q?gHsT5aXVmxbQRBi2dU1Tt7PpCjYw+FhqBVFQsm+TMWvdEGhSpLHVORZ191?=
 =?iso-8859-1?Q?wuBPIoyUjqap94muNl7huB0nP3RuEcDUb4luqA4hJlrtq6EzJrN6pRVAKf?=
 =?iso-8859-1?Q?/AtLiEIqkWuSW4i7SEz8V5BCWSbn0vbdJQjwNV5AAsAnvdFwOhqBic9L85?=
 =?iso-8859-1?Q?DXjqLFVrJTNTEQvIZ/enHQ5pP7uHLRjHkZozB76PvOr28CncjC4VfTufEd?=
 =?iso-8859-1?Q?3A9pQXVKnviyAhqUbpQax2yNnJFT3sDDMI?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcb343f-0bd0-4552-01e7-08daf8cd676d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 20:57:11.3215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UqaUdT7XpxkI4kmYIUyE9wt3NdAs/J/66uTAyDMSC4ScK+XDBzOe4WPgFbtdWhdTIMnsydaY16Bzj0xdUFvp/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7097
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:

> "Strawbridge, Michael" <Michael.Strawbridge@amd.com> writes:
>
>> +This hook is invoked by linkgit:git-send-email[1].
>> +
>> +It takes these command line arguments. They are,
>> +1. the name of the file which holds the contents of the email to be sen=
t.
>> +2. The name of the file which holds the SMTP envelope and headers of th=
e email.
>
> The previous iteration said SMTP headers, but now this talks about
> envelope.  I however did not think we have direct access to any
> envelope information [*] (i.e. such a feature is necessary if we
> want to send to one set of recipients by specifying their addresses
> in the envelope, while recording different set of recipients to the
> e-mail headers' To: and Cc: list)?
>
> 	Side note.  We can specify different sender and it gets
> 	passed as a command line argument "-f $sender" to the
> 	sendmail program, which is used in "MAIL FROM" SMTP
> 	envelope.  But I do not think we muck with the list of
> 	recipients that appear in the header when we formulate "RCPT
> 	TO".  And I do not see where you give "MAIL FROM" value in
> 	the input to the hook in the patch.
>
> If we say "we will give your hook information in the envelope and
> headers" to those who know the distinction between the two, they
> will inevitably say "that is great. Now how do I tell which in file
> $2 are in the envelope and which are in the header, when some of
> them are different?"
>
> We just hand the message plus the header, and let $sendmail_cmd come
> up with the envelope info using what is in the header, no?  I am not
> sure we want to mention envelope as that would give readers a false
> impression that we may treat it separately from the headers.
>
> Thanks.

That's fair.  I will remove the mention of envelope.=
