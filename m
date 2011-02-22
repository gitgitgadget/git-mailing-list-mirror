From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] do not overwrite untracked symlinks
Date: Tue, 22 Feb 2011 20:26:32 +0100
Message-ID: <20110222192632.GB4881@localhost>
References: <201102022025.06140.j6t@kdbg.org>
 <7v7hdixkys.fsf@alter.siamese.dyndns.org>
 <201102022324.22123.j6t@kdbg.org>
 <201102051918.44848.j6t@kdbg.org>
 <20110205183351.GA25717@localhost>
 <20110220121343.GA21514@localhost>
 <7vaahpluy9.fsf@alter.siamese.dyndns.org>
 <20110221194623.GA31181@localhost>
 <7v62scftjl.fsf@alter.siamese.dyndns.org>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 20:24:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prxqo-0004UU-8I
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 20:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755018Ab1BVTYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 14:24:41 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33757 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849Ab1BVTYk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 14:24:40 -0500
Received: by eyx24 with SMTP id 24so940016eyx.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 11:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+aPrDdrcPA8wCfVHgFly6VRnOhkradABpcrqx2sjL8s=;
        b=PRsEcJaogLmqeYvDMpWBeTxofotIyP41egkvOq/P0KYT9WIG1SHDGfZq9N11nqUEaP
         Nt0+TAvuIKzUwkqlYZ/b/5ZHhvd6mqh9FO0Gpiwp+X9/q3Ks4PXtIqqTkGgDbulcQuG0
         X7+csr6QmDq2pYnKIkOv0KwkgzaMHOdIhw84s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=MW93pOI0CJMb8STj0udyJqXeZ/+eE49bWlmk56Den03PgBHKYdirCQTmcDPnuYAeU+
         jGN4CWsIX6eIcRD4+UYKXyfo4vHTEbjK62FToEmVNtd3CcZgt7APZi/LeUomN137aH5X
         h8ruKYGPW187gvv5Kpz9rSmFzuBSoCMOswtuA=
Received: by 10.204.101.81 with SMTP id b17mr2875195bko.126.1298402678823;
        Tue, 22 Feb 2011 11:24:38 -0800 (PST)
Received: from darc.lan (p5B22D6D5.dip.t-dialin.net [91.34.214.213])
        by mx.google.com with ESMTPS id j11sm4754609bka.12.2011.02.22.11.24.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 11:24:37 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1PrxsW-0001Jg-At; Tue, 22 Feb 2011 20:26:32 +0100
Content-Disposition: inline
In-Reply-To: <7v62scftjl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167576>

On Mon, Feb 21, 2011 at 10:54:38PM -0800, Junio C Hamano wrote:
> 
> Yes, I agree with that reading.  I'd squash in this on top, first making
> sure that "do not overwrite untracked symlinks" (which is the title of
> this patch) won't be broken, and then the original test that wanted to
> make sure that checking out a/b/c/d when a/b is pointing to an unrelated
> part of the tree does not nuke whatever is pointed at that symbolic link.

Ok, perfect.

> My unhappiness with the undescriptive "check_leading_path()" still
> remains, though...

Ok. If I can't figure anything out this weekend, I'll rename it.
Promise.

It's just that I'm even more unhappy about the actual code rather
than the function name.  And each time I look at it I end up trying
to fix it, only to find out that it affects so many parts of the
code that don't make any sense. 

For example, we already have a function check_path() in entry.c,
which does something very similar and is called by
checkout_entry(), which in turn does something similar to
verify_absent(). In fact, I suspect that both functions are called
twice by the same code path around unpack_trees, for the same paths
and for the same reason.

I strongly feel that we should separate the merge process into two
steps.

 - First, do everything in the index, ignoring the work tree.

 - Second, checkout the index to the work tree while making sure no
   changes or untracked files get overwritten.

I know I have talked about this before, and I don't know if I will
ever find the time to implement such a major change. But I can't
get myself to feel good about fixing the function name, but not the
function.

Clemens
