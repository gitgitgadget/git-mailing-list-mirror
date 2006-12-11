X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [ANNOUNCE] CGit v0.1-pre
Date: Mon, 11 Dec 2006 19:38:57 +0100
Message-ID: <8c5c35580612111038u480b1f95xdb7cf1b3b8fd97b@mail.gmail.com>
References: <8c5c35580612101542n72d300c7o106e53e219670510@mail.gmail.com>
	 <Pine.LNX.4.64.0612101653420.12500@woody.osdl.org>
	 <8c5c35580612110033y4f6260c9xffeaf4457f4ead21@mail.gmail.com>
	 <Pine.LNX.4.64.0612110859200.12500@woody.osdl.org>
	 <8c5c35580612110940p767fd360p52762a8818fbc8c1@mail.gmail.com>
	 <Pine.LNX.4.64.0612111016220.12500@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 18:39:08 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WddThRe/d04GUSGL3LyAInoVniBt6QQipcirPdxb27CJ5NY4RQpjRFfIb60bW1ZUcOvZcxCm4Kn8SvI0UKcA+n9lyB7SlFFftlrc+Qbxu2Zl1Dx05HBAA8KS3iVL3xMeppi5lHxkntS1B7TLvjtFLfpH/dFOXYLoebJnNl/qXTQ=
In-Reply-To: <Pine.LNX.4.64.0612111016220.12500@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34026>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtq3L-0000u6-4E for gcvg-git@gmane.org; Mon, 11 Dec
 2006 19:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937464AbWLKSjA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 13:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763011AbWLKSjA
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 13:39:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:26873 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1763007AbWLKSi6 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 13:38:58 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2071890nfa for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 10:38:57 -0800 (PST)
Received: by 10.82.113.6 with SMTP id l6mr481361buc.1165862337070; Mon, 11
 Dec 2006 10:38:57 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Mon, 11 Dec 2006 10:38:57 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/11/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Mon, 11 Dec 2006, Lars Hjemli wrote:
> >
> > Ok. Code speeks louder than words, so I'll blatantly paste the key functions:
>
> Yeah, they're still buggy:
>
> > int cache_unlock(struct cacheitem *item)
> > {
> >       close(item->fd);
> >       return (rename(fmt("%s.lock", item->name), item->name) == 0);
> > }
> ...
> >       if (!cache_exist(item)) {
> >               if (!cache_lock(item)) {
> >                       sleep(1);
> >                       goto top;
> >               }
> >               if (!cache_exist(item))
> >                       cgit_fill_cache(item);
> >               cache_unlock(item);
>
> What do you think happens if that last "cache_exist()" returned true?
>
> That's right: the "cache_unlock()" will now OVERWRITE the valid cache with
> the (empty) lock-file that you didn't fill in.
>
> Oops.
>

Wow, that's embarrassing.

Thanks for the debugging, I'll try to actually fix it this time :-)

-- 
