From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] diff: funcname and word patterns for perl
Date: Mon, 27 Dec 2010 00:14:09 +0100
Message-ID: <201012270014.09962.jnareb@gmail.com>
References: <20101222234843.7998.87068.stgit@localhost.localdomain> <201012252314.22541.jnareb@gmail.com> <20101226090731.GA21588@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 27 00:18:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWzqy-0002Ur-Ld
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 00:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753Ab0LZXOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Dec 2010 18:14:20 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56799 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab0LZXOT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 18:14:19 -0500
Received: by bwz15 with SMTP id 15so9235366bwz.19
        for <git@vger.kernel.org>; Sun, 26 Dec 2010 15:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ExTIMnhlJOxJl33HFSahHMgAPiqppI/VS4WArMfiQgI=;
        b=MRQcHq7PyEL0oJZkrVPdNzphqx7sd4Lzsbw2qpVArUvTRq1+Xsl67zXqm23CA07cb5
         7dGdkXPo0LnGO+03MKSKu7jR/RPMkEBYWa0A466j+le5Fp9diVfB4elgWhqyAkEJn8QZ
         UBC0lnYFHgppXsMd+PCwCGfbOEAAuPh+gg+Qg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vhWjCdqxzx3dM/F1f0edq0en77jSckpeQee9jH2NoDxA3Qb6EmSmsKH9AV3T39Fqg8
         157aPN7JGObQOwK8jRhmvhcyYwffYXKNz3AarfdiFDQnLSG+3/4VL3hS91eqoWTBfM75
         u2gTm6Fyosx8V52WKKRl35/jB7Z3Oj6iLeZSw=
Received: by 10.204.126.138 with SMTP id c10mr9981178bks.156.1293405258065;
        Sun, 26 Dec 2010 15:14:18 -0800 (PST)
Received: from [192.168.1.13] (abwr69.neoplus.adsl.tpnet.pl [83.8.241.69])
        by mx.google.com with ESMTPS id j11sm7265036bka.0.2010.12.26.15.14.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Dec 2010 15:14:16 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20101226090731.GA21588@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164205>

On Sun, 26 Dec 2010 10:07, Jonathan Nieder wrote:
> The default function name discovery already works quite well for Perl
> code... with the exception of here-documents (or rather their ending).
> 
>  sub foo {
> 	print <<END
>  here-document
>  END
> 	return 1;
>  }
> 
> The default funcname pattern treats the unindented END line as a
> function declaration and puts it in the @@ line of diff and "grep
> --show-function" output.
> 
> With a little knowledge of perl syntax, we can do better.  You can
> try it out by adding "*.perl diff=perl" to the gitattributes file.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Jakub Narebski wrote:
> 
> > BTW. do you know how such perl support should look like?
> 
> Maybe something like this?

Thanks a lot.


Besides here-doc, there are some tricky things that such code should
be aware about.

1. BEGIN {
   	...
   }

   and similar code blocks (END, CHECK, INIT, ...) which I think should
   be marked as 'BEGIN' in diff chunk.

2. sub foo {
    FOO: while (1) {
   		...
   	}
   }

   which should be marked with 'sub foo {', I think

3. =head1 NAME

   Git - Perl interface to the Git version control system

   =cut

   i.e. POD... which I don't know what to do about.


I have not checked what your code does wrt those.

-- 
Jakub Narebski
Poland
