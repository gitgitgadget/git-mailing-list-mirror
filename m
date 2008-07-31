From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 16:34:06 +0400
Message-ID: <20080731123406.GG7008@dpotapov.dyndns.org>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com> <20080731105727.GF7008@dpotapov.dyndns.org> <20080731111446.GO32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cte <cestreich@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 31 14:35:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOXND-0006xE-VR
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 14:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbYGaMeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 08:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbYGaMeN
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 08:34:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:63473 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbYGaMeM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 08:34:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so259041fgg.17
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 05:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=KJ+79r3Pl/VHlnjmkKLzpyA11VbZH+Ed8zzvCzno1zE=;
        b=wLcfKm1awjr51DUuDbq5CpjAMH8vutQlaHoErF0H+9q8XIsVfehvuP0COs8/Jewzx7
         sG+g2Qc74rg8tFVYzVx+JNKE6Sln4ludpurcT1GDJ6kHfqCkTadsjjleVUCtN+feP2hd
         yj+d9aB/j18BzdPmlkGBhyl07ru+JiUgy+3as=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LYAsRJZ+dhuCNWEBp7Fuql7d67KJyuzy23apWtNJ7MLwAa4gzNrMV4E3jTKyW3FyRK
         3G/7FQdxmZ0oQaOX64yWXCa6KCCHyTSgdFWOm8B1By6UE+o6TGkOOowAVvu7r+3czi4Q
         0FZ1UlzoGoZWkpvZjzZcvzpesQvWj1siPoq30=
Received: by 10.86.82.16 with SMTP id f16mr6048550fgb.9.1217507650342;
        Thu, 31 Jul 2008 05:34:10 -0700 (PDT)
Received: from localhost ( [85.141.148.53])
        by mx.google.com with ESMTPS id 12sm2785693fgg.0.2008.07.31.05.34.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 31 Jul 2008 05:34:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080731111446.GO32184@machine.or.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90935>

On Thu, Jul 31, 2008 at 01:14:46PM +0200, Petr Baudis wrote:
> 
> I don't think this is that big a problem; there are applications that
> are doing this already, e.g. cgit, and if you tie your application to
> a particular git version by for example making git a submodule of your
> source, this is pretty safe; it will just mean that you will have to
> do some non-trivial porting of your code to the new interface each time
> you update - but I think large changes in the interface are pretty rare
> in practice by now, and there shouldn't be much on the horizon either(?).

What you see as large changes depend on how well you know git internals.
Git develops very quickly and if someone who is trying to use libgit.a
does not follow git development closely, it may happen pretty soon that
even not so big changes will become a huge problem to accomadate them.
As result, the program may stick with an old Git version, and that puts
users of this program in the situation where they cannot use their
favorite frontend with new repositories.

> What would be the reason to disallow C++ users? The costs aren't that
> high, and (modulo, say, extern "C" { }) there should be no C-C++
> compatibility issues, right?

I mean that putting  extern "C" { } around should be sufficient to use
this library in C++. But I see now some current headers contains some
C++ keywords and that causes the problem. So, yes, those headers should
be corrected if they become part of external available API. I am not
sure whether it makes sense to correct them now, but there are only
three places where C++ keywords are used:

diff.h:135:extern int diff_tree_sha1(const unsigned char *old, const
diff.h:137:extern int diff_root_tree_sha1(const unsigned char *new,
object.h:38:extern const char *typename(unsigned int type);

So, the patch should not be large, and it is up to Junio to decide
what to do about it.

Dmitry
