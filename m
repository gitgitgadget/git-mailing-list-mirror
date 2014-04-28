From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 10:31:08 -0700
Message-ID: <xmqqeh0hs6n7.fsf@gitster.dls.corp.google.com>
References: <535C47BF.2070805@game-point.net>
	<1748955386.11457068.1398588660139.JavaMail.zimbra@dewire.com>
	<535D3DF8.4020904@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:27:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerCv-0001HQ-Hp
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbaD1TZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:25:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59647 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932473AbaD1TZM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:25:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A729B7E92A;
	Mon, 28 Apr 2014 13:31:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IOqqt4VmFVwMIntutwSljmgtno8=; b=W+x8Y6
	iGs0ENTXjmyGsCK3mPMBeumIcwrB0IZDFSOpKZ1WRvT6X/aBN0xjNl8bGuAbYkPU
	rfxWruoycsgdSp5oPYCojD3AM0ws6e8Zdf0j+TskX9+GpfGBd90Zm+I6S5dyaLax
	YxQdxF+fdv6dbaDCC7Mdq/MAVLqv+oPSu8TCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XHXgF0oeAYytN3PmlleM9KgbxRlQD30u
	w5Sf4z8n9Y4EtwlHGqLA/mvnu8dPosfv4vqKmtlbMLm3qitWNlKOUjBSHMkp1ZFM
	A93Ovu3gRsZ0WDARaQYJcmb5R9vxzk+wERaiwzjHLkjU25FKj8mg1ry/DKH+FlMw
	OT2tfxGwlco=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C7847E929;
	Mon, 28 Apr 2014 13:31:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DBBC7E926;
	Mon, 28 Apr 2014 13:31:10 -0400 (EDT)
In-Reply-To: <535D3DF8.4020904@game-point.net> (Jeremy Morton's message of
	"Sun, 27 Apr 2014 18:27:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E3D8821C-CEFA-11E3-BA4B-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247404>

Jeremy Morton <admin@game-point.net> writes:

> But surely, it's recommended with Git that you try to avoid doing
> --no-ff merges to avoid commit noise?

That is a misconception, I am afraid, coming from two different
camps.

Some projects do not want any merges for whatever reason, not
limited to --no-ff merges.  They want linear history perhaps due to
inertia from their CVS days.

In mergy projects, where no such "merge avesion" exists, there still
is a valid reason why you are told to avoid no-ff, but I do not
think it is primarily because no-ff is bad.  The real reason why
people need no-ff to record the fact that the "side branch" was a
separate development is because they rebase on top of the project's
tip right before they push it out.  If you do not do that last
minute rebase, you do not have to do a no-ff, unless the project is
so quiet and no other people are actively working on the codebase.
And in such a case, no-ff would be very much justified.

I do not fundamentally oppose if you want to add "Done-as-part-of:
frotz-topic" at the end of the log message of each commit that
belongs to the topic in your project (I personally wouldn't welcome
such a convention in _this_ project, though).  Christian's
"trailers" series may serve as a building block for such a feature.

But as we can see in the thread, many people view (including me)
that the choice of branch name is a personal thing, irrelevant in
the project-wide history, so even if you add a built-in support to
make it easier for you to add such a trailer, it has to be something
optional the projects explicitly must choose to use by flipping some
toggle.
