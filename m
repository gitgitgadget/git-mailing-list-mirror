From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't search files with an unset "grep" attribute
Date: Mon, 23 Jan 2012 10:33:33 -0800
Message-ID: <7vy5sy8e0y.fsf@alter.siamese.dyndns.org>
References: <CACsJy8C0aXgecCWHrCK3yzNLWnWX4g81x-OzZCY0xtonbspzXw@mail.gmail.com>
 <4f1d2a8b.a2d8320a.50ec.576d@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: conrad.irwin@gmail.com
X-From: git-owner@vger.kernel.org Mon Jan 23 19:33:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpOi5-0003dR-AU
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 19:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495Ab2AWSdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 13:33:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57214 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753152Ab2AWSdg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 13:33:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D16516F1D;
	Mon, 23 Jan 2012 13:33:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3K83O5ehHUv2gxfinbc61zQPRiM=; b=eVz8/m
	BSWqtLeAiLmtV6sWsl56cwHEZytZSbm2qvS9pXc9jQ9S3J2daoTRPQRbnepLkL0v
	5zMuFSfICF4wtZHsbOAzZ+FeteOXdsZqkBLn13LvLY1gjQGUAeO+P2I4Ts/ZQsxm
	mahXHGMKGOOMnD4dDJJvo1ZxMytRQrWg38K7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r2fMTDrQRb4URwQpQbuFhUKbSRF/HZL9
	KuYmH7HbLFGUrEebvosjVGrHjzt4pQv1Hp04Qz5LyJXEUTA6R304eu4OmLoYPywV
	TT1Q84cfiC+FlEJZp7asARaLX2wnTGuJnlNhYOmITdhq5Ge05d3u6ruoKBeqPb9t
	4udKF8b2Uw4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C926D6F1C;
	Mon, 23 Jan 2012 13:33:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BE366F1B; Mon, 23 Jan 2012
 13:33:35 -0500 (EST)
In-Reply-To: <4f1d2a8b.a2d8320a.50ec.576d@mx.google.com> (conrad irwin's
 message of "Mon, 23 Jan 2012 01:37:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C25DCAB0-45F0-11E1-A1C4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189006>

conrad.irwin@gmail.com writes:

> ---8<---
>
> To set -grep on an file in .gitattributes will cause that file to be
> skipped completely while grepping. This can be used to reduce the number
> of false positives when your repository contains files that are
> uninteresting to you, for example test fixtures, dlls or minified source
> code.

Please reword this to describe the problem being solved first (why it
needs to be solved, in what situation you cannot live without the
feature), and then describe the approach you used to solve it.

Plain "grep" does this:

	$ grep world hello.*
	hello.c: printf("Hello, world.\n");
        Binary file hello.o matches

in order to avoid uselessly spewing garbage at you while reminding you
that the command is not showing the whole truth and you _might_ want to
look into the elided file if you wanted to with "grep -a world hello.o".
Compared to this, it feels that the result your patch goes too far and
hides the truth a bit too much to my taste. Maybe it is just me.

Perhaps you, or all participants of your particular project, usually do
not want to see any grep hits from minified.js, but you may still want to
be able to say "I want to dig deeper and make sure I have copyright
strings in all files", for example.  It is unclear how you envision to
support such a use case building on top of this patch.

Your "attributes only" is not an acceptable solution in the longer run,
even though it is a good first step (i.e. "attributes first and other
enhancement later"). There should be an easy way to get the best of both
worlds.

> The other approach considered was to allow an --exclude flag to grep at
> runtime, however that better serves the less common use-case of wanting
> to customise the list of files per-invocation rather than statically.

I doubt that it is justifiable to call per-invocation "the less common".

By the way, if the uninteresting ones are dll and minified.js, I wonder
why it is insufficient to mark them binary, i.e. uninteresting for the
purpose of all textual operations not just grep but also for diff.

I am *not* going to ask why they are treated as source and tracked by git
to begin with.
