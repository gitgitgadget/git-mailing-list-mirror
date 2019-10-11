Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 434E91F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 13:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbfJKNOT (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 09:14:19 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:44745 "EHLO
        kylie.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbfJKNOT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 09:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=QYVvRbXn3eQpwUXG2b3Wgmd1Zn7PYhzLQh0rtyOGiH8=; b=WKyPtGGrGJ9d46yfGaJWbf3HaV
        rNZyNVfAraLive3v38F8xuBqZznpGunZc8gUo981GMs/DfKhRUQwME7K7898TDOOnkECcW6719MEe
        vFfzWS7MtLRCQ3groMucPGr7gDnzloBffQDy54gNr+wVNnWCCE8V5CSp0egVJHJgk8rs14f7YeiOZ
        sOoJul8McI37oV86YnwszU/fmuObw9KBpyE57fS2MkJ/GehQutSDiFE1buSIzYft4BjIgx4tU8LDC
        FVA0nGltXhHECUTGJWoOv6Y+EluBbaPcQstNFh8xBDiUUkxUkSztNvjlnjGq0me4Kjpi+LfD9Cdeo
        +6axK1IyqUeVUh2UNKJwWya98E6gujb08Ft2MWTAHbUFLrV7XG2LJr2CD2aCgWxnAiW5V7ZYhz/ww
        IxUHypWEAlQAKgReBL6i2snSqBXA78QvP99j3PXub5OuzxqxlMltEbu6c8vSv4hFKmqEc6xv7uvJZ
        OiQ2eeCiMzZRIuvXHnllkGZ205kjmvvpmS02MYO3gIbsDnbot0sac0q2EcNgjeqNd3J1fWM9ho6xn
        rgyFrBkKHtgqD7ruUDBXmlNUd22nBgQSwjwvlhEloxqOfvEnGjjl/r6SHfYNNx1OvQOcGnDMQbyXq
        K5DF3ISm2D03RncHxfk2R8nxa012CPIGl7XaO5emE=;
From:   Christian Schoenebeck <qemu_oss@crudebyte.com>
To:     Andrew Donnellan <ajd@linux.ibm.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        patchwork@lists.ozlabs.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eric Blake <eblake@redhat.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        git@vger.kernel.org, Ian Kelling <iank@fsf.org>
Subject: Re: [PATCH] parser: Unmangle From: headers that have been mangled for DMARC purposes
Date:   Fri, 11 Oct 2019 15:13:50 +0200
Message-ID: <6574162.ouEm0onZRE@silver>
In-Reply-To: <7c2f16e3-1397-9ced-e334-a52e99b27e9b@linux.ibm.com>
References: <20191010062047.21549-1-ajd@linux.ibm.com> <c942d9ce-d8fe-32ca-bedd-1cdb3837823d@linux.ibm.com> <7c2f16e3-1397-9ced-e334-a52e99b27e9b@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Freitag, 11. Oktober 2019 06:50:14 CEST Andrew Donnellan wrote:
> On 11/10/19 3:36 pm, Andrew Donnellan wrote:
> > It would be nice if Mailman could adopt X-Original-Sender too. As it is,
> 
> (which I have gone ahead and reported as
> https://gitlab.com/mailman/mailman/issues/641)

Not stopping you from doing that, since I still think that it'd be helpful if 
mailman added some kind X-Original-Sender header in case the email has to be 
munged for some reason. Just some notes about status & consensus we had:

1. On GNU lists the default mailman settings are now to prevent munging in 
first place (if possible):
https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg00416.html

2. If any list member has the "nodup" mailman option turned on, mailman would 
still munge emails due to that. Ian (on CC) worked on a patch to override that 
individual user setting automatically if necessary:
https://bugs.launchpad.net/mailman/+bug/1845751

3. On git side it was suggested to add some kind of "always_use_in_body_from" 
option:
https://public-inbox.org/git/20190923222415.GA22495@sigill.intra.peff.net/

Unless that git option exists, this little trick proofed as usable workaround 
for git patch submitters suffering from munging:
https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg00932.html

4. MTA's should also address this DKIM issue more accurately. For instance 
Exim is currently by default filling the "dkim h=..." header with "all header 
names listed in RFC4871 will be used, whether or not each header is present in 
the message":
https://www.exim.org/exim-html-current/doc/html/spec_html/ch-dkim_and_spf.html
That "h=" tag in email's dkim header lists all email headers which were 
included by MTA for signing the message. However IMO MTA's should not list any 
"List-*" header name in "dkim h=..." (at least not if not present in message), 
otherwise mailman is forced to munge any of such messages when adding its 
required List-* headers.

BTW section 5.5. (page 38) of that RFC4871 actually sais these headers "SHOULD 
be included in the signature, if they are present in the message being 
signed".

For now you can override this setting, e.g. by using Exim's 
"dkim_sign_headers" setting and providing your own list of header names, but 
from security point of view that's suboptimal, since admins probably leave 
that untouched for years and new security relevant headers might not be 
included for signing at some point in future. So IMO it would make sense to 
add more fine graded MTA DKIM config options like:
"include these headers for dkim signing only if present in message"
and/or
"use default header names except of these".

By taking these things into account, emails of domains with strict DMARC 
policies are no longer munged on gnu lists.

Best regards,
Christian Schoenebeck


