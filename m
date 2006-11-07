X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Noel Grandin <noel@peralex.com>
Subject: Re: win2k/cygwin cannot handle even moderately sized packs
Date: Tue, 07 Nov 2006 14:17:41 +0200
Message-ID: <45507965.3010806@peralex.com>
References: <81b0412b0611070302h50541cd5mf0758afe0d6befda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1162901871-30843-4"
NNTP-Posting-Date: Tue, 7 Nov 2006 12:18:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <81b0412b0611070302h50541cd5mf0758afe0d6befda@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang 2.42
X-Synonym: Copied by Synonym (http://www.modulo.ro/synonym) to: mailbackup2@peralex.com, mailbackup2@peralex.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31068>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhPuG-0002Vd-1b for gcvg-git@gmane.org; Tue, 07 Nov
 2006 13:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932490AbWKGMSG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 07:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754224AbWKGMSG
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 07:18:06 -0500
Received: from mail.peralex.com ([196.1.58.220]:15866 "EHLO
 mail.peralex.com") by vger.kernel.org with ESMTP id S1754221AbWKGMSD (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 07:18:03 -0500
Received: from [192.168.1.190] (noel.ct [192.168.1.190]) by mail.peralex.com
 (8.13.8/8.13.8) with ESMTP id kA7CHf92031592; Tue, 7 Nov 2006 14:17:41 +0200
 (SAST) (envelope-from noel@peralex.com)
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1162901871-30843-4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Looking at
http://msdn2.microsoft.com/en-us/library/ms810627.aspx
it looks like
(a) windows provides 2G of address space to play with
(b) VirtualAlloc is constrained to allocating contiguous ranges of
memory within that 2G address space

So the problem is probably memory fragmentation.

You might have more joy if you allocated one HUGE chunk immediately on
startup to use for the pack,
and then kept re-using that chunk.


Alex Riesen wrote:
> For me, it fails even on 332Mb pack:
>
> $ git reset --hard 61bb7fcb
> fatal: packfile .git/objects/pack/pack-ad37...pack cannot be mapped.
>
> Instrumenting the code reveals that it fails on 348876870 bytes.
> Strangely enough, a cygwin program which just reads that pack
> many times without freeing the mem goes up to 1395507480 (1330Mb).
>
> If I replace the malloc (cygwin) with native VirtualAlloc(MEM_COMMIT)
> it reports that "Not enough storage is available to process this
> command",
> which is just ENOMEM, I think.
>
> This is a 2Gb machine, with almost 1.3Gb free, so I'm a bit confused,
> what could here go wrong (besides what already is wrong).
>
> Any ideas?
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


NOTICE: This email, and the contents thereof, 
are subject to the standard Peralex email disclaimer, which may 
be found at: http://www.peralex.com/disclaimer.html

If you cannot access the disclaimer through the URL attached 
 and you wish to receive a copy thereof please send 
 an email to email@peralex.com

