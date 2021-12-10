Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B8CC433FE
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 08:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbhLJIoB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 03:44:01 -0500
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:1538
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238574AbhLJIn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 03:43:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0/qCkwCy4zyO4/tpleSX5p0gO1KUCkcx3QWtfpQ8oomvRGKbs57rUywvTfuof3kTcSdqjSTleLLxt2sf9gZI6QFJm11u609r3zvRT05U9OK/0VZwWVmWR5TQfx7gl72V2cibVjKE72Rd9GZ+AHH3qfqE/kcwWorV1ojvzKxpa+mLCts9xdzvXXnLxM/ii4W+C/5GcARRa0IR/wI9V6iG3+QkUQoXvSft4nzIhOiCCX2A8cA3ywt0RFbCHLs9jQMTvIGqrPlyx8S2NgSG974IiSftizpuWpjFAHvDsuYdcXzlPt/VwyH84lwnrSxKEY6v1Pkk6Mzjh4wQ2//s37+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdVgFsB35dONbpnUnYvr+DoamHkhM92m+RXEuYDsPZw=;
 b=NIsdY3xQS7e+70OMEHDPJJ0BrLKeJauKsXGOqL9PYXRgoPZXUyRv5N2x8mj5ATRBAL/Sm7P/q7OsYcpjrobbMIswv4JXSaOBUfFEH6iIYfRze89QZvsCupo4R63OSdshW0ukRg6N2pKq+7clmkG0JsfeQPWzFWieXOkOw/IbGSwzGrdJJnR88+rFTx2EiCzjERMKW3mH86WseXfnH/03RJ2lQ5RkSzJBQPTiw9Wpd6sOCqwHjglRxhSorL2KJnqtvrGM38bg6LMfHYJG+UWStDA2yMlT6FAGnqVWenVIYF48wx/0UnJqg3RUgtdjj6dNcUEEkCZTs2XHgWNmGUTnOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdVgFsB35dONbpnUnYvr+DoamHkhM92m+RXEuYDsPZw=;
 b=ZnyFcGyUqXoxECtUD0edywspFgfj2nfKVk1we7QrwnS/uZdCGHDyJYLvxEPZLGRHV1klRNP6EnWQ1jou5GJTdN7g0bNjYCLRBbMCfUvmEgtVpM/kOQSdyO5lFp33Uzv20AZ0GkpNUN+JMWHNaQAF+n9Jz8PWS2eYoqna4RHGcFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4750.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:dc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 08:40:23 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Fri, 10 Dec 2021
 08:40:22 +0000
Date:   Fri, 10 Dec 2021 09:40:21 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Joel Holdsworth <jholdsworth@nvidia.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/6] git-p4: Decode byte strings before printing
Message-ID: <20211210084021.k4pzkckrmocoqfgg@fs>
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
 <20211209201029.136886-5-jholdsworth@nvidia.com>
 <xmqqczm5o0pa.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqczm5o0pa.fsf@gitster.g>
X-ClientProxiedBy: AM6PR01CA0070.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::47) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AM6PR01CA0070.eurprd01.prod.exchangelabs.com (2603:10a6:20b:e0::47) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 10 Dec 2021 08:40:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19c68aa1-ff57-4b39-50bb-08d9bbb8b48e
X-MS-TrafficTypeDiagnostic: PAXPR10MB4750:EE_
X-Microsoft-Antispam-PRVS: <PAXPR10MB4750A5B83AC9180E0C1EC2B5B6719@PAXPR10MB4750.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:419;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHB7mZZZ55HKm5/Id7y4excaty7W9hQ967Nr1TceJ2aAaXlMJ3f+XEj842xbWD9yM37hAZhpI0RSd/h9c6wqNxDK2uB3Qb7+t0CEiSE0g0qnR0yAsj68hgqz4bNnWucD0XAukZvzg69LM8j8azwzhyiDplw9gEJdado7AvM8UVWcLlKZUjOuaymd0GvSm+0qDCncEsk90tEFqwD0JnHs7iq7OVxbaNPN2u7MXtbOMpzn7jdvn7qTspOPd7iYXhbkMbyxURYeG1wqwmY72bgceTL3m+TkyCu8brvov+PJGDURrNn45FZcMiZ+aZ/mbz6Jimzz25SYkD7aeymc8W1TWRi3SRIUhtzn5AQfRcduPzH/6n9FCqIcaHNhdf1ImLUAtrpYnxyOkLUa3iIO973C7PT4nxVZvl8rOpJ8yWgc8tT0Ffe5f8vt3KKRCcipqlhMrMa7kJiUSriyQCTM70OyvYbr5cc982l6SMuYcE1oaQYdgsPEao5x3L4vd8Hz/2/4kAwwiTnZgHA5ylDJmb2CkDwJdzjau2md15B+WTWFkaw8Vff/0tcKFWg8UctAHX/8doMM7aOOPYWPe6yJVEzh0+kZsPvFfdZYP++Rf5tMi5nPHHbzsOh6i8ZqQwtwAoDgNWJ7zUCoB5YrO/wdHAJXbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(346002)(396003)(366004)(39840400004)(376002)(136003)(6916009)(8676002)(6496006)(1076003)(83380400001)(33716001)(66946007)(8936002)(66476007)(66556008)(186003)(5660300002)(508600001)(86362001)(4326008)(2906002)(9686003)(53546011)(38100700002)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXE0WTh3OENFenNQQjhWd2JSSCtGSS9yK3B1WG5DS21nZURjYjV4S290RnNr?=
 =?utf-8?B?QmdLTTJ2UW9LWEdwdVNGbEhBQ1B5UWpDVjdab0p0T1c4Z1FianU5WHNMOURa?=
 =?utf-8?B?ZGRGb0VSZG5zckZKL21OSUU1SjliQkNnaVd2VHI2TnBuaC9NM1dpaXg1aFVh?=
 =?utf-8?B?aWZRZ0JkTUVEQ1FLODlrViszTFJ1YXNacTc4Q0s2NnJDSGhnRmFLeFRjWTlk?=
 =?utf-8?B?MmdhOWZrc2RVTXVQdUFySkMwcmIyQWd4N2NaQmJtVnZZV2tWT29lWUdvUlNh?=
 =?utf-8?B?a1ROOHNCWVBpOWh2SVRXSjBwZk5zQ3dKaWREYkViUXZnM2RyS0NTWFZNZG9u?=
 =?utf-8?B?ZURGYk1wVFN6WkxtTFJhY0N6bmJNU1ZML2JXdndwbWRUWmxkWFdvUENqclBY?=
 =?utf-8?B?dlpjMGt0RmtNSUNDL09QeEkyT01kZ2IxRUt4NUtmaDRuQ2N3L1p3SCt5SU1y?=
 =?utf-8?B?VWNWNzJ4dU43SFlLVTB4MVZVQWFlenVvamM5M0xOdzBYcllxSjQ4aXJScEM3?=
 =?utf-8?B?YXFadVY5ZW9PdXVSanZpRXAvZTgyV09lOWt5emFwM1dGZG95NUZoVWdlSUNp?=
 =?utf-8?B?VWNYZjVhOFdvK2pNZU4wRDZUc1B6OEo2dU5KdHVnNy9OSVNCVy9sVmVTaXlD?=
 =?utf-8?B?TStSWGhBZUVJVmFQbURYZEpNbnc4MklhM2VpM3JRcHMrVm02ZkI4eEJmYjRN?=
 =?utf-8?B?K3RxMTkyMURZdTlOb0k4Ylp6MHZnUnhZWGkxem5vUU80QmxQVWtQRzVlRWVi?=
 =?utf-8?B?c3hBSVhSTkNMb3ZCU1VVdDJBMXMzdjM0MUMxSWpwaXNaR09FYi80TlBXZFNx?=
 =?utf-8?B?b1F4TVk4RnVwSkNxWFVmZWVoNy83Wm5YYXFCLytBbUR4aFk5ekowZGxWMENu?=
 =?utf-8?B?Yklab0ZqVDIyRjlCc1RraGJ4QlA2UGhSSzFhS21uZENwYTFJR0xVZ0E1STU5?=
 =?utf-8?B?aXdhVVNJM1RibHRRMnBGeFJhYi93c2tUU0J3OHdkOWRTS1k0TnhqV0N6b3A5?=
 =?utf-8?B?aVMwYjJDbTFXSW9yZ1hta040WFpRSnBYWXF0VHA1QnNZdjJKZ2QzdG8vNUdu?=
 =?utf-8?B?bTFnK1J6a3ZsVjNEY1N4Mk9oNlc2TkZrNUJWa1hmSU1IMGZRclhSNll1MTcy?=
 =?utf-8?B?VlRQNGQxYmc5SUVKdlJLNzhJRkErQTlhV2liOU1UME1QYWhXa0FOWVRTdk11?=
 =?utf-8?B?MzIycjUvaWtPTXFlWlkrMSt4b21FeGhzRGhzSXpYTlB4cVFmcmxsUENwQlhL?=
 =?utf-8?B?ekkrZ1I1b0YrRmZSV2hzOFQzbWhvdDFFM21KQ015Vnh0UUlqandKM1pFYTlO?=
 =?utf-8?B?cUVINElSM2RaQ0pXOFROOG45eW9EOWpzd2JmdkUySFhyczVudjM4U2MyZUNS?=
 =?utf-8?B?NkFmeGkxa2gvWWwzZGRTZUxiVG9jVFVqR0FhSi9QcjMyUlBWYmdwSW9lTXEr?=
 =?utf-8?B?NXROMlNuWHRUTDVaUFZzM2VtK3dlaUY3dW5peFUzZmdUeTFiTU5wVWlHbEIz?=
 =?utf-8?B?bko0bU84RXFlZFVEL2dudlNhZmVtajFNMUJzSEM1MWpxazBjRVd6dWZWNEdu?=
 =?utf-8?B?dWR2SXNBSUFHWUdZaVJ5K0ltS3dnQ2wwM2twMXFVNi9UejRKUEpTakpNc1Iy?=
 =?utf-8?B?eHZUYnN6Q2V6WUFNSjdlMWN5SGFqN3Blbytub3BJRUN4RW44cGJVRitITk1Y?=
 =?utf-8?B?ZFlhYjVIRTJKYUdaWlp6eXhleXI2UktENXNENHhZYk9NSER0OXYreDlkNHZS?=
 =?utf-8?B?ODJ4YmM0WXZMNnRiOFR3UjZ5OTFETERNSE5icHJjT3FzMkJmTjBRd0padDlL?=
 =?utf-8?B?TVRWaFlRZng2RHQweEt3U3NubHhTMGN0SXRoY0RzUkFmM0dITTZTSVpCeFBO?=
 =?utf-8?B?MnVmc0kzYXFvUXg2UVBkYjU4cFlGRmI4MVNTcFdYLytjMTFCMTRkUlhCK0or?=
 =?utf-8?B?dU5wRjgzVUVIREdkTVd0Q0FFTGtVV1FwODVWUGVyNWlOeit2MkJGS3JtN0dT?=
 =?utf-8?B?OHZ0UUdDSklJN0xoVkN1ay9hWU5zYUwwcnhrZUdJS1NnYlVRRVA4WnY3VmRw?=
 =?utf-8?B?b0VOeWZ4cW10OFZicmc1ZTF5enVlbE5IajRrY0xjR3B0R3VWbzZNdEJxSVlO?=
 =?utf-8?B?UE1IampyY3F2VVN0bFNKcUVScE4rZFRqRFlWZTJxL25seFpaODNZM0pBaU5K?=
 =?utf-8?B?T1dKUjZlR0Izd2tEN3MzZVpudGllQUp4S0NCR3Q1SmR6M1NRajlkOWJLU1oy?=
 =?utf-8?B?WDllSHU5dWdyRU1LdFBPUWhPRXZENDRRRVB3ZitCcUJjL25yZ0lTM0YzTWZY?=
 =?utf-8?B?cWV5OFhpSjN1QVEybW9nSzF2VXVqT3Q2eHhvdWg0N1I4VFF2Qmk3cXNJd1Rj?=
 =?utf-8?Q?iWkfbWby9kwLCZ9g=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c68aa1-ff57-4b39-50bb-08d9bbb8b48e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 08:40:22.8203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMp0X1rLEJPS4lWuVlV/iNK1FSL5tJxj6XcXiS51WA38b5LwgU7qwHMc3XsfAN78cSVBiGANA7IFQekj7rWvRXDPxFS6K1n+cY34Yjb6LVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4750
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.12.2021 14:47, Junio C Hamano wrote:
>Joel Holdsworth <jholdsworth@nvidia.com> writes:
>
>> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
>> ---
>>  git-p4.py | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>
>Is the use of strings with {} placeholders and their .format() method
>integral part of "decoding byte strings before printing", or it is just
>a new/better/improved/subjectively-preferred/whatever style?
>

If the new minimum python version will be 3.6 or above I'd vote for using 
f-Strings instead of .format() which I think are more readable and are also 
supposed to be faster.

So:
sys.stdout.write(f'\r{file_path} --> {rel_path} ({size/1024/1024} MB)\n')

instead of one of these:
sys.stdout.write('\r%s --> %s (%i MB)\n' % (file_path, relPath, size/1024/1024))
sys.stdout.write('\r{} --> {} ({} MB)\n'.format(file_path.decode(), relPath, 
size/1024/1024))

>> diff --git a/git-p4.py b/git-p4.py
>> index b5d4fc1176..b5945a0306 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -2917,7 +2917,8 @@ def streamOneP4File(self, file, contents):
>>                  size = int(self.stream_file['fileSize'])
>>              else:
>>                  size = 0 # deleted files don't get a fileSize apparently
>> -            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file_path, relPath, size/1024/1024))
>> +            sys.stdout.write('\r{} --> {} ({} MB)\n'.format(
>> +                file_path.decode(), relPath, size/1024/1024))
>>              sys.stdout.flush()
>>
>>          (type_base, type_mods) = split_p4_type(file["type"])
>> @@ -3061,7 +3062,8 @@ def streamP4FilesCb(self, marshalled):
>>              size = int(self.stream_file["fileSize"])
>>              if size > 0:
>>                  progress = 100*self.stream_file['streamContentSize']/size
>> -                sys.stdout.write('\r%s %d%% (%i MB)' % (self.stream_file['depotFile'], progress, int(size/1024/1024)))
>> +                sys.stdout.write('\r{} {}% ({} MB)'.format(
>> +                    self.stream_file['depotFile'].decode(), progress, int(size/1024/1024)))
>>                  sys.stdout.flush()
>>
>>          self.stream_have_file_info = True
>> @@ -3803,7 +3805,7 @@ def closeStreams(self):
>>              return
>>          self.gitStream.close()
>>          if self.importProcess.wait() != 0:
>> -            die("fast-import failed: %s" % self.gitError.read())
>> +            die("fast-import failed: {}".format(self.gitError.read().decode()))
>>          self.gitOutput.close()
>>          self.gitError.close()
>>          self.gitStream = None
