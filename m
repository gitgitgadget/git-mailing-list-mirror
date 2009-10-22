From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [RFC/PATCH] git-merge: forbid fast-forward and up-to-date when --no-commit is given
Date: Thu, 22 Oct 2009 19:21:45 +0900
Message-ID: <20091022192145.6117@nanako3.lavabit.com>
References: <200910201947.50423.trast@student.ethz.ch>
	<alpine.LNX.2.00.0910201912390.14365@iabervon.org>
	<20091021030608.GA18997@atjola.homenet>
	<7vk4ypb71j.fsf@alter.siamese.dyndns.org>
	<20091021172123.GB27495@localhost>
	<7v3a5c2zrr.fsf@alter.siamese.dyndns.org>
	<7vpr8g1l2a.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Clemens Buchacher <drizzd@aon.at>,
	Bjorn Steinbrink <B.Steinbrink@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 12:21:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0unt-0006yV-AH
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 12:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbZJVKVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 06:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbZJVKVp
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 06:21:45 -0400
Received: from karen.lavabit.com ([72.249.41.33]:60657 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524AbZJVKVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 06:21:45 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 11AA711B9CE;
	Thu, 22 Oct 2009 05:21:50 -0500 (CDT)
Received: from 5391.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id XM79IDCSTNS7; Thu, 22 Oct 2009 05:21:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=ywTmGuUc2fyv20A6nkk/HRrXwHeaABJt9rFZMPiwUpM21CSiMJ5emnmcnyNbZOqpT1vI27IE4lLtnaKUOEeG6WkLfPEn0uMb7OaOL2bZTLXHMLUydhJ66iPdGEJ6k1ZWMgqqbhCh2PNTt0edlJvOOsRlePx+ZPgORfQ0R0rCZeU=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vpr8g1l2a.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131016>

Quoting Junio C Hamano <gitster@pobox.com>

> Traditionally "git merge --no-commit" meant just that: do not create a new
> commit even when a merge succeeds.  But this leads to confusion when the
> merged commit is a descendant of the current commit, in which case we
> succeed the merge by fast-forwarding and without creating a new commit.
> Also when the merged commit is already a part of the history, we succeeded
> without doing anything.
>
> Error out when --no-commit is given but the merge would result in a
> fast-forward or an up-to-date.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * This is the first alternative.  I think it makes more sense than the
>    other one, but I am unsure, as I obviously do not get confused when
>    --no-commit becomes no-op due to a fast-forward nor an up-to-date and
>    am rather happy with the current behaviour.

I think this is good (but I am saying this only from your 
description without understanding the updated code), but 
the change breaks --squash to merge a branch, doesn't it?

    % git checkout feature  # from your master branch
    % work; git commit; work; git commit
    % git checkout master  # go back to your master branch
    % git merge --squash feature

This is a useful way to clean up changes that were built
in small steps that turned out to be worth only a commit.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
