From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: show remote name instead of URL if available
Date: Tue, 26 Apr 2011 10:33:48 -0700
Message-ID: <7v1v0ogbnn.fsf@alter.siamese.dyndns.org>
References: <1303830807-21966-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:34:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEm9G-0002gH-EH
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 19:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757719Ab1DZReB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 13:34:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754387Ab1DZReA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 13:34:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DD65E33A7;
	Tue, 26 Apr 2011 13:35:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=50rN7T0ZlLx28BsWcr2OhUXjpl4=; b=CP6qPd
	pD3fVoJ8vMoJOowjXVNhOE7YxU/qU+K1IRXVLCW+siQfvoQCJ/98lgjqKBQoczoi
	TX6jLFiNMgILMeXp1d+ttf9tjCdy0XCGLqY9zFKeXBAyGmPyH0jiqRupz97Rmpf4
	nYDzJcr2fIhOA8Uex2ZZ2pQvo5EHUVDVByqMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R9f+7/9/QgJwSzfW8V1sWauRTX/wnlvc
	cNdWruZZw+2FfJJubgerrzzAZHSwfyYJjqNMVIi+IUKXW/TOVuHAseEc4kPQNPbX
	cgy6V/FBB3noUHBrwlpuFKX6MKWpdi7/a+MI0cL7DAdWzW5rZxGWDZ8gC9lIm9Dh
	68xntpKWo6w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 96B7433A4;
	Tue, 26 Apr 2011 13:35:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A2FE2339F; Tue, 26 Apr 2011
 13:35:51 -0400 (EDT)
In-Reply-To: <1303830807-21966-1-git-send-email-dpmcgee@gmail.com> (Dan
 McGee's message of "Tue, 26 Apr 2011 10:13:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3CF27EC-702B-11E0-AD8C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172114>

Dan McGee <dpmcgee@gmail.com> writes:

>     $ git fetch -v
>     From git://git.kernel.org/pub/scm/git/git
>      = [up to date]      html       -> origin/html
>     ...

I see this full URL output as a nice reminder of what "origin" refers to,
especially when you said "git fetch -v origin".  This is especially useful
when you are fetching from different locations that house repositories of
the same project (e.g. among my multiple git.git working trees on my
notebook, some of them fetch from my private, primaty development machine
and others from public k.org).

Changing this output ...

> Versus the new output:
>
>     $ ./git fetch -v
>     From origin

... this way feels like a regression to me.

> Alternatively, we could do something like
>     From origin (git://git.kernel.org/pub/scm/git/git)

That is much less problematic.

But let's step back a bit.  What problem are you trying to solve?

Are you trying to give a reminder that you are interacting with 'origin'
when you said "git fetch -v" without saying where you are fetching from?
I think that is a good thing to aim for (the same reasoning behind the
comment of mine above).  If so, the ideal change from my gut feeling is to
add an extra " (origin)" at the end, like so:

	From git://git.kernel.org/pub/scm/git/git (origin)

when and only when the fetch is done without mentioning any remote
nickname; iow, "git fetch -v origin" or "git fetch -v git://.../git" won't
get the extra " (origin)" at the end.
