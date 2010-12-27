From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] diff: funcname and word patterns for perl
Date: Mon, 27 Dec 2010 23:44:41 +0100
Message-ID: <201012272344.42657.jnareb@gmail.com>
References: <20101222234843.7998.87068.stgit@localhost.localdomain> <201012270014.09962.jnareb@gmail.com> <7vmxnrxhgm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 27 23:45:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXLoK-0002RR-7k
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 23:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068Ab0L0Woy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Dec 2010 17:44:54 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60453 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab0L0Woy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Dec 2010 17:44:54 -0500
Received: by fxm20 with SMTP id 20so9404319fxm.19
        for <git@vger.kernel.org>; Mon, 27 Dec 2010 14:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=7jR0Rjyo4duVdgDBt7W/AFvXbgE5K1K9of7VQAdLCHI=;
        b=qvC02oaqSuU4xVhCrdUu6NysFNd3ocpEC7DRaQ3Cou4asaHyp3cgIdRbW65Wqiv8RD
         mJZdFi0yR6AoiscQCH2hrV67wX+yCxezP4gVPQiFvhwOzsFxdt/aQPZ+EWTGlXOGWukN
         ydVQ9KkapXR+hIWnauMWBfnNsvZXDE+MDlcAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QlmdgG/kI63vM2YHV+lgaXIcZuaOF/a6UpHN7sSwz3ZZT1g0gvZ7v2l+iFkWAu+b0N
         2hgQeno9uQ1zR54D6T5T20WyU+/ctDA2JNZOv+6Odws56DyFRo0sL0y3qrQQelhF0P4w
         mHcqrnzz9akLImMJjMRJvZCOCySkeDTzx/B8E=
Received: by 10.103.165.3 with SMTP id s3mr1259143muo.24.1293489892755;
        Mon, 27 Dec 2010 14:44:52 -0800 (PST)
Received: from [192.168.1.13] (abwm110.neoplus.adsl.tpnet.pl [83.8.236.110])
        by mx.google.com with ESMTPS id l3sm2065825fan.2.2010.12.27.14.44.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Dec 2010 14:44:49 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vmxnrxhgm.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164229>

On Mon, 27 Dec 2010, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > 2. sub foo {
> >     FOO: while (1) {
> >    		...
> >    	}
> >    }
> >
> >    which should be marked with 'sub foo {', I think
> 
> I do not think Jonathan's patterns would be fooled by this; it wants to
> catch only "package <anything>;" and "sub <anything> {".

All right.

> Jonathan's pattern set allows them to be indented, and followed by some
> garbage at the end., which we might want to tighten.  How many people
> start 'package' and the outermost 'sub' indented?
> 
>  userdiff.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/userdiff.c b/userdiff.c
> index fc2afe3..79569c4 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -62,8 +62,10 @@ PATTERNS("pascal",
>  	 "|<>|<=|>=|:=|\\.\\."
>  	 "|[^[:space:]]|[\x80-\xff]+"),
>  PATTERNS("perl",
> -	 "^[ \t]*package .*;\n"
> -	 "^[ \t]*sub .* \\{",
> +	 "^package .*;\n"

Note that in future Perl 5.14 there would be 'package NAME {' form,
so perhaps it would be better to future-proof and use

  +	 "^package .*[;{]\n"

> +	 "^sub .* \\{\n"

Using "sub foo {" is just a recommended programming convention (like e.g.
GNU convention or K&R convention for C code).  I think it would be better
to relax it a bit, either

  +	 "^sub "

or

  +	 "^sub .*( \\{)?\n"

> +	 "^[A-Z]+ \\{\n"	/* BEGIN, END, ... */

We won't list possible block here?

> +	 "^=head[0-9] ",	/* POD */
>  	 /* -- */
>  	 "[[:alpha:]_'][[:alnum:]_']*"
>  	 "|0[xb]?[0-9a-fA-F_]*"

-- 
Jakub Narebski
Poland
