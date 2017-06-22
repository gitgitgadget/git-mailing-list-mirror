Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3A5F1FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 17:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753301AbdFVRXM (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 13:23:12 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35052 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753297AbdFVRXK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 13:23:10 -0400
Received: by mail-pg0-f68.google.com with SMTP id f127so3246580pgc.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Olt0zLclx9k5YULzI5gR/5LxAmuKZIZHLEW/mN8WY8o=;
        b=g1w+c++y7fble0md26dnyc9Qr58rxDgdsZ+H/+er5u65lcRyuj+3RJiVTLRgoKMZra
         lC/JopisnidXJ4sIgQd6zOptppk29IsPOgJg5aJ6zZ1qSGSB2ijora3IzjdmliYp59Xp
         D1fy7cX2TI9Obxkkwnl+tN/9FeWhgsAo89iS3qfyIgkNoxeWAK+gokUdS1QqsJch5yPM
         IsYVOPXgb5kY4Eg+QBw7SQCg+Bru3Jyw8sMmn5p1lq/c0q5/SkG6bx3hCy+sz4VOlfAn
         Xhgyxx8Wy5Q2TdtOeJaDWf9YSamDGWiJRXrmNdS/QbNwhG5J0N0OC6e19CSD8wIWPvov
         eZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Olt0zLclx9k5YULzI5gR/5LxAmuKZIZHLEW/mN8WY8o=;
        b=qFX2E4ojePRJlPk41KEaLhh+r2IjaQNPicKZ4Li6cZylaxRBal6bVsnnukY1uJH71I
         ixpyoJyJSkH5t2q7n58eEaPUbAu5a5J6G+rlz+g80m1kt6gCiIh5E//QeAscam0aNCZe
         KF7ai1pos5LFfJifNptmiUZ61bfmrHxtqvb7AD11oHIamBFQQMbujQ2f37ZTSZ26LWZQ
         8WuZfqRC8pcx7A1e2lLAmCIMZnqfwgzq9N5dJL+b8RUq1KrKfE+FXsWAlqaJJrpNrCJA
         Z7zUxhJ2NQMQSYR4PvOmhGHXVJL8RQcgRJ50xsRQJAZpexVVrVRlNCJfoLoE/zS3AISE
         AkVA==
X-Gm-Message-State: AKS2vOwQ8wSFs5OCZ39S0oecwY0/2iLYGWVzY8HvLtrIjdfNaGtMbqkd
        ugIVge+ImD8e3A==
X-Received: by 10.98.200.214 with SMTP id i83mr3728730pfk.144.1498152189880;
        Thu, 22 Jun 2017 10:23:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id i63sm5000892pge.56.2017.06.22.10.23.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 10:23:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 5/5] stash: implement builtin stash
References: <20170608005535.13080-1-joel@teichroeb.net>
        <20170608005535.13080-6-joel@teichroeb.net>
        <xmqqvanvv9be.fsf@gitster.mtv.corp.google.com>
        <CA+CzEk8+B71RoMeiZukfST-e6Ry+BijkNzHBusHycq2nhh2sPw@mail.gmail.com>
Date:   Thu, 22 Jun 2017 10:23:08 -0700
In-Reply-To: <CA+CzEk8+B71RoMeiZukfST-e6Ry+BijkNzHBusHycq2nhh2sPw@mail.gmail.com>
        (Joel Teichroeb's message of "Mon, 19 Jun 2017 19:12:20 -0700")
Message-ID: <xmqqefuckkcj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Teichroeb <joel@teichroeb.net> writes:

> On Fri, Jun 16, 2017 at 3:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> Then you write exactly the same index contents again, this time to
>> info->u_tree here.  I am not sure why you need to do this twice, and
>> I do not see how orig_tree.hash you wrote earlier is used?
>
> I'm not sure I understand what's happening here either. When I was
> writing this, it was essentially a lot of trial and error in order to
> get the index handling correct....

Thanks for being honest.  I agree that we do not want to say "we do
not yet know the exact mechanism how X happens, but X does happen"
for any value of X (in this case "the code happens to do the same
thing as the original").  In biology or physics experiments, that
may be how science advances, but it is different when it comes for
us to explain our own code ;-).  After all, its our creation.

I haven't followed the big picture in your codepath, but if you had
something like this, I can see how you need a seemingly unneeded
reading of the index:

    function A
	discard and read index
	do A's thing

    function B
	discard and read index
	do B's thing

    function C
	discard and read index
	if (some condition)
		do things that involves smudging the index
		call A
	else
		call B

    function D
	read index
	if (some other condition)
		call A
	else
		do things that involves smudging the index
		call B

That is, when the division of labor for preparing the in-core index
is not very well defined between the caller and the callee.  When
function C calls function B, the index is unnecessarily discarded
and read at the beginning of function B, but if you remove it
without changing anything else, the call to it from function D would
break.  One way to fix it would be to make the two helpers work from
the given in-core index, iow, make their callers responsible for
preparing the in-core index to desired state, i.e.

    function A
	do A's thing

    function B
	do B's thing

    function C
	discard and read index
	if (some condition)
		do things that involves smudging the index
		discard and read index
		call A
	else
		call B

    function D
	read index
	if (some other condition)
		call A
	else
		do things that involves smudging the index
                discard and read index
		call B

Again, I didn't follow the big picture callpath in your patch, so
the above may not be why your extra read-index calls are needed, and
I do not know which of your functions correspond to A, B, C and D in
the above illustration.  But I think you get the idea.
