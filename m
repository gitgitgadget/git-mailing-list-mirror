From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 11/12] Documentation: add documentation for 'git interpret-trailers'
Date: Tue, 27 May 2014 12:18:20 -0700
Message-ID: <xmqqd2ezf2tf.fsf@gitster.dls.corp.google.com>
References: <534414FB.6040604@alum.mit.edu>
	<20140425.230710.1024850359228182788.chriscool@tuxfamily.org>
	<535E2A69.30600@alum.mit.edu>
	<20140525.103721.1806399553055631284.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mhagger@alum.mit.edu, christian.couder@gmail.com,
	git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, dan.carpenter@oracle.com, greg@kroah.com,
	peff@peff.net, sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	jrnieder@gmail.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue May 27 21:18:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpMtK-0001oo-7Z
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 21:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbaE0TS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 15:18:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64681 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078AbaE0TSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 15:18:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B1F21B045;
	Tue, 27 May 2014 15:18:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=HrGDhUVMBNATREUtD+eSCfTXtFo=; b=L82HFVdLT3baet+H7xYD
	GKIsrLe5cudWD2/M/mCzodluYuwdMIZH5KoEt7WRlz1b38wFJnu14RWh0cEiD8rL
	wmR+vtcg2df4JLT7RBWrA3wOrrG9SjW5CppuyMhyk/EFKtNvBfBDyR7OWNelhRXf
	TyiduIocAMc+RKdQNUAeBLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=oaBk3Ukne3ZRmoJx8vqXFnFiaPbQEYG0RiUo0QzwF2RBgT
	JII/xn9JgBsh2PhNa9r294+zhGpTWl3sB/aTsX5fb1Zsvy4ED4tH+e5s5WAJPfmT
	Oj/50Qj83W3mGyVTobMqjZZeqF942E+1nwAKvkNGE55ltBXOruxz2SEikyElc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 10E7C1B044;
	Tue, 27 May 2014 15:18:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B2AF21B03B;
	Tue, 27 May 2014 15:18:21 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AAD4767A-E5D3-11E3-B50D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250191>

Christian Couder <chriscool@tuxfamily.org> writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
> ...
> An option like --input-separator might be enough to support this.
>
>> For me this means:
>> 
>> * Enumerating a list of allowed separators (e.g., [:=#])
>
> Junio suggested in a message that users might use different separators
> like '%'.

I actually think we shouldn't go any fancier than ":" and nothing
else, not even "#".

I was hoping that you would eventually realize that there are only
two viable extremes when I suggested "the users may want to use
other random characters like '%'" and also "the users can specify
the 'key' with colon and trailing SP" (in $gmane/245960).

 - If you want to give the projects greater control of the format,
   then you cannot rely on "separators" anyway.  Your users can list
   all possible footer "keys" the particular project would use, so
   that they are recognized by Git, be that "Fixes: 4a28f16", "Bug
   #12354", without hard-coding what "separator" Git must pay
   attention to.  You can easily find a run of lines that begin with
   any of the "key" (e.g. "Fixes: ", "Signed-off-by: ", "Bug #",
   ...) starting from the tail-end of the log message and that is
   your footer block.  No need for "separators" at all.

 - If you want to give the projects freedom to come up with random
   new kinds of footers without pre-arrangement, then you need to
   have a reliable way to say if any line you have never seen could
   be a footer material.  A colon has been used everywhere, and used
   even in the "Fixes: 4a28f16" example you took from the kernel
   circle.  I think you presented it with '#' but I do not think
   they even want that, looking at:

   http://lists.linuxfoundation.org/pipermail/ksummit-discuss/2014-May/000618.html

I also think that bug tracking system using "Bug #12345" is an
unrelated issue, as log viewers would want to highlight and make
links out of them anywhere in the log message text, not limited
to the log footer part.

As to which one of these two we should take, I tend to think that we
should start small and limited; loosening the syntax later is much
easier than going the other way, i.e. ":" and nothing else.
