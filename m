Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34483EB64D9
	for <git@archiver.kernel.org>; Mon, 19 Jun 2023 21:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjFSVhb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jun 2023 17:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjFSVh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2023 17:37:26 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43837E64
        for <git@vger.kernel.org>; Mon, 19 Jun 2023 14:37:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDJfqqKY14LZr+HVBZ+Qj7Mzat1Z0Jf2AXQC27M8U6MdkHZHGHOo+JUq3WQTUDolksfWcPuEJsWIQjOiL4NHiaW5X136e/u/X3Dh8Yg0EdthpnCjM/LAX0LgXy0jDgRa8C+SMnm6cQDUeK08ZqGywKvy9njSNq/BDUelIkOJ6yZ4o4nLi2jm7dMfxVrDHdTskGbgxCFx/aR3a7LvCwtJzr21ApklMKCygzcZlJ0IOo7UZ+6fLMzjgoP1bVLabuy/4PwKB3P/4WrMJFFPW8LHKL9sDB3FenNZBvI+cfoccLC1Ya8GOwzGh4tz0T5Wl2Z8BIkDaVeei0tKNbh4pXu+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHkmT14Olnm98H7DK5lHGHb1DI6KQG7/Kb3GuyFIxLM=;
 b=H5QnrFnJor+n8UvgkEbfr1Xm6qeEqy+aQ9dCVtNVidt+uyl0TjKlVtKCanxQmPMj6T6dwMHOjx60VYxCwl2Ovx8HL0o+CeE1TF6e4O9gz36SacQEeRRNNiE28auM26E9Y9xmamQfLD3cB+ScGuxTkEzx/FuDxiC4nTlnpr44shrBW9ae81rYJaRXsy+3T6KpLpgDhuGlM17jTML3L6AoYSLBFCtbLUCes4yr3LG86xH1RsjyTpxBxCmWL+/2VXP2RpH2PSPnGeamrjgc3UmKiu1IOKfqxCb450OHnh+8M00t+RPAdpEa7XSOm7nI+RNJjMo9DUkxgu4ztgfZyIkXOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHkmT14Olnm98H7DK5lHGHb1DI6KQG7/Kb3GuyFIxLM=;
 b=FYFGhtJMzRjmQZXD8kbtKFFt+jeDDznhJjBZjphaS5pnWCffDtGF/Sa2KTlfKkvgCWKJrWPgqY1FdCKkC8PZU8/vQDZ7s8AkeoJESxcE453W71cEG7gN5mxX+G4jlW8LXXBTr8/QYVmVVg+M+Hhh0bWPSVj9ADeHiYrczUjjygc=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MN2PR21MB1453.namprd21.prod.outlook.com (2603:10b6:208:1f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.4; Mon, 19 Jun
 2023 21:37:21 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::bb03:96fc:3397:6022]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::bb03:96fc:3397:6022%4]) with mapi id 15.20.6544.002; Mon, 19 Jun 2023
 21:37:21 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: [BUG] git-web unable to show this commit properly?
Thread-Topic: [BUG] git-web unable to show this commit properly?
Thread-Index: Admi9V5lvlNTbB2MSBabvLMU8FVizw==
Date:   Mon, 19 Jun 2023 21:37:21 +0000
Message-ID: <SA1PR21MB1335BD64334ABD240C23C43ABF5FA@SA1PR21MB1335.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=90fc1a20-5a39-4a2f-ba32-1d89a4dc5a2d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-19T21:30:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MN2PR21MB1453:EE_
x-ms-office365-filtering-correlation-id: 095e7132-393b-400d-c3f8-08db710d5d05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Cdb0CebwMzKK1jpq4359uBU0+9pAZmJCDSlR96XGrZskWdc9PPGL1GLMmKpGYHrVIJrUiI03MTPaTzNFbo28nIvRY3omz6SLmCdsFQG8SVSbqPDwZm1kr2ME1MvL0rYRY7Lo8CmP78t1dycR/+Y0BLxqNJIXGHdFjMT5tcSlXLOcCvz3vVbcO2F3xJTg+GmOdAkrrsZEcC+uvc10ZH4MNUNQYybEIJnk7EjSw908df1P0pgiWyy0ifMtWVY1PJx3jaS4waIZ4PkCPG8EnFhjKPAAbOkdzbFJpNJVXmlqpn8bnOr8yNMrItzrcUJfYC03k1NYAj8O/mBB9I1oEAtMb8O77eBecKVa7H7HYv8G2bX1upLi22vHWUZ5coSig5tmi18E8FrHma5RVxZGmMvbdGxGOoeG4haGeRoXfQgZfTmGPIwAaaf3EpdaUWAeCI70W54RYfawH2avBCkTLzvoC7v+KW/FlX2ZvEE7NnjptqkR+SjjeZ2fzbPmZKuFDshAU5wrCCFtao+2XCB8LZFZAJm/l4aj2PbeBndtibAPh7VwpJsYoBMpOSQjdr7xOBYsMkn/Nxn+nGEyCezdgbjNULzIFhVHmxOah0Za1U2gzJsNK36RjlIErzIVJRvvJ1i5AcOpYZn5758exPFDuNz1dLZaf/WuQVoaxObjFq8GPI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(186003)(71200400001)(966005)(7696005)(9686003)(86362001)(26005)(6506007)(10290500003)(478600001)(82960400001)(38100700002)(316002)(83380400001)(82950400001)(76116006)(66946007)(122000001)(66446008)(66476007)(64756008)(66556008)(6916009)(41300700001)(52536014)(5660300002)(38070700005)(8990500004)(2906002)(55016003)(8676002)(8936002)(33656002)(491001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?obd8nl5/9fORX0C++/Kej/MOBviSt7cFQKO9xvijtRFHTNGhD9fnlo66+atD?=
 =?us-ascii?Q?LGRxhMRVrXsk2pUXgwK354qWlR6eFFfpvQmjGqzWjxP/7gzW6o6KgzqyT/IA?=
 =?us-ascii?Q?qNqRHWt41AhemE7816QxwEcIDCb2jrWxYdD77pDAoas0z48XvcobBs1wwrcR?=
 =?us-ascii?Q?8fXFdXCpTU47GzGiZpd6n8+M4zb5trXHPMjQSOw/rKKmVbzB6wboK49kVqwk?=
 =?us-ascii?Q?pg3IA4HsjqNd2ICw8SZAp+zbrEUK4lmCo6oOlKCs+azNh8eYdTfTYn8BAKZC?=
 =?us-ascii?Q?Rx0L2WMyflf3ZOOIx2mcv83bJbJRGbrXONx0gpPxJEzXm04Fs4OmgJ72uje9?=
 =?us-ascii?Q?99yNFBPLBLEWzyjjpOM6KXX/ZFQOkQFqhmntQnSyfazy85oCKBNgO3AsPRsP?=
 =?us-ascii?Q?9jufwDP7eEsgcyilIYSYjQ1HP3sbnGxcAggFjDdvZjPUgs5AtKL4DiLrEKn2?=
 =?us-ascii?Q?0XtUptqWFfki2gzMFpcUzNMA29GfPGUWhAvoLttTkysm2jOMI3cK+DHSCOpt?=
 =?us-ascii?Q?dxiTaCsKY+Z9IuoBN06EMI74uztzGSX259IJOJQAjVDtR9uiCzVVA6oXhAla?=
 =?us-ascii?Q?BwM+zC3WhYQDTK8Kjp5mbORLasnViA4UHxJYRMNjljf9XE5Bg/d5gsLtVk8O?=
 =?us-ascii?Q?k2/MwEp3G2mRa18r7fiJVq0UT8w1uwkrDQWJ3QwHKk999lWxFXpezpoVSqiW?=
 =?us-ascii?Q?QQzjlMFYGTjrZzO43PPIPhvmydfN0F/litI1e8sbJw4GJ50LPKoLWu45jX82?=
 =?us-ascii?Q?9fKV1MrGHx8g7apw54Gr/Q5PA/Oe0Pw3vGe5r3gWBPgjd8p5yYFHGX39/XFf?=
 =?us-ascii?Q?Lgq+8qPazz9iI1JjLqT7iygVMJeDcqoUO3YDihxqFE1QJk999e9uXLYrRhwY?=
 =?us-ascii?Q?UTT5pYRq/oxYIgxehYu9OHKFO4sFQ2g8XnXTgTnWF+VLR/KSwoaNhhIr5SMg?=
 =?us-ascii?Q?8LUKh1oZtqtCxQ8CSgM8qc7pQbhY4edHY/ceAOZVFfj7Cv7suHfsL76kYQE5?=
 =?us-ascii?Q?XHPCEgB1Ih1M+Po5CVkN+k+VhX4fQvJnHoDK0pSJrT9pmMQBRz357issZ1uJ?=
 =?us-ascii?Q?w+Olyy9oUIp9TKWpu9krJPk6zEdlFuW2PnARCUT6KzfUojvT8uPqmQf3T8eL?=
 =?us-ascii?Q?PsuDZ63AXWY5zY/MQOgMCc8RyconJbR93KiEuIXy/x5N40Odss3HTeDWFJxV?=
 =?us-ascii?Q?c6aoVwbKAr3t4QDeC6e+AOPOVfKrhfcrn0dNVYr+JS5OWXA2CWjqijpuW9f4?=
 =?us-ascii?Q?WoXJLvpG67ckK7Ru/zDPs/+744Ww0mS8SdrddoOsElJyH2UatMzEY6I4d+7u?=
 =?us-ascii?Q?AcvTPyzgVToP5eRCPaomA8uUcZK7w5n7qz1LtuhnDxUIDUioicnwaYgMihdN?=
 =?us-ascii?Q?FD2GCsv6rw5rXMz5jMquonlhkxtayDPBNu2dx6391WW4cUFr8Ut6UgS1Ar+W?=
 =?us-ascii?Q?rzHvEXmRV+Fr6XtzE0h2z7Rb534z4zo7W1uJYVHiYw3kis3utvv9vN2mxmoA?=
 =?us-ascii?Q?3xeS++ntqpseg+d8lZikxrAPfn6BGfd1r9aL2AHfOIefB2KDqSGC2q6+btXP?=
 =?us-ascii?Q?f/HphrKn3KBcXkXEQ31f9fbZO5ft68+Tzj6D0NXa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095e7132-393b-400d-c3f8-08db710d5d05
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 21:37:21.2077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UrTFYx0h/QH9nZK5HDgEtsnWK1o1r3Kt45NJpjI0z9WQLGqMV3054qNbO4xSWg4GiVkTuKh16SM4C96ApxrqLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1453
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
"git show 122333d6bd229af279cdb35d1b874b71b3b9ccfb --stat" shows the below:

commit 122333d6bd229af279cdb35d1b874b71b3b9ccfb
Author: Nikolay Borisov <nik.borisov@suse.com>
Date:   Fri May 5 15:03:32 2023 +0300

    x86/tdx: Wrap exit reason with hcall_func()

    TDX reuses VMEXIT "reasons" in its guest->host hypercall ABI.  This is
    confusing because there might not be a VMEXIT involved at *all*.
    These instances are supposed to document situation and reduce confusion
    by wrapping VMEXIT reasons with hcall_func().

    The decompression code does not follow this convention.

    Unify the TDX decompression code with the other TDX use of VMEXIT reaso=
ns.
    No functional changes.

    Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
    Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
    Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    Link: https://lore.kernel.org/all/20230505120332.1429957-1-nik.borisov%=
40suse.com

 arch/x86/boot/compressed/tdx.c    |  4 ++--
 arch/x86/coco/tdx/tdx.c           | 11 -----------
 arch/x86/include/asm/shared/tdx.h | 11 +++++++++++
 3 files changed, 13 insertions(+), 13 deletions(-)

But the web interface only shows " 1 files changed, 0 insertions, 11 deleti=
ons"=20
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/arch/x86=
/coco?id=3D122333d6bd229af279cdb35d1b874b71b3b9ccfb
(Note: the correct info should be "3 files changed, 13 insertions(+), 13 de=
letions(-)", as shown above by git-show)

Looks like this may have something to do with Rename Detection? But IMO the
web interface should at least show "3 files changed", otherwise it's confus=
ing...

Thanks,
-- Dexuan

