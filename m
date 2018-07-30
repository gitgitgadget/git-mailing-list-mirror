Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F7D1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 20:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbeG3Vlb (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 17:41:31 -0400
Received: from mail-sn1nam01on0106.outbound.protection.outlook.com ([104.47.32.106]:21830
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729315AbeG3Vla (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 17:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXwjFqIoirZ9SXojMlRmpse+Ku9eSIRIxDYLo+jxFFA=;
 b=gmHyjJyaSSYo8rrj0KfSWH1QihlFWqw52MoroKsAEzWgqN77LtFo1RpxRsQbc9McV3agOR0m9QreCr31oJy5Yzu4++R4TVcg6Le28zOLQiWwYMl9at32CN3oW0C3Clz4jTGW1jYh9SuDlFvdSpe8APViF9EAPYrDYxIxBdzbBzk=
Received: from MWHPR21MB0173.namprd21.prod.outlook.com (10.173.52.19) by
 MWHPR21MB0159.namprd21.prod.outlook.com (10.173.52.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.2; Mon, 30 Jul 2018 20:01:11 +0000
Received: from MWHPR21MB0173.namprd21.prod.outlook.com
 ([fe80::792d:44bd:e4eb:8818]) by MWHPR21MB0173.namprd21.prod.outlook.com
 ([fe80::792d:44bd:e4eb:8818%10]) with mapi id 15.20.1038.003; Mon, 30 Jul
 2018 20:01:11 +0000
From:   Dan Shumow <danshu@microsoft.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        "keccak@noekeon.org" <keccak@noekeon.org>
Subject: RE: Hash algorithm analysis
Thread-Topic: Hash algorithm analysis
Thread-Index: AQHUJ+SryzRdlN3meUyQesMKSNgkW6SoHdSA
Date:   Mon, 30 Jul 2018 20:01:11 +0000
Message-ID: <MWHPR21MB01738A46E37527E45E950937C42F0@MWHPR21MB0173.namprd21.prod.outlook.com>
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net>
 <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net>
 <20180724190136.GA5@0f3cdde9c159>
 <CA+55aFwSe9BF8e0hLk9pp3FVD5LaVY5GRdsV3fbNtgzekJadyA@mail.gmail.com>
 <xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com>
 <20180724221008.GI18502@genre.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1807301058560.10478@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1807301058560.10478@tvgsbejvaqbjf.bet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=danshu@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-07-30T20:01:09.5794646Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [76.121.229.23]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0159;6:S0oEG3VtfXcv92iefcIoJCqKH7x63ZCKy8m7FUvCNuhANl9N0aaWwB0ABtVbX3G/cG+J0D+uZ+//1lVOZHbDrw3TK+pC/A+ZXUpxqAxqLOpzrT4DV7XMSVJBAh5hsTGUeWWonPeGaMCX1QkxS8XR8uw00BfMPNU1d2ETazWIRS9LHGgDB2hmwzyWqw9yGta34l1uwOq01HxNCuBNhMNhcI3SB243aKU6FHY6O3cOaWhLTq7UTtqo7+8f9wLCBb0R2MVWPUlZ4TcLfN8OrTYnHgmoOdrX8G64S9E82sdFxtNhd8e8ejAWdhHVL/hCo9ZEXUxYTG+tAczIbUfrNweENN5j880SlrzLdSBKjcsv29lCk+lNNAeDFrM3GOiAy7X59qHF9m9JeLdSkurNsKG/j1zDV5FzfGIUokNgkDG+GBZgiJhKpQ64R3sY2mZyESLaEn7TAZKsR89JFIa+YFKvTQ==;5:2zG2g8ppPV1Nso/1OCF+j/SD/BoDppRHGZ4kZcwjBYGho6s4DcNazjPSwvC5KtLar3zWtDJOecJj11mGhTpFt2+1BQ33lxKMhjgZhCIFwG43oFc+qFpItHvsaheb8bOy3ALn/Wg+4sDfO0aatW/rkKTH6PYcFE4nmODw2yDvhwE=;7:tbkdhFEvi/zbZu6H/mmQTX5a/qbKPEhDNTTGVTGeEY4GQlPxMUzx8X8YvooyvsbMSo8X0b8jdLUMll6TxsTItyQQFNf9UpsnywDuQt6y+6pLdEnpZShk048T9rWygxzniXCWYI3IL7XI0kLJwcRmjfkLJlARr6h+kdiHaAIrx2VTF7Whrd1SuYoZPeiadUZzD9Qi0Y0De9OS0KVy/SjhvBFh1o2ip3jDm5/G6tDS7WQZcxgRydT/rfnG5QQa+SzQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3b9be2a6-aee4-42ed-edff-08d5f65732bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:MWHPR21MB0159;
x-ms-traffictypediagnostic: MWHPR21MB0159:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=danshu@microsoft.com; 
x-o365-sonar-daas-pilot: True
x-microsoft-antispam-prvs: <MWHPR21MB0159929AAB2DD80FEA3725B4C42F0@MWHPR21MB0159.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR21MB0159;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0159;
x-forefront-prvs: 0749DC2CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(136003)(366004)(39860400002)(199004)(189003)(51444003)(53754006)(8676002)(81156014)(81166006)(8936002)(9686003)(6116002)(3846002)(229853002)(68736007)(3480700004)(110136005)(22452003)(55016002)(316002)(99286004)(26005)(305945005)(7736002)(186003)(10290500003)(478600001)(102836004)(7116003)(4326008)(54906003)(5660300001)(8990500004)(11346002)(86612001)(6506007)(2900100001)(25786009)(6436002)(446003)(74316002)(7416002)(76176011)(86362001)(7696005)(476003)(5250100002)(66066001)(39060400002)(6246003)(486006)(2906002)(33656002)(53936002)(256004)(14444005)(10090500001)(97736004)(14454004)(105586002)(93886005)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0159;H:MWHPR21MB0173.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cf8m6kYd71o66bxUQLmK52HMPXsTbjPVLDn4SIske9GEJznQiS1bPhmiT366AliOfgCyKM7/N/JwrGO9NJacjnqLGsdXD0PKdPb+G+dC3lLADwMNSGDIoLuFrCedfgxS83ghw/8RhwbKg2p0pUcH5eBpzGG7MbC8gTT6tz04p6UDAPIvxzOZtD/IGqsNec2rKkvSWK9K5mTOaBO7km9YtomqKRIa/eix9KeEs366a4/W4oqOi5U9COICaUqtf2N8cGhc2akx4kvBEgBLtn1OtferkCwvoaLeEp/C7IVzk7tSTrUW8ZO0DRqik9OzfCWK4hFAIqNVc/3pa+93MCsbrE+xK8Ht2LbtKkO7IeEepvM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9be2a6-aee4-42ed-edff-08d5f65732bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2018 20:01:11.5328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0159
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all.   Johannes, thanks for adding me to this discussion.

So, as one of the coauthors of the SHA-1 collision detection code, I just w=
anted to chime in and say I'm glad to see the move to a longer hash functio=
n.  Though, as a cryptographer, I have a few thoughts on the matter that I =
thought I would share.

I think that moving to SHA256 is a fine change, and I support it.

I'm not anywhere near the expert in this that Joan Daeman is.  I am someone=
 who has worked in this space more or less peripherally.  However, I agree =
with Adam Langley that basically all of the finalists for a hash function r=
eplacement are about the same for the security needs of Git.  I think that,=
 for this community, other software engineering considerations should be mo=
re important to the selection process.

I think Joan's survey of cryptanalysis papers and the numbers that he gives=
 are interesting, and I had never seen the comparison laid out like that.  =
So, I think that there is a good argument to be made that SHA3 has had more=
 cryptanalysis than SHA2.  Though, Joan, are the papers that you surveyed o=
nly focused on SHA2?  I'm curious if you think that the design/construction=
 of SHA2, as it can be seen as an iteration of MD5/SHA1, means that the cry=
ptanalysis papers on those constructions can be considered to apply to SHA2=
?  Again, I'm not an expert in this, but I do know that Marc Steven's techn=
iques for constructing collisions also provided some small cryptanalytic im=
provements against the SHA2 family as well.  I also think that while the pa=
per survey is a good way to look over all of this, the more time in the pos=
ition of high profile visibility that SHA2 has can give us some confidence =
as well.

Also something worth pointing out is that the connection SHA2 has to SHA1 m=
eans that if Marc Steven's cryptanalysis of MD5/SHA-1 were ever successfull=
y applied to SHA2, the SHA1 collision detection approach could be applied t=
here as well, thus providing a drop in replacement in that situation.  That=
 said, we don't know that there is not a similar way of addressing issues w=
ith the SHA3/Sponge design.  It's just that because we haven't seen any wea=
knesses of this sort in similar designs, we just don't know what a similar =
approach would be there yet.  I don't want to put too much stock in this ar=
gument, it's just saying "Well, we already know how SHA2 is likely to break=
, and we've had fixes for similar things in the past."  This is pragmatic b=
ut not inspiring or confidence building.

So, I also want to state my biases in favor of SHA2 as an employee of Micro=
soft.  Microsoft, being a corporation headquartered in a America, with the =
US Gov't as a major customer definitely prefers to defer to the US Gov't NI=
ST standardization process.  And from that perspective SHA2 or SHA3 would b=
e good choices.  I, personally, think that the NIST process is the best we =
have.  It is relatively transparent, and NIST employs a fair number of very=
 competent cryptographers.  Also, I am encouraged by the widespread interna=
tional participation that the NIST competitions and selection processes att=
ract.

As such, and reflecting this bias, in the internal discussions that Johanne=
s alluded to, SHA2 and SHA3 were the primary suggestions.  There was a slig=
ht preference for SHA2 because SHA3 is not exposed through the windows cryp=
tographic APIs (though Git does not use those, so this is a nonissue for th=
is discussion.)

I also wanted to thank Johannes for keeping the cryptographers that he disc=
ussed this with anonymous.  After all, cryptographers are known for being p=
rivate.  And I wanted to say that Johannes did, in fact, accurately represe=
nt our internal discussions on the matter.

I also wanted to comment on the discussion of the "internal state having th=
e same size as the output."  Linus referred to this several times.  This is=
 known as narrow-pipe vs wide-pipe in the hash function design literature. =
 Linus is correct that wide-pipe designs are more in favor currently, and I=
IRC, all of the serious SHA3 candidates employed this.  That said, it did s=
eem that in the discussion this was being equated with "length extension at=
tacks."  And that connection is just not accurate.  Length extension attack=
s are primarily a motivation of the HMAC liked nested hashing design for MA=
Cs, because of a potential forgery attack.  Again, this doesn't really matt=
er because the decision has been made despite this discussion.  I just want=
ed to set the record straight about this, as to avoid doing the right thing=
 for the wrong reason (T.S. Elliot's "greatest treason.")

One other thing that I wanted to throw out there for the future is that in =
the crypto community there is currently a very large push to post quantum c=
ryptography.  Whether the threat of quantum computers is real or imagined t=
his is a hot area of research, with a NIST competition to select post quant=
um asymmetric cryptographic algorithms.  That is not directly of concern to=
 the selection of a hash function.  However, if we take this threat as legi=
timate, quantum computers reduce the strength of symmetric crypto, both enc=
ryption and hash functions, by 1/2.  So, if this is the direction that the =
crypto community ultimately goes in, 512bit hashes will be seen as standard=
 over the next decade or so.  I don't think that this should be involved in=
 this discussion, presently.   I'm just saying that not unlike the time whe=
n SHA1 was selected, I think that the replacement of a 256bit hash is on th=
e horizon as well.

Thanks,
Dan Shumow
