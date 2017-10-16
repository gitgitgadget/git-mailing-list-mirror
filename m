Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C51020455
	for <e@80x24.org>; Mon, 16 Oct 2017 05:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbdJPF6I (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 01:58:08 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:1229 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751046AbdJPF6H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 01:58:07 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp8.bon.at (Postfix) with ESMTPSA id 3yFng21R6rz5tlH;
        Mon, 16 Oct 2017 07:58:06 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 41020306;
        Mon, 16 Oct 2017 07:58:05 +0200 (CEST)
Subject: Re: Does Git build things during 'make install"?
To:     noloader@gmail.com
References: <CAH8yC8kx9Td51=UFvLwLAQFPKxUXg0D6KKqWR+JX+-wmTAKYRQ@mail.gmail.com>
Cc:     Git List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <0ec353db-428c-bb6f-03fe-303487fde197@kdbg.org>
Date:   Mon, 16 Oct 2017 07:58:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAH8yC8kx9Td51=UFvLwLAQFPKxUXg0D6KKqWR+JX+-wmTAKYRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.10.2017 um 07:05 schrieb Jeffrey Walton:
> My script to build Git dies during cleanup. Cleanup removes the
> downloaded tarball and the unpacked directory:
> 
> ********** Cleanup **********
> 
> rm: cannot remove 'git-2.14.2/perl/blib/lib/.exists': Permission denied
> rm: cannot remove 'git-2.14.2/perl/blib/lib/Git/SVN/Fetcher.pm':
> Permission denied
> rm: cannot remove 'git-2.14.2/perl/blib/lib/Git/SVN/Utils.pm': Permission denied
> rm: cannot remove 'git-2.14.2/perl/blib/lib/Git/SVN/Ra.pm': Permission denied
> rm: cannot remove 'git-2.14.2/perl/blib/lib/Git/SVN/GlobSpec.pm':
> Permission denied
> ...
> 
> When I look at the permissions:
> 
> $ ls -Al git-2.14.2/perl/blib/lib/.exists
> -rw-r--r--   1 root     root           0 Oct 16 00:43
> git-2.14.2/perl/blib/lib/.exists
> 
> The only place in my script that does anything with privileges is
> 'make install' because it runs with sudo.
> 
> Is Git building things in the install recipe? If so, then I don't
> believe that's supposed to happen. According to the GNU coding
> standards, Git should not be doing that. Cf;
> https://www.gnu.org/prep/standards/html_node/Standard-Targets.html.

Yes, running "sudo make install" is a nightmare. sudo clears the path, 
and the git command is not found by the make invoked with root 
permissions. This changes the version string that gets compiled into the 
executable, which finally triggers a complete rebuild under root. Sad...

-- Hannes
