Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74EEC7EE2C
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 22:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbjFBW10 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 18:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbjFBW1V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 18:27:21 -0400
X-Greylist: delayed 1038 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Jun 2023 15:27:17 PDT
Received: from USG02-BN3-obe.outbound.protection.office365.us (mail-bn3usg02on0103.outbound.protection.office365.us [23.103.208.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C1A1BB
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 15:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=hAuPt8uz/U3ak+sdyKXVmPLbmEj0Mz8PkEzJTY66gRbn00+XXc6wSoNArQWjIeKCAqWR4fn1uVgPWjkunvt5vcRVrIoEBbCzoGQj/kogjeCW6U8WGwRXu953jPEmd7R7xSP3/mhCS8CpqO46RArXAy9uGOPJ8fmfNYi7a6rQf1zDtKP6BJcO0SFqZ2gPwb8ueuYofsxO0TCdshWkh3CIXeGcv+Lf4074RJIpynSTVhPIrozyZyMrnSROR4/cFe9nVkNLOvy7Wg0tJn4u+CZf56ZdhALg+PGLwqfnNyK1ya3KeWg6Ya/BY4zJO4G8YJWkxg5hnC6cheGtVJFszsQQ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPUfr6LUJrT82LTBndIGplijVN5thy8ZjD3xiyKtx0o=;
 b=Qe7UAzkpRBUi+L8xyRepLz2fXbhcZV1XybAMdAH9I0Y66UDJbArAUaGZspD1u8GmOSOZXt8jqQbmOKULbrjybQ3BykGJqoUnhyoPVzlWjfFp70WePgit7wNPbAtjsFgaxAHByTxuEX5RAzNsBuj46m95LDMvqkz65FDFZCceADkq/cDi2I94TCnQ3XifQhIRi6Jgq9erXVMsNYVr78S1/Nie5U9qv3uPzyHiA+GT8blhTzMQly9fMZBwRNde/bXDK/r5kRcgiZQuxnUxpUawDhykg+wrS0JDSy+SVRvkDb2wIDAShF+H4gApOVI7f50yH4neVn11dWQ5j5FCjA4Kdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=noblis.org; dmarc=pass action=none header.from=noblis.org;
 dkim=pass header.d=noblis.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noblis.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPUfr6LUJrT82LTBndIGplijVN5thy8ZjD3xiyKtx0o=;
 b=eMW4UKz4Pl04fPVYNMjVLchpApfuSq5zI38O/YryP60SLdH3GRwNNOL1ICuH6P9/G27+RFMM4g3PVTqFTQ0Gue2ynCN96IdVKpoarMp/CF3ZWycS5+xShjtjRzmaGcrV99nAQ7rkAmPloHnHl3O2Ec9hkTGgg/EZdtF1Afr5pt/qocpWLjdj2O6Hjd94ka1vR7IpalhuUoqINo+mI5liiwwSpDLpuUkgk0CVwO966spQUQog1fqc4b1aOxJU0Fu2ZKSsBnJHP8Hso2ZGJhUtvFIyT3go6tkpiVsKgJwfX7RmhJUbzjNKy6DUr/zL5AlaqNr2ADk9Ed1UlMIprezYhg==
Received: from BN2P110MB1224.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:17a::14)
 by BN2P110MB1575.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:17d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 21:55:21 +0000
Received: from BN2P110MB1224.NAMP110.PROD.OUTLOOK.COM
 ([fe80::848f:7279:d705:8b4]) by BN2P110MB1224.NAMP110.PROD.OUTLOOK.COM
 ([fe80::848f:7279:d705:8b4%6]) with mapi id 15.20.6433.022; Fri, 2 Jun 2023
 21:55:21 +0000
From:   "Duffey, Blake" <Blake.Duffey@noblis.org>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: CTRL-C in ssh included with git kills the pipe
Thread-Topic: CTRL-C in ssh included with git kills the pipe
Thread-Index: AdmVnM/kIWRKKRbkTn6hHEztQh+l7w==
Date:   Fri, 2 Jun 2023 21:55:21 +0000
Message-ID: <45dd0347ff2646e8a9770644728afb07@BN2P110MB1224.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=noblis.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN2P110MB1224:EE_|BN2P110MB1575:EE_
x-ms-office365-filtering-correlation-id: c3e507e4-85c9-4f14-2912-08db63b40fa7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hnCE3mVGcTNhw5AcFGlp0mFODV5bZRWWKVh1+absAjg/+1bVxhLgNauXJsN+3UmCBdYZmcniyb2w+T/66wviJwUHJyu8dqhb+1v/Kk0Qw1V0HqYOEhnU/FiQb++0aduzFGtBvqADTpdkwD7lfvm7A1StJY4P7kFk90MK2YlCaVzsTCtwcZKefEAA0eXKsgpWBTMXnQab25svyd1jsuBV3sRxa6mQpv5yHVgqM7wgWxJ1Y5saKlIvqiSWGaQOYpvVyWic3cGKC+3FXiZILdLPfID5n1wn62hxWA76RrYP6o81oSforTvMVNbPtX+j4/Coo8jCXZdycbWoK0D1s95tzEDeXDO2PDsXLoNtOKJ36N/X715b1I9Y8h5qFZHbSrGnfxZmOlA34fVDFaJFRedaFlw9Ucjuy//zhFqMYfE5IVK2kPqaC44sS3GM1mBLE8xzeFoFRP+uFx6Lu1JSoILjLc/y9aVaZHTXnt8AnzYzymXUR0F7UnIxUCoXtratSiZmZefpoUoZiJc29KKiJvaWHG5v+6n4yTCmzuFeAH6XvHy2Kr5/pC6Soe8DAxWIKAlR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN2P110MB1224.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39830400003)(396003)(366004)(451199021)(122000001)(38100700002)(38070700005)(86362001)(6916009)(76116006)(66446008)(66946007)(66556008)(64756008)(66476007)(508600001)(41320700001)(55016003)(108616005)(24736004)(71200400001)(186003)(966005)(9686003)(6506007)(26005)(2906002)(8676002)(4744005)(5660300002)(8936002)(7696005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: S5rGJrryvXXL5wUCL6oy+q3TRl2i0DkU2Z00j6pgxkY7c9/jjQn2qBZUaO3B5zLVUdciE6yf7Vbn1XxP9Ob6Ven0YzkZb4RdzDh9LQtIgAh17gKq1q8lzSVjXCkXGo7wZoy7K2TB4ue60F2zbdrrDUx+aW3UG7Mhxrdo+0THPYtRinHYrJDE44hPXhdk/VoSl/nHOszzgdUstUT7fhhYzMh06OuYsn0EwugCbta20klZMAG484lqU+SqPbPPtCGRB4HuRae5NkmNd0PjM/JvjOLOUg3ak+/ibdwAtKSEXHwVTnoyEqy3LNVS8JrwiM4XsO3dKSt2IyKKnvvQspL6/HJfz/Tmj9lsBOy5eh4QgKuozdbyyagUIMXoBd2V0N+EGs7qMipbTqibDQXPj41nOHwlyGOK9sXceyleSVfrbHM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: noblis.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN2P110MB1224.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e507e4-85c9-4f14-2912-08db63b40fa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 21:55:21.0812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ce0b61c-3e9d-4790-85f1-d44a713bf642
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN2P110MB1575
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The version of OpenSSH included with git 2.41 reports as:
OpenSSH_9.3p1, OpenSSL 1.1.1u 30 May 2023

The version of OpenSSH available from=A0https://github.com/PowerShell/Win32=
-OpenSSH/releases=A0reports as:
OpenSSH_for_Windows_9.2p1, LibreSSL 3.7.2

If I connect to server X with the first client, run top, and issue CTRL-C -=
 I get
client_loop: send disconnect: Broken pipe

If I connect to server X with the second client, run top, and issue CTRL-C.=
..
it ends top and the connection remains




