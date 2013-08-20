From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mailmap: fix check for freeing memory
Date: Tue, 20 Aug 2013 10:18:08 -0700
Message-ID: <xmqqob8s7033.fsf@gitster.dls.corp.google.com>
References: <1377004958-14489-1-git-send-email-stefanbeller@googlemail.com>
	<878uzw7a6l.fsf@linux-k42r.v.cablecom.net>
	<52137A63.3010609@googlemail.com>
	<871u5o785o.fsf@linux-k42r.v.cablecom.net>
	<52137F59.2030103@googlemail.com>
	<20130820161237.GA4332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 20 19:18:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBpZQ-0006mC-7G
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 19:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558Ab3HTRSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 13:18:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41110 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365Ab3HTRSL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 13:18:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3E323A616;
	Tue, 20 Aug 2013 17:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LBHKdY5szdjtNViPTLF3GNzKXRU=; b=uNT1v9
	xmoZFGLMXRF9S0x2zjJvSC5klTkUuVhWGHWuq4mNcFwCrk4hmsyRWFJVLs2iLvPh
	HYxorbFU5R35MhxN4507IDFsRf2IRmWnLT+zxu7ty/8Vzz6iW9cX7jl3qC4Dv7J0
	diXK9wG/gCkwmgeY7akPkOaqunpyZcLiJfNl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DqYEZ0LhyerpdPXpZjRGpiVwkd6nnuhg
	BGlwf3KayZRXqN8JDShNIw6zHi5MC76pWUEjQeB6v8cpfkmsxgiIhFcG4njvfymd
	sfF1cVctnTTrzJ/qI5WrDEUtWaW4/4EFWFqGDdnakqzXhnnTaaKDXytGrTmFMCVi
	WYJ9dirzY1w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7A943A615;
	Tue, 20 Aug 2013 17:18:10 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48F853A60D;
	Tue, 20 Aug 2013 17:18:10 +0000 (UTC)
In-Reply-To: <20130820161237.GA4332@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 20 Aug 2013 12:12:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7CC60472-09BC-11E3-8576-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232615>

Jeff King <peff@peff.net> writes:

> It _only_ impacts git-shortlog, not git-log or other traversals. Making
> it an even more dubious feature, IMHO.

I think this was done by an explicit end user request for shortlog.

As you mentioned, merge gives readable merge log messages, but it
deliberately uses the real URL, not your personal nickname for the
remote when writing the title line of a merge, i.e.

	Merge [branch <x> of ]<repoURL>

so it would be helped by the repository abbreviation.  It probably
was an oversight that we did not extend it to the rest of the log
family.
