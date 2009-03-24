From: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] git-cget: prints elements of C code in the git repository
Date: Tue, 24 Mar 2009 14:30:28 +0100
Message-ID: <49C8E074.4030808@gmail.com>
References: <49C8B159.2040600@gmail.com> <alpine.DEB.1.00.0903241257430.7493@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 24 14:32:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm6jc-0002dc-FA
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 14:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759192AbZCXNae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 09:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758862AbZCXNae
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 09:30:34 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:61393 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758958AbZCXNac (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 09:30:32 -0400
Received: by ewy9 with SMTP id 9so2070836ewy.37
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 06:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=5OFNrClCvdiHzlFM2PJAE8J/wZ32vfFdFf+L1cu8uYQ=;
        b=HVx7512c+smdPKmB2kZZpFulQXdVLe1BZyaiYNMPaKkVeu1q9Le3JRRt+VcDzXR678
         cb69/HazPxPpPAFZjHHM32IvVBfqHHOuT2Xe742IUfhVuyEyUzG33RU3NbdVoA+POUjq
         jt1hsNm/yQdMizfzRqEe8G0AEElN4rIU+gVOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=oqoacIKhdOaus+Rfx1bTJLG7RP+S4Gz7LyMBu9vy28ys5VOKGq0GNli5xQ+aCb43Ev
         3j93RGGYR7dCE4oSiHKuOKPoXUAbkuyTM1Ic+6J9PnHrjW/uLt06Wjd60WyiA6zIbmgq
         laf4grCCthInXvqY5zSYjjy8bc08GwPmo+5FE=
Received: by 10.216.72.83 with SMTP id s61mr3082054wed.79.1237901428150;
        Tue, 24 Mar 2009 06:30:28 -0700 (PDT)
Received: from ?192.168.1.115? (d133062.upc-d.chello.nl [213.46.133.62])
        by mx.google.com with ESMTPS id 10sm5082968eyd.23.2009.03.24.06.30.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Mar 2009 06:30:27 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <alpine.DEB.1.00.0903241257430.7493@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114457>

Hi Johannes,

thanks for your pointers.

> - the name is not expressive enough,

How about get-def? If it's too long it will become tiresome to type.

> - the commit message is severely lacking (I had to apply it and run it to 
>   find out what problem it tries to solve),

This is probably better:

This script shows where elements of C code are defined in the git-repository.
It is still experimental, although it should work in most cases.

As invoking it with -? will tell:

USAGE: git get-def [OPTION]... PATTERN [FILE]...
print elements of C code with name PATTERN in the git repository,
where PATTERN is an extended regular expression

Options to specify which element(s) should be printed:
        -f      function
        -s      struct
        -d      definition
        -m      macro
        -e      enum
        -u      union

Options to alter the output:
        -b      only print body
        -n      only print file and lineranges

The pattern is required.

If no files are specified it will search the entire repository for
the specified elements with name PATTERN.

If no element is specified, it will search for any of the above
elements and print these when found.

> - it still uses dashed git commands,

Should be fixed in my next version

> - it might be better to put it into contrib/, otherwise it needs 
>   documentation with examples, and tests,

Ok.

> - it misdetects functions: trying
> 
> 	$ ./git-cget -f get_sha1.*
> 
>   shows this, amongst others:
> 
> -- snip --
> // vi sha1_name.c +59
>                 return get_sha1_hex(hex, sha1) == 0;
>         return found;
> }
> 
> static int match_sha(unsigned len, const unsigned char *a, const unsigned 
> char *b)
> {
>         do {
>                 if (*a != *b)
>                         return 0;
>                 a++;
>                 b++;
>                 len -= 2;
>         } while (len > 1);
>         if (len)
>                 if ((*a ^ *b) & 0xf0)
>                         return 0;
>         return 1;
> }
> -- snap --

Yes, it doesn't always work yet, I'll try to fix this in my next version.

> - maybe it would be nicer to integrate this into git grep itself?  Maybe 
>   by allowing multi-line matches and default patterns, or pattern 
>   templates?

I did attempt to program it in C, but I am more comfortable with bash. Also,
what would be more appropriate for this purpose, I think, is a git sed.

However, allowing multi-line matches may be an option, I'll look into it.

> Ciao,
> Dscho

Thanks,

Roel
