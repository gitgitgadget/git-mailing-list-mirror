From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/9] --left/right-only and --cherry-mark
Date: Wed, 09 Mar 2011 13:49:39 -0800
Message-ID: <7vtyfc7ymk.fsf@alter.siamese.dyndns.org>
References: <cover.1299499429.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 09 22:49:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxRGV-0008OK-EO
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 22:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318Ab1CIVtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 16:49:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57473 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529Ab1CIVtt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 16:49:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CFD214867;
	Wed,  9 Mar 2011 16:51:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dy5FsnetS+htrTRDwOxCCGyZoyI=; b=UQF/PZ
	BivKrxJjmeb9gfS9NIlTnBUbkDm08fPU540dddrWWPUjhDV6L6UaY90ka5Rj0wSI
	FTmarbmVjxAynmJ2x08dcnnYces4elfCPVdRYNmmCfQdr44/adBtxONcI2Hr7L2Y
	DiWdwvj8bBuWa772Rt+pirpYOc+tneJv8W9eg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K4QOCemA5jTXcJJhJgnWpvrCMfLH6XEz
	cjBY1wfv8haf6G455hxD6YPyl4mwV4lTTe5kn5tRYKYuLIaoHVXjlmqPuRpzJuPT
	qD7uc3RM6pYm3n2M3Hzg6M8n1uqsvXIuDMf2e8PKWunMyyjrZeNVxUAtUcJFCokS
	8gmkfxcuP0A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9F6794864;
	Wed,  9 Mar 2011 16:51:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 991C1485F; Wed,  9 Mar 2011
 16:51:09 -0500 (EST)
In-Reply-To: <cover.1299499429.git.git@drmicha.warpmail.net> (Michael J.
 Gruber's message of "Mon, 7 Mar 2011 13:31:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59A01686-4A97-11E0-9277-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168767>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> This is a replacement for mg/rev-list-one-side-only in pu.
> The --left/right-only related commits (1-4/9) are unchanged.

I like the general idea of marking the equivalent ones instead of outright
discarding the commits in the cherry_pick_list() function.

It might be a good idea to record the correspondence between equivalent
commits in some way; the current topic does not need that information in
order to produce its output, so that is something other people can build
on top of this topic in the future.

There is only one minor point that nagged me while reading this series.

Conceptually revs->cherry_mark ought to be a subset of revs->cherry_pick
and the code shouldn't have to do something like this:

	if (revs->cherry_pick || revs->cherry_mark)
        	cherry_pick_list();

Instead, the code should arrange that revs->cherry_pick is always set
when revs->cherry_mark is set before the calling application enters the
loop to call get_revision().

But that would make the command line parsing more cumbersome (you would
either waste one bit so that you can tell if you saw --cherry-pick on the
command line, or keep the version of parser in this series as-is, and add
postprocessing code to flip revs->cherry_pick on when revs->cherry_mark
was given in prepare_revision_walk()), and I understand that is why you
did it that way?

Thanks.
