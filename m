From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: return correct HTTP status codes
Date: Tue, 17 Jun 2008 16:33:26 +0200
Message-ID: <200806171633.26864.jnareb@gmail.com>
References: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com> <7vy75580p1.fsf@gitster.siamese.dyndns.org> <4857C469.1000401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 16:34:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8cGc-00042V-Ar
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 16:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757900AbYFQOdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 10:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757714AbYFQOdn
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 10:33:43 -0400
Received: from gv-out-0910.google.com ([216.239.58.185]:59637 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757876AbYFQOdm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 10:33:42 -0400
Received: by gv-out-0910.google.com with SMTP id e6so989559gvc.37
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 07:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Flv3Xf3jTijb/tiI0Emn+nTa57NikcS2UwWwHZx3fu4=;
        b=l409Xg2vMVNFRcHZMBZ9X+IJ+ParZ1Oacq0YKbEXd3Td/5BOkGPW3RkJb4RlhEXGnp
         apWYVnpF8AKAjPrfQ0my+UTuGXrfGF/nlMelLCv6QsAD//DZA5VfdWow2mnylrH4LQ/1
         0pR0gIqZPYjPipS0DlOyV8zL4yaKQKhapTGJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZDFp5gQTMD63+GeFYNCRGGDGr4mTHQee4NSU2mnlg5k3SHgcz+qVocweCG6AD7ZO3Z
         LO4a29+7IeLt8ke0Tu6kSDkryn3IDZf5dMOKvTp+TqBbULqNZQwZsi0ZZsLcvDHoKfkr
         YUY/sKR4X0aS0h5iVAH5QGt7BzM6SZDJ5zwVY=
Received: by 10.210.130.14 with SMTP id c14mr7739346ebd.100.1213713215278;
        Tue, 17 Jun 2008 07:33:35 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.204.69])
        by mx.google.com with ESMTPS id c22sm10888351ika.1.2008.06.17.07.33.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 07:33:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4857C469.1000401@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85305>

Lea Wiemann wrote:
> Junio C Hamano wrote:
 
> > [Gitweb's error handling:] isn't it possible for you to unconfuse
> > yourself in a slow path and  figure out exactly why it failed?
> > 
> >         unless (open $fd, '-|', ls-tree $base -- $path) {
> >                 # Oh, an error?  why?
> >                 if (!object_exists($base)) {  [...]
> >                 } elsif (!is_a_treeish($base)) {  [...]

BTW. you can catch such errors on close(), not on open(), my mistake.
On open you can catch only fairly fatal errors (5xx category I think).
 
> That's possible, but the API I'm writing is designed the other way 
> round: First, get the hash & type of $base; if it fails or the type is 
> wrong, die accordingly.  Then pass the hash you got into whatever call 
> to git, and if that fails, you can quite safely assume that something 
> serious went wrong.  (The example above has an additional $path to deal 
> with, but you get the idea.)
> 
> IOW, the strategy is "don't let the git binaries resolve any object 
> names for you", which should make both error handling and caching a lot 
> easier.

But that means checking arguments in the "fast path", which means
additional calls to git commands in the _common_ case, not only in
the case of errors.  I think that even with caching it is not a good
idea.

I'll try to come with example implementation using Error.pm and Git.pm
-- 
Jakub Narebski
Poland
