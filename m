From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: git branch performance problem?
Date: Wed, 10 Oct 2007 23:34:49 +0200
Message-ID: <8c5c35580710101434n3a4f77edm50d205d53fbc9200@mail.gmail.com>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com>
	 <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com>
	 <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com>
	 <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Wed Oct 10 23:35:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfjCl-0001Kt-Su
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 23:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756093AbXJJVev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 17:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755466AbXJJVev
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 17:34:51 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:59092 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755606AbXJJVeu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 17:34:50 -0400
Received: by nz-out-0506.google.com with SMTP id s18so272334nze
        for <git@vger.kernel.org>; Wed, 10 Oct 2007 14:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2Gywj1tzn3LULxnf9pePOTzeFqVjhHinrD1dBN0NxtQ=;
        b=cvp+TZxyVNgj01yYEnoSuUGWBwSIHK85PiUbmlliwXrLubi4sW8JqUVVfgeuSp5jkJpFoOsqbsnDUZ7YjIxKBSEXGxGRynT0NzijOHmT9wySkrv1gYEWzv3qKPGVYiJWsLXMEQiQK9EUCQo15g0tuMk7Zff3smsTfPVeamZPrxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zqp//TvUkRSiRdDtwOViBJHQ+DVIMezd3LRUCymKTXwC2VwWLvKomdFngpIqznwtOCnPIqsCFtmTRcs5+sORPnygXA7hajANv9e+BdEnZc6V6C/Pn81bP4UvnjuXCyzcAwN7oXKqvQVw5u1R2XioZeslWcvwOuDHO0+NJIUk8V0=
Received: by 10.115.22.1 with SMTP id z1mr1311680wai.1192052089082;
        Wed, 10 Oct 2007 14:34:49 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Wed, 10 Oct 2007 14:34:49 -0700 (PDT)
In-Reply-To: <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60550>

On 10/10/07, Han-Wen Nienhuys <hanwenn@gmail.com> wrote:
> 2007/10/10, Han-Wen Nienhuys <hanwenn@gmail.com>:
> > > You probably want to run 'git gc' (which will run 'git pack-refs',
> > > i.e. put all files currently under .git/refs into a single file). This
> > > should speed up 'git branch' (and quite possibly other commands too).
> >
> > This seems rather unuseful. After running gc pack-refs --all, I lost my HEAD,
> >
> > hanwen@lilypond:~/vc/git5$ git show HEAD
> > fatal: ambiguous argument 'HEAD': unknown revision or path not in the
> > working tree.
>
> More to the point, I seemed to have lost my entire repository. This is
> the type of surprise  I don't enjoy.

Yeah, this is bad, I'm sorry to have caused you trouble. But I fail to
see how 'git pack-refs --all' could possibly trash your repository. A
few questions:

What version of git are you using?
What's the output from these commands:
$ cat .git/packed-refs
$ cat .git/HEAD
$ find .git/refs -type f | wc -l

> Now, can someone explain why 'git branch' takes forever if there are
> only two non-remote branches ?

That's because git-branch always traverses the complete directory tree
below .git/refs, even if you only want to see the 'local' branches (I
have a patch cooking to fix this).

--
larsh
