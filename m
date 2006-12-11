X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [ANNOUNCE] CGit v0.1-pre
Date: Mon, 11 Dec 2006 09:33:36 +0100
Message-ID: <8c5c35580612110033y4f6260c9xffeaf4457f4ead21@mail.gmail.com>
References: <8c5c35580612101542n72d300c7o106e53e219670510@mail.gmail.com>
	 <Pine.LNX.4.64.0612101653420.12500@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 08:34:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nMzjfzpTVkIohbnsA7mq/vXRBXM1RWBRb4vpt+tLAGNRvYR3TzWTPtkiZE45aRT0JIvgRcK9HuNxLxO6OQZP0UlFqurP8OcHYBgNk5NbYO7LrbwY/20+Ipyf2fl4XxQLsOTiv9uCrLvrA+upg4B9UiB5lXPFhkRxDQ24w973eyQ=
In-Reply-To: <Pine.LNX.4.64.0612101653420.12500@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33978>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtgbk-0000zD-Cl for gcvg-git@gmane.org; Mon, 11 Dec
 2006 09:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762653AbWLKIdj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 03:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762655AbWLKIdj
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 03:33:39 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:20821 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762653AbWLKIdi (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 03:33:38 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1930082nfa for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 00:33:37 -0800 (PST)
Received: by 10.82.139.17 with SMTP id m17mr444042bud.1165826016515; Mon, 11
 Dec 2006 00:33:36 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Mon, 11 Dec 2006 00:33:36 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/11/06, Linus Torvalds <torvalds@osdl.org> wrote:
> you really want to re-check the existence after you got the lock,
> otherwise you would race with somebody else that got the lock, generated
> the data, and then unlocked (and you got the lock _after_ the data was
> generated, so now you generate it unnecessarily).

Yes, you're right. Thanks for noticing.

But this also applies to the case where the cachefile has expired,
right? In that case, after getting the lock, I have to recheck that
the cachefile is _still_ expired.

Anyway, I must say I find it rather unlikely for these cases to occur
(frequently) in real life. That would seem to imply that the caching
isn't really needed at all.

>
> As a side note: how do you release your caches?
>

Simple timeouts (time()-stat.st_mtime), depending on what kind of page
was requested. If anyone cares about invalid cache content (branch
head moving), relevant cachefiles can be deleted with an update-hook.

-- 
