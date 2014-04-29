From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3910: show failure of core.precomposeunicode with decomposed filenames
Date: Tue, 29 Apr 2014 10:12:52 -0700
Message-ID: <xmqqvbtskqjv.fsf@gitster.dls.corp.google.com>
References: <20140428161630.GA9435@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 29 19:13:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfBaX-0005yz-Vm
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 19:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758265AbaD2RM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 13:12:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34418 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758248AbaD2RM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 13:12:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2AC0813EE;
	Tue, 29 Apr 2014 13:12:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5kBEKTFonLwWwTVex7a+nQXl4HI=; b=PRmK23
	6S4ozMZ1BzlCZXE25zAlkPeHqc/Pb3YOMyhT1tfNRPJvNaEW/yOhwXtk4ELs2+He
	NoiQV6JTwlcAvT+mlgIJ5CbseO+4E3pgXbVBVDhCxKc8E48sFQUK4Qw+cHQxl1Os
	mJVHc/ZpK9C1BQw/xHO+28YOLDXZ7qHuU1b6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eyhojbikwiXDB6scPvLhtQ7Aqnjiias2
	o6Gq+ZoX8TYHtD7EGf7LWUCoCQvnTkWp+B3lz4AIO+/OCmnoHppBu9Yx80VJe7pO
	AHmLDnY1DfWfXK2/NzC2Nsg9yTNunv0JkxLAMGnMGKmTjk1R5eVt5Iflrw0U7PNC
	938RevXVaBU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE48B813EC;
	Tue, 29 Apr 2014 13:12:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3C6E813E6;
	Tue, 29 Apr 2014 13:12:54 -0400 (EDT)
In-Reply-To: <20140428161630.GA9435@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 28 Apr 2014 12:16:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 80C16A78-CFC1-11E3-8AD8-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247592>

Jeff King <peff@peff.net> writes:

> This patch just adds a test to demonstrate the breakage.
> Some possible fixes are:
>
>   1. Tell everyone that NFD in the git repo is wrong, and
>      they should make a new commit to normalize all their
>      in-repo files to be precomposed.
>
>      This is probably not the right thing to do, because it
>      still doesn't fix checkouts of old history. And it
>      spreads the problem to people on byte-preserving
>      filesystems (like ext4), because now they have to start
>      precomposing their filenames as they are adde to git.

Hmm, have we taught the "compare precomposed" for codepaths that
compare two trees and a tree and the index, too?  Otherwise, we
would have the same issue with commits in the old history.

Do we have a similar issue for older commit in a history under
"ignore-case" as well?
