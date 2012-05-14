From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ls-tree and wildcards
Date: Mon, 14 May 2012 09:43:38 -0700
Message-ID: <7vbolqiuh1.fsf@alter.siamese.dyndns.org>
References: <4FAE7CBD.3020605@rotorised.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ryan McCue <lists@rotorised.com>
X-From: git-owner@vger.kernel.org Mon May 14 18:43:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STyN8-00006v-GK
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 18:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab2ENQnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 12:43:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37999 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901Ab2ENQnl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 12:43:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA1A4961D;
	Mon, 14 May 2012 12:43:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cl/2lN5hWhb0op4KixZPqELXi3I=; b=MxnpyP
	xdh7q4UqFwMiFCQbDnReUqa8qeqK72DOj820/3CkXc4RpfQ1/9bN9PKBBMgFXmm5
	2L8WlopXmx9dMlmIGN8ykGhA355mHj4CgI+hTKk+XJPcWoXLT20kVJ4QXqFAhTSa
	aguslxRoiUfljeBv3w0TNdy0bHCQXm5v69CPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vbGdt8PMnmofG+zI+WK0ZPrCTB52oiCT
	LknseROMR8JfEs+3vcfiykJdDnGUGnTrJWsBIUXnMDvz0lAaL2ITBc0BHPSjP3jD
	MZWOWpZhOZ4JZPMCF8frrDsXGRkdvrFU9IFKuDtEiPpFquS5XRomLE0cPeMhLSee
	GVjGNeEvNs8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A10E7961C;
	Mon, 14 May 2012 12:43:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38C6C961B; Mon, 14 May 2012
 12:43:40 -0400 (EDT)
In-Reply-To: <4FAE7CBD.3020605@rotorised.com> (Ryan McCue's message of "Sun,
 13 May 2012 01:07:41 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5A88658-9DE3-11E1-8776-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197784>

Ryan McCue <lists@rotorised.com> writes:

> Good evening folks,
>
> I'm attempting to grab relevant information for files in a tree
> matching a given pattern with wildcards. The help for ls-tree
> indicates that it can accept a pattern of files to match,...

There are two uses of "pattern" there, and the former is probably OK but
the latter is indeed misleading.  Back when we wrote this command, there
were two distinct "pathspec" families, and ls-tree belong to the one with
"diff" family that did *not* take anything but "leading path pattern" (the
other one from "ls-files" and "grep" family allowed wildcards).  Giving a
wildcard to the command in the "ls-tree/diff" family was never supported.

Later Nguyen and others started working on unifying the two separate
"pathspec" semantics and we are probably halfway there.  Many of the
commands from "diff/log" family now can take wildcard (there may be new
bugs in the codepaths, though), but "ls-tree" has not been converted.
