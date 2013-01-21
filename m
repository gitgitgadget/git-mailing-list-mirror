From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL] Module fixes, and a virtio block fix.
Date: Sun, 20 Jan 2013 18:00:24 -0800
Message-ID: <7vpq0zi9c7.fsf@alter.siamese.dyndns.org>
References: <87zk03wg7r.fsf@rustcorp.com.au>
 <CA+55aFwzdcv0LXovZobha=EH=L6DapJt+ODP0nq=TWWAqCxLYQ@mail.gmail.com>
 <87fw1vwcao.fsf@rustcorp.com.au>
 <CA+55aFy1nW859yaGP17epRX8A+TaJ8APvb0-Ww1zw91dCAOhoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rusty Russell <rusty@rustcorp.com.au>,
	Git Mailing List <git@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alexander Graf <agraf@suse.de>,
	Prarit Bhargava <prarit@redhat.com>,
	Sasha Levin <sasha.levin@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 03:00:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx6gw-0005ZX-KS
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 03:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670Ab3AUCA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 21:00:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37730 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559Ab3AUCA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 21:00:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4ACD6A1BF;
	Sun, 20 Jan 2013 21:00:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aH3BdYh9P7NVLZPaDn6wgDKHF8Q=; b=pamm3Y
	OOIsBxYgG8sgdGpgzCR7KpYlk6XxfeBfOCW2QcYFK8+xJQYjJWfsjdYYX/Yt8/3t
	eyKrk0MaXUfyYPa73J8dXKC1OZknw1cgUefjMv9StUdM4Lejw77zl4CSE++AuOKQ
	gzbMNy4hVJ87K7AFUyz2DAEp+YiST9MBIVFk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d7d07JPT5CRg03kpKG26sl3mcy/5Wgwo
	3vzpfMa4UylPqjb6quSMPiMc8OJ3rzTaROyD2eP4i/Cxi9YCjdTWCsiNPaGNdAoC
	59HArCSvSee9tT0GTL+bMgPCWfpWCA9KnznEvaKs1GhXzf6nK9p6N8sQLIONHSoM
	rqMJ5qjci6k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E616A1BE;
	Sun, 20 Jan 2013 21:00:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9434A1B9; Sun, 20 Jan 2013
 21:00:25 -0500 (EST)
In-Reply-To: <CA+55aFy1nW859yaGP17epRX8A+TaJ8APvb0-Ww1zw91dCAOhoQ@mail.gmail.com> (Linus
 Torvalds's message of "Sun, 20 Jan 2013 17:45:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 529AEDCE-636E-11E2-8C23-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214073>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, Jan 20, 2013 at 5:32 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>>
>> Due to the delay on git.kernel.org, git request-pull fails.  It *looks*
>> like it succeeds, except the warning, but (as we learned last time I
>> screwed up), it doesn't put the branchname because it can't know.
>
> I think this should be fixed in modern git versions.
> ...
> Junio, didn't "git request-pull" get fixed so that it *warns* about
> missing tagnames/branches, but never actually corrupts the pull
> request? Or did it just get "fixed" to be a hard error instead of
> corrupting things? Because this is annoying.

What you mean by "corrupt" is not clear to me, but the last change
to the script is from 6 months ago to solve a related (perhaps the
same?) problem, which should be in v1.7.11.2 and later:

    request-pull: really favor a matching tag

    After tagging the tip of "dev" branch with a "for-linus" tag and
    pushing both out, running

        $ git request-pull $url $last_release dev

    would produce an output asking the 'dev' branch of $url to be
    pulled, because that is what the user asked the message to say.

    We already detect this situation locally and include the
    contents of the tag in the output; if the $url has that tag,
    favor that tag (i.e. "for-linus") in the generated message over
    the branch name the user gave us (i.e. "dev") from the command
    line, to make the output look more consistent.
