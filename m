Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D55C25B50
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 22:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjATWFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjATWFw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 17:05:52 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2020.outbound.protection.outlook.com [40.92.89.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FD68B328
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:05:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXRnVyhXk6pEjqA7aeBY0tr1GRDFZfovB7dTGTc3PwdgPc/1/sESwLTsN4ztb2VmSOl6rOo0x95RXKS2pOLjUANl992Vs/0Hiqy/t7PclqVkl0keFhV1gMYU6J7Ue8ho1ow0npW5mZzYy2JRTamWYv+ohmBjnwElLfd9isV2gHuQYzYX0FpFDRquUcpicQIXjNQQvj14gwjaBBvT29T++Gl3VYepNv1rIUhHcrrXaPouaLZv1lbmxD0g5jkd+GOSL8a/LuTtw9hyXp08iJoSAtfKpEFie0Fq/dySVwWbhq+fX4HQSiLxCwwr22U8o9eJVtyBww6OeSt7z8QwSWvqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAeSvc3TYHZ8XB7Nu9T4ysIjxkS31WhN0amG0u3Ancc=;
 b=FQICH6LDFXTJcbeqk1YIcnwyl3JaZqgk0dZddFC7LhTc8vPlBsqO//LZ2qB26Jt9TBYdffsJPdEojw+G8+OEcs1PhtY6/slB3PjMupsueQVRnvtqUI+nnX+DBqhEGMRXCFTzyRkcBDSWPePZ9n8CVNRs+96GmYwoVzX6F1jvWLsvlg6vbJBTywPCidb/Pyn7PpzM9Jb4uWBEnhVWfFuxT26yJsWZE/gb78V+nHLBFowaRSesnYZxC24D8DIaENwI5YQ/UbO+HfEv1kCM5pC4lHI7NWrTDI3JwEasKQASQFUqh/wpTgYwmZHI9BWEfV6YJdbRaZzYZj9ZJClkz/LYOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAeSvc3TYHZ8XB7Nu9T4ysIjxkS31WhN0amG0u3Ancc=;
 b=bRC6LXUSEWkzXR4GWd4Qk+NOumQo/RTWjWihw5jU1Mn7tDU4direM10HFsG5shHlJ1ibyMwiHEr8D9YZtkxjeZPZq1HEuXIQ2wS7FarF4927bsf5X5RRxiVQV1janvNWy/obHEQuGDsfZw8gqUvxoQci80DYeXngmnUikTq6chDb/rz0fCctyCNUjZwSm7AmsoJbzfEu+5XJ/9L1x3GZwe/C639C4J6tsREtHHpIwTKkk4Nq4unWLjM2MsGXDWUh2/gl/4U4KTCSec83zflCnpqy1PWQgy8OqBTUWMSutLgrWAn5Q8Rbaky9RCVrWmRAWVIvL2PY6GXRb/2HCXwOkw==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AM7PR03MB6676.eurprd03.prod.outlook.com (2603:10a6:20b:1b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 20 Jan
 2023 22:05:44 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.6002.025; Fri, 20 Jan 2023
 22:05:44 +0000
Message-ID: <AS2PR03MB9815A64884689C30112BCA11C0C59@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Fri, 20 Jan 2023 14:05:38 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v6 08/12] test-http-server: add simple authentication
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
 <a1ff55dd6e25aa39f14b494f482720edf7d1eabd.1674012618.git.gitgitgadget@gmail.com>
 <230118.867cxkxece.gmgdl@evledraar.gmail.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <230118.867cxkxece.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [sPUi8rLHgjnm29nrtbcS92I+gHpnRGDI]
X-ClientProxiedBy: MW4PR04CA0229.namprd04.prod.outlook.com
 (2603:10b6:303:87::24) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <7fc3dfe0-5998-451e-15f6-4debdad0c991@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AM7PR03MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b0432c-d77c-4ab6-79d7-08dafb327a2c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Md0OyoJwwmjEFt8+eR4p5h6FBNLOSmIAP8ABR0Qoc4mVckw0VRcZb1me6SOKEckOZmBnjqY9rAd38jqB8go8WoV0vLbSZolmSQyxvLwbWWaCbLxrwej4GPdJPNUiTy79L7FNCvdz7coUQ/M4GmKBBdhwc56+w/ZtvR+XarHhLEzSy9bqQdxEvU86l8wHoClO1SD9Y/c1NHYfvoXHIG0ypcjiw5k69ABT/BJOFDelFz89ENCsGsAxZj8gInzg4E/etZEixsxBnK2GidjIIljOt3cYgsvOqJ1pdTFJXkbSv4j4RXLLVBl8Rg5WwWNHgHy6rvZNidg7ykh01jY4RzWlUMWhqOgKX0uF/UBScnkrkAhtTVsMX276tKJKmA+nlfZxoQeIxUfg9FV+nllgG2vXoUgiT3YWpa2U3sOObHQmbi76KgcIjjSrq8GZBvRCw+615YN4GX549hIQDjtFRIe1En424FkiIs7lMHXTZfiwihHnQGgnTavun1JbVKognqniJ5Z1Y7AESGBxE2u8gYgajein3YGy2/jnlVo1/BSG8efVABoz1fXaAuxMDzKDO/JOO3SducbnNs1xoLFa0TxokL4Qg2Bixi6CG+5W7yz1FMcvAO6vReAtNMFOZccuMBiqWC99zGieVXabX1JeFNY/3g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXJ3bjlZS1hVem5DMkUwVlV2Z2E1M3lEVmc1cUtYc0p2NTNoMFU5NzIrWERk?=
 =?utf-8?B?RmJKeVJhcWwrK3NLTnBnb2ErTSthQmVZTjl0M2V1M0xhOFJaTEVublFMMU5B?=
 =?utf-8?B?SnR0Skd3ZXRjckJWK201Tnp1dUdCYTJsYkNKekNjcFp3QzRzWmxiYkNUcm9v?=
 =?utf-8?B?bU5nVWFOUk1ZUnVNY1hZVTFWSHJlME92bitHaVNPbVU5U1l2V3YxcGxMRVF3?=
 =?utf-8?B?UmpLZVpubXhXdkJ6MTYzK2k1RE1Mb1piOGlvd0NUWVcvODJGTlAzRGlZeW1a?=
 =?utf-8?B?U1RUZ3N3SXZpTUIwVjd4bThrMFdhUFduQWQxWVJaY1MzY2NZL2Z2SitBa2Nv?=
 =?utf-8?B?K0F5Qjl6TXlXTE50aGUzZlJvc3hKbW12akNqUGtUVWlpL1ZwelpkNFVoQWcv?=
 =?utf-8?B?dFRHekFINzl2UGpwc1NFUmt0NGVhVzBIUDk2d0xxME8vM253NCtBWWtUbnRJ?=
 =?utf-8?B?RmRCcUVNM09UamhiVUVEeitiOGt3Tk1WQUpIVDFjcVE5SUM2dGt5bHZVNzg2?=
 =?utf-8?B?OW9zTmNlVTB4UFZJZ2F4alVZeTBvOWNQSUQyQ3BVeUVpNDlncUlLbldvL3hW?=
 =?utf-8?B?MzJmdU9DZ3lqUkcxNHpRZDlxWVg0OFpRUk9wSUdsd3NsOVVTbjhoWDQrUUt4?=
 =?utf-8?B?UG5xV0VGNkhFeWVlVEliSi95UFlPYmRYU0pYdHJ5Zi9hbVBMcGN0MEpmZDJq?=
 =?utf-8?B?VGdlT3JJSTFidWxaaGxXR2l3ak5qV3pJRkNxN1JZbUZOY1d0Q1d0c0JwQ0Nz?=
 =?utf-8?B?RE44SzhhcEhFbUtwZ3gzYVRxMWF6RGlHR2d2YlVJQXR3a0t3ZDJoM05UemR2?=
 =?utf-8?B?T0FvdWJqdVF1eXJkK0NjTVRDdERJUzU0WjhnZ1ZyRTl0R1pxRllpeUUyRGs5?=
 =?utf-8?B?d3NjK3hKMzZXcTdMUks2NWdNYTJlSzdTa3prYXpRd0ZYVzYvNHhSQVZRVDdG?=
 =?utf-8?B?bUVneU15ZUNCSWZmcEUwK1NvYkRoNldjMzhNdWcrVG84ZHRrc0dTZnE0QU5s?=
 =?utf-8?B?Z2g3VmN1OHVCKzY1NWFZYm5WSTc1TUN5eWRjQy9IWjlYY2swQXAwMDhrOXV3?=
 =?utf-8?B?MWVLUktTeFRWUzBrTGhNazVmTUNDRzR5QiszeG9QeW5mQ0hWMnJaVmNDZUwy?=
 =?utf-8?B?SS9yYnFwUVl1aHFOcjJHeUVmMFdOd1BsTlRBNTJCcVk0SXFINm1UZ1k0NFNx?=
 =?utf-8?B?citMeHp0THdPREpCaUNrejJQV3J2Wk13NUs2Y1hWb3MyNThJUXNJVW90OHg5?=
 =?utf-8?B?TTdwc1duSHpEdGJuaXR4NVZ6TEdhZ2NnS2VwSk10dVNqWnYzWUZVZXp6Rytp?=
 =?utf-8?B?S1dYN0tCU0dQZEh4c0JoTFBGUDRvVkprOW5lSWFiMjUxdGFyTFF3V3pqUkhq?=
 =?utf-8?B?T3pnYzdHUHN2OEIySGNnNVRoc1Y5L3NDRmpEc0pJNWx0Y0tKaG1PTkdMUWU0?=
 =?utf-8?B?OHRPNktJYzlxNmtHQTJ1NEtuWUcwMk56YVI1VFZaL2w1Ykt1TmdNaDRRa285?=
 =?utf-8?B?R1JVTW4wbFpIU1oveGhHZ3VNbUwzTGh4V2tVL1hYRDZrOTR0Snk0VnpxK3la?=
 =?utf-8?B?Qk0zMlVXMUtyWWgzbjIyTVBYSjE3K1NZbU8yL3NRZXQvdGNqdFpsbzNHRXhj?=
 =?utf-8?B?Sm4ydGE4cjFWMEtWWm1iSnU5dmlnUklTa3pwaitNYTBHWEUrNDYreFdPelRp?=
 =?utf-8?B?NW56aXhzcFRtNlFYSDZIT2dyNElJTm5PTFYvZGxJRmdwOVZaVzJCT3JnPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b0432c-d77c-4ab6-79d7-08dafb327a2c
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 22:05:44.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6676
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-18 03:21, Ævar Arnfjörð Bjarmason wrote:

> 
> On Wed, Jan 18 2023, Matthew John Cheetham via GitGitGadget wrote:
> 
> 
>> +static struct auth_module *get_auth_module(const char *scheme, int create)
>> +{
>> +	int i;
>> +	struct auth_module *mod;
>> +	for (i = 0; i < auth_modules_nr; i++) {
> 
> We can use "for (size_t i = 0" syntax now, let's do that here to not mix
> "size_t" and "int" types needlessly.

Yep!

>> +	if (create) {
>> +		struct auth_module *mod = xmalloc(sizeof(struct auth_module));
>> +		mod->scheme = xstrdup(scheme);
>> +		mod->challenge_params = NULL;
>> +		CALLOC_ARRAY(mod->tokens, 1);
>> +		string_list_init_dup(mod->tokens);
> 
> Don't use CALLOC_ARRAY() if you're then going to use
> string_list_init_dup() (which is good!), use ALLOC_ARRAY() instead. We
> don't need to set the memory to 0, only to overwrite it entirely again.

Sure.

>> +		ALLOC_GROW(auth_modules, auth_modules_nr + 1, auth_modules_alloc);
>> +		auth_modules[auth_modules_nr++] = mod;
> 
> I have not looked at the whole context here, but instead of:
> 
> 	struct auth_module {
> 		char *scheme;
> 		char *challenge_params;
> 		struct string_list *tokens;
> 	};
> 
> Why not:
> 
> 	struct auth_module {
> 		char *challenge_params;
> 		struct string_list *tokens;
> 	};
> 
> Then you could use a "struct string_list" for this, make the "scheme" be
> the "string" member, and stick the remaining two fields in the "util",
> and thus save yourself the manual memory management etc.

I looked at this, but this then means being more careful when looping over
different `struct auth_module`s to keep the current 'scheme' and `*mod` in
sync/together. Just feels like overkill right now.

>> +static int is_authed(struct req *req, const char **user, enum worker_result *wr)
>> +{
>> +	enum auth_result result = AUTH_UNKNOWN;
>> +	struct string_list hdrs = STRING_LIST_INIT_NODUP;
>> +	struct auth_module *mod;
>> +
>> +	struct string_list_item *hdr;
>> +	struct string_list_item *token;
>> +	const char *v;
>> +	struct strbuf **split = NULL;
>> +	int i;
>> +	char *challenge;
>> +
>> +	/*
>> +	 * Check all auth modules and try to validate the request.
>> +	 * The first Authorization header that matches a known auth module
>> +	 * scheme will be consulted to either approve or deny the request.
>> +	 * If no module is found, or if there is no valid token, then 401 error.
>> +	 * Otherwise, only permit the request if anonymous auth is enabled.
>> +	 * It's atypical for user agents/clients to send multiple Authorization
>> +	 * headers, but not explicitly forbidden or defined.
>> +	 */
>> +	for_each_string_list_item(hdr, &req->header_list) {
>> +		if (skip_iprefix(hdr->string, "Authorization: ", &v)) {
>> +			split = strbuf_split_str(v, ' ', 2);
>> +			if (!split[0] || !split[1]) continue;
>> +
>> +			/* trim trailing space ' ' */
>> +			strbuf_setlen(split[0], split[0]->len - 1);
>> +
>> +			mod = get_auth_module(split[0]->buf, 0);
>> +			if (mod) {
>> +				result = AUTH_DENY;
>> +
>> +				for_each_string_list_item(token, mod->tokens) {
>> +					if (!strcmp(split[1]->buf, token->string)) {
>> +						result = AUTH_ALLOW;
>> +						break;
>> +					}
>> +				}
>> +
>> +				goto done;
> 
> Sometimes we need a strbuf_split_str, but in this case couldn't you use
> the in-place "struct string_list" variant of that instead, and just
> carry a "size_t len" here for it, which you'd then pass to
> get_auth_module() (which this commit adds)?

`get_auth_module` taking a scheme name as parameter is a more sensible, IMO,
than a `string_list` or `string_list_item` and an offset. Given this is a test
helper, performance also isn't a priority. Readability wins here I think.

> Also, you "split" in the loop, but...
> 
>> +	strbuf_list_free(split);
> ...only free() the last one here, isn't this leaking?

Yes, it is. Will fix in next iteration.

>> +static int split_auth_param(const char *str, char **scheme, char **val)
>> +{
>> +	struct strbuf **p = strbuf_split_str(str, ':', 2);
>> +
>> +	if (!p[0])
>> +		return -1;
>> +
>> +	/* trim trailing ':' */
>> +	if (p[0]->len > 0 && p[0]->buf[p[0]->len - 1] == ':')
> 
> Don't compare unsigned length fields to "> 0", just do "if (len &&
> ....)".

Sure!

> Also, maybe I'm just groggy today, but how do we have a trailing ":" if
> we just split on ":", and with a limit such that...
> 
>> +	if (p[1])
>> +		*val = strbuf_detach(p[1], NULL);
> 
> ...we have an item after that?

Because that's how the `strbuf_split_str` function works. The comments
in the header file even call that out. "The substrings include the
terminator". From strbuf.h:

/**
 * Split str (of length slen) at the specified terminator character.
 * Return a null-terminated array of pointers to strbuf objects
 * holding the substrings.  The substrings include the terminator,
 * except for the last substring, which might be unterminated if the
 * original string did not end with a terminator. [cut] ...
   ...
 */
struct strbuf **strbuf_split_buf(const char *str, size_t len,
				 int terminator, int max);

>> +static int read_auth_config(const char *name, const char *val, void *data)
>> +{
>> +	int ret = 0;
>> +	char *scheme = NULL;
> 
> Don't init this to NULL, instead the split_auth_param() return value
> should be trusted, the compiler will then help us catch errors, no?
> 
>> +	char *token = NULL;
>> +	char *challenge = NULL;
> 
> In this case it *is* needed though, as the function will return
> non-errors, but *maybe* give us the second out parameter.
> 
> For such a function though, isn't just assigning "*second_param = NULL"
> at the start of it less of a "running with scissors" pattern?
> 
>> +	struct auth_module *mod = NULL;
> 
> This NULL assignment can be dropped, we assign to it below
> unconditionally before using it.

All of these variables need to be initialised to NULL because not all
arms of the `if-elseif` chain assign to all of these variables, but
we always `free` all of them at the function exit.

For example,

char *scheme = NULL;
char *token = NULL;
char *challenge = NULL;
...
} else if (!strcmp(name, "auth.allowanonymous")) {
	allow_anonymous = git_config_bool(name, val);
} else {
...
free(scheme);
free(token);
free(challenge);

>> +
>> +	if (!strcmp(name, "auth.challenge")) {
>> +		if (split_auth_param(val, &scheme, &challenge)) {
>> +			ret = error("invalid auth challenge '%s'", val);
>> +			goto cleanup;
>> +		}
>> +
>> +		mod = get_auth_module(scheme, 1);
>> +
>> +		/* Replace any existing challenge parameters */
>> +		free(mod->challenge_params);
>> +		mod->challenge_params = challenge ? xstrdup(challenge) : NULL;
>> +	} else if (!strcmp(name, "auth.token")) {
>> +		if (split_auth_param(val, &scheme, &token)) {
>> +			ret = error("invalid auth token '%s'", val);
>> +			goto cleanup;
>> +		}
>> +
>> +		mod = get_auth_module(scheme, 1);
>> +
>> +		/*
>> +		 * Append to set of valid tokens unless an empty token value
>> +		 * is provided, then clear the existing list.
>> +		 */
>> +		if (token)
>> +			string_list_append(mod->tokens, token);
>> +		else
>> +			string_list_clear(mod->tokens, 1);
>> +	} else if (!strcmp(name, "auth.allowanonymous")) {
>> +		allow_anonymous = git_config_bool(name, val);
>> +	} else {
>> +		warning("unknown auth config '%s'", name);
>> +	}
>> +
>> +cleanup:
>> +	free(scheme);
>> +	free(token);
>> +	free(challenge);
>> +
>> +	return ret;
>> +}
>> +

Thanks,
Matthew
