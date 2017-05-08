Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8262B1FC44
	for <e@80x24.org>; Mon,  8 May 2017 17:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753468AbdEHRF3 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 8 May 2017 13:05:29 -0400
Received: from elephants.elehost.com ([216.66.27.132]:59023 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753047AbdEHRF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 13:05:29 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.238.41.215])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id v48H5Oov097222
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 May 2017 13:05:24 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Stefan Beller'" <sbeller@google.com>
Cc:     "'Ciro Santilli'" <ciro.santilli@gmail.com>, <git@vger.kernel.org>
References: <CAFXrp_do8Jn-k18_FSRNeHQrWNydwdj2y3y5gw+XoZPGAzPL-w@mail.gmail.com> <001b01d2c809$62ac8520$28058f60$@nexbridge.com> <CAGZ79kaES-3ftadorYnx2wMDc-q7qsG376E1zy-C67Ldt2BO5g@mail.gmail.com> <002201d2c81a$9ff76060$dfe62120$@nexbridge.com> <CAGZ79kbxdXhhG3+4v9qH_oDi5o_zseGsQf8KCyTN3+axZB9sUA@mail.gmail.com>
In-Reply-To: <CAGZ79kbxdXhhG3+4v9qH_oDi5o_zseGsQf8KCyTN3+axZB9sUA@mail.gmail.com>
Subject: RE: Add an option to automatically submodule update on checkout
Date:   Mon, 8 May 2017 13:05:16 -0400
Message-ID: <002301d2c81d$4728aae0$d57a00a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJFtsy+gX9bRxHg9rX7flyynOAlGwFCwG3XAfXKjogCwxC3awL2dmEZoL07SUA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 8, 2017 12:55 PM, Stefan Beller wrote:
>On Mon, May 8, 2017 at 9:46 AM, Randall S. Becker <rsbecker@nexbridge.com> wrote:
>> On May 8, 2017 12:25 PM, Stefan Beller wrote:
>>>On Mon, May 8, 2017 at 7:42 AM, Randall S. Becker <rsbecker@nexbridge.com> wrote:
>>>> On May 6, 2017 4:38 AM Ciro Santilli wrote:
>>>>> This is a must if you are working with submodules, otherwise every 
>>>>> git checkout requires a git submodule update, and you forget it, 
>>>>> and things break, and you understand, and you go to stack overflow 
>>>>> questions 
>>>>> http://stackoverflow.com/questions/22328053/why-doesnt-git-checkout
>>>>> -a utomatically-do-git-submodule-update-recursive
>>>>> http://stackoverflow.com/questions/4611512/is-there-a-way-to-make-g
>>>>> it -pull-automatically-update-submodules
>>>>> and you give up and create aliases :-)
>>
>>> The upcoming release (2.13) will have "git checkout 
>>> --recurse-submodules", which will checkout the submodules at the commit as recorded in the superproject.
>>> I plan to add an option "submodule.recurse" (name is subject to 
>>> bikeshedding), which would make the --recurse-submodules flag given 
>>> by default for all commands that support the flag. (Currently cooking we have reset --recurse-submodules, already existing there is push/pull).
>>
>> Brilliant! 😊
>>
>>>> I rather like the concept of supporting --recurse-submodules. The complexity is that the branches in all submodules all have to have compatible >>>semantics when doing the checkout, which is by no means guaranteed. In the scenario where you are including a submodule from a third-party (very >>>common - see gnulib), the branches likely won't be there, so you have a high probability of having the command fail or produce the same results as >>>currently exists if you allow the checkout even with problems (another option?). If you have control of everything, then this makes sense.
>>
>>>I am trying to give the use case of having control over everything (or rather mixed) more thought as well, e.g. "checkout --recurse-submodules -b >><name>" may want to create the branches in a subset of submodules as well.
>>
>> I have to admit that I just assumed it would have to work that way 
>> this would not be particularly useful. However, in thinking about it, 
>> we might want to limit the depth of how far -b <name> takes effect. If 
>> the super module brings in submodules entirely within control of the 
>> development group, having -b <name> apply down to leaf submodules 
>> makes sense (in some policies). However, if some submodules span out 
>> to, say, gnulib, that might not make particular sense. Some downward 
>> limit might be appropriate. Perhaps, in the submodule ref, you might 
>> want to qualify it as <commit>:<ref> (but the impact of that is 
>> probably and admittedly pretty horrid). I hesitate to suggest a 
>> numeric limit, as that assumes that submodules are organized in a 
>> balanced tree - which is axiomatically unreasonable. Maybe something 
>> in .git/config, like
>>
>> [branch "topic*"]
>>         submodules=a,b,c
>>
>> But I suspect that would make things even more confusing.

>I thought about having yet-another-flag in the .gitmodules file, which states if the submodule is extern or internal.

>[submodule "gnulib"]
>    path=./gnulib
>    external = true # implies no branch for checkout -b --recurse-submodules

>I think there are a couple more situations where such "external" submodules are treated differently, so maybe we'd want to think carefully about the >actual name as different workflows would want to have different features for an internal/external submodule.

I didn't want to open up that one, but yes. That makes sense. However, I don't like overloading what "external" means or might mean in the future. Would you consider a distinct Boolean for that, like inherit-branch=true?

Cheers,
Randall

