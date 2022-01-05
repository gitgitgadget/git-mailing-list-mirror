Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE50C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 10:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiAEKgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 05:36:18 -0500
Received: from mail-vi1eur05on2085.outbound.protection.outlook.com ([40.107.21.85]:30624
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230353AbiAEKgP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 05:36:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNDv6lGFzvFjC8XOtXcle2hSwloikb7CHBKbmZgH+qT+HpuN8gWh4sLZbbjBipV8bTsxsSiJL9rfYNWCVZa/LrOoUi9Zbrlibuql2G+uJnlsLV4w4Bei4BMQsKZNrYqGXLOzxT/BnXYlekx8mba6D6lKnsqXAoFJ1rt049KinIMNACrYoIunWnKxLtfxswXiic6AGGYKNsCKQhdC+HAOlchEAzmlnWQHF+PEKRLDQcjm/Vm3jNR7HQmhcev++28oYOb3qZOmp2mR1zmT18V9npfWImMUd3emd7yxSDkv9zKHRhI80oVPG3xtljN6rKxUASZFWFI6W+wkGObylm07rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SjPPRBxVXNjGHaYaAiv1hm5ApcUTjGGLenkDo8fFhs=;
 b=X5Hvl3YuiqwcUb1z8VCIIHIMTzzbnxtKEz6i0KlHppaLRYfz6KKBU4jcVRfvmKMbStrINAdJSfdQ7R8i4evzgPl1yUqI1QX6/AxE+x/QHD/Svk6GQhAPAMlqFqEiuOwI7x9Pt/wZx2/SvOHoKpYX4y+YuWFTdDJBQ8+qGNqISrEWFs9kpkL7JQpEwtUtuKgVoIUMokL4ZOJL/R7T+U81YP1nx+zLU090/YUqSxCg8M14UX5N4YA1B0V5r9xUZGKpkwqRbc1ixJPv5v9hwmmOStQFn4YE+T7dh/vG+QQX0ziIS2LquJc9xlckzHvIG4p2oVV2P/ZgSby/f/TRNt9bew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SjPPRBxVXNjGHaYaAiv1hm5ApcUTjGGLenkDo8fFhs=;
 b=X2KelT9hVN95jl91tOuH/KlMp8KE34SZEZQkFZRQXUbrLaqXhgUbrtFByGwqCtux+Uc+EoZ8Nup5s/v6OmI/QmFSGV2lFgTt0Y+HBuvGys+SR34fs2AhmXgZEU02E3I3fMb6yU/E4QJV7okozLcYm4w2FihKHRVSAbmrHltZOSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4464.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:106::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 10:36:13 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4867.007; Wed, 5 Jan 2022
 10:36:13 +0000
Date:   Wed, 5 Jan 2022 11:36:11 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Pedro Martelletto <pedro@yubico.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] gpg-interface: trim CR from ssh-keygen
Message-ID: <20220105103611.upfmcrudw6n3ymx6@fs>
References: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
 <20220103095337.600536-1-fs@gigacodes.de>
 <CAPig+cS6h6o2_dJAZC1M1Ace29bN2mhPgaEtTWtj3oXfcHq9cA@mail.gmail.com>
 <xmqqee5oieb2.fsf@gitster.g>
 <CAPig+cTM3wZz4NXjxYeBuFv0CVNS-T+pBFeVkfMQ-25pL1kBzw@mail.gmail.com>
 <xmqqmtkcguvm.fsf@gitster.g>
 <CAPig+cR93GyN53JoZbaiROrNtzGjiet7eTPQOk-26G+mB0KaCA@mail.gmail.com>
 <20220104125534.wznwbkyxfcmyfqhb@fs>
 <xmqqo84rcn3j.fsf@gitster.g>
 <CAPig+cQinNZp_2=eo7nokMCZ9gc-tAKO1V_jejL2Ei9J63tSDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPig+cQinNZp_2=eo7nokMCZ9gc-tAKO1V_jejL2Ei9J63tSDQ@mail.gmail.com>
X-ClientProxiedBy: AS8PR07CA0022.eurprd07.prod.outlook.com
 (2603:10a6:20b:451::17) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96aa7479-ac6f-41da-e191-08d9d03731ad
X-MS-TrafficTypeDiagnostic: PA4PR10MB4464:EE_
X-Microsoft-Antispam-PRVS: <PA4PR10MB4464EE56DADA68E5E917FD29B64B9@PA4PR10MB4464.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nu39VIN37P9QfEy+8/YDAH0//gO6nfATI0xyoAX+Bfay4gWA7RodwEElSiyt9s3LSmk1L0PUUH3Q4lbnw1OrfHQ22JiQeqa7H/JmnKpPPz4jt+3bTLKfb8Z5BzAIkK75e7ChPi1G6zKVNW7mmxA/nNaqIa8EetLh2mP/BIg5td3qz+XY3fMChwzPPuge/Svho7PESQeOLdOB/dYs3Bfx4by8a8PrYSHe+2HkPAWQi0tZYECFKBY/iBcqJQV1ciNfTwNRgGD5x8UNacPWErAwnj6xuMRDZQNE+S6S892wkVqBnQxwB3UuKbmBaO35rz0S1NLz9xRUT8WL0LyoysRDqZZU2AP2pvzRd6UanRrNpYR5kM86ltOPfV9PjxFGw3R/O+dBftYRuNXY/723KRJ5pGy3QUNWyQeOWa9u7DgE6I4H+t35gdd6do0EjK8OuBmesZxro72gwUaeKVZzvYLch7Xe2DW328/4X39WqHuqa0sKsV3J49gjKOLFoVzl5EhHybnr8vVEwjH0glUTNLmaCHvqb6LwIBDvpq0N4LNtfXaLbjg0ELZ+hZ3qW094wSPQSBZyPLCrrSJ/T+LFiYRSVYdkhget+YtgSJ3IYuAnZNrAjT2A1Kfi2PxfB0Y0qmYTJP+Z0siwi1X+b7vi1V3TVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(136003)(39830400003)(396003)(376002)(346002)(366004)(53546011)(66556008)(6506007)(26005)(5660300002)(66946007)(33716001)(38100700002)(8936002)(66476007)(508600001)(54906003)(316002)(6916009)(6486002)(2906002)(8676002)(1076003)(6512007)(83380400001)(9686003)(186003)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0t0cFFMUnl3NGoydE9IV3V0UlBWT1VMZ0MvSlg3WUVXYWpDaTRJYUhjdmpV?=
 =?utf-8?B?YWMwR2U1SEdFbzRCdTRCcWN4WS9udDNkdk9BQ292bm5DelpJTHFweUFJZjR6?=
 =?utf-8?B?S1phQ1hXMlYvWmVXdThLRUJMVnFOb3lyY2tjdE5xajgzRlIzRUduaU9YeFlR?=
 =?utf-8?B?TGdZd3M1OW9IUkZYbFJlZWp0U3VIS1lJbjZVWlRtZkRWbDFxbnFIZ1IxeGhM?=
 =?utf-8?B?UG0vbU50VmxNbGRDd3FNVkkvb0doTkJnamg3blFDdDBJQlFWMTVZYmloeTdB?=
 =?utf-8?B?TUdNTE9NaWVtUmgrTXFiRGFkQVl6b3VWUU9YU3ZMTWpnTVgxNkVtRU5ReTZn?=
 =?utf-8?B?NXNvQjVCTjNORmltUjJ3NExuWWNtWjJRRFhkbTFsbXhFVEtkanVBVVQwQ28y?=
 =?utf-8?B?SjZkQ1UyY3RXdGZCUi9qN0hMY1RTajNmVXN2aURBckVUeGt2UU5seDFrbHdU?=
 =?utf-8?B?NjRCZ3dkQXN3RTVHZW8vOEdSa0dDN2NxQ3JVRXRLZXZiRzEwMVhGVnZBRUpF?=
 =?utf-8?B?VGdJSU1vU0ZYbkM5Q1pLYTNMeFlaL0xFbkxVTjFuVEZZbjBybi93UUR1TTJw?=
 =?utf-8?B?Q1FlalRSOUFjRm4zU1pQSExQNE5SK1Z2YlhlKzJpQkhmKzFzOXFzdnBnRDJV?=
 =?utf-8?B?UVgzZ1Rhcm4vd1RZRk5pL00rVUlEaDVIMjh6bHRwb2hPMzBJazhIYTl0K2hj?=
 =?utf-8?B?blk0R2lDdE9FSForc2o3UWNieDYyMWwrakhvTkRUMzI0Ukt3cjZ4Rmg4dkZB?=
 =?utf-8?B?UnQrR2VVUkhxampCaU9FUldGYVlPa2xBanBoclhqc21EU2tGdUorNjQ5aHdv?=
 =?utf-8?B?cUdjNWd3UDI1UmhaV0w1d0EzbS9wZkY5N1IzSTRzenNQRVo1N29qWGJ6Vmhz?=
 =?utf-8?B?eTlONGlhT3F1K1lxd0RhY1VhYkd6WjROcHN5TTc2V0lqWndDa2M2OWErWnBz?=
 =?utf-8?B?NzVpV091RkZEUnpBUGdBTUE5NFVLQVVaN0dXYmVLdXlxd1J1NnBKOUxqcEFG?=
 =?utf-8?B?T3EzMnpxRmZMUEdTNFAwc0JVQXBvcVc5Sk5oMDk0TWhNU2JBMDBIMDQ0UzBv?=
 =?utf-8?B?R3QrdVU4WWlrLzk2NTBrNlBNeTRaa2FzU1ZHbnoxMVJ5RGtMSzJBZmtjNmxB?=
 =?utf-8?B?anJtdGs3YWVtbUFRWWtuZ05QSzFmRWdvMjRIVTczOXVVUGVsM082WmNQY1l0?=
 =?utf-8?B?bDRkcWVVQ3pHamtNQjluWDN2Z1JtSTIyTzF4TUtsOElEUHoyd3Zma0RDM1dV?=
 =?utf-8?B?OXJHellEVnFGZno1MnJGbG1LRGpXVDR6YW9xdk0vWVpjZU4zejNEWjlDVG9Z?=
 =?utf-8?B?ZCs4UjVpSnQ3cmMrRTlNMkF6ellRUUt2V2pQaTM2ZDJuSUhadklXRklPS2Jl?=
 =?utf-8?B?V2RQOUhBU0NVU1ZsUHhDOFVkTFc2Vkd4SndqM1EwSzlOQXFWOEVPaEFvRHNq?=
 =?utf-8?B?OWhsbU5xaTFBb1RJc2kwYWVwaHFsbDRHaGlmaS8wMWFlR1NCanpvemUxK1I3?=
 =?utf-8?B?U1IzNzFkbEdvREhkTkpOeUNSdUpKNHozK2hvT1FLMXIwRml3WHRjeEhqaXl2?=
 =?utf-8?B?dVZJRS94U1Y2S04rSzlpMG5tQUIxVWJWYjVNNnBRd2xnYnFFQUNYZmxtR0lY?=
 =?utf-8?B?WXA3QUVIQXFFcjlrTFFCUDdvNUx2QUVLeXRFMGdkR1NFQjh5MHY1RUVkMkpI?=
 =?utf-8?B?ZXUxdlhsTC9GbjlUOHQ3MzdSUW45cFVLK29aTjZsSGdZaUJQWDFXRlBKakhR?=
 =?utf-8?B?MHVGQ1QxOFdsekVFMnZiV3d6NitEZ2c4THNyY1QrZ1JRbXFNODBYWXFOYnpY?=
 =?utf-8?B?YzRZLzFTYmpnWEZHV3o1TFpXaVdGNjNoYldaT1NHL3BKREk5bFM1Mzd4em1o?=
 =?utf-8?B?WWR4cG1UMUJCNUhNOTM4RDRkUGFrUnlZdEpRKzBmR1h6aFFGcTBqVCt3ZkVY?=
 =?utf-8?B?aUZucVV1dmZJZjRxeDk2dUh5bUw1Q0gyUDVoQmJaMEtWZ09GeFBVSnhlR3Nj?=
 =?utf-8?B?RVNBMHljVnY5MnhndjlkMmY2a0JGckxmcmNHT29tV2orakN3TUVoUExYRW9v?=
 =?utf-8?B?a3cxaE42Ui90NmRkek1GZUlHTnpUd3dPWU12TXNEclJxSjd5T08vazk2dE9x?=
 =?utf-8?B?cExvSzlzRGhSSlM2dEx3Ukowcmo4cHZ6TWlYdmdtczllaWVUb0l5eVZhdEpn?=
 =?utf-8?B?ajMwaXk5ckpwbHpIcHNaeVB5TnJxNk56ZzBWbUtBelR4NERsNnhPU25lc3A3?=
 =?utf-8?Q?LS337vPrtp/0QzEdSryjDcMQ/SOtSHRzpYa/wHKwA0=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 96aa7479-ac6f-41da-e191-08d9d03731ad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 10:36:13.0673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8073ddygJ6RSDqC6WxMzToYplzrN73JLG5EsCvHQziDL+jCYtI6KnGg9Vjx9uc6/eXvdu3aGDierqcUttk84QPHUVjZ++VB8Bld46ZvA4EU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4464
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05.01.2022 02:09, Eric Sunshine wrote:
>On Tue, Jan 4, 2022 at 2:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Fabian Stelzer <fs@gigacodes.de> writes:
>> > I guess we need a bit more context for this patch to make sense:
>> >
>> > for (line = ssh_principals_out.buf; *line;
>> >      line = strchrnul(line + 1, '\n')) {
>> >       while (*line == '\n')
>> >               line++;
>> >       if (!*line)
>> >               break;
>> >
>> >       trust_size = strcspn(line, "\n"); /* truncate at LF */
>> >       if (trust_size && trust_size != strlen(line) &&
>> >           line[trust_size - 1] == '\r')
>> >               trust_size--; /* the LF was part of CRLF at the end */
>> >       principal = xmemdupz(line, trust_size);
>>
>> Ahh, OK.  Sorry for being ultra lazy for not visiting the actual
>> source but just responding after reading only somebody else's
>> comments.
>
>I'm also guilty of being lazy and not consulting the actual source. Sorry.
>
>Fabian, thanks for all the extra context information.
>
>> OK, so I was completely missing the idea.  And I agree that it may
>> be a good idea to check how strcspn() returned to deal with an
>> incomplete line, although as you hint later in the message I am
>> responding to, checking line[trust_size] would be a more obvious
>> implementation.
>>
>> In any case, I think the earlier part of the loop is more confusing,
>> and I think fixing that would naturally fix the trust_size
>> computation.  For example, wouldn't this easier to grok?
>
>Indeed, the existing code is confusing me. I've been staring at it for
>several minutes and I think I'm still failing to understand the
>purpose of the +1 in the strchrnul() call. Perhaps I'm missing
>something obvious(?).

This whole loop was basically copied from parse_gpg_output() above. Without 
the +1 this would always find the same line in the buffer. The +1 skips over 
the previously found LF.

>
>>         const char *next;
>>
>>         for (line = ssh_principals_out.buf;
>>              *line;
>>              line = next) {
>>                 const char *end_of_text;
>>
>>                 /* Find the terminating LF */
>>                 next = end_of_text = strchrnul(line, '\n');
>>
>>                 /* Did we find a LF, and did we have CR before it? */
>>                 if (*end_of_text &&
>>                     line < end_of_text &&
>>                     end_of_text[-1] == '\r')
>>                         end_of_text--;
>
>It took several seconds for me to convince myself that the -1 array
>index was safe. Had the `line < end_of_text` condition been written
>`end_of_text > line`, I think it would have been immediately obvious,
>but it's subjective, of course.
>
>>                 /* Unless we hit NUL, skip over the LF we found */
>>                 if (*next)
>>                         next++;
>>
>>                 /* Not all lines are data.  Skip empty ones */
>>                 if (line == end_of_text)
>>                         /*
>>                          * You may want to allow skipping more than just
>>                          * lines with 0-byte on them (e.g. comments?)
>>                          * depending on the format you are reading.
>>                          */
>>                         continue;
>>
>>                 /* We now know we have an non-empty line. Process it */
>>                 principal = xmemdupz(line, end_of_text - line);
>>                 ...
>>         }
>>
>> The idea is to make sure that the place where the line ending
>> convention is taken care of is very isolated at the beginning of the
>> loop.
>
>Yes, this may be an improvement, though the cognitive load is still
>somewhat high. Using one of the `split` functions from strbuf.h or
>string-list.h might reduce the cognitive load significantly, even if
>this code still needs to handle CR removal manually since none of the
>`split` functions are LF/CRLF agnostic. (Adding such a function might
>be useful but could be outside the scope of this bug fix patch.)

How about something like this:

int string_find_line(char **line, size_t *len) {
	const char *eol = NULL;

	if (*len > 0) {
		*line = *line + *len;
		if (**line && **line == '\r')
			(*line)++;
		if (**line && **line == '\n')
			(*line)++;
	}

	if (!**line)
		return 0;

	eol = strchrnul(*line, '\n');

	/* Trim trailing CR from length */
	if (eol > *line && eol[-1] == '\r')
		eol--;

	*len = eol - *line;
	return 1;
}

Its use would then simply be:

char *line = strbuf.buf;
size_t len = 0;
while(string_find_line(&line,&len)) {
	if (!len)
		continue; /* Skip over empty lines */
	principal = xmemdupz(line, len);
}

Not sure about the name though.
Maybe string_find_line() / _iterate_line / foreach_line ?

