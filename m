Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B54620288
	for <e@80x24.org>; Fri, 21 Jul 2017 19:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754628AbdGUTDJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 15:03:09 -0400
Received: from smtp38.i.mail.ru ([94.100.177.98]:58410 "EHLO smtp38.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754603AbdGUTDI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 15:03:08 -0400
X-Greylist: delayed 4974 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Jul 2017 15:03:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=list.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=1Rnyw0WGIHRf7nEhsOIAE1pY0yxcK2LC+gB5sXQqHBc=;
        b=BvbVQGF8FbTmyqZTvs8eFvVpMUVpA60fwiH0POcqPEsb7r3+4D2vXrmBDnhCn/LItfN0VDKmGqPs3yqOinWVr1qAigFF+SRDxgDVTrL/tRNm8GWOZhE4LlrlOUMO/AfJxE0HWZ+pzeyCyKZFLWR0ZZs47pI/8hMCxtWtH4zpIe0=;
Received: by smtp38.i.mail.ru with esmtpa (envelope-from <stsp@list.ru>)
        id 1dYdCc-0006lA-DM; Fri, 21 Jul 2017 22:03:06 +0300
Subject: Re: git gc seems to break --symbolic-full-name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <234492d7-7fd6-f847-8b85-010732ff43b6@list.ru>
 <xmqqbmodhb5h.fsf@gitster.mtv.corp.google.com>
From:   Stas Sergeev <stsp@list.ru>
Message-ID: <223fa7c7-196d-e4fe-85b5-7d7cc576aa52@list.ru>
Date:   Fri, 21 Jul 2017 22:03:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqbmodhb5h.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
Authentication-Results: smtp38.i.mail.ru; auth=pass smtp.auth=stsp@list.ru smtp.mailfrom=stsp@list.ru
X-7FA49CB5: 0D63561A33F958A5EFC773DD113F6C84687A05CFEE0ED58BDA13F4E33994491C725E5C173C3A84C369456C5265B6C55C94DB734853BBA024BAAD9279A72BC9ABC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0FD319CD858665117E2623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: F1845AB6CCC9920DF7838D61D4D05C42B0ADD4D441C52F7D56CD0E05AFEBF77D46138560D21E87E01653177920737CA72999BEE114A20FF4278B2D54D4112F244F0A872F021F905956A8FB0C6EBA5FCCEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

21.07.2017 21:56, Junio C Hamano пишет:
> Stas Sergeev <stsp@list.ru> writes:
>
>> I do the following:
>>
>> $ git rev-parse --symbolic-full-name devel
>> refs/heads/devel
>> $ ls -l .git/`git rev-parse --symbolic-full-name devel`
>> -rw-rw-r-- 1 stas stas 41 июл 21 15:05 .git/refs/heads/devel
>>
>> This is fine. But after git gc:
>>
>> $ git rev-parse --symbolic-full-name devel
>> refs/heads/devel
>> $ LC_ALL=C ls -l .git/`git rev-parse --symbolic-full-name devel`
>> ls: cannot access '.git/refs/heads/devel': No such file or directory
> This is expected, and in the modern world (like, after year 2007),
> a refname "refs/heads/foo" does *not* mean that there is a file
> with such a path under .git/ directory.  "rev-parse" does not return
> any "path" in the filesystem sense.
>
> See "git pack-refs --help", and depending on what you want to learn
> about the ref in question, perhaps "git show-ref refs/heads/devel"
> is what you want.
I wanted some kind of file to use it as a
build dependency for the files that needs
to be re-built when the head changes.
This works very well besides git gc.
What other method can be used as simply
as that? git show-ref does not seem to be
giving this.
