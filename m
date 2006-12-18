X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-parse-remote: fix ambiguous shell bug in expand_refs_wildcard
Date: Mon, 18 Dec 2006 17:45:05 -0500
Message-ID: <20061218224505.GB13034@coredump.intra.peff.net>
References: <20061218080941.GA3857@coredump.intra.peff.net> <7v4prtx9hu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 22:45:47 +0000 (UTC)
Cc: Herbert Xu <herbert@gondor.apana.org.au>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v4prtx9hu.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34751>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwREj-0002eC-QC for gcvg-git@gmane.org; Mon, 18 Dec
 2006 23:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754718AbWLRWpK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 17:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754721AbWLRWpK
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 17:45:10 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:38052
 "HELO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id
 S1754718AbWLRWpI (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 17:45:08 -0500
Received: (qmail 14323 invoked from network); 18 Dec 2006 17:45:06 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 18 Dec 2006 17:45:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Dec
 2006 17:45:05 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Mon, Dec 18, 2006 at 11:57:33AM -0800, Junio C Hamano wrote:

> Sounds like a dash bug, if my reading of 2.6.2 Parameter
> Expansion is correct:
> 
>     http://www.opengroup.org/onlinepubs/000095399/utilities/xcu_chap02.html

Interestingly, this works in dash:

$ foo=bar}
$ echo ${foo%'}'}
bar

but doing it inside an interpolated string doesn't:

$ foo=bar}
$ echo "${foo%'}'}"
bar}'}

> This would be another way to work it around.  Both dash and bash
> say 'foo':
> 
>         $ suf='^{}'
>         $ name='foo^{}'
>         $ echo "${name%$suf}"
>         foo
> 
> I think this might be easier to read than using "^{\}".

That seems reasonable to me.

