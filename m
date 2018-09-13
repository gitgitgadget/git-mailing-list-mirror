Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 309191F42B
	for <e@80x24.org>; Thu, 13 Sep 2018 15:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeIMUsi (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 16:48:38 -0400
Received: from elephants.elehost.com ([216.66.27.132]:63065 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbeIMUsi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 16:48:38 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w8DFcSpn048234
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 13 Sep 2018 11:38:29 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Johannes Sixt'" <j6t@kdbg.org>, <git@vger.kernel.org>
References: <003901d44acd$12c2bb90$384832b0$@nexbridge.com>        <4102803b-d5de-5812-4cef-569c9869fed1@kdbg.org>        <004e01d44ada$b4a11ad0$1de35070$@nexbridge.com>        <000001d44ae6$c2a20ac0$47e62040$@nexbridge.com>        <xmqq1s9yjp9j.fsf@gitster-ct.c.googlers.com>        <001101d44b5b$fa337350$ee9a59f0$@nexbridge.com> <xmqqefdxign2.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqefdxign2.fsf@gitster-ct.c.googlers.com>
Subject: RE: [Question] Signature calculation ignoring parts of binary files
Date:   Thu, 13 Sep 2018 11:38:21 -0400
Message-ID: <003a01d44b77$d0b289a0$72179ce0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL1dHr/8n7yCB9UeIXEGLjm31C4owFRfwXbAhcuk1ECJbKk4AITag6rAj4bbawDCIckP6JEwDRA
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 13, 2018 11:03 AM, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> > The scenario is slightly different.
> > 1. Person A gives me a new binary file-1 with fingerprint A1. This
> > goes into git unchanged.
> > 2. Person B gives me binary file-2 with fingerprint B2. This does not
> > go into git yet.
> > 3. We attempt a git diff between the committed file-1 and uncommitted
> > file-2 using a textconv implementation that strips what we don't need to
> compare.
> > 4. If file-1 and file-2 have no difference when textconv is used,
> > file-2 is not added and not committed. It is discarded with impunity,
> > never to be seen again, although we might whine a lot at the user for
> > attempting to put
> > file-2 in - but that's not git's issue.
> 
> You are forgetting that Git is a distributed version control system,
aren't you?
> Person A and B can introduce their "moral equivalent but bytewise
different"
> copies to their repository under the same object name, and you can pull
from
> them--what happens?
> 
> It is fundamental that one object name given to Git identifies one
specific
> byte sequence contained in an object uniquely.  Once you broke that, you
no
> longer have Git.

At that point I have a morally questionable situation, agreed. However, both
are permitted to exist in the underlying tree without conflict in git -
which I do consider a legitimately possible situation that will not break
the application at all - although there is a semantic conflict in the
application (not in git) that requires human decision to resolve. The fact
that both objects can exist in git with different fingerprints is a good
thing because it provides immutable evidence and ownership of someone
bypassing the intent of the application.

So, rather than using textconv, I shall implement this rule in the
application rather than trying to configure git to do it. If two conflicting
objects enter the commit history, the application will have the
responsibility to resolve the semantic/legal conflict.

Thanks,
Randall


