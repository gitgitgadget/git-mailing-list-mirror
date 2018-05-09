Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 106651F424
	for <e@80x24.org>; Wed,  9 May 2018 22:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965855AbeEIW52 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 9 May 2018 18:57:28 -0400
Received: from elephants.elehost.com ([216.66.27.132]:51485 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965426AbeEIW51 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 18:57:27 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w49MvOS3089055
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 9 May 2018 18:57:24 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Bryan Turner'" <bturner@atlassian.com>
Cc:     "'Git Users'" <git@vger.kernel.org>
References: <004d01d3e7e2$517f78d0$f47e6a70$@nexbridge.com> <CAGyf7-GJgpCZ=wEorLxYOm_ABaDamWKkTnOtaAwti35DJ_zS7g@mail.gmail.com>
In-Reply-To: <CAGyf7-GJgpCZ=wEorLxYOm_ABaDamWKkTnOtaAwti35DJ_zS7g@mail.gmail.com>
Subject: RE: [Best Practices Request] clean/smudge configuration
Date:   Wed, 9 May 2018 18:57:18 -0400
Message-ID: <006201d3e7e9$17c1a800$4744f800$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFnnQJFkppPCcoZJFTxZlMkMoJajAGXzmEUpPPX+zA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 9, 2018 6:39 PM, Bryan Turner wrote
> 
> On Wed, May 9, 2018 at 3:09 PM Randall S. Becker
> <rsbecker@nexbridge.com>
> wrote:
> 
> > The question: what is the best practice for versioning the parts of
> > clean/smudge filters that are in .git/config given that only some
> > users in my environment will be cloning the repository in question and
> > that I
> really
> > can't put the entries in /etc/gitconfig or ~/.gitconfig because of
> potential
> > conflicts with other repositories that might also have clean/smudge
> > definitions.
> 
> Depending on level of trust, one approach might be to use an [include] in
> .git/config to include a file that's in the repository. Something like:
> 
> [include]
>      path = ../path/to/config

It's a possibility, but I don't like the implications. Files that are subject to the clean/smudge would need to be reprocessed manually. In the scenario:

1. A checkout is done, changing ../path/to/config.
2. The clean/smudge configuration changes in ../path/to/config, but the files impacted by it do not.
3. git does not look like it would not be aware of the change until after the checkout, which is too late.
4. The work tree is now inconsistent with the idempotency of the clean/smudge rules, basically because nothing happened. (not blaming git here, just timing).

As far as I understand, this is a bit of a chicken-and-egg problem because the clean/smudge config needs to be there before the checkout. Correct?

Cheers,
Randall

