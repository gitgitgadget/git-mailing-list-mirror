Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA1362082E
	for <e@80x24.org>; Sat, 24 Jun 2017 11:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbdFXLnP (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 07:43:15 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:47214 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751305AbdFXLnO (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Jun 2017 07:43:14 -0400
X-AuditID: 12074412-b97ff70000000fed-3f-594e50502191
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id D8.FA.04077.0505E495; Sat, 24 Jun 2017 07:43:13 -0400 (EDT)
Received: from [192.168.69.190] (p54AAE63F.dip0.t-ipconnect.de [84.170.230.63])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5OBh98H020995
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 24 Jun 2017 07:43:10 -0400
Subject: Re: [PATCH v2 22/29] commit_packed_refs(): use a staging file
 separate from the lockfile
To:     Jeff King <peff@peff.net>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
 <d8fa8dec13eb095c0c39ef0de2ee8987d6bf9d77.1498200513.git.mhagger@alum.mit.edu>
 <20170623194610.o2eyte4xmlsscrlz@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <8156514c-f255-5bda-2011-db8f512d6fb9@alum.mit.edu>
Date:   Sat, 24 Jun 2017 13:43:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170623194610.o2eyte4xmlsscrlz@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqBsY4Bdp8PGiqMXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8WSh6+ZLbqnvGW0+NHSw2yxeXM7iwOHx85Zd9k9Fmwq9ehqP8Lm8ax3D6PH
        xUvKHp83yQWwRXHZpKTmZJalFunbJXBltPzrZC2YLFhx9+5ntgbG3bxdjJwcEgImEnP3XmHu
        YuTiEBLYwSSx/+MvZpCEkMB5JonVPUogtrBAssSz3fsYQWwRAVmJ74c3MkI0HGKUmPxyJlg3
        s8BDJomrd1+zglSxCehKLOppZgKxeQXsJfafeMsGYrMIqEqcProPrEZUIELiYecudogaQYmT
        M5+wgNicAi4SF98cA6tnFlCX+DPvEjOELS+x/e0c5gmM/LOQtMxCUjYLSdkCRuZVjHKJOaW5
        urmJmTnFqcm6xcmJeXmpRbpmermZJXqpKaWbGCEhL7SDcf1JuUOMAhyMSjy8Gd6+kUKsiWXF
        lbmHGCU5mJREeWPP+EQK8SXlp1RmJBZnxBeV5qQWA/3OwawkwrvH1y9SiDclsbIqtSgfJiXN
        waIkzvtzsbqfkEB6YklqdmpqQWoRTFaGg0NJgrfcH6hRsCg1PbUiLTOnBCHNxMEJMpwHaLg/
        2PDigsTc4sx0iPwpRkUpcd5GP6CEAEgiozQPrheWkl4xigO9Isy7FWQFDzCdwXW/AhrMBDR4
        xhofkMEliQgpqQZGddu3njZrdvzXkrD9WGM1U4o1puXppFmnrdVyoq76fLF+Hb778XaBL1xS
        1vluK740LH9s6eAXzfsgdtIileMipQxTOgt4nDZ46q++7HwteH668m9rIUaeirf6973exmts
        Prt2jYoYz86XHe8E388JXPif2+7rvQ0dYctYFuXK39o9iSGsMMNdiaU4I9FQi7moOBEAiGxK
        1SQDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/23/2017 09:46 PM, Jeff King wrote:
> On Fri, Jun 23, 2017 at 09:01:40AM +0200, Michael Haggerty wrote:
> 
>> @@ -522,10 +529,16 @@ int lock_packed_refs(struct ref_store *ref_store, int flags)
>>  		timeout_configured = 1;
>>  	}
>>  
>> +	/*
>> +	 * Note that we close the lockfile immediately because we
>> +	 * don't write new content to it, but rather to a separate
>> +	 * tempfile.
>> +	 */
>>  	if (hold_lock_file_for_update_timeout(
>>  			    &refs->lock,
>>  			    refs->path,
>> -			    flags, timeout_value) < 0)
>> +			    flags, timeout_value) < 0 ||
>> +	    close_lock_file(&refs->lock))
>>  		return -1;
> 
> I was wondering whether we'd catch a case which accidentally wrote to
> the lockfile (instead of the new tempfile, but this close() is a good
> safety check).
> 
>> -	if (commit_lock_file(&refs->lock)) {
>> -		strbuf_addf(err, "error overwriting %s: %s",
>> +	if (rename_tempfile(&refs->tempfile, refs->path)) {
>> +		strbuf_addf(err, "error replacing %s: %s",
>>  			    refs->path, strerror(errno));
>>  		goto out;
>>  	}
> 
> So our idea of committing now is the tempfile rename, and then...
> 
>> @@ -617,9 +640,10 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
>>  	goto out;
>>  
>>  error:
>> -	rollback_lock_file(&refs->lock);
>> +	delete_tempfile(&refs->tempfile);
>>  
>>  out:
>> +	rollback_lock_file(&refs->lock);
> 
> We always rollback the lockfile regardless, because committing it would
> overwrite our new content with an empty file. There's no real safety
> against somebody calling commit_lock_file() on it, but it also seems
> like an uncommon error to make.

If this seems too dangerous, we could add a `LOCK_NO_COMMIT` flag for
`hold_lock_file_for_update()` and `hold_lock_file_for_update_timeout()`,
which would die() if somebody tries to commit the associated lockfile. I
think we can live without it. I hope that any such bugs would be caught
immediately by CI. But I admit that the prospect of renaming an empty
file on top of a `packed-refs` file is quite sobering, so if anybody is
worried about this, let me know and I'll implement it.

Michael

