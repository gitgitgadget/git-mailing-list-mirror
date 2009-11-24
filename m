From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH/RFC 0/3] git rerere unresolve file
Date: Wed, 25 Nov 2009 08:40:48 +0900
Message-ID: <20091125084048.6117@nanako3.lavabit.com>
References: <200911211958.40872.j6t@kdbg.org> <7v6393mfqz.fsf@alter.siamese.dyndns.org> <200911221519.55658.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Nov 25 00:41:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND50e-0003Vx-Cw
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 00:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934435AbZKXXlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 18:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934428AbZKXXlK
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 18:41:10 -0500
Received: from karen.lavabit.com ([72.249.41.33]:36191 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934420AbZKXXlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 18:41:09 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 2A25711B842;
	Tue, 24 Nov 2009 17:41:16 -0600 (CST)
Received: from 9547.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id SOXJGFBA7EB2; Tue, 24 Nov 2009 17:41:16 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Xp6c38lgdPxNHUW7SOvNuvvdX171o+Y2abr7QYpTQQYsN6/zNg1LCA54uq9A9Zdh0s46w0hnAMW7YG/beuEgRUHkwqi5vvo2PTrp4ykpU8kNlrdBjIiFINHXYLTjtqGnB7d7q533uEIr1lpfewKBYihvqITyRQyUNBZac3Pcwm8=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <200911221519.55658.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133599>

Quoting Johannes Sixt <j6t@kdbg.org>

> On Sonntag, 22. November 2009, Junio C Hamano wrote:
> [snip]
>>  * Then the user tells rerere that "this is the corrected resolution",
>>    perhaps
>>
>>    $ git rerere update Documentation/git-commit.txt
>>
>>    This will
>>
>>    - Internally recompute the original conflicted state, i.e. run
>>      "checkout --conflict=merge Documentation/git-commit.txt" in-core;
>>
>>    - feed it to rerere.c::handle_file() to learn the conflict hash;
>>
>>    - read the user's updated resolution from the work tree, and update
>>      "postimage" with it.
>>
>> ...
>>
>> The "forget" subcommand may be useful, but the real implementation should
>> be the first half of the "update", iow, recreate conflict in-core in order
>> to compute the conflict hash, and drop existing "postimage", without
>> replacing it from the work tree.  We should leave it up to the user using
>> "checkout --conflict" to reproduce the conflict in the work tree.
>
> Thank you for your elaborate feedback and the guidelines about how to move 
> forward.
>
> I actually think that 'forget' should be the primary subcommand. Because after 
> the postimage was purged, the next implicit or explicit 'git rerere' will 
> record the resolution anyway. I'll see what I can do.
>
> -- Hannes

I think 'forget' should be the primary interface to this new feature too. If I mistakenly recorded an incorrect merge in the past and I'm trying to do a better job this time, I wouldn't be confident enough to be able to say 'update' to mark the attempt I made this time, and it may take more than one attempts for me to reach a good result. Running 'forget' once will let me retry until I run 'rerere' again.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
