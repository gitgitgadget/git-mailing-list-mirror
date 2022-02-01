Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A84C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 07:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbiBAHBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 02:01:35 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:7774 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234494AbiBAHBe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 02:01:34 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Jnwp434vwz5tlB;
        Tue,  1 Feb 2022 08:01:31 +0100 (CET)
Message-ID: <f8202cc7-be5c-5efa-2a3b-987114356c6b@kdbg.org>
Date:   Tue, 1 Feb 2022 08:01:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/4] i18n: factorize more 'incompatible options'
 messages
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
References: <pull.1123.v3.git.1643580113.gitgitgadget@gmail.com>
 <pull.1123.v4.git.1643666870.gitgitgadget@gmail.com>
 <2eac2ef502b86d0c15513c8d0e69928ce2140b1f.1643666870.git.gitgitgadget@gmail.com>
 <xmqqv8xzh6iw.fsf@gitster.g>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqv8xzh6iw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.01.22 um 23:41 schrieb Junio C Hamano:
> "Jean-Noël Avila via GitGitGadget"  <gitgitgadget@gmail.com> writes:
> 
>> +inline void die_for_incompatible_opt3(int opt1, const char *opt1_name,
>> +				      int opt2, const char *opt2_name,
>> +				      int opt3, const char *opt3_name)
>> +{
>> +	die_for_incompatible_opt4(opt1, opt1_name,
>> +				  opt2, opt2_name,
>> +				  opt3, opt3_name,
>> +				  0, "");
>> +}
> 
> I haven't seen a non-static inline function defined in a common
> header files.  Does this actually work?  In my build, ld choked on
> this one.
> 
> Otherwise make it "static inline"?  Or just
> 
> #define die_for_incompatible_opt3(o1,n1,o2,n2,o3,n3) \
> 	die_for_incompatible_opt4((o1), (n1), \
> 				  (o2), (n2), \
> 				  (o3), (n3), \
> 				  0, "")
> 
> perhaps?

Please no macros where they are not a clear advantage. Make it a
function, either static inline, or out-of-line (the latter would be my
personal preference in this case because the function is not called in a
hot path).

-- Hannes
