Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DB4B202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 15:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752928AbdGLPCh (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 11:02:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751054AbdGLPCg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 11:02:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1E7B61D0F;
        Wed, 12 Jul 2017 15:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com A1E7B61D0F
Authentication-Results: ext-mx10.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx10.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=pbonzini@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com A1E7B61D0F
Received: from [10.36.116.38] (ovpn-116-38.ams2.redhat.com [10.36.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D0F4A6046D;
        Wed, 12 Jul 2017 15:02:34 +0000 (UTC)
Subject: Re: [PATCH 0/3] interpret-trailers: add --where, --if-exists,
 --if-missing
To:     Christian Couder <christian.couder@gmail.com>,
        Paolo Bonzini <bonzini@gnu.org>
Cc:     git <git@vger.kernel.org>
References: <20170712134646.17179-1-bonzini@gnu.org>
 <CAP8UFD0bwb+Zeqn8Xg24J_Z639NiT3Awjzstk6o_L-Q+Wh+c0g@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3be619bd-9018-f328-7cbe-1dd8c93b8d19@redhat.com>
Date:   Wed, 12 Jul 2017 17:02:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD0bwb+Zeqn8Xg24J_Z639NiT3Awjzstk6o_L-Q+Wh+c0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 12 Jul 2017 15:02:35 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07/2017 16:47, Christian Couder wrote:
> On Wed, Jul 12, 2017 at 3:46 PM, Paolo Bonzini <bonzini@gnu.org> wrote:
>>
>> These options are useful to experiment with "git interpret-trailers"
>> without having to tinker with .gitconfig.  It can also be useful in the
>> oddball case where you want a different placement for the trailer.
>>
>> The case that stimulated the creation of the patches was configuring
>>
>>      trailer.signed-off-by.where = end
>>
>> and then wanting "--where before" when a patch author forgets his
>> Signed-off-by and provides it in a separate email.
> 
> Maybe you could have used the following to temporarily override the config:
> 
> git -c trailer.signed-off-by.where=before interpret-trailers ...
> 
> But it could be helpful and more straightforward to provide the
> options you implemented.

That works indeed---and I have now learnt that $GIT_CONFIG_PARAMETERS
makes "git -c" work across my thick layers of aliases!  The main
disadvantage is that it is harder to discover than a command-line option.

Also, I have scripts which pass the --trailer argument is passed
unmodified to "git interpret-trailers", and the command-line argument
avoids the need to parse the trailer to figure out the -c option.  In
particular, in my case the separator is always ":", but in general that
may not be the case.

> I am not sure also if --where should override both "trailer.where" and
> "trailer.<token>.where", or if should just override the former.

I think it should override both, otherwise you have different behavior
depending on whether trailer.<token>.where is defined or not.

Paolo
