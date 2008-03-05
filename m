From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] git-clean: correct printing relative path
Date: Thu, 6 Mar 2008 02:41:24 +0300
Message-ID: <20080305234124.GD11519@dpotapov.dyndns.org>
References: <20080305094058.GF4793@artemis.madism.org> <20080305141720.GA11542@dpotapov.dyndns.org> <20080305155359.GA15843@artemis.madism.org> <20080305155943.GB15843@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 00:42:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX3Fs-00077A-BX
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 00:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761244AbYCEXlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 18:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756351AbYCEXlc
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 18:41:32 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:3522 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761244AbYCEXla (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 18:41:30 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2001608fga.17
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 15:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=0DUxM24/w8JPsl/SV7Xhy2THIROd/R06uu9cKASY75I=;
        b=XtXtGQihd6m8wNqhDVKQNLszgQbCAqNpgYuls0Kgv88A3uMHHNUsxKrKcGKiuH4urMbtQs3NCaeT37EoEU9mOsls2UPX4VNs7S3gD7dzlapQJ6NBvDysL425gDct/6YN2Y9tijM5deBjyzKiO8h8tvHEvWZd+EHWGAuxJZlrgAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=fV4C+xsX2mzdoQwRO9dCy2j9bwzaXGJkAecMad2gl4+w8qmA9iIDYf1eohlINtVWopWwVEInWOMeXo4kom2Aut9p15X4cybK397+fFFyG9qnjEsH8Mu/J9JyYXEaxujd02lc5Nvp8ICg/tCOD7CZQS6kksmwNDZdjzdUD6qDDXc=
Received: by 10.86.59.2 with SMTP id h2mr3742579fga.19.1204760489283;
        Wed, 05 Mar 2008 15:41:29 -0800 (PST)
Received: from localhost ( [85.141.189.14])
        by mx.google.com with ESMTPS id 31sm2740710fkt.14.2008.03.05.15.41.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Mar 2008 15:41:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080305155943.GB15843@artemis.madism.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76293>

On Wed, Mar 05, 2008 at 04:59:43PM +0100, Pierre Habouzit wrote:
> 
>   And as far as it goes for your patch, it misses a #include
> "wt-status.h" 

My bad... I will correct and resend the patch now.

> and for me it gives:
> 
>     git clean ..
>     Removing ../
>     Removing ../git-clean.patch
>     Removing ../stFdw8KY
> 
> For a tree that had those unclean entries.
>     ../git-clean.patch
>     ../stFdw8KY
> 
> 
>   Removing ../ is clearly wrong both times: it didn't really did that
> (my current dir was the 't/' dir in the git repository for that) and I
> didn't specified 'git clean -d'.

Hmm... when I ran 'git clean' inside of the 't/' directory in the git
repository, it did not print any message about removing ../. However,
when I did the same in a clean repository where the 't/' directory
contained only untracked files then the 't/' directory and all files
in it were actually removed even I did not specify '-d'. This happens on
both 1.5.4 and master versions. IMHO, removing a directory without '-d'
is incorrect.

In addition, when I ran 'git clean -n ..' at the top a repository, the
current master version of Git though printed the error that '..' is
outside the repository, still exited with 0. When I test this with
1.5.4, git clean exists with 128 after printing the error. Bisect blames
d089ebaad5315325d67db30176df1bbd7754fda9 for changing the exit code to 0.

I will look at git-clean more tomorrow.

Dmitry
