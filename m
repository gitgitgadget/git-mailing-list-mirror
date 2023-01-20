Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D4BC05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 22:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjATWFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjATWFW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 17:05:22 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2015.outbound.protection.outlook.com [40.92.90.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C5B1B54C
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:05:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJuADiWSBKNDV680h7MqegXRlVbi9Ohr3O7B05dv26JoFX5utlp5p4k1LMKnoVIa2JdhDIsc+9E+qvDZcf15uOq5oeK63tnSMrh5o/Ww26mROuMwMGLXMPLBAszlOG59RSFjh8kwsxrAcEdh3HHJ/7wiTdYfdC/vlMt5WF49Vmca0lBLIsbjAtNgNTBN0lnD9+AYcVoYfSfVY6EFRWNxlkba19wl3wejxOgCbJZM2OVT/eFhqKqx5KnsJVriyCnEqnkRf5bd9/AfYh3Fh4n2qENYHfpc48VUpVgTqTKqV0Fx2YfyFVt1Cm+Da7ZAvDZ7KHjLb32RqUQHjA6ZbCgqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXBEGFd+RtKrEISyHeeJLB12HlX3hRwEZJpaCNbbgpE=;
 b=hIf5iYDZVptt0hL//uoZnLboRG0mn8XCM7pyvvc1wv54H9udlnIi1+WVP0q6bwW1nzL4P7IUAHaihN5iXuzHp/fBR+vMxoR5v8JH7uM1bTpphs1xWN1FnTq/5+uWToOM66ZP2WawDkLrLa1BJozN0iVZ13d7MUMmzLyf5y4FnvfCrFjH6fITkoYLVzXS+r7fAJxxpiewPZV/sCSNyY4fVkjJZdbBd6/V4OtG8MKgD3k0FCJM4keZKjp5u+XawdiYbp/nV3iWtPHgmQSt8Lj7ZfR262NfuqPSuPAtel7eymzpWzBCKnOJf+gXK+iKC8j2Ec02M2OWvU9bONiTGceh3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXBEGFd+RtKrEISyHeeJLB12HlX3hRwEZJpaCNbbgpE=;
 b=pQosw8lBtq+9gOR2p405oNM+ct4Wt0xZ7qNkI/zH6HeYCT3OeBfG3hE062vW/uGe8/vBsUQQ4/LY1L6alqJIdKqzac9fyX+faOmDWUp8GLnF651GRYoHkiE6A64gSWgSjIKWj8K0FOZdw4mrJV+7eL7cyfRJeRBcSpsR2oGHyV+FwGfgb05DcG+vGphYn9w1esYb/NB/mCnbgwt3yqbZhCqg/oTxPSmyYPFn8ul9f0sftyy9QZmpN+C1lfcUbRuqUIzTaB5eXIa8RWiT5wA5jf5AJgT0xRNmes3Nc/wxBqmQTNhFaaJIL8L22Wzgcmk2KmlqjVmg0Q8WTFUrg6BX3w==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AM7PR03MB6676.eurprd03.prod.outlook.com (2603:10a6:20b:1b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 20 Jan
 2023 22:05:19 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.6002.025; Fri, 20 Jan 2023
 22:05:19 +0000
Message-ID: <AS2PR03MB9815437B9BE892A9F0AC564BC0C59@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Fri, 20 Jan 2023 14:05:12 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v6 04/12] test-http-server: add stub HTTP server test
 helper
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>, Victoria Dye <vdye@github.com>
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <d6e5e8825e8454242820738f0dfb03a9f1c01ced.1674012618.git.gitgitgadget@gmail.com>
 <230118.86k01kxfr7.gmgdl@evledraar.gmail.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <230118.86k01kxfr7.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [uK5kf/zpq2/zJAgGjtVOSgRjpIiodVVc]
X-ClientProxiedBy: MW4PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:303:87::10) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <be1c86ea-135e-15cc-dce5-f32b65c83e17@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AM7PR03MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: c42ee653-a99f-4d33-694c-08dafb326b1e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a71+gGBRQJMCnrast07CLuFJaCjqa5Bu4Dx/HGmKznnG6VJ0HFNXkVbna28PEOgWJyBfnbMCSXkkFHgRNA3cg3XkakbNw4nDHK5p5g/Ts6hlFP+++o0UU4uBFaph7li3o8W6D3hlWn5tvuWnfRNsagxnw0VvfgTpkEQ5PoKj75FjA7OnXpIVtiT3ks8AKmZ3v+k1wDSdwF9MTAaKXjZ6efxCyd7Lj8ngzcZqe76Nfx43rrBckmwALhYVU8exkxDLoDK8ZG41fNcXp6dhXUQVaPTKBiwcsk4OCGc66aP26cvQAoJfasYnPB64LMxllh66VCsrV8P3HVRg5G8JCzGzPOWtTnUOX2CAfmqJVRz/SjYFoagGflVKg8a/WyYoIsVzDxojHRdICxWWnek50INlOpCafVlN49snTfeJrx9aw3CB14immAoj98Dbp7drk2C2sV9oodZnE13Ww3TaqKiWMDMqZiXjOytRZ5rJa8jTNhcK5GhNYZ76Rtg/JGKW37805j6JK2y7Qvky/quTaxidevkMOHLXko+MBpqr0kOL5bVvn9N8clnfcvE6/mnPzvJA0jrc1MkrMKmEeslU9wkaWwpMkaxrQkYsp3538KOT9kQ03sSfAiRRPXUwCJezEYhzeWFmk82hqTxoZx9bgwCaow==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXh4MmVSekVPMC9aRkV4aEx6L0FHeno3d3dPTUJvT0xKbjRaelF3NXpKb1Nr?=
 =?utf-8?B?cVU0V25POERCYjZuRUhPbXJ6YytKZlRia1dUN1VVWW90UHp6SWFQaS9DNnk3?=
 =?utf-8?B?empMa2lsbFJTdmgxSHhRM2xrOTBCUUhWYWxKUkNyMkJNNDRzYlkvdjhoeWZz?=
 =?utf-8?B?K1J2czFxY25LSkNpa0VYcFVkODJnVS9vbkRkK3pxeTFJVnFlTHRqUlZiQXo3?=
 =?utf-8?B?dmx2Z1NNbGgrbGFOWWFkTUhYMStLVlBKN0wyZFRrZUpCYWNLODhQUzRsVUVC?=
 =?utf-8?B?VGpmNFQ0aUViRmVsUThSbGdTQkJTTktsbmpydDZIM0lma1hxdUpoZ0o4Rlgy?=
 =?utf-8?B?RVlSN3FhOTRvSDczQVp1VTZkbjdZRkN0ajRYdFdpQmk5Wm5vQW5WSHNKQTVF?=
 =?utf-8?B?ZFJEQzFoSjJxZmk2VE9YN0dpb1cxY0haYzlNaC9nQ1Q0ZVBFSi9vWlZmNkZ0?=
 =?utf-8?B?bytOb213NUkvU1BUUVJ0QUpLcmJHYU5kblR0MFZFS2xHcHlGVHc3SmtJNjZB?=
 =?utf-8?B?ZEVBcHVnUUZLWkNpL2NRTmM5UnN6bU1idkRYcEN4WXZmMUxtVWh3bFdHQnhq?=
 =?utf-8?B?NGpXUUtYRUtpc2pJSjhHaGNRbGY4Ykk2cit5NTV0OGtaZnV3V1piaHNrTEsz?=
 =?utf-8?B?SS9ZVTVaa24rdTRRRjlOeHBSbE1jTUx3T2VIUWY1Zy94R0RMTHRGaXRIOTFR?=
 =?utf-8?B?b3lad2o0NzM4dXFqcWVZVmlmQ3ljMEtDeXVCT0dWUktEWWQ3QkQ0TGVBR2dR?=
 =?utf-8?B?akhGRm9QOGJOSHVhV3Fzd0tEQlBpTjFUcmdoaVg3bnFnd2tNNDZTRUtpbnFs?=
 =?utf-8?B?WUZzZkxPc3pFTjVNYlRxdEM1dFpKVG03UHpyNWVxS3l2REFDQXdKMm43eVVk?=
 =?utf-8?B?bzkwaUZNL3hFUlRvVThFbGZSVWxDb1VtUWRhNHV5TlYxcXNPbVJ5NHhvdnQz?=
 =?utf-8?B?T2NUNGVHL3E5OFlSTnNsRll4azQreDBCSGRPcWhCL2NKNjA4ekZKWTNjVVhY?=
 =?utf-8?B?RC9ZdmxFZ29HdURkWThJT0J6YjR4QjNGNGFZV3EzM2dITjFoUFgxcDJSUUw2?=
 =?utf-8?B?TWdPUXhldDRDRDFJSEFzMWsrQ0hGS1RPNFluZDlLUlJteWlXR045SGRBOGNj?=
 =?utf-8?B?T0xGelprNTQ4SFFNNlZFaFdHSGloOHhkNDE2OGkxUHYwWGd5OC8wcWpqQlgz?=
 =?utf-8?B?Y25zUkU0Y1JIa3Mwc2VuMEhNdWVGSU9qeHQ3YnZweWY0MSs2ZmZVdkRDT2tN?=
 =?utf-8?B?NGtpSktsRllJc2pVdDRyMmhwd3RNeC84bU0zbXlYWjFyeTdlU3VycVg4M2hp?=
 =?utf-8?B?d3RJNVYyWm9hQ0xWRTBVWHdUQ2tRcDkrS1RUeVdkenQvN3V6aTVROFJaWkUy?=
 =?utf-8?B?MFlTNmtPWUhONElXNW9FWWZZTmw1OEczaGJHMGxJNkcyT2R3bnlUeXNtL3hL?=
 =?utf-8?B?Ylg2cHVnTDVXTXVRbzMwK3IwcHBLTHpYQUZ0d0I1ejh3WVR6eDhjRmdOaE1J?=
 =?utf-8?B?VEFUNWZrYjcxYUtUNXkrQWplbzFCcmU3Wm5UenZwVGVpWDFRb1l2clVuam1Z?=
 =?utf-8?B?SDZvakYyNUNmWTBqZUMyc3RZV01XazZTNGpnNVN1Q295NVh0Z0tDSUM1REZG?=
 =?utf-8?B?cS9Ub09pNkZYd1poVDZKOHRnMnNwY3dGTFVxRTYwRS9hVll5dGtXeFdUcnpx?=
 =?utf-8?B?N28wcDNJVlhQUWhhbVVDVHVJODNiZGR0WklvMmV0SmNTeW1jcmhqeTN3PT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42ee653-a99f-4d33-694c-08dafb326b1e
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 22:05:19.6063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6676
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-18 03:04, Ævar Arnfjörð Bjarmason wrote:

> 
> On Wed, Jan 18 2023, Matthew John Cheetham via GitGitGadget wrote:
> 
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>> [...]
>> +enum worker_result {
>> +	/*
>> +	 * Operation successful.
>> +	 * Caller *might* keep the socket open and allow keep-alive.
>> +	 */
>> +	WR_OK       = 0,
>> [...]
>> +	enum worker_result wr = WR_OK;
>> +
>> +	if (client_addr)
>> +		loginfo("Connection from %s:%s", client_addr, client_port);
>> +
>> +	set_keep_alive(0, logerror);
>> +
>> +	while (1) {
>> +		if (write_in_full(STDOUT_FILENO, response, strlen(response)) < 0) {
>> +			logerror("unable to write response");
>> +			wr = WR_IO_ERROR;
>> +		}
>> +
>> +		if (wr != WR_OK)
>> +			break;
>> +	}
>> +
>> +	close(STDIN_FILENO);
>> +	close(STDOUT_FILENO);
>> +
>> +	return !!(wr & WR_IO_ERROR);
>> +}
> 
> We have cases where we assign "0" to a bitfield-looking structure like
> this, but only in cases where we're planning to use it as a boolean too.
> 
> Or, in other cases where we want some to be explicitly <-1.
> 
> Here though we're adding a mixed "OK" and error use, which seems a bit
> odd. Shouldn't we pick one or the other?

You make a fair point about bitfields vs simple integer values. This was a
holdover from previous early hacking on this work where I had the bitfield
serve as a way to communicate the aspects of "does this count as an error?"
and "should we close the connection?".

Upon second thought, I think just simple integer values would be fine as
really only an "OK" and "HANGUP" are non-errors (the latter being the case
that the client gracefully ended the connection without an error and we
should exit).

Check for my next iteration for a rework on these `worker_result` values.

> So far (maybe in later commits?) nothing uses WR_HANGUP, and oddly we
> also use the bitfield-looking thing as a return value from main()....

We don't use the `enum worker_result` values as a return from `main`. We only
ever return 0 or 1 as we `return worker()` from `main`, and the only `return`
from `worker()` is `!!(wr & WR_IO_ERROR)` - 1 if we have `WR_IO_ERROR` set,
otherwise 0.

Thanks,
Matthew
