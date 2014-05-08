From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Thu, 08 May 2014 11:31:29 -0700
Message-ID: <xmqq61lg3ywu.fsf@gitster.dls.corp.google.com>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
	<20140505184546.GB23935@serenity.lan>
	<xmqqoazb944d.fsf@gitster.dls.corp.google.com>
	<536B3259.1050602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 20:31:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiT6c-0002dR-Jc
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 20:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240AbaEHSbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 14:31:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53337 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753705AbaEHSbh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 14:31:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 33607155DF;
	Thu,  8 May 2014 14:31:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qX848DC/n7/6ri22//zd86nL5Ow=; b=R+Mtw5
	1mwrEPuwK0ucLNrzfNyeArzDFYLwdHdwte9l8rpaQwoGfgIlvUkUPl6sgz0siXY7
	TyfosA8wNUVYPdkHBUH68aSejIJKQ2dBgtUSv+kQm6c6qcb8JdSC542CF9A1aWCp
	hTaIgdZIpAM9y9HdWsL/n2kmLzjs1kruvIOVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VUpGs+wQFTVPMBhVGv5r45aEIEhlhVT/
	dFP2pLjk8ehcZhmivk8shIApDk9F9D5oYfzIy9ZIKEDPK0gd+sy1QSo5AMbFt0Xv
	WztOU11Pfsmg8Z9letwo5jloWpVc3aHrnQb2LeyLX59l5WHLIwoztCKiC0w1REjM
	d5vFEWIjp7I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DFFFF155DE;
	Thu,  8 May 2014 14:31:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D78D3155D9;
	Thu,  8 May 2014 14:31:32 -0400 (EDT)
In-Reply-To: <536B3259.1050602@gmail.com> (Chris Packham's message of "Thu, 08
	May 2014 19:29:29 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FB54BDA2-D6DE-11E3-A5C4-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248429>

Chris Packham <judge.packham@gmail.com> writes:

> A bit of a crazy suggestion and a little off-topic. Assuming maintainers
> can be found what about having these foreign vcs interfaces as
> submodules. That way they can be in Junio's tree as well as having their
> own release cycles. The same could apply to git-gui, gitk and gitweb. It
> would also be a chance to eat-our-own-dogfood with submodules.

While I agree that submodules may be useful for git-gui and gitk
(which already have their own repository and history), I do not
think that affects the issue of release cycles for third-party tools,
especially the ones with heavier foreign system dependencies like
vcs interfaces.

The release schedule of Git itself places a lot of stress not to
regress anything for existing users of Git, and the gitlink that
points at the specific commit in a submodule will stop advancing in
the top-level superproject (i.e. my tree) during the feature-freeze
period before releases, just like any other paths (i.e. regular file
blobs).

A third-party product maintainer may have other ideas about
stability of their product.  They may want to issue an unproven new
release to adjust to a recent update made to their external
dependencies as soon as code is written, relying on their ability to
issue follow-up maintenance updates on their product in quick
succession.  If many of them are bundled with Git, then we would
have to keep following these "oops, that was wrong" updates from all
of these, which would add unscalable burden to a single choking
point.

Not bundling gives third-party tools the freedom to evolve and worry
about compatibility with their dependencies on their own, and allows
them to treat Git as just one of the dependencies at the same level
as their other dependencies.
