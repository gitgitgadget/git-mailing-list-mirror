Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3362A1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 20:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeIFAew (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 20:34:52 -0400
Received: from mout.gmx.net ([212.227.15.19]:50697 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbeIFAew (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 20:34:52 -0400
Received: from [10.24.110.212] ([185.190.160.130]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0ML6qP-1fxv880Kyf-000OQy; Wed, 05
 Sep 2018 22:03:01 +0200
Subject: Re: [RFC PATCH v2] Allow aliases that include other aliases
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <20180905085427.4099-1-timschumi@gmx.de>
 <20180905173455.GA2336@sigill.intra.peff.net>
From:   Tim Schumacher <timschumi@gmx.de>
Message-ID: <cd9a3a74-fdd6-0fb5-ae22-41d552391478@gmx.de>
Date:   Wed, 5 Sep 2018 22:02:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180905173455.GA2336@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pPhI+UOkQg6skTxd4ghC+fnTvGNB3UoaYPKeYOJC7xJJhyk33I8
 MvJCzgnAw+nMYwk7CquTL+PwMsTPVvzgWRukLuVB2QwKxSi602bZot1T2A8ohhZPw46Visc
 nTaXoU69LocVqkgpRJwQZG2BgRIx3GlCH6IDvIDSOKMulU8BaRngwrsO7evX6wa2QhyJ8dR
 ndGh3t+OMarejC10xPwRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I1W5yv1SW+U=:wsz7Xp0u5Kuw6xPVX85IJo
 +nTDl3vpel0ph+ZcwYIggUf/B7qeplRYYoRiddlXimtO0/38fYSHK4RayBxz5G0OrdWhyWZa1
 BXwo/TBmBFtlaTxLYvTq+PmD+8LzzEC99QhZgvDi54L+2JA7whM3OKUt/GDE84RGQru3L98mv
 h9M1gVN6zzatO8kd7kGBqP54d4JYwHvJ/uSjRDn8cpnLDWmzUYr5jN6yZqyGAsb4srKWX/68Q
 ffZgC5ouqIMvcSzWwWsh59vy4VKZ0o4MeDZaWiXd5rxqGwbsdHRH2vFV4bK0Vq2o25jQIU+x4
 wOcUZpZpmpAU6OwHEIBU33YvA+uvqcg92E5uVrRxvnT+PxlmUnKoElY8ZI5NUF/y0kgoazPYX
 BXtRgwjr9eSlP1D+5QTEHmk92awntNvxOO2omASIxP53n8+FeU8XiYeFM8YoEb4H2bLmPOWoj
 lti/tt1XBWYskam2w9nXx1f8NdL36DLrcI4T2AKphHlcuIMkqwHOKx+goIVY7wkgLviYlalp0
 qe6xwbGy9LVHtym6OOk3WJVw7fxxRS/bWJy2yy70Owxcg0O8lB4Xi/9zNpVRFPLPiqGdnvxM4
 YPmjiZVCWdNE6tsLMH5nYZ8LaAKEvPF62BtSJtOA8Ft/kPoKqOzpchsZLFewOpwW58h+gPsa6
 DB3B1qKCeVzwC5dtqzY5PGcRrO3duCV4lw6suqlq+9JhN3Ju5ZLsHYMAjf06KxVvAV5+A7Mjf
 kZggJdeRrxWiJ/jqG8WIm3f6UZkz46+gMj4bOVZS61591tXSY7a2lJ4Rm1LwzGOnpWNaJIHrE
 rN0Rtbg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05.09.18 19:34, Jeff King wrote:
> On Wed, Sep 05, 2018 at 10:54:27AM +0200, Tim Schumacher wrote:
> 
>> Aliases can only contain non-alias git commands and their
>> arguments, not other user-defined aliases. Resolving further
>> (nested) aliases is prevented by breaking the loop after the
>> first alias was processed. Git then fails with a command-not-found
>> error.
>>
>> Allow resolving nested aliases by not breaking the loop in
>> run_argv() after the first alias was processed. Instead, continue
>> incrementing `done_alias` until `handle_alias()` fails, which means that
>> there are no further aliases that can be processed. Prevent looping
>> aliases by storing substituted commands in `cmd_list` and checking if
>> a command has been substituted previously.
>> ---
>>
>> This is what I've come up with to prevent looping aliases. I'm not too
>> happy with the number of indentations needed, but this seemed to be the
>> easiest way to search an array for a value.
> 
> I think this approach is OK, though I wonder if we'd also be fine with
> just:
> 
>    if (done_alias++ > 100)
> 	die("woah, is your alias looping?");
> 
> The point is just to prevent a runaway infinite loop, and this does that
> while keeping the cost very low for the common case (not that one string
> insertion is probably breaking the bank).

I'd opt to use the list-approach instead of aborting when the
counter reaches 100 (or any other value), because it aborts
at the earliest known looping point. I didn't run any tests
comparing both solutions, but I assume the list would perform
faster than the hard-limit, even if it requires slightly more
memory and lines of code.

I hope that I can put the string-list struct to some use,
so that the solution using lists becomes an equally good
solution code-wise.

> 
> It could also extend to ! aliases if we wanted (i.e., my '!git foo'
> example from earlier), but you'd have to carry the counter through the
> environment between processes.

That is a question about "shooting oneself in the foot" again,
but I think trying to prevent that would require more changes
than I can make, and it is definitely out-of-scope for this
patch.

> 
> -Peff
> 
Thanks for reviewing,

Tim
