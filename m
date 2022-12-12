Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF675C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 22:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiLLWH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 17:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiLLWH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 17:07:56 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03olkn2109.outbound.protection.outlook.com [40.92.57.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF7BD95
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:07:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHfYScYN949S6RcXI8uTv4zVNjIuQ2Bx2vCYAfbqmTyYDjy+/ertSZFMd4KTTdhUB/vN3+5ntU6BII0z6LScRj7HZhnhup7yZrhlCGjsjQjPiD9sA7Emp+LopehHFdOBfIl65NaFAtjfUDMcx4kN9qdGWCAVaZiGiBrZ3eFFxeGaZ2R6GkeqSTIPHQZZ79amYaP063sbqqYPgh8onAUWPqBW4fLGRtay/ym1LPxmluyauuvO29frXK6oj/Xqvpsq01Gcuf8FBI/Mm+IHAuX0hf58pCoYMLeFhikC4bGi8b+gApXzV3e5bQhKTiSDUYq2xKrx/3LksDN8eW0Z88t3jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KugaPGHBeRUpNAv3b9Zp7XOpmHAcGON8gvmBpeFsG9M=;
 b=gGAzXVb3ZGxbIndXb6lTIJpoL6s5iFJGAHE0TcYUNP9Mcy+HMsNItGImh22zntQ9zmY7pIjDbNYQeAWaOrW6w4vEsiouVEl42JXf5CGKYU16HKkHhI/XnZYufy+VMyuqX+obgOgPbkMb6pgkv0DrUStxHD/qorbwFRN8oCzdeGCMxoNaacmfRRZ0E9CidE5Dztk29TDz0LbBDna4GJh3zxIv66VxezxwClAzsZEe3g3hkloJTdqbnxPpiMFDnrRirjpmDTtJJKmZ36B3z5ebVz4tCmOvLwqzk1Dyz7cY0J4TPn+QxK66gg3UkBG4andr3cP5aTiCKvBpShhZ0bNZ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KugaPGHBeRUpNAv3b9Zp7XOpmHAcGON8gvmBpeFsG9M=;
 b=LllQ5F0S8sJFLBVeDvHXXMmMdGn84rSZAmfnBPf24WkmTn5T/Bal9B9XRw8zwH+3EEjC/K6n126fB8m5LHQVMyrwzj6vbFjbQITeWbrmClf9kTh+Oj2dCq9ihg/eDLsBNGIro+up9bhZlI4T0+Inq6fUUtTcHLGUrqqzHetghJtEO2cYJAmOhp3Xo2r5hgx+4taiZvdaDPrLNpuwuTdQtQir1Kn8ewkOkVLeOGM4UiP0vjcCN9GTup0wp1dN1GqFZGxcParACw6q9lp8oByoOhlBhNZ5UsnQtJNppEW/BXBjLS4p96rLIV5zII3hB6ZyoToDZ3zto/o+a7vwsXS7hg==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AS8PR03MB8975.eurprd03.prod.outlook.com (2603:10a6:20b:5bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Mon, 12 Dec
 2022 22:07:51 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::e829:a187:754:6a85]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::e829:a187:754:6a85%3]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 22:07:51 +0000
Message-ID: <AS2PR03MB9815205F73EFE1D5DBF17510C0E29@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Mon, 12 Dec 2022 14:07:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v3 00/11] Enhance credential helper protocol to include
 auth headers
To:     M Hickford <mirth.hickford@gmail.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
 <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
 <CAGJzqs=o2O+W=Uecu+TJ0Nuw7FsehocKu4Dyko2iKdz5HyiKrA@mail.gmail.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <CAGJzqs=o2O+W=Uecu+TJ0Nuw7FsehocKu4Dyko2iKdz5HyiKrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [6Nu+jOofnaTEzl/8yupLqYfDvQ8AVKZjO4wmRG5oRfmoU2uHAJk9K9L11smjGXK5]
X-ClientProxiedBy: BY5PR17CA0049.namprd17.prod.outlook.com
 (2603:10b6:a03:167::26) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <998605b1-d250-cb9a-4bef-1bc1a4feddb1@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AS8PR03MB8975:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b81757-edf6-4425-4d57-08dadc8d4fb4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVGOOxgo4S/uAT/RQB+zBeajeHCcMeht8UitZo68AsFSTkAf0NVENfH8ZPmsfv0t5L15V/CeByQfU6uu2MHNb6PJ2yWhddOfxr7dEv2srqXA1sq5AzvWs6a9+0n7So9fDJ6bSX7xpbFBWI2r1yjYXikamTaHN767SlSt7A85wwPraoWtprl7ynEIEqAu7gr8tFWbv3LgJs4JDWo1RnRGrXI051bmJ/KyZqUO4B+yTXo3nBT1JPfGp7k7msTAgdfzcpYOqT5abX1bWTdLnTmM53kpHHqg55f5VkvNzaU01JSUN05ntiMclyIDOxqLt2tgH2eRMJUufomiEC/5X1JWtxdQ3vxk8mGj4yrhJnp2/jFVgCt39Ch0H//Br1e62/Pn0F1KK8qagKMFMyQk2QPwRpOTQOlK7hT+BmXLZCZPVcFY82fWxwGa6ycCM1q1SgT9C8PijVyLrXh8PmJcsqff2cJgl+OqioujcC38eWi27iKNczLNo1xxz7DystVusukRFcpzlW87Cy1gnWA9Y6sMhL0CV7Po2zAMCLqFLLzfO8DzjuCSYOTInahihYMT79IJm3ogyfWDtD7N0iCFIUoNsVAGhCQSMNz2DCFTJw4jhvwh1FlTZ1VznHkhY/JvloMDX5gPQUdGkFoq18zGXVKnWg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1RNRmlzek9yUkQ1WjlIdmJOWXh5QzVIWDZERmtHQ3hwdTNuTWdQNG85Ykky?=
 =?utf-8?B?Mi9SbXRRWW12QS82M0VnaVZDSlg3dStxSlVjMjIrT1EwQXQwMFhDdW9IOXBU?=
 =?utf-8?B?OHYrRnpPQ3Y0M3Q5Um85YjZpMmthK25sQ3FSSDJQMGtQb1BsZkVUamhnTzJ4?=
 =?utf-8?B?eWxIcHNLY3VaOU56YkV4akFvVUVqakxTY2MvQWRDazZ4QlNXM2lka1pCQ3hy?=
 =?utf-8?B?RHdsMjJ5WCtzaTlkdUhiR3dsbGRtRGx2KzNSeFQzRDZrR0hqaXdPU0lJaUhL?=
 =?utf-8?B?cEZiWkdMaUw4bXMwM2dJRkRjVEhXQzhDVGtIQ1kyc2dWZGVxVncvWTUwQ0Er?=
 =?utf-8?B?dVVpRkdCYnRRZVBzSU1PSHNzYy9xNEt5QmVUQTVjTHdqeXJYR2NUcjFxUksy?=
 =?utf-8?B?U1l1L0ZRQnpZYmw2eCt2Q0hKQkRqbFIrODJ2MmlFdFRtdXlMVm51TEFQbjQ3?=
 =?utf-8?B?T3pMZkIwN3JsRWtkS2MwWklFMEJWV0FHSU5DdmRFY0NwU1JXMjhGUVRqNTlR?=
 =?utf-8?B?K2tob1BOVzh3bWgveVBxR1lqZlVXRHVvblpDQ3c0Qk1zTWVLS1lLSHJqOGxk?=
 =?utf-8?B?NWV3NFFCSkV0S0FBK1Z6Q3NCOW9venpOb1FQeWVhVVhxTW9VaDFoVmU1Zy9h?=
 =?utf-8?B?Y1dhbG8ybVFHZTJlYVJ6VkFGMHdIVXdtd1NVTnJrbHZpVTV2ZlJkY0phQ3FD?=
 =?utf-8?B?a2wrRmZmdzRXQm1xeXRBT2VqejF6cTJsOGpjMUJYYjh6SDdsSjk5bUsrODBO?=
 =?utf-8?B?RzZ0cDFhYmp3bkIwdlpNeUxIZlVKU0h0VTh0WWoydkZBenphOU9wOFFxMkxY?=
 =?utf-8?B?MDhXVy9INmk4YkhiV1lxdnFBeER5Si9TVzBCei93SGdNdkFPRng2NTdwMlo3?=
 =?utf-8?B?SHVmQ2x0Wm1aU0ZjNE5hZ0NVaytHVEZSSDV1U00rWkJXbGdScGhLb2xkaFpE?=
 =?utf-8?B?b1dUSnhBK1VoZzFLY3RQMXBBcDEyNnhxUXlTakJlazF3OW8rNTFndkJOOFVR?=
 =?utf-8?B?Y2MrUThjTis5eG5XL2ZlQWNTaFlZK2xiZU5lRlRCOEgzSXBScU9saWVmR2tC?=
 =?utf-8?B?TDVlUDljc0NuRndZcDlPZmNjeTVNYTRlVmsrUVVsZEo1a01aU2pFLzRFT0lW?=
 =?utf-8?B?d1RZN2JtQ1NtT1hzMXkrY3pTcXRYOStEVmpLOVByN3ZiNXJKNHM3SmE2Vkdr?=
 =?utf-8?B?bEJTaStUcWc1TGVPc2d0Z3ZOUExGN05IMjkvb0c2Vy8vUDl2dW5oUkRIU3ZL?=
 =?utf-8?B?bDNmbTV3ZnhZMENoeU9pdUh6T2NtcjNDellKcnA1QUlKdFVkaEVhcXQwT201?=
 =?utf-8?B?a3RRVkJIRHhhSkhKcHNPWXZqMGNUS0JtQ21jclg2cGZnSDd3TmhHWFdhcVBu?=
 =?utf-8?B?RXNKSUJXL2RmNFdJOUZObis5cEEwRzR1ZlhybUdoNzF1akVQcUtWSGpVVjNN?=
 =?utf-8?B?QkN0ZGphWElYQThNVEZpYjBFWXNrTENCTWFtMkRnbU1BckZNL1F4ZGNQRVQw?=
 =?utf-8?B?Y0VkQTZ2NkF3NVV4NW12ZXN6ZjQreklsWTF0WjN5QktCc2Nhai9tcUNmY01X?=
 =?utf-8?B?UjBraXpsSEx5MnkrUjkwVC9hUE1xa2FhMC91T2szZERSQnFlU0dUQ1RzcUx3?=
 =?utf-8?B?ZmNZMXlJeDk1SE9sNWFxa0Z4cWJMdUJOY3pvajZtK0t3dkNuRk9tR0FLUTMr?=
 =?utf-8?B?UEJmcDZIbkRXaEJERFlkT0NDR2REMlR6UGhzVHd2YXFxZGxucUkvQ2JrWTJi?=
 =?utf-8?B?YmNHaUMvcUhpOWVGZFRsdXJsbzZwZUhJN3ZwTUtvU3BLN1dTMlgrRmw2TGFB?=
 =?utf-8?B?d1NrcXZ1QWtDeXhkVWpuZz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b81757-edf6-4425-4d57-08dadc8d4fb4
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 22:07:51.6922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8975
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-11-03 12:00, M Hickford wrote:
> On Wed, 2 Nov 2022 at 22:09, Matthew John Cheetham via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> `authtype`::
>>
>> Indicates the type of authentication scheme that should be used by Git.
>> Credential helpers may reply to a request from Git with this attribute,
>> such that subsequent authenticated requests include the correct
>> `Authorization` header.
>> If this attribute is not present, the default value is "Basic".
>> Known values include "Basic", "Digest", and "Bearer".
>> If an unknown value is provided, this is taken as the authentication
>> scheme for the `Authorization` header, and the `password` field is
>> used as the raw unencoded authorization parameters of the same header.
> 
> Do you have an example using authtype=Digest? Would the helper
> populate the password field with the user's verbatim password or the
> Digest challenge response? Put another way, is the Digest
> challenge-response logic in Git (libcurl) or the helper?
> 
> https://www.rfc-editor.org/rfc/rfc7616#section-3.4
Digest should be handled by libcurl, but you've spotted that I missed
configuring libcurl here to select digest over basic for a returned
username and password.

You may have noticed I've dropped these `authtype`/response config
patches from the latest iteration (v4) as I intend to expand this part
in a separate future series. I'll be sure to specifically test and handle
digest here! Thanks for spotting :)

Thanks,
Matthew
