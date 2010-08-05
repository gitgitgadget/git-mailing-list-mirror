From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC v2 0/12] Re: rerere: let caller decide whether to
 renormalize
Date: Thu, 5 Aug 2010 06:08:22 -0500
Message-ID: <20100805110822.GB13779@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
 <20100804032338.GF19699@burratino>
 <7vocdifdrk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 13:09:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgyKf-0005O4-Ro
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 13:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758935Ab0HELJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 07:09:49 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39198 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858Ab0HELJr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 07:09:47 -0400
Received: by iwn33 with SMTP id 33so76343iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 04:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FDzk67rnWOvfqE3z2ZbRAcmpELQFtfio8Rzsyp+WScw=;
        b=XSD2Wmv9FfayfFVoyUUWhvkXmLi4ttdh2jlTQS9rpa++BWRuxSP1BzIYKIYi5TM4GH
         QCqiQKyOr0eYi1uMkQFddbL48B7hvXi/F9cDhmdJKFqHbXRq7muzy95XpH0t4cS8uo3E
         pecz/RrBYZwqU5dbQiAZr1IkS59hjVVQOO+9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IOV/r97nAxfLG+h1yBZ52TrxzykWAYAUr4CF65jcrTzz6d6V3c0e50KCoz2o/r7o21
         3+gtZoozc+SGi9+nbM/U14AzhLwE0izA3B7pYqMMMOfU2tZIEYbhcHp8rl1xvhyhDAS3
         ILdKLl6B/d0PimejbNYeEMZuk0cUojlMJj/lI=
Received: by 10.231.174.206 with SMTP id u14mr12137673ibz.103.1281006586577;
        Thu, 05 Aug 2010 04:09:46 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r3sm45814ibk.7.2010.08.05.04.09.44
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 04:09:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vocdifdrk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152632>

Junio C Hamano wrote:

> 1. "-s"
[...]
>    When "rerere" is invoked,
[...]
>    It is purely a three-way merge at the file-contents level and there is
>    no room for a "strategy" to get involved.  It makes direct calls to
>    ll_merge() exactly for this reason.
> 
> 2. "-X"
[...]
>    A command that natively knows about an option is correct to take an
>    option as "--<option>", e.g. "merge--recursive --renormalize".  You
>    trigger it by saying "merge -Xrenormalize" from the frontend.
> 
> 
> To recap: it is absolutely the right thing to do to introduce a new
> "rerere --renormalize" option, like your patch did.  Doing anything else
> IS a step in the wrong direction.

Once you say it like that, it makes sense. :)

Or rather, rerere should not take --renormalize at all.  Patch 11 below
has an explanation.

Jonathan Nieder (12):
  t6038 (merge.renormalize): style nitpicks
  t6038 (merge.renormalize): try checkout -m and cherry-pick
  t6038 (merge.renormalize): check that it can be turned off
  merge-trees: push choice to renormalize away from low level
  merge-trees: let caller decide whether to renormalize
  Documentation/technical: document ll_merge
  ll-merge: make flag easier to populate
  ll-merge: let caller decide whether to renormalize
  t4200 (rerere): modernize style
  rerere: migrate to parse-options API
  rerere: never renormalize
  merge-recursive --renormalize

 Documentation/merge-strategies.txt    |   12 +
 Documentation/technical/api-merge.txt |   73 ++++++
 builtin/checkout.c                    |   11 +
 builtin/merge-recursive.c             |    4 +
 builtin/merge.c                       |   19 ++-
 builtin/rerere.c                      |   52 +++--
 builtin/revert.c                      |    7 +
 cache.h                               |    1 -
 environment.c                         |    1 -
 ll-merge.c                            |   11 +-
 ll-merge.h                            |   15 ++
 merge-recursive.c                     |   14 +-
 merge-recursive.h                     |    1 +
 rerere.c                              |    4 +
 t/t4200-rerere.sh                     |  394 ++++++++++++++++++++++-----------
 t/t6038-merge-text-auto.sh            |  143 +++++++++++-
 16 files changed, 588 insertions(+), 174 deletions(-)
 create mode 100644 Documentation/technical/api-merge.txt

-- 
1.7.2.1.544.ga752d.dirty
