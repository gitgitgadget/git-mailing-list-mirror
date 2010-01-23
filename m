From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 01/10] gitweb: Print to explicit filehandle (preparing for caching)
Date: Sat, 23 Jan 2010 01:48:18 +0100
Message-ID: <201001230148.19770.jnareb@gmail.com>
References: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net> <0dd15cb3f18e2a26fc834fd3b071e6d3ecc00557.1264198194.git.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 01:48:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYUAu-0008Jq-Pg
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 01:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322Ab0AWAsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 19:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755008Ab0AWAsX
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 19:48:23 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:15486 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759Ab0AWAsW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 19:48:22 -0500
Received: by fg-out-1718.google.com with SMTP id l26so287673fgb.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 16:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=0Ur0bl2dQLh11m1D805vtm6UiLk3AH31NCy+94gpXao=;
        b=ucQleyshyFv3DX3SigoHkPenonODypTuASmWBEtt4cA+hodt3WvQkOa9tgvJBt/8y8
         adOG/7cp74nTu7ACg1hmoqkePiBIeRDIiO8g0MPoy7e+tCKlQkOC3YBE/H+fwDYYoGN1
         Hcyv6q4UpYQ33HHAlBIyI4RLjlxQApUDSBsdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wyYUknBdet4nfe7W40/f0GrTbWzQD98QCZX/ToW1uPOPAftV5FBN43iK4RIw/13U4W
         wC2rvnwZLoZgXEWTzkXve8MCb839Owr2qusyh4+ke6ntadbCk0mWUzAl9kCPzFXAhHD2
         /hHyrFlNA/LqtStlzndSwSG36RQx1kekcWZ34=
Received: by 10.102.209.26 with SMTP id h26mr1892039mug.48.1264207700739;
        Fri, 22 Jan 2010 16:48:20 -0800 (PST)
Received: from ?192.168.1.13? (abvr137.neoplus.adsl.tpnet.pl [83.8.215.137])
        by mx.google.com with ESMTPS id t10sm11182849muh.44.2010.01.22.16.48.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Jan 2010 16:48:19 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <0dd15cb3f18e2a26fc834fd3b071e6d3ecc00557.1264198194.git.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137807>

As you can (or rather can't ;-)) see this patch didn't made it into list,
because with 119,993 characters in format-patch patch it probably exceeds
a little bit exceeding 100,000 characters message size limit on VGER.

The problem is that it doesn't make sense to send partial patch... well,
perhaps reindent and breaking of exceedingly long lines should be split
into separate patch...

For now you can view the patch via gitweb
  http://repo.or.cz/w/git/jnareb-git.git/commitdiff/0dd15cb3f18e2a26fc834fd3b071e6d3ecc00557
and apply it from
  http://repo.or.cz/w/git/jnareb-git.git/patch/0dd15cb3f18e2a26fc834fd3b071e6d3ecc00557

The comment for this message (for this patch) can be seen below.

-- >8 --
On Sat, 23 Jan 2010, Jakub Narebski wrote:

> This means replacing
> 
>   print <something>;
> by
>   print {$out} <something>;
> 
> and
> 
>   binmode STDOUT, <layer>;
> by
>   binmode $out, <layer>;
> 
> where $out is global variable set to \*STDOUT at the beginning of
> gitweb, but after reading gitweb config.  This way it would be simple
> to e.g. tie output filehandle or use PerlIO layers to simultaneously
> write to standard output and to some specified file (like "tee"
> utility does), or redirect output to a scalar, or a file.
> 
> die_error (re)sets $out to \*STDOUT; we would (probably) want to treat
> errors in a special way, and do not cache them.
> 
> 
> The only other differences are reindent of continued lines (if
> needed), and sometimes word-wrapping lines which this change made too
> long.
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This patch is meant as (straight) replacement for the following patch
> by J.H. (John 'Warthog9' Hawley):
> * [PATCH 8/9] gitweb: Convert output to using indirect file handle
>   Message-ID: <1263432185-21334-9-git-send-email-warthog9@eaglescrag.net>
>   http://permalink.gmane.org/gmane.comp.version-control.git/136915
> 
> Actually this patch precedes (was written before) the patch by J.H.
> 
> This patch was written _before_ comment from Junio that it would be
> better to simply use
>   print $out <something>;
> and do not try to be too clever.
> 
> 
> Differences from patch by J.H.:
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> * Only one output handle, instead of having one output handle for text,
>   (':utf8'), and another output handler for binary files (:raw).  
> 
>   I do assume that I can write to handler with appropriate layer:
>   :utf8/:raw, and then I can simply read from cache file in :raw
>   binmode, as the data is already converted correctly.
> 
> * Shorter name for output handle: $out instead of $output_handler
> 
> * Set output handler to \*STDOUT (default value in declaration of this
>   variable, and also in die_error() subroutine), instead of *STDOUT.
>   This way $out is indirect filehandle, instead of using direct
>   filehandle which is _global_ to current package (see perlopentut(1)).
> 
> * Reindent continuation lines, i.e.
> 
>     print <line1> .
>           <line2>;
> 
>   got replaced (reindented) with
> 
>     print {$out} <line1> .
>                  <line2>;
> 
>   In some places lines were broken into two, when after indent the
>   line got too long.
> 
> * Slightly different replacement for printf

-- 
Jakub Narebski
Poland
