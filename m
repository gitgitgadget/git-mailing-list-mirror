From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Rename conflicts in the index
Date: Tue, 02 Apr 2013 17:57:50 -0700
Message-ID: <7vobdw77n5.fsf@alter.siamese.dyndns.org>
References: <A54CE3E330039942B33B670D971F857403995D93@TK5EX14MBXC252.redmond.corp.microsoft.com> <7va9q72n1u.fsf@alter.siamese.dyndns.org> <A54CE3E330039942B33B670D971F857403A0AA7A@TK5EX14MBXC253.redmond.corp.microsoft.com> <7vboa6t14w.fsf@alter.siamese.dyndns.org> <A54CE3E330039942B33B670D971F857403A0BA54@TK5EX14MBXC253.redmond.corp.microsoft.com> <7vk3osn3vs.fsf@alter.siamese.dyndns.org> <A54CE3E330039942B33B670D971F857403A0BB93@TK5EX14MBXC253.redmond.corp.microsoft.com> <7v38vgmxty.fsf@alter.siamese.dyndns.org> <A54CE3E330039942B33B670D971F857403A0E20C@TK5EX14MBXC253.redmond.corp.microsoft.com> <A54CE3E330039942B33B670D971F857403A0F540@TK5EX14MBXC253.redmond.corp.microsoft.com> <7vr4isaath.fsf@alter.siamese.dyndns.org> <7vsj3877u8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Edward Thomson <ethomson@microsoft.com>
X-From: git-owner@vger.kernel.org Wed Apr 03 02:58:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNC1u-0008Jo-7y
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 02:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758990Ab3DCA5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 20:57:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59975 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758568Ab3DCA5x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 20:57:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9ED310CA4;
	Wed,  3 Apr 2013 00:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ocA9yxeHNMhNX5DWLila87SxlfI=; b=qi76Co
	tHzqkJCKVtPQHA3yGH3P9s9NEDXGkQ+nThH3R+sfGpXyZQLxgMQBXxQHwBgq1HzS
	Rlths4RZgF2j4ANIXjwAjtEdU5I3aSLgkbTTmIzFKod2i0HgfcQ5PD4l8eShkgsZ
	iaznrIVvpGPMb2Vqt4gbUEAvAxxPZ38Q21rqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tY8QqaWwQxjEaZzikr4N6pdGi5trbvUN
	GRhSdlxz7F4w3bAhAyZzB3eRBwlHgcmoe2qglCXc/iteS1pfM8a7wbTqqg4RSHON
	UXnAPvD3oYbj7651bGAPadcnpKbhYiKO1ifeeivmPW4EdOOmAMV1S4OQpHh01MpS
	QMXf2FBMK8k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1AC710CA3;
	Wed,  3 Apr 2013 00:57:52 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DB5910CA1; Wed,  3 Apr
 2013 00:57:52 +0000 (UTC)
In-Reply-To: <7vsj3877u8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 02 Apr 2013 17:53:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8310DD06-9BF9-11E2-B1CA-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219907>

Junio C Hamano <gitster@pobox.com> writes:

> If I were solving the issue, I would probably proceed like this:
>
>  * Start from a rough sketch of what extra information I would want
>    to store in the new index extension section.
>
>  * Teach read-cache.c to read from the new extension and keep it in
>    an in-core data structure, and read from the in-core data
>    structure and seriealize it to write to the extension section.
>
>  * Perhaps enhance "update-index" so that it can read textual
>    representation of the contents of the new extension section, turn
>    it into the in-core representation, so that it can write it out
>    to the index file, as a debugging/development aid.
>
>  * Teach read-cache.c to read from the new extension and keep it in
>    an in-core data structure.

Sorry, this is a dup of the second one.  Please ignore.

Also, all "you" in this section should read "I" (because this is a
description of "If I were solving it").

>  * Teach wt-status.c to read from that in-core data structure and
>    improve the presentation of the cases I care about using that
>    information.  Use the "update-index" development aid to prepare
>    various cases you care about.
>
>     - If the kind of information that is stored in the new extension
>       turns out to be insufficient, go back to the beginning and
>       iterate.
>
>     - If the use the in-core data structure here turns out to be
>       awkward, go back one step and iterate.
>
>     - As I cover one more case, I would add a test to the test suite
>       so that we would know what cases are covered and what the
>       expected end-user presentation should be.
>
>  * Once the result of the above covers all the cases I care about,
>    then update merge-recursive.c to prepare the in-core data
>    structure to be written out as the extension section.
>
> As I iterate, the rough sketch will hopefully cover all the cases I
> care about and I'll be ready to write them down as an update to the
> document somewhere in Documentation/technical/api-*.
>
> Thanks.
