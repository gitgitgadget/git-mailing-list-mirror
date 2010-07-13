From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Question about 'branch -d' safety
Date: Tue, 13 Jul 2010 10:00:33 +0100
Message-ID: <1279011633.2030.17.camel@wpalmer.simply-domain>
References: <20091230065442.6117@nanako3.lavabit.com>
	 <m3lj9jknlr.fsf@localhost.localdomain> <20100711065505.GA19606@localhost>
	 <201007110916.29567.jnareb@gmail.com> <20100711133730.GA10338@localhost>
	 <7v1vb9hnd9.fsf@alter.siamese.dyndns.org>
	 <20100712184754.GA18429@localhost>
	 <7v39vo8dkn.fsf@alter.siamese.dyndns.org>
	 <20100713071317.GA26348@localhost>
	 <1279008023.2030.11.camel@wpalmer.simply-domain>
	 <4C3C2435.8010500@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jul 13 11:00:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYbM5-0007Xx-6u
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 11:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637Ab0GMJAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 05:00:40 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63100 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab0GMJAj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 05:00:39 -0400
Received: by bwz1 with SMTP id 1so56791bwz.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 02:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=if8AsOq8zecR56c+COuASy4QMRNHPV6vg/rlV9vjtP0=;
        b=II2DL8tjtxfCOubofqN2CSaON9jKP9+cYEmBva693OfoqWbt2wPaoAWnG6GlRM/Osk
         d7u+gc1ANBlKuWSxqOsebu6fwFl6MRGzynN9Kmin5Y1FwsQgwi4QzcZGVS1i19It+mi2
         kbkbBpEL/DI5o6yPgVQA8Jw9flp9BoG6eiex0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=uWXOFTw7IWb7+X21KYrEJb/qWbeS/5kjlc7erevheDlmSRRpuZES64B0hBlgGReBG2
         tBskJVnn9s713UR7qAuiR+pSsO7xQ9vjSAuAd1ExOl/XUJRW+mspZcK4Mz2jb8W2CHt5
         hvlcjtdmwHptBKgH/N7ZsDstE4eKDWjtl9qFI=
Received: by 10.204.101.207 with SMTP id d15mr2492657bko.59.1279011636684;
        Tue, 13 Jul 2010 02:00:36 -0700 (PDT)
Received: from [192.168.2.128] ([193.164.118.24])
        by mx.google.com with ESMTPS id y27sm22764398bkw.14.2010.07.13.02.00.34
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 02:00:35 -0700 (PDT)
In-Reply-To: <4C3C2435.8010500@viscovery.net>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150890>

On Tue, 2010-07-13 at 10:30 +0200, Johannes Sixt wrote:
> With that in mind, shouldn't it be exactly the other way around, i.e.,
> dump the reflog (the objects are still referenced from HEAD's reflog), but
> keep the ref around in some attic, just in case the branch is so old that
> its reflog was empty and its objects would otherwise be pruned right away?
> 
> -- Hannes

It would probably be more sensible to add a "deleted" entry to the
reflog just prior to removing the ref (yes, this will make HEAD@{1}
equal to HEAD@{0} in many cases). Keeping the ref itself around in an
attic doesn't make sense - the reflog can act as a better "attic"
anyway, if we stop deleting nonempty reflogs just because they don't
have a live ref associated with them.

Having a separate "attic" just runs into problems of "what if you delete
the ref twice?" and adds an entirely separate mechanism for tracking
something which we already have a perfectly good method of tracking: the
previous state of a ref.
