From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Something is broken in repack
Date: Fri, 7 Dec 2007 22:29:31 -0500
Message-ID: <9e4733910712071929h17a7d88dv37686ec7cd858c63@mail.gmail.com>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	 <alpine.LFD.0.99999.0712072032410.555@xanadu.home>
	 <9e4733910712071804ja0a49e1m1eb209cb942bc36f@mail.gmail.com>
	 <alpine.LFD.0.99999.0712072124160.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 04:29:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0qO2-0006ux-PH
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 04:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbXLHD3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 22:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbXLHD3d
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 22:29:33 -0500
Received: from ro-out-1112.google.com ([72.14.202.182]:48448 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbXLHD3c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 22:29:32 -0500
Received: by ro-out-1112.google.com with SMTP id p4so7414618roc
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 19:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+CeL2JXTsp0JC9pHnKARDAiwgzyQlfHSEE7SzLMAo5A=;
        b=DA6pUUswxXRG3q9/XZNIeonfhmpGVvV7E05Y4shn8SJ1I7jj/yMs/cOGtNx979piOo2XrX7FU8Dung/7e/2ulvGOXsTLfNZECeFT6GwNd99GK+LYW0/4/LZzQF+5ELpmAIIivadlHncAHOmRDF6uhNSjMC7Z/Clj9Wf7SaKZN/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f8RWSkcg2Ou7c5hy9fZiUwXPJlFlW9O67Ro768Y0UZY6w+XbjzV4EoTKW30zBQwXXapJWCbrTrQd2gbT8E7XjCpvV1d86BL3ciB7jaLpd+llcyb4d2orud/cy8zNjAKxF8JQZeVmUDAXv+LHstN1nqymN4TR2VsKDqItdvEmbh0=
Received: by 10.114.125.2 with SMTP id x2mr260110wac.1197084571468;
        Fri, 07 Dec 2007 19:29:31 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Fri, 7 Dec 2007 19:29:31 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712072124160.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67502>

The kernel repo has the same problem but not nearly as bad.

Starting from a default pack
 git repack -a -d -f  --depth=1000 --window=1000
Uses 1GB of physical memory

Now do the command again.
 git repack -a -d -f  --depth=1000 --window=1000
Uses 1.3GB of physical memory

I suspect the gcc repo has much longer revision chains than the kernel
one since the kernel repo is only a few years old. The Mozilla repo
contained revision chains with over 2,000 revisions. Longer revision
chains result in longer delta chains.

So what is allocating the extra memory? Either a function of the
number of entries in the chain, or related to accessing the chain
since a chain with more entries will need to be accessed more times.

I have a 168MB kernel pack now after 15 minutes of four cores at 100%.

Here's another observation, the gcc objects are larger. Kernel has
650K objects in 190MB, gcc has 870K objects in 330MB. Average gcc
object is 30% larger. How should the average kernel developer
interpret this?

-- 
Jon Smirl
jonsmirl@gmail.com
