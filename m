Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F87C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 684BD611C1
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhGLUit (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 16:38:49 -0400
Received: from mail-vi1eur05on2087.outbound.protection.outlook.com ([40.107.21.87]:52833
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230058AbhGLUis (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 16:38:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGKMyfaonhXli02XMLX201un4kO7Pkp25bGiQGRSvZ+Gbl+O/Lj+GDNTvCSfCFg07IEcK8EsnfGFyyopVFZDrvlID3iSQSpI9YkUzXePu6P2KIbpbOQzNXPjYW6D3Wp13Ox4hg4rBfYd8Oxc9J1rd/eS6ZkBlF/tsBU46kSIeQKYhXF3eXFV9ui4PA7+RgQg3JOI1VUL7bbmqKWglV6B4gAGIpGQ7CaE6obMPVSUK0gcGQwNiJhjsFRf0osF064mozSFZq7AItU6lLgH/FFNBQfZ3DBpEtlRJ8uXr9fp1J8YvuXwJY8+7rK2QP6NwhcX3dqVhb97zn4ZXxi/zxVkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXjOoq/PQIRdZvPP3L8rYymY3bU7rsJnTxyUQYh/PcY=;
 b=SeW1Pr+flh/Mf7UtQ7ZRXsXBn9b8jKzfN1YCxO55B+MWwm7tWjeh84nhDLJBD9NnBQveVc0i776acBr4KoaOjaYNg9dKTGw4NRDa45e+KPvKVnJ4bldBciE2DE1QWHChEDiKRi/ZgJOCNjsmeZUdsL3Oh6io1A1doW0Nvfahm74iBRuPaBUwXSvoI9PgrYp0TAk9HH3JmeX2qkptrLg5CJCbyJFkNsJmmpikB5hC+2UN95+j4cIsQZBVs/ivmDSg9UMeFfGoPR5qTtlS773qBQ2ziCA0PSvsj5uvIi+Tv3DBWaNSkm/Eb39DDciWJ3Y98PJr3NGQq+dYkV7gmz7A+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXjOoq/PQIRdZvPP3L8rYymY3bU7rsJnTxyUQYh/PcY=;
 b=aXnQOJrzAn8tfteR/pFmZ2/RaUQIvXzvnr02G1mA6BT/LaKHnDhyy107f2wh85d1UCYuonB3wbsLYA0unMPRF3cdg2cwWtcJMKLePb4KN/lfIPKAAYYgYt2jdvAsh4ZU1ASwfVKmkR0ACoSPtJxScoSP2f/LKE80wvzzwfnptM8=
Authentication-Results: dyntopia.com; dkim=none (message not signed)
 header.d=none;dyntopia.com; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Mon, 12 Jul
 2021 20:35:57 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%4]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 20:35:56 +0000
Subject: Re: [PATCH v2] Add commit, tag & push signing/verification via SSH
 keys using ssh-keygen
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1041.git.git.1625559593910.gitgitgadget@gmail.com>
 <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
 <87y2ab30yr.fsf@evledraar.gmail.com>
From:   Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>
Message-ID: <ddba5667-346d-de64-ac6a-a27d78bc266d@gigacodes.de>
Date:   Mon, 12 Jul 2021 22:35:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <87y2ab30yr.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR3P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::14) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:176:e980:2d4e:7e07:50bd:bf92] (2a02:908:176:e980:2d4e:7e07:50bd:bf92) by FR3P281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1d::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.11 via Frontend Transport; Mon, 12 Jul 2021 20:35:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e0f899f-5c7a-4e39-7a3e-08d94574a6cf
X-MS-TrafficTypeDiagnostic: PR3PR10MB4046:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4046104A81456674AC863B5CB6159@PR3PR10MB4046.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HEuV1OyQvlGjf3Bv7T3+yPB/4kRdXDzqOXQFq8TaOEW+QMdEa44JS0pr/dJ+8UaTkrQe7Oq0vaEZolnaaw5dDTlqaIbalS1ky7kpgkdEs0CLZDV6L7SZp2dWT/Sgxu0tLcGhYkVk/yKT6sGB8jxtCoToDn5DNrvgI9F8Qs0dSVRr2P05MJIWJqAb9SwtkiL/U2bjtt1uPbhPXd9bNdhnjhtE5A8+3ybs1EL3jDixtteILPMBWc5LrWml1SxxWiWN4C3B+xDI3/Pkzdzu9yyDOPd54Dvh2sc5sHNJT/WgRPXrx6ddPv5ciOryMw/1OdDU9Mms5o5PCE9piwSvn9BsoePhlZ3ZCVahKJVwJxFFlfdzDIpuV8j+vw6nTzcYErDubGU8+34jnj1eyoO/pbzj1vwRgFOOJ5I0taGDaTYrjWr4aGCDCxnR7siZnXkJBJrMx8t3cWlzJN7aQsQM8GivzREpbfh/RMngIkfO//ZVDpCN3KlAODucRPO/PJk8111I800PNJmAZ/ssFdJw71Ipkk9q+xQpRrZsE07m28fyHRcpCBul26pohcCQYIkAGOpl3WkXmkJhdAI1OEBIufFFMoDIm61WEzLadzcBISy9hdCCvpTPw+QTb03y7WN1Uc+8gm5pMrLU/cc++llKtkeAwcrTXMg9blUDg/1LH1AuOA44AHvjGfVEtAkHfF07By8P7GYhQxeFw6O75PL0CWmJTp9nqJyFk/tN6LMoCc4SzAM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39830400003)(136003)(366004)(5660300002)(36756003)(478600001)(8676002)(86362001)(31696002)(66556008)(66476007)(6486002)(110136005)(4326008)(31686004)(2906002)(66946007)(83380400001)(53546011)(316002)(66574015)(38100700002)(8936002)(54906003)(2616005)(52116002)(15650500001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXkyL0t4LzhNaGE2TVY1WENLclBvK2FPeGNsbWhjOFU4Z2V1UDBtTjJhK3lW?=
 =?utf-8?B?R3FCR3RvN1MzNEdWRVBsanpnSkF1RlU3WTdFdFRrYXBpMFRZaFVnRlJwRnZt?=
 =?utf-8?B?UnB2NGlYM0U0dzNBWmZidjI0SkNOVVRLUVFCZk5zYVJmcEZ4UXIvWjRHOVhS?=
 =?utf-8?B?amNibHAvaGovSEQwRm1LcDQ5blMwa2k2L01EVnhteDM3NE1aT2tDMjU3SnRV?=
 =?utf-8?B?S2NlUDdJZlk3ZndSL2ozbzV5UTNUc2FlWjBSdHV3cFg5blcxNjVjekVPN0Qw?=
 =?utf-8?B?ZVlpQm4yeFlOR1YwMnNYLy90aVM1MTZ0UmdPWEUyQ1lXL2xubkhNMVRyOWMw?=
 =?utf-8?B?ZEdYWlY4cDcrUnd4TDRQWXQ3TjB5akx3cTNiTW1JeExtRFFuK3NaMnpuTytF?=
 =?utf-8?B?MXRWVUU5R1ZqYjU1T2VIOThjdGxBdHBrTVhmdCt5M0tCSmtQMnE0bCtWUHRr?=
 =?utf-8?B?dDYxUTQ1ZUU4WGlUUlN2cUVnV09pMUNVUGlVMFI5azBvN1k2Lzl1V1Y3TDlh?=
 =?utf-8?B?TUNBZGx6M3l3dmJyNkdxejNMR1JnR0c0VVZLYjRnelFqVExsZjlaUnZWeSs4?=
 =?utf-8?B?RnAwUEdQWmNwbTAzbjNWd3J1TnBud3YraVo2LzdNMnZCRHo4Zit6OGxuU042?=
 =?utf-8?B?eVIweFZGMEpjeVJYNlZtOXBjOFN1Mm82bUlOOTFxMGpwMDk2TXJOcmx6Skgy?=
 =?utf-8?B?bjhTZHZUL3dMUEZUMko2ellIQjdncDRnZG9EdGFuSWNQS0cxVDY2NWxvQWR2?=
 =?utf-8?B?S2crclhCVW85SU1Gc0V0R3ZORFBRS3dKZlFFalN3bmpINUFaWDFLdGJQYnQz?=
 =?utf-8?B?R1RyYnNlWnZCdVdYK28veE1tNDU2NmdkL3B3NzV1U2Q1UUlpcnR0ZnJXNm9M?=
 =?utf-8?B?V2hCZVpwNmJ5TkJzOGl0RHVjNG9OTG5reHNhWmtudEh2eEt5Z3oyUXNhOG83?=
 =?utf-8?B?OUV5Y1VlU1YrcXAvTldGWEZjTXFxUWw2cHRhMytpcFFQYlNabk9ERGhnQkNZ?=
 =?utf-8?B?Lytub08zM1dlNlZTS09zZHJJejZuVi80SFEwYm53cmtGQkI5dVFvWEhkVWFw?=
 =?utf-8?B?ZUxvNFlZZk5zdWlJRFJjMHVMdnFmK1Jma1dGRnR4WGQxOVdwVDR3KzllU24w?=
 =?utf-8?B?dHdBL3hUMUNObFRiVDZVcFZCSXVjaFdLNmk3TkJJa2hnTGhwRTRGM2E4Uklz?=
 =?utf-8?B?WlVBdDF5dGlDZDQzRDlZM3B3Ky83UzM3a3VESWVyVU1DU0NnRk4xcmF5Ukpv?=
 =?utf-8?B?R3N3Q1MxT3pLN3pnUVJjekNqZ2FvK2JJSUpTQmpiSlBxK2lyRFd3NVRWVTQ5?=
 =?utf-8?B?bTdFZlhYdkx0a0lmS25lRXpSVDBXV00xTTZybEdqVDhhTmlFQ0hRZzYrOHd4?=
 =?utf-8?B?Q2Q3ZVdDd2k5S3I4MHhnaHA0Sm5UQzRVOTMwbjBIYXJUWXV0RVB1YVFWem5n?=
 =?utf-8?B?M0YzL3Q1eEdjTndzSGlmdXFNUjd2akVPelhCYXB5RlRIZGF4SUxOWTlIK2Ns?=
 =?utf-8?B?SnV3VzB1RnNVeXVLNitBTGpvU3c1UEd1WTZCY1dMbEQyMUpZMnQwK3NVeFJs?=
 =?utf-8?B?WHViUHNXbEE4YWptMVpQZmhGK3dvZ3NKdEVuMEVyL1lFRHA1MDd2UEtiL24y?=
 =?utf-8?B?cVR1YTc4d2NyU0pyRlVYSWl6anR6SXlEMUp4bGtaUVdTdDIrK3h2cE5OblU4?=
 =?utf-8?B?dldibHhSNURmNFRHRTlucStUbStxRENFNGNleENwUWtmVEFWd2t0MUtucy93?=
 =?utf-8?B?a1FkalZ3QitmWlNxS2RFT1ZNb092cHArRjhtbnNGNng5UUFUY05Jdkh5UmlC?=
 =?utf-8?B?WjM2MHIyaEY1RXNIR0d3Vk4rU2FWYVZWOXF3WkxhdkNBbERpN243UUdrWVpt?=
 =?utf-8?Q?IOuTA9YlCUsUx?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0f899f-5c7a-4e39-7a3e-08d94574a6cf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 20:35:56.7898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5IlTCJVJpRsYfZf6vfQCG13gAgihJQr49S4CY98KQnHyD/kGNepmVa/oNAiSj00REaPzPBthJaMrZEal00aTrWLOkJKXrrt3vzm771R15I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4046
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12.07.21 18:55, Ævar Arnfjörð Bjarmason wrote:

I'll change all the whitespace / comments / style issues with the next 
commit. Thanks
>> +		sigc->result = 'G';
>> +		sigc->trust_level = TRUST_FULLY;
>> +
>> +		next = strchrnul(output, ' '); // 'principal'
>> +		replace_cstring(&sigc->signer, output, next);
>> +		output = next + 1;
>> +		next = strchrnul(output, ' '); // 'with'
>> +		output = next + 1;
>> +		next = strchrnul(output, ' '); // KEY Type
>> +		output = next + 1;
>> +		next = strchrnul(output, ' '); // 'key'
>> +		output = next + 1;
> FWIW for new code we'd probably use string_list_split() or
> string_list_split_in_place() or strbuf_split_buf() or something, but I
> see this is following the existing pattern in the file...
I agree. This is my first patch in the git codebase so it takes a bit 
getting used to all the available utilities.
>> +	const char *payload, size_t payload_size,
>> +	const char *signature, size_t signature_size)
>>   {
>> -	struct child_process gpg = CHILD_PROCESS_INIT;
>> -	struct gpg_format *fmt;
>> +	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
>>   	struct tempfile *temp;
>>   	int ret;
>> -	struct strbuf buf = STRBUF_INIT;
>> +	const char *line;
>> +	size_t trust_size;
>> +	char *principal;
>> +	struct strbuf ssh_keygen_out = STRBUF_INIT;
>> +	struct strbuf ssh_keygen_err = STRBUF_INIT;
>>   
>>   	temp = mks_tempfile_t(".git_vtag_tmpXXXXXX");
>>   	if (!temp)
>> @@ -279,29 +342,125 @@ static int verify_signed_buffer(const char *payload, size_t payload_size,
>>   		return -1;
>>   	}
>>   
>> -	fmt = get_format_by_sig(signature);
>> -	if (!fmt)
>> -		BUG("bad signature '%s'", signature);
>> +	// Find the principal from the  signers
>> +	strvec_pushl(&ssh_keygen.args,  fmt->program,
>> +					"-Y", "find-principals",
>> +					"-f", get_ssh_allowed_signers(),
>> +					"-s", temp->filename.buf,
>> +					NULL);
>> +	ret = pipe_command(&ssh_keygen, NULL, 0, &ssh_keygen_out, 0, &ssh_keygen_err, 0);
>> +	if (strstr(ssh_keygen_err.buf, "unknown option")) {
>> +		error(_("openssh version > 8.2p1 is needed for ssh signature verification (ssh-keygen needs -Y find-principals/verify option)"));
>> +	}
>> +	if (ret || !ssh_keygen_out.len) {
>> +		// We did not find a matching principal in the keyring - Check without validation
>> +		child_process_init(&ssh_keygen);
>> +		strvec_pushl(&ssh_keygen.args,  fmt->program,
>> +						"-Y", "check-novalidate",
>> +						"-n", "git",
>> +						"-s", temp->filename.buf,
>> +						NULL);
>> +		ret = pipe_command(&ssh_keygen, payload, payload_size, &ssh_keygen_out, 0, &ssh_keygen_err, 0);
>> +	} else {
>> +		// Check every principal we found (one per line)
>> +		for (line = ssh_keygen_out.buf; *line; line = strchrnul(line + 1, '\n')) {
> Hrm, can't we use strbuf_getline() here with the underlying io_pump API
> that pipe_command() uses, instead of slurping it all up, and then
> splitting on '\n' ourselves? (I'm not sure)
Sounds good. I'll give it a try.
>> +			while (*line == '\n')
>> +				line++;
>> +			if (!*line)
>> +				break;
>> +
>> +			trust_size = strcspn(line, " \n");
>> +			principal = xmemdupz(line, trust_size);
>> +
>> +			child_process_init(&ssh_keygen);
>> +			strbuf_release(&ssh_keygen_out);
>> +			strbuf_release(&ssh_keygen_err);
>> +			strvec_push(&ssh_keygen.args,fmt->program);
>> +			// We found principals - Try with each until we find a match
>> +			strvec_pushl(&ssh_keygen.args,  "-Y", "verify",
>> +							//TODO: sprintf("-Overify-time=%s", commit->date...),
>> +							"-n", "git",
>> +							"-f", get_ssh_allowed_signers(),
>> +							"-I", principal,
>> +							"-s", temp->filename.buf,
>> +							NULL);
>> +
>> +			if (ssh_revocation_file && file_exists(ssh_revocation_file)) {
>> +				strvec_pushl(&ssh_keygen.args, "-r", ssh_revocation_file, NULL);
> Do we want to silently ignore missing but configured revocation files?
I'll add a warning
>
>> +			}
>> +
>> +			sigchain_push(SIGPIPE, SIG_IGN);
>> +			ret = pipe_command(&ssh_keygen, payload, payload_size,
>> +					&ssh_keygen_out, 0, &ssh_keygen_err, 0);
>> +			sigchain_pop(SIGPIPE);
>> +
>> +			ret &= starts_with(ssh_keygen_out.buf, "Good");
>> +			if (ret == 0)
>> +				break;
>> +		}
>> +	}
>> +
>> +	sigc->payload = xmemdupz(payload, payload_size);
>> +	strbuf_stripspace(&ssh_keygen_out, 0);
>> +	strbuf_stripspace(&ssh_keygen_err, 0);
>> +	strbuf_add(&ssh_keygen_out, ssh_keygen_err.buf, ssh_keygen_err.len);
>> +	sigc->output = strbuf_detach(&ssh_keygen_out, NULL);
>> +
>> +	//sigc->gpg_output = strbuf_detach(&ssh_keygen_err, NULL); // This flip around is broken...
> Broken how? And why the commented-out code as part of the patch?
Sorry, i should have removed it. The original code assigned gpg's stdout 
to gpg_status and stdout to gpg_output which can be a bit confusing.
>
>> -	status = verify_signed_buffer(payload, plen, signature, slen,
>> -				      &gpg_output, &gpg_status);
>> -	if (status && !gpg_output.len)
>> -		goto out;
>> -	sigc->payload = xmemdupz(payload, plen);
>> -	sigc->gpg_output = strbuf_detach(&gpg_output, NULL);
>> -	sigc->gpg_status = strbuf_detach(&gpg_status, NULL);
>> -	parse_gpg_output(sigc);
>> +	fmt = get_format_by_sig(signature);
>> +	if (!fmt)
>> +		BUG("bad signature '%s'", signature);
> So if we run this from receive-pack or whatever we'll BUG() out? I.e. I
> think this should be an fsck check or something, but not a BUG(), or
> does this not rely on potentially bad object-store state?
The BUG() call is also from the original code. I agree that it should be 
handled differently.
Unfortunately this call is also the reason that when trying to verify a 
new SSH signature with a current git version you'll get a segfault from 
this BUG() :/
I'm not sure if i can do anything about this other than adding a 
completely new tag in the commit itself instead of "gpgsig" which might 
be quite involved. I haven't looked into that too much yet.
>
>> +static char *get_ssh_key_fingerprint(const char *signing_key) {
>> +	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
>> +	int ret = -1;
>> +	struct strbuf fingerprint_stdout = STRBUF_INIT;
>> +	struct strbuf **fingerprint;
>> +
>> +	/* For SSH Signing this can contain a filename or a public key
>> +	* For textual representation we usually want a fingerprint
>> +	*/
>> +	if (istarts_with(signing_key, "ssh-")) {
>> +		strvec_pushl(&ssh_keygen.args, "ssh-keygen",
>> +					"-lf", "-",
>> +					NULL);
>> +		ret = pipe_command(&ssh_keygen, signing_key, strlen(signing_key), &fingerprint_stdout, 0,  NULL, 0);
>> +	} else {
>> +		strvec_pushl(&ssh_keygen.args, "ssh-keygen",
>> +					"-lf", configured_signing_key,
>> +					NULL);
>> +		ret = pipe_command(&ssh_keygen, NULL, 0, &fingerprint_stdout, 0, NULL, 0);
>> +		if (!!ret)
>> +			die_errno(_("failed to get the ssh fingerprint for key '%s'"), signing_key);
>> +		fingerprint = strbuf_split_max(&fingerprint_stdout, ' ', 3);
>> +		if (fingerprint[1]) {
>> +			return strbuf_detach(fingerprint[1], NULL);
>> +		}
>> +	}
>> +	die_errno(_("failed to get the ssh fingerprint for key '%s'"), signing_key);
>> +}
> Her you declare a ret that's not used at all in the "istarts_with"
> branch, and we fall through to die_errno()?
I'll clean up the logic. Thanks
>
> [I stopped reading mostly at this point]
>
>> [...]
>> +# test_expect_success GPGSSH 'detect fudged commit with double signature' '
>> +# 	sed -e "/gpgsig/,/END PGP/d" forged1 >double-base &&
>> +# 	sed -n -e "/gpgsig/,/END PGP/p" forged1 | \
>> +# 		sed -e "s/^$(test_oid header)//;s/^ //" | gpg --dearmor >double-sig1.sig &&
>> +# 	gpg -o double-sig2.sig -u 29472784 --detach-sign double-base &&
>> +# 	cat double-sig1.sig double-sig2.sig | gpg --enarmor >double-combined.asc &&
>> +# 	sed -e "s/^\(-.*\)ARMORED FILE/\1SIGNATURE/;1s/^/$(test_oid header) /;2,\$s/^/ /" \
>> +# 		double-combined.asc > double-gpgsig &&
>> +# 	sed -e "/committer/r double-gpgsig" double-base >double-commit &&
>> +# 	git hash-object -w -t commit double-commit >double-commit.commit &&
>> +# 	test_must_fail git verify-commit $(cat double-commit.commit) &&
>> +# 	git show --pretty=short --show-signature $(cat double-commit.commit) >double-actual &&
>> +# 	grep "BAD signature from" double-actual &&
>> +# 	grep "Good signature from" double-actual
>> +# '
>> +
>> +# test_expect_success GPGSSH 'show double signature with custom format' '
>> +# 	cat >expect <<-\EOF &&
>> +# 	E
>> +
>> +
>> +
>> +
>> +# 	EOF
>> +# 	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" $(cat double-commit.commit) >actual &&
>> +# 	test_cmp expect actual
>> +# '
> Perhaps you're looking for test_expect_failure for TODO tests?
Yes. Although this test explicitly i'm having a hard time to duplicate 
for ssh. I'm still trying to find out if the duplicate signature thing 
is actually an issue with ssh.
>
> I think this patch is *way* past the point of benefitting from being
> split into a patch series. It grew from ~200 lines added to ~1k.
Sure, I can easily split the patch into seperate commits. But do i 
create a v3 patch from this or issue a new pull request?
The diff between v2 & v3 would be quite useless otherwise wouldn't it?

And maybe another beginner contribution question:

When i make changes to a patchset do i put new changes from the review 
on top as new commits or do i edit the existing commits?
If so what is the workflow you normally use for this? fixup commits? I 
know about those but haven't worked with them before.

Thanks for your help!

