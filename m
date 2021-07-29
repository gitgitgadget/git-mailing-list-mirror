Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47554C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 21:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A5360F00
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 21:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhG2V0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 17:26:03 -0400
Received: from mail-eopbgr130043.outbound.protection.outlook.com ([40.107.13.43]:36711
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231164AbhG2V0A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 17:26:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqLIbSBVPINq/oIfEsy/jbXSSGYX0zAP/5XMAsn2oVzt9mUMDbquKigw/XjdDauFaLcl2n0HlT8inlZExKjbgcCYElD4AuuzRPq9rPRuzHITXdaz6anypN3AJiQ310GsRr+KteHq/xFQo5RwL6Flvhb2bG73UY9yPlxqGbWvPyAZNiRrYx+Yw8QtHfi6S6x7Q4Wd8OpLCri3dmY+m8RtqGy+TT9axglbLeSIEu26BUFCyPwQCayoJnfwuQ5jMgR8W1Rqxev59/2I25fUm46RxFtvC3oh0VP6mYVWjgSEbL68bFpl2a5gXmb2+VebWp5JZMrUQe0Ncaj7KacEpFckUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkoS563tfN1btN2Wp4Qi3cTyWATNCn7uoFN/VN1wBP8=;
 b=OS1dbsL/7XmhXiBTwpvxFpdxiQm3yhnXy+nWmw0ALhrIk4EwEnyNGYTheN1oEieHKeqs6in0e9vfNxZ5oYOzCHkCR9LTL8/B3oswZsoOLlaqCickAia0MdqkMDrEVrwppTRkK/0yYraBslDKhejQA55jb70YKCG4Fl3mROixOAx75k0UG+9D753H8rnrh6ZtRJjDVeEnlnsWXTUOq85CfYBSf7f5xHjKfSkuNCQc/tcBdsFN15jHe7xMIMjsiXlam1+vgZTZQdfwFjZZhBnRhrDx8Hq/O3xEGd7f+RFv7+ELgmckrWWl/vh7yL3NAlydD9jA5QqPozXF8H9WxT/KrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkoS563tfN1btN2Wp4Qi3cTyWATNCn7uoFN/VN1wBP8=;
 b=IGwOBEpevBdZPvn+9T96G7kZU7KaWb96a4ulYokXIgcc+L8HjUVitoDDjujtEEBGpDXRTMLu2QGviPg6s68Z4glnshJ3M7rr1S9IRWvTjolrtm3lPH413un4kgT/deRobwXWcCutIuZCk2Ez2jvZvS4aIPmqJiV9ya/qXF7SkBM=
Authentication-Results: tilde.club; dkim=none (message not signed)
 header.d=none;tilde.club; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3788.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.22; Thu, 29 Jul
 2021 21:25:53 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%3]) with mapi id 15.20.4373.022; Thu, 29 Jul 2021
 21:25:53 +0000
Subject: Re: [PATCH v6 2/9] ssh signing: add ssh signature format and signing
 using ssh keys
To:     Josh Steadmon <steadmon@google.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>
References: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
 <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
 <f05bab16096c080891ee8f7e179eecce7f32e839.1627501009.git.gitgitgadget@gmail.com>
 <YQL8zAHe8CkW1U6j@google.com>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <309c7c9a-f38f-ca3b-ad30-4e22a27a692a@gigacodes.de>
Date:   Thu, 29 Jul 2021 23:25:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YQL8zAHe8CkW1U6j@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::8) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:176:e980:2d4e:7e07:50bd:bf92] (2a02:908:176:e980:2d4e:7e07:50bd:bf92) by FR0P281CA0064.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:49::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.9 via Frontend Transport; Thu, 29 Jul 2021 21:25:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a7eaddf-5977-4f80-b25e-08d952d7721a
X-MS-TrafficTypeDiagnostic: PR3PR10MB3788:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3788D20AC6A35C660C597BF0B6EB9@PR3PR10MB3788.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ug4NwysT+gC3t6w2Re6gNnJ/ZNlDmN9SoivlF09onrEBNrbE1JvgaRXVX1HNK3UkOb5Sij7dQ6eR7VB6du05B9ctDbAHQuVR8IOuoedGIoZYgMFh3gEXXI0OqVOFEY3XopdAGd0PDArpm93TPB0Edq1tSfjt0SoC198poodP9x+bwhSxrw2lnqCMj/3u6zeg1q+IOznM26LSg/e7lnVuDGwFAX/EKtQZUXoXXH6dzsPADgXGR0QgGUZacG23A+vWTOyyVL2QoaFvSq1F4oUZwqc5oLHXUDX9yibaaSvKYmB9ocD9XKWf9gft6VAe/QmpjjpeUfPb58qr/J02ZpLsqWW0RjT5rOk0jhl6nlyfeTCeyezEOMto9DQZ41QVVA2VY+qBWYLRnA6mm1RXEGNe3aXT1WbsJpu8VgGoPftvFXyhfaloMmJOiS/IJ0qsjFXhJaOcNUNX0jhIUIoe4bdTUi1Nq5kKILGg4X/Wf8UQA1sQHnTrQsLw3uCMVYvDAAy4+ss0CIOTtkUX1+U2ycTwWgPxQnvxAK5nLSdYPdhOPH7kop2mru/XmFZ+1umiRNndUaxPRo611ei4jmv80zM+Ur9nWPGMulSAKupk6xs9dMdjgQu9Jk1wMVlft/5CQoVx/9IFWpC6Aw2+bTj8uKoJpm4RSH/FYhH6mQXiRy/9AZHeznm4L0w/LWBFU4h7EqsizGiLpRUFkk4XQzNBCNwkYnGRzusLcLThrP/dp+LxnDcB/++ewQTh6Bgd3/6u1+3p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(39830400003)(396003)(366004)(376002)(136003)(186003)(8936002)(66946007)(316002)(110136005)(31696002)(38100700002)(921005)(86362001)(31686004)(36756003)(66476007)(7416002)(83380400001)(8676002)(66556008)(2616005)(478600001)(52116002)(6486002)(2906002)(5660300002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1VWNCtKaWE0RHl6bDhrRUh1cGxSV01lc2poOHJocmZoTUR1eks4R2hqd0Nl?=
 =?utf-8?B?cFdQZjAyMXU1ZHk2N3poa2ZzZEpYR1Jxb1NZR0djQkpyTkY3U0VCZDVJbkdj?=
 =?utf-8?B?dzJjRml2OXU4UFNjYlFpV3o0a0xnblRIY3lPTzNSS09iZmNKRkl6V1l5YjNy?=
 =?utf-8?B?d0hzUkVXbXlzZTA4NGk2WVAzb2pldlNwdlhuRkw3OWk2MkF0eDJYSUtOcm5B?=
 =?utf-8?B?REFMMGVoYkRoeThpTUN5RVFCOEhjZE1LYnM0OStSTjRLalViWkpuSnByZm1x?=
 =?utf-8?B?Q2Z5S1o3b0RBZldFWjA0KzBPUjJ4UXdYRUxHdFh0cHovMlkzOXg2OXhIRUNU?=
 =?utf-8?B?VGh4TlRNeWh2elVadWZsMHQwOHdkM0hmM2piODRzankrV2RsbTlVWWhuaFEx?=
 =?utf-8?B?OTBYTzM5Nng1MTJpd3FIQ2RKU0UzMVl2aU84NjY5YmtPcDVVRDlJZHM0YUpF?=
 =?utf-8?B?OGwvTjQ5Q3daN3RZd0Z1azJNRWFVay9JdUZzUFdUMGdsd2l4OWE0WlVmMDAw?=
 =?utf-8?B?YTNDU0Q2ODluSERnMUx4WHA1YkV3S0pweTJTNW8vM0ZOMTZ1VFpibUpMWTNO?=
 =?utf-8?B?aXR5MC8xNElGa1hjdmpEa1N6ZjByaVFHQXNCWUFoNFgyT1gwdjBjaWE0Wmht?=
 =?utf-8?B?VHREb1M1MXkwcGhJVTYyeHlhR3pKNHpmVFR5OStSRG1yamF0a3FGUXhQRFJD?=
 =?utf-8?B?TUJNMUx1K0kzMGVKZ0JXYzM4eG4wRE81cDBrL1J4MGd0Sk9nbktPRXFvSzhT?=
 =?utf-8?B?MW9NUzZ6S00zZnY0eDAwWFFlWFVLYmV6eHJCcW1nVFNQNDErbGVicE9DV0pp?=
 =?utf-8?B?T0ZXSGZ0QUIyZCtpby9CM0pIOTlhS0FOM3VQMmdIS3Fub1FrSW1mYTNzb3Zm?=
 =?utf-8?B?OUxESk9nZjVGbUkrb2lTMW8rdmxWcW1jM3RSRmo0VExqek5iQmZHbndoUitv?=
 =?utf-8?B?eUdPYkUya2FmSUFmQVVuNFJrN0pkUythaXlXUXZOUWtRZ2p1UGVxZ0hZUVF5?=
 =?utf-8?B?NFNPNHBxaFBwSE9XQWtpbmJOOVpNUER5aXc4UytkZHN4Q2NvZU1lUUFhWEZa?=
 =?utf-8?B?cUdoMklDeEE5TTdONmNZdmNQWkNQYjc3VXUyREJzMUNFQ3pHSVE3UGU5MFEy?=
 =?utf-8?B?NnlWRDk3R3lDNFZuUW5McTdzaU1ZbVVLTmlnQmZqMFNJY3dMRWlQUGZDS0ts?=
 =?utf-8?B?Qjl6NFp4a0lYNTdWbGtMbGFBU2xIKzJFeS9JUWtnWld1dTUyVCtEWHRJRFJu?=
 =?utf-8?B?ZkNPZlF3bk9HVW9MbUhjUnBqUHV2WU83L0pzcU1GYnJIaWhySVlidU1XaEpP?=
 =?utf-8?B?TDVUdndnMW9HUWRyT1ZHMjVZSFFRUjdoekJHYm9hbHN3OUFvN2I1RTQ1Wkhw?=
 =?utf-8?B?OTcvNGZBSFNJVm9pZ041aG91VWMxeEEzVE54NlloOHVuczgrb0JzSFI5c01Z?=
 =?utf-8?B?RFEycGFFTGx3UkN6TXBRVE9TOWo2dTI2RlQ2TGhsQzZRQUR6MlFweVdlUDNN?=
 =?utf-8?B?eUsrb2ZUa0xhSDNNc1dpM3hSQWgvUXdKVFpkRnZ3OGkzQVdvejJqNXQ3UGxU?=
 =?utf-8?B?ajVzb1M3VTRiVjZEUlRvcHEraW54bTh6cjJ1SUNLQ1ZVaGVRd0pwSk9mRmVn?=
 =?utf-8?B?b0hEcXNNOGR6Y2FBS3BMaUQweDNlSkdFYVRSOGgyZDRFSTVCMmIwVXVjZVNF?=
 =?utf-8?B?UXFvc2ZLVXpldWFndThJbjNCRVVvZHdlUE80SEp4RHBvcDRpUFhVRDdvNXFr?=
 =?utf-8?B?aTlpRnZqWTU1U1l1UlFZM0ExL2lwYndDMVgrTVhwQkppNjBONmpIL1d0S1o1?=
 =?utf-8?B?R1lUSVNWZTdKRVQ2VThlOWdXeEZHWGJtT0FoUGhOZ1pmZU41N1dBNWdad0d5?=
 =?utf-8?Q?AnTJ7BOehfaWj?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7eaddf-5977-4f80-b25e-08d952d7721a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 21:25:53.6529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmzaga7zvubyB/L7N5Tyud08HfzQo+HFOVnHloQRV1w5zD0HIg5o4IGonflpJ+2EGY+No2EpsakEzyzbjg/brVSTOi2AYKEdY+igXRUuuRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3788
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.07.21 21:09, Josh Steadmon wrote:
> Thanks for this series, it sounds like a great idea. I have a few
> comments, inline below.
>

Thanks for your review and help with this patch.

> On 2021.07.28 19:36, Fabian Stelzer via GitGitGadget wrote:
> [snip]
>> +		ssh_signing_key_file = key_file->filename.buf;
> 
> You probably want to call strbuf_detach() here, because...
> 
>> +	} else {
>> +		/* We assume a file */
>> +		ssh_signing_key_file = expand_user_path(signing_key, 1);
>> +	}
> 
> ... you need to free the memory returned by expand_user_path(). If you
> detach the strbuf above, you can unconditionally
> free(ssh_signing_key_file) at the end of this function.
> 

fixed. thanks

>> +
>> +	buffer_file = mks_tempfile_t(".git_signing_buffer_tmpXXXXXX");
>> +	if (!buffer_file) {
>> +		error_errno(_("could not create temporary file"));
>> +		goto out;
>> +	}
>> +
>> +	if (write_in_full(buffer_file->fd, buffer->buf, buffer->len) < 0 ||
>> +	    close_tempfile_gently(buffer_file) < 0) {
>> +		error_errno(_("failed writing ssh signing key buffer to '%s'"),
>> +			    buffer_file->filename.buf);
>> +		goto out;
>> +	}
>> +
>> +	strvec_pushl(&signer.args, use_format->program,
>> +		     "-Y", "sign",
>> +		     "-n", "git",
>> +		     "-f", ssh_signing_key_file,
>> +		     buffer_file->filename.buf,
>> +		     NULL);
>> +
>> +	sigchain_push(SIGPIPE, SIG_IGN);
>> +	ret = pipe_command(&signer, NULL, 0, NULL, 0, &signer_stderr, 0);
>> +	sigchain_pop(SIGPIPE);
>> +
>> +	if (ret) {
>> +		if (strstr(signer_stderr.buf, "usage:"))
>> +			error(_("ssh-keygen -Y sign is needed for ssh signing (available in openssh version 8.2p1+)"));
> 
> I share Jonathan Tan's concern about checking for "usage:" in the stderr
> output here. I think in patch 6 the tests rely on a specific return code
> to check that "-Y sign" is working as expected; can that be used here
> instead?

In the test setup i first check if ssh-keygen at all is present (exit 
code 127 means command not found). Afterwards i check for a specific 
error message from the command if it is present. Not sure how portable 
this is, but i can do that because i give known invalid parameters to 
it. I can't do this here without doing an additional call to ssh-keygen 
just to check this.

> 
>> +
>> +		error("%s", signer_stderr.buf);
>> +		goto out;
>> +	}
>> +
>> +	bottom = signature->len;
>> +
>> +	strbuf_addbuf(&ssh_signature_filename, &buffer_file->filename);
>> +	strbuf_addstr(&ssh_signature_filename, ".sig");
>> +	if (strbuf_read_file(signature, ssh_signature_filename.buf, 0) < 0) {
>> +		error_errno(
>> +			_("failed reading ssh signing data buffer from '%s'"),
>> +			ssh_signature_filename.buf);
>> +	}
>> +	unlink_or_warn(ssh_signature_filename.buf);
>> +
>> +	/* Strip CR from the line endings, in case we are on Windows. */
>> +	remove_cr_after(signature, bottom);
>> +
>> +out:
>> +	if (key_file)
>> +		delete_tempfile(&key_file);
>> +	if (buffer_file)
>> +		delete_tempfile(&buffer_file);
>> +	strbuf_release(&signer_stderr);
>> +	strbuf_release(&ssh_signature_filename);
>> +	return ret;
>> +}
>> -- 
>> gitgitgadget
>>
