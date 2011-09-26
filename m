From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Sun, 25 Sep 2011 21:09:31 -0700
Message-ID: <7vwrcwq70k.fsf@alter.siamese.dyndns.org>
References: <4E7A3BDE.3040301@alum.mit.edu>
 <7vy5xh1whq.fsf@alter.siamese.dyndns.org> <4E7AF1AE.5030005@alum.mit.edu>
 <CAG+J_DxtCx6-RKWLKFy+V7tOtu7UnUrke7iN8gNdGiY-sC52sQ@mail.gmail.com>
 <20110922171340.GA2934@sigill.intra.peff.net>
 <CAG+J_DxdP2qHhttJOtWQTKeiDV2YbC_A_F+b9sDOZsWhWxjcjw@mail.gmail.com>
 <20110922205856.GA8563@sigill.intra.peff.net> <4E7C5A3B.10703@alum.mit.edu>
 <20110923193341.GA26820@sigill.intra.peff.net>
 <4E7D7329.7070800@alum.mit.edu>
 <20110924061555.GB13974@sigill.intra.peff.net>
 <4E7DB916.6010606@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git discussion list <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 26 06:09:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R82Vm-00074U-8n
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 06:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855Ab1IZEJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 00:09:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55381 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808Ab1IZEJe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 00:09:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E338463F0;
	Mon, 26 Sep 2011 00:09:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HNdmNzgF9KqvK2SBP0nhSg4QOCk=; b=jfRf7D
	2g2QEcMe4QlfKahAiLqT2g+ZiW1G0tySi5UJRgxmelaiAVdmh38dvuUf7LHQf+Bt
	bPZ1b9GeE93paV/H2DZ2Bxvl14eshC1ypr93MXGmCGEmZR+lkaYTBTgdBz+BHHGV
	9nk9fIUIwlbFFeEMVgzcVomL2j6xG2XqA6kR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JVofAo32cYpla6ZLlIhTvyXpMYWlzlft
	CSHKfq4VmcDZP1NplQ1jhxqFKds9mBD+et5CrjBu+OUY4CFRBsXiWnAQ95B0VRKg
	a9D4BoFeBoXdJ03lqz6rnaOMwikwxnZGvWyyZIPD6UtQRnzvGZdkB5CzzMnpxdQY
	xtRWo+U8bRc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9FA063EF;
	Mon, 26 Sep 2011 00:09:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AE1F63EE; Mon, 26 Sep 2011
 00:09:32 -0400 (EDT)
In-Reply-To: <4E7DB916.6010606@alum.mit.edu> (Michael Haggerty's message of
 "Sat, 24 Sep 2011 13:03:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 567308D2-E7F5-11E0-9E79-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182089>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 09/24/2011 08:15 AM, Jeff King wrote:
> For most software projects, the user does
>
>     git pull
>     make
>
> daily.  There is nothing that a nasty .gitconfig can do that can't be
> done more easily by a nasty Makefile (or anything else in the build
> process).  The moment I pull from Junio's repository and run a build
> without having personally done a full code review first, I've given
> Junio complete pownership of my account.

I suspect that argument is somewhat leaky.

Will I be the _only_ one you will be pulling from?  What if I were not so
careful and relay a contaminated in-tree configuration file (which I would
never use myself) to trusting downstream users like you?

>> I'm not sure it makes sense to have it in the tree at all. For
>> attributes it makes sense, because you are annotating a path at a
>> _specific_ revision. But config is often much more meta- than that.
>> Take textconv for an example. The gitattributes say "foo.pdf should use
>> the 'pdf' diff driver". That makes sense to go in a revision. But the
>> config will say "pdf files can be converted to text using
>> /usr/bin/pdftotext". That is not something that is tied to the revision
>> at all, and should exist outside of any revision. I.e., whether I am
>> doing a "git show" on the HEAD, or on some ancient commit, I would want
>> to use the same value, not whatever tool I used to convert PDFs years
>> ago.

I agree 100% with Peff on this point. What pdfviewer is configured to be
used for my repository is tied closely to what I happen to have installed
on my box that I use that repository on. This is not by accident but by
design why attributes only specify what _kind_ of payload is in the path,
and leave it up to the config to say _how_ to handle each kind of payload
on the box).
