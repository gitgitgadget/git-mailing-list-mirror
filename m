Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DA461FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 07:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbcF2Hn0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 03:43:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50071 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047AbcF2HnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 03:43:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u5T7hGp4020084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 29 Jun 2016 09:43:16 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5T7hH7E003767;
	Wed, 29 Jun 2016 09:43:17 +0200
From:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:	"Andy Falanga \(afalanga\)" <afalanga@micron.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's happening to the index
References: <57728A17.3010207@micron.com> <vpq60stuyv5.fsf@anie.imag.fr>
	<5772FF0E.6030503@micron.com>
Date:	Wed, 29 Jun 2016 09:43:17 +0200
In-Reply-To: <5772FF0E.6030503@micron.com> (Andy Falanga's message of "Tue, 28
	Jun 2016 22:49:51 +0000")
Message-ID: <vpqoa6kh23u.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Wed, 29 Jun 2016 09:43:16 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u5T7hGp4020084
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check:	1467790999.52612@KJaoLDqNcmnug+i19y7Auw
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"Andy Falanga (afalanga)" <afalanga@micron.com> writes:

> The strange thing now is, after the script exits, I then call "git 
> fetch" in the recipe.  I can see from the output of make that the remote 
> db is fetched.  However, when I call "git show 
> origin/rpm:path/to/rpm_build_num" from the makefile I get the *previous* 
> number.  Yet, as soon as the make process exits, I call "git show 
> origin/rpm:path/to/rpm_build_num" and it shows the correct number!

My bet would be that you are running the commands in two different
repositories. Try running

  pwd && git show origin/rpm:path/to/rpm_build_num

In the Makefile and after make completes, and check that pwd returns the
same thing. Also, to avoid getting the issue you previously had, try

  cd $(pwd) && pwd && git show origin/rpm:path/to/rpm_build_num

too.

> Is there some sort of strange file caching that happening
> when make starts that, although the local db is updated, I don't get
> what I'm after?

Git can keep information either in RAM, hence not shared between git
invocations (so running git within or outside the Makefile wouldn't
matter), or on disk, but then inside or outside the Makefile doesn't
matter either.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
