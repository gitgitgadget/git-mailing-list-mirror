Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84AEB203E2
	for <e@80x24.org>; Fri, 11 Nov 2016 21:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964856AbcKKVYD (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 16:24:03 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:10956 "EHLO bsmtp5.bon.at"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S938558AbcKKVX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 16:23:57 -0500
Received: from bsmtp.bon.at (unknown [192.168.181.107])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 3tFtFc1Dtwz5tmS
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 22:23:48 +0100 (CET)
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tFtDQ1fLDz5tlG;
        Fri, 11 Nov 2016 22:22:46 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 8AC1A146;
        Fri, 11 Nov 2016 22:22:45 +0100 (CET)
Subject: Re: 2.11.0-rc1 will not be tagged for a few days
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com>
 <xmqqoa1n57u4.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1611111711210.3746@virtualbox>
 <4FF1825D-F699-4532-9B53-A673DFF00D8B@gmail.com>
 <89DB812E-EC29-4D12-97EA-6E8FF6F86FE5@gmail.com>
 <C3840B91-58E2-4563-9597-5EE514D97CC1@gmail.com>
 <e0785e35-b43d-37ed-598d-b458daf3c355@kdbg.org>
 <xmqq1syh3fjx.fsf@gitster.mtv.corp.google.com>
 <xmqqr36h209y.fsf@gitster.mtv.corp.google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a90fe336-5b62-4278-64e6-e73cb65a02a8@kdbg.org>
Date:   Fri, 11 Nov 2016 22:22:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqr36h209y.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.11.2016 um 22:07 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> OK, then let's have
>>
>> 	filter_git () {
>> 		rm -f rot13-filter.log &&
>> 		git "$@"
>>                 ...
>>
>> and call that -rc1.
>
> That is, to queue this on top of ls/filter-process and merge it
> down.
>
> -- >8 --
> Subject: t0021: remove debugging cruft
>
> The redirection of the standard error stream to a temporary file is
> a leftover cruft during debugging.  Remove it.
>
> Besides, it is reported by folks on the Windows that the test is
> flaky with this redirection; somebody gets confused and this
> merely-redirected-to file gets marked as delete-pending by git.exe
> and makes it finish with a non-zero exit status when "git checkout"
> finishes.  Windows folks may want to figure that one out, but for
> the purpose of this test, it shouldn't become a show-stopper.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Nicely summarized! Thank you very much!

I've double-checked again that the redirection is really not used by the 
tests. The name does occur in a .gitignore, but I guess that is not 
important for the background filter process. It would be good if Lars 
could confirm this.

> ---
>  t/t0021-conversion.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index cb72fa49de..5ce2535017 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -27,8 +27,7 @@ file_size () {
>
>  filter_git () {
>  	rm -f rot13-filter.log &&
> -	git "$@" 2>git-stderr.log &&
> -	rm -f git-stderr.log
> +	git "$@"
>  }
>
>  # Compare two files and ensure that `clean` and `smudge` respectively are
>

