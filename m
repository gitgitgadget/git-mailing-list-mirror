X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sat, 9 Dec 2006 15:52:09 +1300
Message-ID: <46a038f90612081852u63e05da1qe57504636f3578fd@mail.gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
	 <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net>
	 <200612081438.25493.jnareb@gmail.com>
	 <46a038f90612081728s65d65ccewe64fa1a496de76fa@mail.gmail.com>
	 <457A1962.6000401@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 02:52:19 +0000 (UTC)
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Rogan Dawes" <discard@dawes.za.net>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Kernel Org Admin" <ftpadmin@kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Petr Baudis" <pasky@ucw.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XZUhco8O1+E3KpXgytH2kTq9Mwe6dzPKcSErQp7SVLrmmjQbys0UBed89GskvQGe5hJRgO4YIuV5svGzri8cUuPSiRM5hJisQGVeYqQffumZKtZ62sEsUnhXZQwUT1IreBiTXnIcgYFx/rIPwiTADnMmqGDP4Sk5lT6p8wupO0k=
In-Reply-To: <457A1962.6000401@zytor.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33792>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GssJz-0006Xg-HQ for gcvg-git@gmane.org; Sat, 09 Dec
 2006 03:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758466AbWLICwM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 21:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758606AbWLICwM
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 21:52:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:65440 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1758466AbWLICwK (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 21:52:10 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1302967nfa for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 18:52:09 -0800 (PST)
Received: by 10.49.21.8 with SMTP id y8mr1192097nfi.1165632729385; Fri, 08
 Dec 2006 18:52:09 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Fri, 8 Dec 2006 18:52:09 -0800 (PST)
To: "H. Peter Anvin" <hpa@zytor.com>
Sender: git-owner@vger.kernel.org

On 12/9/06, H. Peter Anvin <hpa@zytor.com> wrote:
> Martin Langhoff wrote:
> > On 12/9/06, Jakub Narebski <jnareb@gmail.com> wrote:
> >> Perhaps gitweb should generate it's own ETag instead of messing with
> >> 'expires' header?
> >
> > That'll be the winning solution.
>
> Doesn't solve the thundering herd problem or the timeout problem at all,
> though.

I posted separately about those. And I've been mulling about whether
the thundering herd is really such a big problem that we need to
address it head-on. If we doHTTP  caching headers right (that is, a
bit better than now) then the fact that web caches are distributed
means that even a cache restart or cache invalidation won't trigger a
thundering herd.

And gitweb rarely has a "new" URL that gets a ton of hits immediately.
Our real problem is the summary page, and the fact that we aren't
setting an effecting ETag there. If we do, a front-end cache plus the
ability to revalidate the ETag cheaply will get us through.

We get 99% of the benefit from ETags and cheap revalidations,
specially if they are coupled with a reverse caching proxy,. The
remaining 1% of dealing with the highly infrequent thundering herd can
be addressed with the scheme I've posted 5 minutes ago.

cheers


