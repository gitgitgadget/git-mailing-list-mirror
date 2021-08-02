Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46860C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 310F360FA0
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhHBQLL convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 2 Aug 2021 12:11:11 -0400
Received: from elephants.elehost.com ([216.66.27.132]:60625 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbhHBQLL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:11:11 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 172GAsPV044161
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 2 Aug 2021 12:10:55 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Emily Shaffer'" <emilyshaffer@google.com>
Cc:     <git@vger.kernel.org>
References: <20210722012707.205776-1-emilyshaffer@google.com> <20210722012707.205776-3-emilyshaffer@google.com> <87o8agp29o.fsf@evledraar.gmail.com>
In-Reply-To: <87o8agp29o.fsf@evledraar.gmail.com>
Subject: RE: [PATCH v6 2/2] tr2: log parent process name
Date:   Mon, 2 Aug 2021 12:10:47 -0400
Message-ID: <00a501d787b8$f8347a80$e89d6f80$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
thread-index: AQG+xmSp1ylf0N6hA1ma48JUnkKAjwMnnvdCAgV3W2GraHs6IA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 2, 2021 6:22 AM: Ævar Arnfjörð Bjarmason wroteL
>On Wed, Jul 21 2021, Emily Shaffer wrote:
>
>> Git for Windows also gathers information about more than one
>> generation of parent. In Linux further ancestry info can be gathered
>> with procfs, but it's unwieldy to do so.
>
>Having read the win32 get_processes() implementation and read proc(5) I don't get how it's unweildy to do so on Linux? Perhaps I'm
>missing some special-case but this rather simple patch-on-top seems to do the job for me. This includes the unrelated enum/switch/case
>change I suggested.
>
>I can submit it as a patch-on-top with SOB etc, but maybe there's some subtle reason it won't work properly. It works for me, I get e.g.:
>
>    {
>      "event": "cmd_ancestry",
>      "sid": "20210802T102731.879424Z-Hc2f5b994-P00001acc",
>      "thread": "main",
>      "time": "2021-08-02T10:27:31.879618Z",
>      "file": "compat/linux/procinfo.c",
>      "line": 66,
>      "ancestry": [
>        "bash",
>        "screen",
>        "systemd"
>      ]
>    }

Should not the subfields of "ancestry" also have field names? I get that they are a list, but it seems a bit restrictive.

My preference here would be:

     "ancestry": [
       "ancestor": [
	"program": "bash",
	"pid" : 1234 ],
       "ancestor": [
              "program": "screen"],
       "ancestor": [
       	"program" : "systemd"],
     ]

With more richness available in the ancestor.

