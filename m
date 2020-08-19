Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7350DC433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 18:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF3E20758
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 18:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHSSre (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:47:34 -0400
Received: from elephants.elehost.com ([216.66.27.132]:21525 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgHSSrc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 14:47:32 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 07JIlN6k029446
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 19 Aug 2020 14:47:24 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Lukas Straub'" <lukasstraub2@web.de>
Cc:     "'git'" <git@vger.kernel.org>,
        "'Elijah Newren'" <newren@gmail.com>,
        "'Brandon Williams'" <bwilliams.eng@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Jeff King'" <peff@peff.net>
References: <cover.1597853634.git.lukasstraub2@web.de> <xmqqr1s2tswd.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1s2tswd.fsf@gitster.c.googlers.com>
Subject: RE: [RFC PATCH 0/2] Allow adding .git files and directories
Date:   Wed, 19 Aug 2020 14:47:18 -0400
Message-ID: <04aa01d67659$2dc217b0$89464710$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJUwsi1t0kYcCu+MG1WzKjrMbhjgQKo5EueqC3iyiA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 19, 2020 2:04 PM, Junio C Hamano
> To: Lukas Straub <lukasstraub2@web.de>
> Cc: git <git@vger.kernel.org>; Elijah Newren <newren@gmail.com>;
> Brandon Williams <bwilliams.eng@gmail.com>; Johannes Schindelin
> <Johannes.Schindelin@gmx.de>; Jeff King <peff@peff.net>
> Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
> 
> Lukas Straub <lukasstraub2@web.de> writes:
> 
> > These patches allow this and work well in a quick test. Of course some
> > tests fail because with this the handling of nested git repos changed.
> 
> In other words, this breaks the workflow existing users rely on, right?  I
do
> not know if such a behaviour ever needs to exist even as an opt-in
feature,
> but it definitely feels wrong to make the behaviour these patches
introduce
> the default.

I am concerned about broader implications. I might be stating the obvious,
but a key security vulnerability that would open up here is to put contents
of files like .git/config into a repository. This capability would allow
scripts to be introduced without the explicit knowledge of the user. While
I'm sure some of the heavy clean/smudge users might appreciate it, this can
represent a vector for the introduction of hostile code into an environment.
While this enhancement seems like a good idea on the surface, if it goes
forward, it should not be the default and should not be under the control of
the upstream repository. You would need loads of warnings about potential
script hazards at the very least presented to the user, beyond what is
already documented in git. This change would not interoperate with JGit -
not that that is a huge concern here, but heavy Jenkins and other pipeline
users could be significantly impacted.

Just putting my CSIO hat on here. We would need a system-wide setting to
prohibit users from using this capability.

Sincerely,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



