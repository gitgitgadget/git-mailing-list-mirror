From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: First cut at git port to Cygwin
Date: Fri, 07 Oct 2005 17:29:16 -0400
Organization: Network Appliance, Inc.
Message-ID: <4346E8AC.5030503@citi.umich.edu>
References: <81b0412b0510050424h21fc06bav7677911f52b38426@mail.gmail.com> <81b0412b0510050846l2258775co117bada2d2b5a1ad@mail.gmail.com> <20051005155457.GA30303@trixie.casa.cgf.cx> <20051005191741.GA25493@steel.home> <20051005202947.GA6184@trixie.casa.cgf.cx> <81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com> <81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com> <81b0412b0510070544v3e7cf0b4n521db8ff7e4e335a@mail.gmail.com> <Pine.LNX.4.64.0510070828270.31407@g5.osdl.org> <20051007205450.GA14827@steel.home> <20051007212250.GA1423@steel.home>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060702040806070308000408"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Christopher Faylor <me@cgf.cx>,
	"H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 23:30:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENzmK-0005yY-P5
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 23:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbVJGV3S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 17:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbVJGV3S
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 17:29:18 -0400
Received: from citi.umich.edu ([141.211.133.111]:63867 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932646AbVJGV3R (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2005 17:29:17 -0400
Received: from [141.211.133.33] (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id F3F951BB94;
	Fri,  7 Oct 2005 17:29:16 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1 (X11/20050719)
X-Accept-Language: en-us, en
To: Alex Riesen <fork0@users.sourceforge.net>
In-Reply-To: <20051007212250.GA1423@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9817>

This is a multi-part message in MIME format.
--------------060702040806070308000408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alex Riesen wrote:
> Make read_cache copy the index into memory, to improve portability on
> other OS's which have mmap too, tend to use it less commonly.
> 
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> 
> diff --git a/read-cache.c b/read-cache.c
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -497,9 +497,12 @@ int read_cache(void)
>  	offset = sizeof(*hdr);
>  	for (i = 0; i < active_nr; i++) {
>  		struct cache_entry *ce = map + offset;
> -		offset = offset + ce_size(ce);
> -		active_cache[i] = ce;
> +		size_t size = ce_size(ce);
> +		struct cache_entry *newce = malloc(size);
> +		offset = offset + size;
> +		active_cache[i] = memcpy(newce, ce, size);
>  	}
> +	munmap(map, size);
>  	return active_nr;
>  
>  unmap:

s/malloc/xmalloc/

--------------060702040806070308000408
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Linux NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763 4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668 1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------060702040806070308000408--
