From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] deprecating and eventually removing "git relink"?
Date: Mon, 14 Nov 2011 02:24:32 -0800
Message-ID: <7vmxbzj927.fsf@alter.siamese.dyndns.org>
References: <7v4ny7mtbx.fsf@alter.siamese.dyndns.org>
 <buomxbzutjm.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 11:24:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPtiS-0007nv-Ek
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 11:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724Ab1KNKYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 05:24:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41128 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324Ab1KNKYf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 05:24:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E0F151D0;
	Mon, 14 Nov 2011 05:24:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=50klqjAlqmYuiuXAIiXj+4v08JI=; b=dMzBsdcQbS6avG37LUxj
	d/1WmpM3xKgzIAyqzfuDJbNj+0+Fj4B0nCcu43GS3tJk4rjbwavDWLyd2GR9nBwl
	vcfwuJvG058uxbxr6UYu12THOLRIE0Ofs7qPaklmHAkVOo0YDA9whjWN7W0ky1kQ
	vECraDdY4ynjcSpy4lUKGlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=l54s84XY+tSsVUeyHCNgnSB648L0uHAoOOlaHRw2rIxh5j
	4P7OcFZuR27GKn/7AzoGPCNo6MPdlf2DLDZSYFmsmqgWE5X4VkJ6Baqrz19Q+pUD
	j4zXumcURA9aYaj0psVC1JxzjQhlUHNtNivotaIvyMj9CAQ0mC1vrmzkF8LWQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65AFF51CF;
	Mon, 14 Nov 2011 05:24:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC91651CE; Mon, 14 Nov 2011
 05:24:33 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8A5B896-0EAA-11E1-B22A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185372>

Miles Bader <miles@gnu.org> writes:

> It might be nice to have a mechanism where new objects would update
> the _alternate_ rather than the object-store in the tree where the
> command was run.

With the alternate mechanism, your borrowing is read-only and that is
exactly why you can borrow from other peoples' repositories to which you
have no write permission to.

What you are suggesting is fundamentally different from the alternates
mechanism. I am not saying it is better or worse, though. Not yet at this
point in this message.

> .. then you could easily have a bunch of trees using a
> central object store without needing to update the central store
> occasionally by hand (and do gc in its "clients")...

If you write objects to the central store, "gc" in the "clients" will be a
no-op because they do not have their own objects. But instead, crufts your
"clients" accumulate will be in the central store. There is still need for
"gc" at the central store to remove things that are no longer used by any
client, isn't it? Unless you declare that you do not care because perhaps
the central store is large enough, that is.

At least with the alternates, running "gc" in the "clients" is a safe
operation and the only change necessary is to make fsck/repack aware of
the repositories that borrow from the repository these commands are run,
and the logic to do so is exactly the same as the case to run "gc" in your
central store, I would think.
