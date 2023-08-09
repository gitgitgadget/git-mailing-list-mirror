Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BA7C41513
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 18:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjHISsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 14:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjHISsE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 14:48:04 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B21E51
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 11:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691606873; x=1692211673; i=tboegi@web.de;
 bh=hReAIvoE2Ga82a59KAIkCkX/qTgQxbZzKxU+bxb41Xw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Aw9C/yPMWYeNMCugHCVP6aY5h1snFtKz1igPhO7MEUUt6G+5wBG4MX5c0sreOYHHDYIdFqO
 Op8K6TZmPKJxALhb7dzj/Izb+HA9azjlcVd7bwf5d935TYOoTEjlxRzCh32uYnPCGrsEVUGM1
 5zkoULeAc/ZduBLqvfTDpZBJXyoBu1WlWBePeIhqWOa84wOjabfLHGZXtLmLTpAxAoP0xy0vO
 QxaCNz/n6K8lAQK4thVmEtdqsTrLkfL3k9WfI81Uc2T754cGysIm5n6DZbfFuLB50VaWIEvd+
 fIIWVTb/J9kH3ATSsc7qhflrw5iJiDeEmh6R1j7uxKxtO6Wit94w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdwJY-1pv1Ac3cOs-00bJLC; Wed, 09
 Aug 2023 20:47:52 +0200
Date:   Wed, 9 Aug 2023 20:47:52 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, friebetill@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1 1/1] git stash needing mkdir deletes untracked file
Message-ID: <20230809184751.ffwolkvjwoptnmen@tb-raspi4>
References: <5260C6A0-C53C-4F6D-B899-6AD8601F8458@gmail.com>
 <20230808172624.14205-1-tboegi@web.de>
 <6e40eb0b-2331-1e39-bee0-c9720c24d1c8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e40eb0b-2331-1e39-bee0-c9720c24d1c8@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:fXoFWqD6tYt4ObIpnN1+ze98+P1s9CuxUtnWdmVStwH/4ae28AX
 QVKwvE30vNgMZmnuZUhurCAIabwKu9oRUFeDwa4OKeT/2qC7TMDRXAy8Y479oiQ3G3LSdqS
 uKhZa1R7Vq9AZTVrG15fQjMwqZoGFp3f0ep+bgwTzqIelfTyU2Zij1pRxJ6t/sOJXjbTaTN
 piFleANEGZJwk+mohxd2Q==
UI-OutboundReport: notjunk:1;M01:P0:6gg4zWbBJt0=;UPzVO1gVGD7YnZCnunQWQfg9CHD
 78YFtSE2Lo4OkHWunbdHDIYh/iaYeiZAs+SxwPZ77vCTrNAZkrYfoKhheuEStDR39EyIDDcsZ
 2F/Ed3Jal+ozsO++sQdJSwkXOXGBi7Dlu2l7a2jf5aHi00RM7h9jHIxLdHml6T/1UYbIgpGee
 fLtYSJVnKh9Ho5cBsn7CC3mu9Er3s7mGmFy0C7q0SZ7/zmAmBbb+2e2COCiMcEssVhzuj8sko
 nQaHjOe8Z3mfwQtmbzY4X0Hmg4wBIKNxBzfQf/tKF6dIgqtt2mK943SMvab12VDMYcllv7nf2
 UPpFR6WJhMby2w4d/4HfitcHOwRlhT+q8ZrQ+iZlkfo1Lz1T8Vh8C+tb7CVc5Mn6dPrTKWHWX
 UWe38+nHuQns5MZcN+HoS5pTA44bgYHZmaQNmTxULaJiDrQaWLWQJFZpYRg53hVpkOXEE2AQj
 ah0hJeHy2f78BSSReYFmlW3U9lXbcCugljISdMd9lMRrc9nTMcFJo8bi7Dc51InjVeENP7JNm
 2xvWABs7F/+K+PlzasnLYL7k+we00zbQXNI0HCdbXQX7Wa5rYf+kbeoiB4k+oiMUsvrHY0Pq0
 xIUNAqU1MSyzgjw0bCFcQpQlWHT7kT1olWc4cAlpwCKqd/6CM8WGb3QsGkoN5zrHcaTgv/ZjR
 EveXwCmYwGddZflNmym3tzNgQAu07Og1P4Ag5NJ8s7KYqmquuWVvmko2Cy2PjegbGf4TnMEfF
 LL20CO458dfZCq/LQsBaz56OfBslWlzo6Ei45cvqpAS82YAQHfLfnQWRMLuL8Ro1CTMWPppMa
 PH6HXgc/LPQeRuhV+9gUuEKte3iJAogLIMYohK+NKpa5GxYvhOE0s7CBx7xKlThKTNNpNFvqD
 CoAnke0lTXdwtgR3cdDmR0uuE3GzzZrgnftT7QmqK9PGP0+ERCqlhTzv/ffrHtFTlwpOSJM1c
 oEsx4oPaixqQwLuGMRucRwAxe4M=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2023 at 02:15:28PM +0100, Phillip Wood wrote:
> Hi Torsten
>
> Thanks for working on this. I've cc'd Junio for his unpack_trees()
> knowledge.

Thanks Eric for the review.

Hej Phillip,
I have been playing around with the whole thing some time.
At the end I had a version, which did fiddle the information
that we are doing a `git stash` (and not any other operation)
into entry.c, and all test cases passed.
So in principle I can dig out all changes, polish them
and send them out, after doing cleanups of course.

(And that could take a couple of days, or weeks ;-)

My main question is still open:
Is it a good idea, to create a "helper file" ?
The naming can be discussed, we may stick the date/time
into the filename to make it really unique, or so.

Reading the different reports and including own experience,
I still think that a directory called ".deleted-by-user"
or ".wastebin" or something in that style is a good idea.

What do others think ?




