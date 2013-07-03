From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] [submodule] Add --depth to submodule update/add
Date: Wed, 03 Jul 2013 10:36:58 -0700
Message-ID: <7vvc4rfsud.fsf@alter.siamese.dyndns.org>
References: <51D342BB.8080907@web.de>
	<1372801376-32673-1-git-send-email-iveqy@iveqy.com>
	<51D3D20A.5000700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, hvoigt@hvoigt.net,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 03 19:37:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuQzP-0004Ca-Bj
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 19:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753Ab3GCRhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 13:37:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47172 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193Ab3GCRhC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 13:37:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4029E2DDB6;
	Wed,  3 Jul 2013 17:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z++ra0UypiBE+ZOX4wTXwEfGUzI=; b=uB1J9D
	tOeqxgHd/sacrCIR93vvxIILG9RIhEFHWkXbQnwTrICm/UFIH52cRK6HLGSr3pzE
	KMcuDjeo9EI1d6bQMGRuqdckNziWydN8TawGi8zetVtAqckkH/GAXGqvX65g24nj
	Ox8ND3E+5X01p7Nn4Ako7Wtq79BktNllpg3M8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dmBjgS/rBaJKsWSIr9izK87HC+ONcIuF
	KFch8z97QWJgBh0Sta411ho90fS6E79+gTvDXa0A2Z4dPaO3W82nfTe+RjPF2gSD
	J81CNsUTCTv1F3cJUQb4OV0ihpC8e5Bu9scerDLEeGJ03KU2J1RIsdlRxiy8o3VS
	k/eoK4OeANE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30E032DDB5;
	Wed,  3 Jul 2013 17:37:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A0A12DDAE;
	Wed,  3 Jul 2013 17:37:00 +0000 (UTC)
In-Reply-To: <51D3D20A.5000700@web.de> (Jens Lehmann's message of "Wed, 03 Jul
	2013 09:26:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A98DC72-E407-11E2-8304-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229501>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> The only minor problem is that this patch still does not apply cleanly
> to master, next or pu (I wonder what you based this on ;-).

Older iteration of the topic has been queued directly on top of
v1.8.3.  When I replace a topic with its new version, I try to
rebuild on the same base.

This is primarily out of habit, but it makes comparison between the
two versions easier, and also "show-branch -g" output looks sane.

The workflow goes like this:

	: quick-glance the old iteration
	$ git log --boundary --oneline master..fg/submodule-clone-depth

        : can we rewind?  compare with the previous one for 'master'
        $ git log --boundary --oneline next..fg/submodule-clone-depth
        : if nothing has been merged to 'next', we can continue...

	: detach at the old base
	$ git checkout master...fg/submodule-clone-depth

        : apply
        $ git am -s3 ./+fg-submodule-clone-depth.mbox

        : inspect
        $ git show-branch @{-1} HEAD
        $ git diff @{-1}

	: replace
        $ git branch -f @{-1}
