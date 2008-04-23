From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH 1/3 v2] Add --blob-filter option to filter-branch.
Date: Wed, 23 Apr 2008 18:07:03 -0400
Message-ID: <32541b130804231507l4aff2ca3x962bf385a409685b@mail.gmail.com>
References: <alpine.DEB.1.00.0804232113480.20267@eeepc-johanness>
	 <1208981890-758-1-git-send-email-apenwarr@gmail.com>
	 <20080423215501.GB30057@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 24 00:07:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jon85-0000Nn-OU
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 00:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbYDWWHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 18:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbYDWWHH
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 18:07:07 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:26543 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbYDWWHF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 18:07:05 -0400
Received: by fk-out-0910.google.com with SMTP id 19so4025950fkr.5
        for <git@vger.kernel.org>; Wed, 23 Apr 2008 15:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=s6DdEzf/NLEBprIZN8OMtkIm6uf+oj+xqHut1mFwyC8=;
        b=AetepO9cAIC/hgPpwD9Qp22AhSvGwD5txv94D1WFTiLjD4aiVWRy4cFZOGPLhHz7I9VeRUcpdzmuVUuKa6gtcRRTwcjxDQTWUKuMKotKn+2U0ZGt0XzQYCvAEhICKy/YNIlS3Lv7g7BUEvIIuX3hxfOZQDsFdpSmGrodsblABh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dQE6X0ev9bw8zbrkzHKZ2mUvRI5nbPgUaY3zrk6LGEzSt4dkZKO1ojDAAjh7T8zRAPk84dtFAJIfQ7bzTQVUL4QKoQ5JkY3wcaqADJ1aCnqRYLJeqiLt5t46Fk4dvzhvhkEseUvgyoQf6TYoKhjcfHciWqdf4gcKIbIgRn62Xnw=
Received: by 10.82.186.19 with SMTP id j19mr1855359buf.60.1208988423182;
        Wed, 23 Apr 2008 15:07:03 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 23 Apr 2008 15:07:03 -0700 (PDT)
In-Reply-To: <20080423215501.GB30057@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80266>

On 4/23/08, Jeff King <peff@peff.net> wrote:
> On Wed, Apr 23, 2008 at 04:18:10PM -0400, Avery Pennarun wrote:
>
>  > From: Jeff King <peff@peff.net>
>  >
>  > This patch allows
>  >
>  >   git filter-branch --blob-filter 'tr a-z A-Z'
>
> The commit message munging you did is fine.
>
>  However, I think Johannes Sixt's question about providing the pathname
>  needs to be resolved. As it is now, the blob-filter is impossible to use
>  in a mixed binary/text repository, short of the undocumented $path magic
>  that you described. And I am a little uncomfortable just adding the
>  $path as he suggested because of the subtle bug it introduces.

It is indeed a very subtle bug; so subtle, in fact, that I never
expect to experience it myself :)

I think it would be fine to index into the cache using $path$sha1,
which would seem to resolve this issue.  The catch is that $path isn't
a very good cachefile name.  I'd suggest doing an md5sum or something
on it, but that would result in an extra fork for every file, which
brings us back to our original level of slowness (or worse).

Hmm, I gues using a cachefile like $sha1/$path would work; it requires
a "mkdir -p", but only when *filling* the cache.

Avery
