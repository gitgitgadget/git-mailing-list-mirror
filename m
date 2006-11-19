X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sun, 19 Nov 2006 01:28:50 +0100
Message-ID: <e5bfff550611181628o41e11652ycd17ddad5dd21225@mail.gmail.com>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com>
	 <7vmz6oeh2k.fsf@assigned-by-dhcp.cox.net>
	 <20061118184345.GO7201@pasky.or.cz>
	 <e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com>
	 <7vac2oefuz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 19 Nov 2006 00:29:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VbU8DG12N1TdgVBYxo3lhVgSV8AIzidq580SmG24hdarxfEwLdjDRdbYVUOobq/IA5kpggIhlQybeU1yRAQlFB8WybUtCoNEkXyFWGpG/9f+8Kvx3qBr1EomDlROgnR4hy+nKfDol/7jiMKzsbR75GYLPjF0f/I9x0IQXDKDRls=
In-Reply-To: <7vac2oefuz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31815>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlaYO-0004gw-FU for gcvg-git@gmane.org; Sun, 19 Nov
 2006 01:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755440AbWKSA2v (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 19:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755445AbWKSA2v
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 19:28:51 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:21463 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1755440AbWKSA2v
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 19:28:51 -0500
Received: by py-out-1112.google.com with SMTP id a29so700686pyi for
 <git@vger.kernel.org>; Sat, 18 Nov 2006 16:28:50 -0800 (PST)
Received: by 10.35.100.6 with SMTP id c6mr5377763pym.1163896130056; Sat, 18
 Nov 2006 16:28:50 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Sat, 18 Nov 2006 16:28:49 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

>
> A quick one that is to the point to solve "your" problem.
>
>         show-ref -d
>

I was out for dinner, just come back home.

Some quick tests with show-ref -d instead of peek-remote:

- git tree 2374ms
- linux tree 2225ms

Not a big change. I reboot before each test to have a guaranteed cold cache.

Tested also with show-ref only, not useful to me, but just as a comparison.

- git tree 1420ms
- linux tree 1021ms

Better, but still slower then what I would expected.

In both case CPU load is low, processes are heavily I/O bound, so
avoiding some fork does not save the day.

Please, tell me if you want me to run some kind of additional test.

> I wonder how fast update-server-info is under the same condition
> with your earlier timing.
>
> I am not suggesting you to use update-server-info.  The reason I
> am wondering about it are:
>
>  (1) traditionally, "peek-remote ." has been the only way to get
>      to that information, so you have every right to keep doing
>      so;
>
>  (2) however, even with presense of packed-refs, upload-pack
>      that is invoked by peek-remote needs to consult unpacked
>      refs first and then fall back to packed-refs, and only
>      using the ^{} information "cached" in packed-refs file and
>      computing ^{} itself when dealing with unpacked refs means
>      more code, which we need to assess the pros-and-cons.
>
>  (3) another inefficiency of using "peek-remote ." is that it
>      spawns another process in the "remote" repo and talks with
>      it.
>
> So storing this information making upload-pack to reuse it when
> it can might make things go faster for other applications but
> first I wanted to know how much overhead is incurred in the
> extra upload-pack process, and time update-server-info needs to
> prepare the info in .git/info/refs would be a way to get a rough
> estimate for that (you subtract that from "peek-remote ." time).
>

It's to late to understand this part of your e-mail ;-) I will read
better tomorrow.

Thanks
