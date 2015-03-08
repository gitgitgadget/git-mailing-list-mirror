From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/10] Use a structure for object IDs.
Date: Sat, 07 Mar 2015 23:43:32 -0800
Message-ID: <xmqqa8zoszmj.fsf@gitster.dls.corp.google.com>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Andreas Schwab <schwab@linux-m68k.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Mar 08 08:43:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUVsD-0001Ow-C5
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 08:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbbCHHnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 03:43:35 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52954 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751189AbbCHHne (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 03:43:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B6A13760E;
	Sun,  8 Mar 2015 03:43:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YsNiFcprCcXfpc7Hu9jrOz/+6ek=; b=i+ye2D
	o4GIn2DJSjj+4zAtu8Mly207nDAcc9VwQgsuJriAYVn0h7Istk2fJpFslVOxVOOf
	+ocXRHV1FwkgnxgHhBzLYF4wxpbBvPHHwRYxOmtqd7bC9wVMwSt87DGvLBCkQ/MD
	dNWiLIL8QfFwcqvWkYuLgbrQe24qZQCl4dFZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qDM3afbxbLP4Iv9InJNlJd/8KIpIfdrC
	yC4FOXtlqJtYVtSd9XFTS1XXaDeda4ZmY7+Tz9IEI0Nytjb+jlHVCICLo24ioMtg
	U64aSh+wbAWGALET1aLoJrHJrpUe7q+anYb22PpBTvs53sqUsSV4c6IA9gjTiXEY
	8BoRUkjtH0Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 026803760D;
	Sun,  8 Mar 2015 03:43:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 815B337609;
	Sun,  8 Mar 2015 03:43:33 -0400 (EDT)
In-Reply-To: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Sat, 7 Mar 2015 23:23:55 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D26A39F4-C566-11E4-B423-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265036>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Certain parts of the code have to be converted before others to keep the
> patch sizes small, maintainable, and bisectable, so functions and
> structures that are used across the codebase (e.g. struct object) will
> be converted later.  Conversion has been done in a somewhat haphazard
> manner by converting modules with leaf functions and less commonly used
> structs first.

That "leaf-first" approach sounds very sensible.

In the medium term, I wonder if the changes can progress faster and
in a less error prone way if you first used GIT_SHA1_RAWSZ in places
that cannot be immediately converted to the struct yet.  That way,
we will be easily tell by "git grep GIT_SHA1_RAWSZ" how many more
places need treatment.  I do not know if that is all that useful
offhand, though.  Those places need to be touched in the second pass
to use the struct again, after the "s/\[20\]/[GIT_SHA1_RAWSZ]/"
first pass.
