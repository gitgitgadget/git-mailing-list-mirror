From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 08:59:29 -0700
Message-ID: <7f9d599f0804290859y6a579302m5db9f7f827b320a4@mail.gmail.com>
References: <200804281829.11866.henrikau@orakel.ntnu.no>
	 <20080429124152.GB6160@dpotapov.dyndns.org> <481733A3.4010802@op5.se>
	 <alpine.LFD.1.10.0804291132060.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Dmitry Potapov" <dpotapov@gmail.com>,
	"Henrik Austad" <henrikau@orakel.ntnu.no>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 18:01:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqsFf-0002Sv-Hd
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 18:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755654AbYD2P7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 11:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754392AbYD2P7c
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 11:59:32 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:34441 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbYD2P7b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 11:59:31 -0400
Received: by py-out-1112.google.com with SMTP id u52so104531pyb.10
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=agAC6qHGsoDjSw6AUGvsCa44YUW7yeklY1OtQgpiWFo=;
        b=tObpcrcj3525gB7YynXssprgyLGscdUHUhfg7pek1UvM2E2ipFihSfCi1np6FLS1HoX7YmOP1Di37jRUBfgW7u6JgJEVh3QdKVZ0O2l7a9KH1JPs4y8tdzK1p/tCrM0QaumNBr3qEggCy3hxFWXzIzBvKZoQbYSsOdNrrgMABdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=kru+++WO13w1X5Zwi+ydrUiJ6ZUvzCMibA2rrsf59J7N/JqUSA1rCP7jArzm2146aaSV4UMc57RBJlWloNWV915Ne3C4FR62EUpR/KXkQdMIeASjMaSdMvAIPq644hVGh2ioTcwZt2SiZwUdtEJDxwnhVFpYEqCS8Wmh00iQ6zQ=
Received: by 10.140.172.19 with SMTP id u19mr3727313rve.31.1209484769390;
        Tue, 29 Apr 2008 08:59:29 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Tue, 29 Apr 2008 08:59:29 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0804291132060.23581@xanadu.home>
Content-Disposition: inline
X-Google-Sender-Auth: 758ccceacb7bff34
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80694>

On Tue, Apr 29, 2008 at 8:42 AM, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 29 Apr 2008, Andreas Ericsson wrote:
>
>  > But they won't, because it's impossible to add two objects with the same
>  > SHA1 hash key to a git repository, since it will lazily re-use the
>  > existing one. In practice, this means that in the case of an "innocent"
>  > hash-collision, git will actually break by refusing to store the new
>  > content.
>
>  I'd also like to point out that Git usually receive "untrusted" new
>  objects via the Git protocol through 'git index-pack'.  If you look at
>  sha1_object() in index-pack.c, you'll see that active verification
>  against hash collision is performed, and the fetch will abruptly be
>  aborted if ever that happens.
>
>  Yes, writing a test case for this was tricky.  :-)

Here's the standard scenario for a hash collision attack, with
parties, A, B, and C:

1. C, the malicious one, computes the standard two pdfs with matching
sha1 hashes.
2. C sends the valid pdf to B through a git commit, and B signs it with a tag.
3. C grabs the signature, and then forwards the "signed" commit to A,
but substitutes the invalid pdf with the same hash.

The fact that git will check for hash collisions within one repository
is nice, but it doesn't significantly increase the security of git
against hash collision attacks.

Geoffrey
