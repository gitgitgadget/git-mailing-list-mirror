Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D6F208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 10:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbeHFNHG (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 09:07:06 -0400
Received: from ao2.it ([92.243.12.208]:59670 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbeHFNHG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 09:07:06 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fmdCC-0006bp-J8; Mon, 06 Aug 2018 12:57:04 +0200
Date:   Mon, 6 Aug 2018 12:58:28 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH v2 06/12] submodule--helper: add a '--stage' option
 to the 'config' sub command
Message-Id: <20180806125828.66fc99ef0b118e26e0b3e60d@ao2.it>
In-Reply-To: <xmqqbmajzadt.fsf@gitster-ct.c.googlers.com>
References: <20180802134634.10300-1-ao2@ao2.it>
        <20180802134634.10300-7-ao2@ao2.it>
        <xmqqd0v01trp.fsf@gitster-ct.c.googlers.com>
        <20180803130334.3979eedb0733c609815e9fd5@ao2.it>
        <xmqqbmajzadt.fsf@gitster-ct.c.googlers.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 03 Aug 2018 09:24:14 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Antonio Ospite <ao2@ao2.it> writes:
> 
> > The rationale behind the change is to close the circle started with 04
> > and 05 and stop referring to .gitmodules explicitly by file path in git
> > commands. The change is not strictly needed for the series, it's for
> > consistency sake.
> 
> Sorry, but I am still not quite sure what consistency you are
> referring to.
>

Hi Junio,

to recap: in previous patches we removed all instances of "git config
-f .gitmodules" (read/write operations), because in that case
encapsulating access to .gitmodules would directly enable us to add
new functionality (i.e.: read from HEAD:.gitmodules).

So, to me, it looked more organic to remove also the last explicit
reference to .gitmodules in git-submodule.sh ("git add -f .gitmodules",
the "stage" operation), even if in this case no new behavior about
staging is going to be added for the time being. that is: the change is
not strictly necessary.

The consistency I was referring to is merely in the mechanism used to
deal with .gitmodules: by always using "submodule--helper config".

As a side argument: in some previous discussion Stefan mentioned the
possibility that, in the future, he may be interested to explore
different locations for submodules configuration, like a special ref,
to prevent .gitmodules from being in the working tree at all, not even
for writing submodule configuration.

Having an opaque "stage submodule configuration" operation would
prepare for that too, but as I said this is not my immediate goal.

> I also do not see a reason why we want to stop referring to
> .gitmodules explicitly by name.  We do not hide the fact that
> in-tree .gitignore and .gitattributes files are used to hold the
> metainformation about the project tree, saying that it is an
> implementation detail.  Is there a good reason why .gitmodules
> should be different from these other two?

Not sure about that, but one difference I can see
between .gitignore/.gitattributes and .gitmodules is that I got the
impression that editing the latter by hand is strongly discouraged, if
that is indeed the case a layer of indirection can make sense IMHO to
make the actual file path less relevant.

Having said that I can drop patches 06/07 if this can help moving things
forward; or if I had some success in convincing you I can improve the
user interface (any advice?) and the commit message.

Thank you,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
