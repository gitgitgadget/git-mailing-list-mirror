Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AE9920C11
	for <e@80x24.org>; Wed,  6 Dec 2017 18:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbdLFSZ3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 13:25:29 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:43179 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751598AbdLFSZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 13:25:28 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3ysRqp3TQfz5tlC;
        Wed,  6 Dec 2017 19:25:26 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9436B29D9;
        Wed,  6 Dec 2017 19:25:25 +0100 (CET)
Subject: Re: [PATCH v4 1/4] Makefile: generate Perl header from template file
To:     Dan Jacques <dnj@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes.Schindelin@gmx.de,
        avarab@gmail.com, git@vger.kernel.org
References: <f0ad1ad4-67d8-21e2-fdd0-0a08328c1eaa@kdbg.org>
 <20171205212625.6616-1-dnj@google.com>
 <xmqq7eu0j1th.fsf@gitster.mtv.corp.google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e0a22ee4-9503-760f-293c-be56fa46fa04@kdbg.org>
Date:   Wed, 6 Dec 2017 19:25:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq7eu0j1th.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.12.2017 um 22:35 schrieb Junio C Hamano:
> Dan Jacques <dnj@google.com> writes:
> 
>> Thanks for checking! The patch that you quoted above looks like it's from
>> this "v4" thread; however, the patch that you are diffing against in your
>> latest reply seems like it is from an earlier version.
>>
>> I believe that the $(pathsep) changes in your proposed patch are already
>> present in v4,...
> 
> You're of course right.  The patches I had in my tree are outdated.
> 
> Will replace, even though I won't be merging them to 'pu' while we
> wait for Ævar's perl build procedure update to stabilize.

The updated series works for me now. Nevertheless, I suggest to squash
in the following change to protect against IFS and globbing characters in
$INSTLIBDIR.

diff --git a/Makefile b/Makefile
index 7ac4458f11..08c78a1a63 100644
--- a/Makefile
+++ b/Makefile
@@ -2072,7 +2072,7 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES perl/perl.mak Makefile
 	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
 	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
 	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
-	    -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
+	    -e 's=@@INSTLIBDIR@@='"$$INSTLIBDIR"'=g' \
 	    -e 's=@@GITEXECDIR@@=$(gitexecdir_relative_SQ)=g' \
 	    -e 's=@@PERLLIBDIR@@=$(perllibdir_relative_SQ)=g' \
 	    $< >$@+ && \
