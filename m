From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] gitweb: merge boolean feature subroutines
Date: Sat, 3 Jan 2009 09:13:34 -0800
Message-ID: <20090103171333.GB4205@ftbfs.org>
References: <1230996692-7182-1-git-send-email-kraai@ftbfs.org> <9b18b3110901030818i242d81ccl20ef3f264ec64cad@mail.gmail.com> <20090103164024.GA4205@ftbfs.org> <9b18b3110901030851t47c03d0ay75fc91b1ef2ed44b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 03 18:15:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJA5c-0002LS-At
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 18:15:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759127AbZACRNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 12:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbZACRNp
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 12:13:45 -0500
Received: from neon.ftbfs.org ([83.168.236.214]:57450 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbZACRNo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 12:13:44 -0500
Received: from pool-71-119-193-199.lsanca.dsl-w.verizon.net
	([71.119.193.199] helo=macbookpro.ftbfs.org ident=Debian-exim)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1LJA48-0001Pz-6t; Sat, 03 Jan 2009 09:13:40 -0800
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1LJA46-0007h1-6s; Sat, 03 Jan 2009 09:13:34 -0800
Content-Disposition: inline
In-Reply-To: <9b18b3110901030851t47c03d0ay75fc91b1ef2ed44b@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score-Int: -40
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104475>

On Sat, Jan 03, 2009 at 05:51:50PM +0100, demerphq wrote:
> 2009/1/3 Matt Kraai <kraai@ftbfs.org>:
> > I don't think Perl has *a* false value, but rather has multiple values
> > that are treated as false, such as undef, zero, and the empty string.
> > Personally, I find 0 clearer than the empty string, but that's
> > probably just my C bias sneaking in.
> 
> Yes it definitely does have a false value, PL_sv_no, and a true value,
> PL_sv_yes (although it is much less important).  It is these values
> which are copied to signify true and false in the cases where the
> internals need to, such as for boolean operators that must return
> false, and things like negation and (in)equality checks.
> 
> It is a so called "dual var" SvPVNV, with 0 in the NV (numeric) slot
> and the empty string in the PV (string) slot.
> 
> You can see one example of its behaviour in my previous mail, and can
> see it further here:
> 
> $ perl -MDevel::Peek -e'print Dump(shift @ARGV eq "true")'
> SV = PVNV(0x952eb10) at 0x952b6f0
>   REFCNT = 2147483647
>   FLAGS = (IOK,NOK,POK,READONLY,pIOK,pNOK,pPOK)
>   IV = 0
>   NV = 0
>   PV = 0x952eae8 ""\0
>   CUR = 0
>   LEN = 4
> 
> Compare that to:
> 
> perl -MDevel::Peek -e'print Dump(shift @ARGV eq "true" ? 1 : 0)'
> SV = IV(0x94d8398) at 0x94bd678
>   REFCNT = 1
>   FLAGS = (PADBUSY,PADTMP,IOK,READONLY,pIOK)
>   IV = 0

Wow, I had no idea about this.  Thanks for the information.

It seems like using these values would require obfuscating the code,
though.  :(  They only seem to be exposed directly via XS.

-- 
Matt                                                 http://ftbfs.org/
