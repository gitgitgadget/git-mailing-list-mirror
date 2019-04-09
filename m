Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B3E820248
	for <e@80x24.org>; Tue,  9 Apr 2019 05:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbfDIFyy (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 01:54:54 -0400
Received: from mout.web.de ([212.227.15.14]:48539 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfDIFyx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 01:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554789289;
        bh=p9nwFIPuSoShrmOr+ae5J2RFI7Ha/NkGFcXnqPq3i8g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Vq2a/hWafk1sszz04lg/qJw3z2+mIvXDZsLLQRwqrgKNqgXOVAnn2JVTXlbf5L0aa
         zOtGMxXZteB90cygfkHxfQ5lJnRIjH9mWqGP0wmqQDB7Ey91oS7qkUy1IxTQ35/Uj5
         TB2z6WNXiACMobM1CcaKJ883X0QjPMGc2n+5rJF0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from macce.local ([134.30.197.86]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lj88M-1gbw7r2vRm-00dHhd; Tue, 09
 Apr 2019 07:54:49 +0200
Subject: Re: [GSoC][RFC] Proposal: Make pack access code thread-safe
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Philip Oakley <philipoakley@iee.org>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
References: <CAHd-oW7KMrDJ-cyzk63oqW9-QVpag6fKnDp+Mo5bWxg1KfzY3g@mail.gmail.com>
 <CAP8UFD0qeOaS8NBOaMjzDf_tWJrgkYSAOgn8D=4JER2atg3H8g@mail.gmail.com>
 <CACsJy8DxW7ZcSNQBZq4+A6c+9xZopg79sXfi6Na61Xgcoqd6ng@mail.gmail.com>
 <79ecdc5b-2ccf-ae4d-3775-b850641f8c3e@iee.org>
 <CAHd-oW5PFmj4u2YB-1TcHWNxkokfCEsUq_zB=Rx2Vmdk5Z9eMw@mail.gmail.com>
 <1348d823-9729-a5eb-2104-df7c4a41911d@iee.org>
 <CAHd-oW79P+Fq6OkdDa4Ly2mecuCM0tyS7jopON2_2rL-mf9RXQ@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <bebc5bfe-0d84-d499-4dff-8f72b8b9f12b@web.de>
Date:   Tue, 9 Apr 2019 07:54:49 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHd-oW79P+Fq6OkdDa4Ly2mecuCM0tyS7jopON2_2rL-mf9RXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JTo5NQTtI8lnKG5ilGi6NAAo7W4RtTtNCm7qUoGSVS3Rh14GGir
 4FcdUnszp226AlmxO9p5UMLOPz9xkn0f+R01ZcSX1hYmg2Q6BbK6+Q1wIXoS8iw6JzaD3vw
 putcxt3V6PLRM7PA2PlgmS5v3ZU1mXzZRqF1t9Hpac36xL+zkeX6+7zPI+4oIbyBc5fJe0w
 Ix3tv49k8iw3eIlI7fmEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lBcrmsFa3YA=:SMgsWR7u+6/UCdnHx7ylaa
 QZdqld3XF/wHvqqJ7yXJ36xj97jLYvJ+yfP8HMvm1N/nZkzjspdli09OmS3AqsAamg7UZp2jk
 PPxjTbBsq0DO4rsWhaJZp6erUjuNqwDLhvdJgeVO2k1+7C1WjiVMgcpI2IuoXCMTtLTahvPuA
 lCbORSQusg35jBbaxWvhs5G5BRq8qDARakhgEfzO4z81ZQsyFtxYER2vWun+lu6qSGT0ejCmE
 ao42I5fOzl4XEN9a+8HoZC1qiIplwjzz+UW/2eWezotc22K9F4YIf1zFZ8Plw5oGtGFdFFQPX
 9FmiS48NuyLW6PzwSz1FmUWy1EBoSJYJigbMKJk76d7Py7arSoOzcyVMBIOvBGpChFl34e8gn
 tm0cgNBHwypKeeNvvomvDhgaXhlmkFgDaHq0JHANSUTMYQ8uoj/s2TFTqXBoKdNUr1nfN9kka
 MN33JG5YwRN+FcugNyu7S9siLs1zXouywfOO8ciuE8bXj6+zM0sPVzZViHaTd40mZaza0JCBv
 jGPTq+NIp9P/l4grAfSoYmhyn4pXev99b345oWSIBkSdfRddRUPVoXBmzxHo68vgMZj7tymVI
 oj3haAXOWC3U+B/mrxmzSMLKHoLCwBXAdTzg8aC/KuEaJEYCd8Ig7dHV3k8/Jmi4+AN9waXlV
 uMOHWnMG9ybHWBRjgIu8eKWP7Nu9PIQyXNjlnG3oGWpdhH0BXk8cNO04aFJPKsSazDTvFAO09
 vb4dwj6+ddnPMn+dYltqnJqqCN1M/ics93hS9SDWxC59NzSuDJDrfq8QdUwY9EZ/jFSVykzD0
 u6MpnQGaBICoY2p+hddiLy/GziXBT4IgTtNpbYnzestUivabMbOLhOavjzRRR+cWUFnQs0q88
 +l8W3ATpc9YveZ2j9QA7Rf4ZrGNDhg6xE/SImZc88VuE0LVZe3oM4rG5D1KCuK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-04-08 21:36, Matheus Tavares Bernardino wrote:
> On Mon, Apr 8, 2019 at 4:19 PM Philip Oakley <philipoakley@iee.org> wrot=
e:
>>
>> Hi Matheus
>>
>> On 08/04/2019 18:04, Matheus Tavares Bernardino wrote:
>>>> Another "32-bit problem" should also be expressly considered during t=
he
>>>> GSoC work because of the MS Windows definition of uInt / long to be o=
nly
>>>> 32 bits, leading to much of the Git code failing on the Git for Windo=
ws
>>>> port and on the Git LFS (for Windows) for packs and files greater tha=
n
>>>> 4Gb.https://github.com/git-for-windows/git/issues/1063
>>
>>> Thanks for pointing it out. I didn't get it, thought, if your
>>> suggestion was to also propose tackling this issue in this GSoC
>>> project. Was it that? I read the link but it seems to be a kind of
>>> unrelated problem from what I'm planing to do with the pack access
>>> code (which is tread-safety). I may have understood this wrongly,
>>> though. Please, let me know if that's the case :)
>>>
>> The main point was to avoid accidental regressions by re-introducing
>> simple 'longs' where memsized types were more appropriate.
>>
>> Torsten has already done a lot of work at
>> https://github.com/tboegi/git/tree/tb.190402_1552_convert_size_t_only_g=
it_master_181124_mk_size_t
>
> Got it. Thanks, Philip!
>
>> HTH
>> Philip
>> (I'm off line for a few days)

Thanks for the reminder -
I will probably send something out the next days/weeks.
