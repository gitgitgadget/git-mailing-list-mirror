Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 155B42023C
	for <e@80x24.org>; Fri,  8 Jul 2016 06:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbcGHGhq (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 02:37:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:58393 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751836AbcGHGhp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 02:37:45 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LsPwa-1bS6Ui3hkm-011xdm; Fri, 08 Jul 2016 08:37:36
 +0200
Date:	Fri, 8 Jul 2016 08:37:35 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: ignore return value of write_file()
In-Reply-To: <20160707203157.GA11804@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607080834340.6426@virtualbox>
References: <577EB546.1090007@web.de> <20160707203157.GA11804@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WQAL13J3dUd+O0vVJQhtHsAKxTXKKdM0hsGTjqcxR4Lj6/I/x76
 rpA6dTrtyprHAyrYb5QkVNJCwbvqIw98w1VVN3PxP3+i0f3CAa+9RbQUqRaU0g4ydcOfxgd
 k32e2eNMC0DlACImTJ7PxDJiIWHivUBr/7QBtqEmGaGFXquy8Rw3GLKi6mPijdurKNZwkCk
 GswO2Kn05LJYN6C7yfqZQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:uH8h9O9wQ3Y=:bAHAbbytnype6tM52dWD4U
 vOKTUcoqlbR9DhhBNuW5lPgVONXuFdVRMEaFvc53wBJAE8WOH/SbpQT4aDpro/d+r6EqM30gv
 cvA+1VmTrWMHVk0hZZJwCCEyLu9AklicT2KNTUhU81iUaCNrUoQ03Jx8tlSfi9vDpAPZMsrY1
 Y7tMtK4Z8oWcOAXNeCgp3RUfq8wk8YjylMoWPkwIg65ABjcvCJe0Vnu6nPH56DKKBr3veBF3T
 0mKZstykSE/04mfBxNbdRry+NdzjGyVw3fL0faekaJCjkcOz/ftZ6k6stp7B+IqteSwQniMwx
 uS8nFlZ18pCuDPLHyy7YbA/qqqGyNXsn/G1xAu32ZYY6JGFKQb/XKNLPIsjR2kkAtwBAfAk5X
 MlyBD3/snN6QS70SLIn3PubNCHQeOnOsD2SdaZZ/1vUaf1Rbl7zL66h9ZsyHIRZPJI5OZKSu4
 r+KCb5z9ajMoVKLvf4UimFkdiMSyQ2J5VhQ7HjeF/3isikO0BRPxnVNrNUzKmhSVwYVgvLU44
 2OKXY9QDiFiGZqlnfe8snLeJGx+dnlctInbZj7RKqcvtfnPgIloHDxSfup9HpVMYOKt6GwT0k
 27Om/doL2u6DVlQ6+6KJcnPR3ELA6JYNGZHXI6tqsth/miWWznCX7kNRUCu/j48bTu0+z3IIx
 zy4sequny7akot0ouGUXw2M5X6XtYOiivTC2tnnj1nM6E/LC9f3PgdNQciJ8j8zUSPsSl3fkC
 Q6gcNJLn3FvhxgOaBWQfxlwm7eYJ5TOyAudcDS/KBoUN9LlUBjgGKQp6RQmawCPNYt4q22Btm
 WkTPKw2
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Thu, 7 Jul 2016, Jeff King wrote:

> We have two forms of write_file(): one that dies, and one
> that returns an error. However, the latter has only a single
> caller, which immediately dies anyway (after producing a
> message that is not really any more informative than
> write_file's generic die(), and arguably worse because it
> does not give the actual filename).

This is more an illustration of unnecessarily duplicated code, isn't it?
There are *tons* of instances in Git's code where writing to a file is
implemented separately (and differently).

It would make tons of sense to consolidate all of these instances,
methinks. The diffstat should look *very* pleasing.

Ciao,
Dscho
