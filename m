Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96BF1FDEA
	for <e@80x24.org>; Tue,  9 May 2017 13:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753515AbdEINA3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 09:00:29 -0400
Received: from elephants.elehost.com ([216.66.27.132]:33627 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbdEINA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 09:00:29 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.238.41.215])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id v49D0MXl027334
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 May 2017 09:00:22 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Stefan Beller'" <sbeller@google.com>,
        "'Ciro Santilli'" <ciro.santilli@gmail.com>, <git@vger.kernel.org>
References: <CAFXrp_do8Jn-k18_FSRNeHQrWNydwdj2y3y5gw+XoZPGAzPL-w@mail.gmail.com>        <001b01d2c809$62ac8520$28058f60$@nexbridge.com> <CAGZ79kaES-3ftadorYnx2wMDc-q7qsG376E1zy-C67Ldt2BO5g@mail.gmail.com>    <002201d2c81a$9ff76060$dfe62120$@nexbridge.com> <xmqqtw4u4tz6.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqtw4u4tz6.fsf@gitster.mtv.corp.google.com>
Subject: RE: Add an option to automatically submodule update on checkout
Date:   Tue, 9 May 2017 09:00:09 -0400
Message-ID: <000c01d2c8c4$336c3380$9a449a80$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJFtsy+gX9bRxHg9rX7flyynOAlGwFCwG3XAfXKjogCwxC3awKQXJK2oMG2kfA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 8, 2017 10:58 PM, Junio C Hamano wrote:
>"Randall S. Becker" <rsbecker@nexbridge.com> writes:
>> I have to admit that I just assumed it would have to work that way 
>> this would not be particularly useful. However, in thinking about it, 
>> we might want to limit the depth of how far -b <name> takes effect. If 
>> the super module brings in submodules entirely within control of the 
>> development group, having -b <name> apply down to leaf submodules 
>> makes sense (in some policies). However, if some submodules span out 
>> to, say, gnulib, that might not make particular sense.

>I do not see a strong reason to avoid your own branches in "other people's
project" like this.
>The submodule's upstream may be a project you have no control over, but the
repository you have locally is under your total control and you can use >any
branch names to suit the need of your project as the whole (i.e. the
superproject and submodules bound to it).

>The fact that local branch names are under your control and for your own
use is true even when you are not using submodules, by the way.

I agree with the technical aspects of this, but doing a checkout -b into
something like gnulib will pin the code you are using in that submodule to
whatever commit was referenced when you did the checkout. Example: In a
situation like that, I would want gnulib to stay on 'master'. It is my
opinion, FWIW, that this is a matter of policy or standards within the
organization using git that we should not be imposing one way or another. In
the current state of affairs (2.12.x), when I checkout, I make sure that
people are aware of which branch each submodule is on because git won't go
into the submodules - I'm fine with imposing that as a policy at present
because it takes positive action by the developers and I keep the master
branch on my own repositories locked down and it's obvious when they are
accidentally on it. But we're talking changing this so that checkout
branches can apply recursively. This changes the policy requirements so that
people have to further act to undo what git will do by default on recursion.
The policy will be at a high level the same (i.e., always make sure you know
what branch you are on in submodules), but the implementation of it will
need to be different (i.e., after you checkout recursive, go into each
submodule and undo what git just did by checking out the default branch on
some submodules ___ ___ ___, which depends on which super repository they
are using, is onerous for me to manage, and for my developers to remember to
do).

With Respect,
Randall

