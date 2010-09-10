From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/2] merge-recursive: D/F conflicts where
 was_a_dir/file -> was_a_dir
Date: Thu, 09 Sep 2010 17:26:25 -0700
Message-ID: <7vhbhyjvf2.fsf@alter.siamese.dyndns.org>
References: <1283928041-9882-1-git-send-email-newren@gmail.com>
 <1283928041-9882-3-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, oinksocket@letterboxes.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 02:27:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtrSf-0006iC-Vk
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 02:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757333Ab0IJA0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 20:26:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34147 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215Ab0IJA0e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 20:26:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B289D4795;
	Thu,  9 Sep 2010 20:26:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=YI0IED5xpRAe9TDmNHTBBUviRH0=; b=c9m3AdyXJyDrN/1jQH52Ayn
	8sHAapLEWdmmOJpvZ5jo4bLcKq4K4JGTNUhjrs+abVPpa+MBl3G+1NxyodVhl/zq
	S3k64mnCGIXylMCJ1Gj9GNWEwSrafnjQ1YbyTVUq/BqNvi1KEGLu+3R3PxpKptYQ
	Yt4TodCoG47BrnEK00Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Vxhbjdj2EkNsv/j1fxJ3FIo54cmLb10da06ZiZyFlRbd7eEbc
	Z6zhHLLKlZWDzfvazQB2kB+skI3zsU3iPlHPJsq5oEqXx9Kt7PJXZzW0wWRoZS2c
	3vpzuxOhMq6cPhjwwWpPJzvHI98QcL6QWmIX1QkIyYeS8MIu9qZMKnN7X8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DC53BD4793;
	Thu,  9 Sep 2010 20:26:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FFC7D4790; Thu,  9 Sep
 2010 20:26:27 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0F060CCE-BC72-11DF-B3BE-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155917>

Elijah Newren <newren@gmail.com> writes:

> ... git can't know that there's a conflict
> until after it's tried resolving paths involving newsub/newfile to see if
> they are still in the way at the end (and if newsub/newfile is not in the
> way at the end, there should be no conflict at all, which did not hold with
> git previously).

I'll queue this patch to 'pu', but anybody who wrote the above to
correctly arriave at the crux of the issue in his analysis would know that
this is another band-aid on top of band-aid.  The approach merge-recursive
takes to first grab the set of directories and files fundamentally is
wrong---it should be resolving the paths in-core first and then look at
the result to ignore a directory that has become empty.
