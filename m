Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20865C38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 18:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJ1SWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 14:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiJ1SWV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 14:22:21 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CB324418B
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 11:22:17 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6998BCA124F;
        Fri, 28 Oct 2022 14:22:16 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1E2B9CC8336;
        Fri, 28 Oct 2022 14:22:16 -0400 (EDT)
Subject: Re: [PATCH v2 2/6] credential: add WWW-Authenticate header to cred
 requests
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
 <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
 <0838d992744a4b06523be6df0edb046ebba033ee.1666372083.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <08de9e0e-af08-2bc3-6693-7bf2b798f20a@jeffhostetler.com>
Date:   Fri, 28 Oct 2022 14:22:15 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <0838d992744a4b06523be6df0edb046ebba033ee.1666372083.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/21/22 1:07 PM, Matthew John Cheetham via GitGitGadget wrote:
> From: Matthew John Cheetham <mjcheetham@outlook.com>
> 
> Add the value of the WWW-Authenticate response header to credential
> requests. Credential helpers that understand and support HTTP
> authentication and authorization can use this standard header (RFC 2616
> Section 14.47 [1]) to generate valid credentials.
> 
> WWW-Authenticate headers can contain information pertaining to the
> authority, authentication mechanism, or extra parameters/scopes that are
> required.
> 
> The current I/O format for credential helpers only allows for unique
> names for properties/attributes, so in order to transmit multiple header
> values (with a specific order) we introduce a new convention whereby a
> C-style array syntax is used in the property name to denote multiple
> ordered values for the same property.
> 
> In this case we send multiple `wwwauth[n]` properties where `n` is a
 > zero-indexed number, reflecting the order the WWW-Authenticate headers
 > appeared in the HTTP response.

Here (and maybe in the cover letter) you mention `wwwauth[n]` and `n`...
> +`wwwauth[]`::
> +
> +	When an HTTP response is received that includes one or more
> +	'WWW-Authenticate' authentication headers, these can be passed to Git
> +	(and subsequent credential helpers) with these attributes.
> +	Each 'WWW-Authenticate' header value should be passed as a separate
> +	attribute 'wwwauth[]' where the order of the attributes is the same
> +	as they appear in the HTTP response.

...but here you don't include the `n`.

[...]
> +static void credential_write_strvec(FILE *fp, const char *key,
> +				    const struct strvec *vec)
> +{
> +	int i = 0;
> +	const char *full_key = xstrfmt("%s[]", key);

...nor here.

Jeff
