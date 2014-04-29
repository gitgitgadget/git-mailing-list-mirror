From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3910: show failure of core.precomposeunicode with decomposed filenames
Date: Tue, 29 Apr 2014 11:49:30 -0700
Message-ID: <xmqqwqe8j7id.fsf@gitster.dls.corp.google.com>
References: <20140428161630.GA9435@sigill.intra.peff.net>
	<xmqqvbtskqjv.fsf@gitster.dls.corp.google.com>
	<20140429180210.GB11832@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 29 20:49:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfD62-0000Vi-SP
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 20:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758362AbaD2Stf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 14:49:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46763 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753522AbaD2Ste (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 14:49:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0083681540;
	Tue, 29 Apr 2014 14:49:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ONuqs42ep+l5gy+LrNuOf/xvYX4=; b=jWGYuw
	hVkKzVE7rmHzMOv35QgBgoEonbyYpfEoEgo2GgRhQBkICwSu94s/MNFnffsS28qP
	jsTblFEe9ik3h/i4irI+wpBOEK48v7JboH8PLFq1VOGKxzQrwa+/CCBoRnsEP8LA
	0xSOb20v22W8qjAV3BA4UK8EV8Q9BlrJyYUcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xUZkbuUkGDXCo1OZcLJiC9XJzB39tEz7
	Ul9zHnxDUbn8sQjmxyVHqhwutXvBf7wgyC/VobP/vhuX7YZYrhJjRw0U8Gco5GnG
	fqQ14wpqNdztP68uQQgtkXYCrs8Yopqp4R4+BAWi67fXy2nWKPnmhXE69nHE2uiP
	i9jm8XBeAL4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD2758153F;
	Tue, 29 Apr 2014 14:49:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 996C081538;
	Tue, 29 Apr 2014 14:49:31 -0400 (EDT)
In-Reply-To: <20140429180210.GB11832@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 29 Apr 2014 14:02:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0002BF82-CFCF-11E3-B469-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247601>

Jeff King <peff@peff.net> writes:

> I don't think we have a "str_utf8_cmp" that ignores normalizations (or
> maybe strcoll will do this?). But in theory we could use it everywhere
> we use strcasecmp for ignore_case. And then we would not need to have
> our readdir wrapper, maybe? I admit I haven't thought that much about
> _either_ approach. But aside from some bugs in the hash system, I do not
> recall seeing any design problems in the ignorecase code.

Our diffs and merges depend on walking two (or more) sorted lists,
and that sort order is baked in the tree objects when they are
created.  Using "normalized comparison" only when comparing the
earliest elements picked from these sorted lists would not give you
the correct comparison or merge results, would it?
