From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 3/3] help: respect aliases
Date: Tue, 26 Feb 2008 15:31:11 -0500
Message-ID: <76718490802261231j61e66f91r473401e42816cceb@mail.gmail.com>
References: <cover.1203890846.git.peff@peff.net>
	 <20080224221737.GD31309@coredump.intra.peff.net>
	 <76718490802241810m5f473156nc350eea07016e8f9@mail.gmail.com>
	 <alpine.LSU.1.00.0802261222570.17164@racer.site>
	 <7vve4b4gqu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jeff King" <peff@peff.net>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 21:32:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU6Sz-00071K-9l
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 21:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763727AbYBZUbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 15:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763665AbYBZUbQ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 15:31:16 -0500
Received: from el-out-1112.google.com ([209.85.162.178]:65324 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763579AbYBZUbN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 15:31:13 -0500
Received: by el-out-1112.google.com with SMTP id v27so2031825ele.23
        for <git@vger.kernel.org>; Tue, 26 Feb 2008 12:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=bUth6AuaqxUy+WmcpDGTvkpKL3RbhToWWBpGxUUdrZI=;
        b=oYfrtugJV3cAaUYqy8tD+C56JFpFZpcDehHjWKnzx+JCxOWe3nECCKwCpO0fAxXzPn2oBf4PCJ9o7NjYj3inBTYz4dlaNbGpWzeR/zKc/wbLpxFQIksSWC+IcBBjic8L8p7x8EMEduRqfqu5U9ZxH/fZSzKcYXC76ZgZ2LrTo5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OUbMPH8Vf4ZJPzADziI1FRidpwnqXgOtlkI4yrvPq4bk7aRau86o1o48rCvrRQWukiVxhM6VreOz7+rNybSA6k7SpNvzNnYgQFc4F5HLfG8vsUfub2YxAkCIFN3LnIEStKS6dJnot9MlkQi3o+GD+8cv+idajX3gkYfhzgvEboM=
Received: by 10.114.76.1 with SMTP id y1mr6125611waa.38.1204057871444;
        Tue, 26 Feb 2008 12:31:11 -0800 (PST)
Received: by 10.114.13.5 with HTTP; Tue, 26 Feb 2008 12:31:11 -0800 (PST)
In-Reply-To: <7vve4b4gqu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75169>

On Tue, Feb 26, 2008 at 3:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>  Sure.  The combination of expand, sed, and gnused hurts my eyes
>  ;-)
>
>  One good lesson to take home is that by ending your lines with
>  '|', you can tell the shell that you are not done with the
>  pipeline you are forming yet.

The backslashes aren't there for the shell, they are there for the git
config parser. Anyway, I reworked it a bit:

alias = "! sh -c 'case $# in \
               0) git config --get-regexp \"^alias\\.\" \
                  | sort | sed \"s/^alias\\.//; s/=/ /\" \
                  | while read n v; do \
                     printf \"%-16s\" \"$n\"; \
                     echo \"$v\" | fmt -sw 63 | sed \"2,$ s/^/\t\t/\" ;\
                  done ;; \
               1) git config \"alias.$1\" | fmt -sw 78 ;; esac' -"

And yes, it's still ugly.

Always happy to have folks help me bikeshed my git config. :-)

j.
