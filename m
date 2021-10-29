Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CBBC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DFBD60E8C
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhJ2VNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:13:32 -0400
Received: from elephants.elehost.com ([216.66.27.132]:48415 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhJ2VNb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:13:31 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 19TLAosU074877
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Oct 2021 17:10:50 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <rsbecker@nexbridge.com>, "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <012301d7cd01$90428960$b0c79c20$@nexbridge.com> <xmqqsfwjk1s3.fsf@gitster.g> <013501d7cd06$8c8281e0$a58785a0$@nexbridge.com>
In-Reply-To: <013501d7cd06$8c8281e0$a58785a0$@nexbridge.com>
Subject: RE: [Bug] wrapper.c uses unportable unsetenv
Date:   Fri, 29 Oct 2021 17:10:44 -0400
Organization: Nexbridge Inc.
Message-ID: <013a01d7cd09$72d91cb0$588b5610$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJKjg/2nH6CxKxEU8WUbwNfWnFG+wGTjv0AAhx0Mhmq53Xb4A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 29, 2021 4:50 PM, I wrote:
> To: 'Junio C Hamano' <gitster@pobox.com>
> Cc: git@vger.kernel.org
> Subject: RE: [Bug] wrapper.c uses unportable unsetenv
> 
> On October 29, 2021 4:35 PM, Junio C Hamano:
> > <rsbecker@nexbridge.com> writes:
> >
<snip>
> > There are compat/setenv.c and compat/unsetenv.c to be used when
> > NO_SETENV and NO_UNSETENV are defined.  Is that how you built your Git
> > earlier since 2007, perhaps?
> 
> We have defined NO_SETENV and NO_UNSETENV since I have been maintaining
> it, so I don't get how we are getting into this situation. I was planning
on
> removing NO_SETENV when the OS caught up for that on our minimum support
> builds next year. NO_UNSETENV needs to stick around for bit longer. The
> setenv() code is actually fine. It is unsetenv() that is causing problems.
> Should not git-compat-util.h be included in wrapper.c so that we reference
> gitunsetenv?

The actual issue is this:

        if (!unsetenv(name))
            ^
"/home/ituglib/randall/git/wrapper.c", line 156: error(134):  expression
must have arithmetic or pointer type

This is with NO_UNSETENV = YesPlease. It makes no sense to me why this isn't
compiling.

