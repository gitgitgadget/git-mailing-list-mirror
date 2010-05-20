From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-status and git-diff now very slow in project with a
 submodule
Date: Thu, 20 May 2010 15:59:53 -0700
Message-ID: <7vbpca6uxi.fsf@alter.siamese.dyndns.org>
References: <ht3194$1vc$1@dough.gmane.org>
 <7vy6fe7ldo.fsf@alter.siamese.dyndns.org>
 <201005201817.05593.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 21 01:00:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFEip-0001Ih-Ss
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 01:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194Ab0ETXAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 19:00:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755145Ab0ETXAE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 19:00:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 904C5B42ED;
	Thu, 20 May 2010 19:00:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qwh4c7HhG43IgpZexV5/z3uh08Q=; b=rAIVVO
	hIQpPjf0TAY01n6C0DGOLE3nE+DLWCEIAyaC1ugFalyM1RIU553If/C2vB9NPr/v
	Ha9vqoS2jfIq45w3IOnQSlDFz12G4Y6EZB9tngyXG76EmKsC2acxkEer1Ukr3L4g
	su2I6zuUN3IcWahNAr0nh4AE5/e7xCpv2e3Iw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HzGukfElLpeZtbsLrTPLfEFm49/qTtwC
	O1cjmSl5/epa2jtJYV71Z3SejyYHIj/jF2BhXs2MM0zv+IrhbG8Ga1DZxas55ckM
	Oaql6ewsxb5MiWqQwEfURsMhVdk3ueVaOoYwPvngVzpLNwDWSDnjAWSPaX2ewOK/
	0uYN+yUk0c8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A111B42E8;
	Thu, 20 May 2010 18:59:59 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60251B42DE; Thu, 20 May
 2010 18:59:55 -0400 (EDT)
In-Reply-To: <201005201817.05593.andyparkins@gmail.com> (Andy Parkins's
 message of "Thu\, 20 May 2010 18\:17\:04 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6A502AFE-6463-11DF-B566-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147417>

Andy Parkins <andyparkins@gmail.com> writes:

> Also, I don't want *.log, or *.ps -- neither of them is guaranteed to be an 
> ignore pattern.  These throw away files have all sorts of names, made up on 
> the spot as I'm working, adding them to an ignore file is overkill from my 
> point of view.

I've learned to give them names that begin with an unusual letter (in my
case, a colon or a plus sign), way before I started working on git, so the
above is not a very convincing argument at least to me.

In any case, I am a bit torn about this whole issue.

On one hand, scanning for untracked files are not about these *.log cruft,
but to catch mistakes that are caused by new paths that you forgot to add,
and in that sense, uncommitted modifications to a path that happens to be
tracked and a new path that you forgot to add have (semantically) similar
chance of being a mistake that you might want to catch by running "git
status".

On the other hand, adding new paths to an existing project is a rare
event, compared to modifications to existing paths (e.g. even for a
project as small and young as git.git, we have 10x as many revisions as we
have paths), so by definition the chance that you might break others'
builds by forgetting to commit a new file is much smaller than forgetting
to commit necessary changes to existing files.

But ideally you would want your tool to catch mistakes that are rarer, as
you would learn to avoid common mistakes on your own without help from
your tool over time.

At least we should be able to let the users say, with "git status -uno",
"I don't care about untracked and unignored paths; I don't make such a
mistake to forget adding new paths", and optimize the scanning of
submodule directories taking advantage of that statement.  Is there a
fundamental reason why things shouldn't work that way, or is it just a
bug in the current code?
