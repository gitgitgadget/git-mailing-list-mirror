From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: CRLF support bugs (was: Re: .gitattributes glob matching broken)
Date: Mon, 3 Nov 2008 19:46:26 +0300
Message-ID: <20081103164626.GG21650@dpotapov.dyndns.org>
References: <83od0yaxzk.fsf@kalahari.s2.org> <20081103090932.GA18424@coredump.intra.peff.net> <83y700alzf.fsf_-_@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Hannu Koivisto <azure@iki.fi>
X-From: git-owner@vger.kernel.org Mon Nov 03 17:47:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx2aq-0001Fq-5U
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 17:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755101AbYKCQql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 11:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754798AbYKCQql
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 11:46:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:39709 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208AbYKCQql (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 11:46:41 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1022403nfc.21
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 08:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=X8Wf2DNB31V7YF2TOpFuSmb/GqtCPzPauI3iP2fkcsk=;
        b=Tk9s7KN2OSDCq7Hzrb9Px3Q4CAcO/ksSwaY4VU6Ds6d2/HWd5Sa89jyF7COy/YQ8aQ
         KRgfn4riDs/BwdPSd14PeLKEV9E1XJTf2Rt/yfsxcHrBN6E5vZFdxULe1luQpNmXrEPB
         nq2N75+el1M4k/JhYLsXHf+bpdUQFFIh5qu7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BE20FLKFLj7X2VV9vndCJc9m8zn9EiDsWc3W+spB4DHtfNGmZEOzmItz88OtyvTQ7/
         q53DYGxxyl7YjvYVRj1orPIYWywf0L3Xc8NXEFWjqR59sVfNmFpf0oJOp7oS1GaKOakS
         NMroHwr5AILs3/ThOtABOMp9/42bWILB24Tdg=
Received: by 10.86.72.15 with SMTP id u15mr308734fga.45.1225730790494;
        Mon, 03 Nov 2008 08:46:30 -0800 (PST)
Received: from localhost (ppp85-141-188-150.pppoe.mtu-net.ru [85.141.188.150])
        by mx.google.com with ESMTPS id d4sm8957842fga.5.2008.11.03.08.46.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Nov 2008 08:46:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <83y700alzf.fsf_-_@kalahari.s2.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 03, 2008 at 05:05:24PM +0200, Hannu Koivisto wrote:
> 
> Actually, even if .gitattributes were applied in checkout, I think
> the whole CRLF support is broken by design because people will have
> to remember to use -n in clone, then enable core.autocrlf support
> and then checkout.  This makes it unneccessarily complicated to
> create "quick local clones" as well.  You might suggest that
> Windows users should enable core.autocrlf globally but it may not
> be the right thing to do for all projects/repositories either.

core.autocrlf was exactly meant to be set globally. Basically,
it says what end-of-line should be on your system. It is strange
to have it different for different repositories.

> 
> I think CRLF conversion support should have some attribute (be it
> .gitattributes attribute or something else) that is somehow
> inherited from the parent repository.  It would basically say that
> "you should use platform's native line end type for text files with
> this repository and its children".

It is already so. All text files are treated accordingly to users
preferences, and for those files where automatic heuristic produces
undesirable result, it can be disabled using .gitattributes. (Alas,
there is a bug with checkout that you encountered earlier).

> To go with that, one would
> maybe have a configuration option to tell what that platform
> default line end type is (just in case someone wants to pretend
> Cygwin is Unix or something like that).

That is exactly what core.autocrlf is about. One user may want to
have LF on Windows and another wants CRLF. So, core.autocrlf defines
how text files should be treated. It is what each user may have in
his/her own ~/.gitconfig.

> 
> I also observed this problem:
> 
> # Pretend someone does this on Unix
> mkdir test1
> cd test1
> git init
> echo "*.c crlf" > .gitattributes
> echo -en "foo\r\nfoo\r\nfoo\r\n" > kala.c

The 'crlf' attribute means that the file should be treated as 'text'
without applying heuristic. The correct ending for text files on Unix
is '\n', not '\r\n'.  So, you put a text file with incorrect ending,
not surprisingly it causes problems for Windows users later.


Dmitry
