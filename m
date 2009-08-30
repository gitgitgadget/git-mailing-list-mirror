From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2009, #05; Wed, 26)
Date: Sat, 29 Aug 2009 21:06:10 -0700
Message-ID: <7vskfat07h.fsf@alter.siamese.dyndns.org>
References: <7vfxbeb0mt.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0908292116060.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Aug 30 06:06:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhbgU-0004Mh-UN
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 06:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbZH3EGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 00:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbZH3EGS
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 00:06:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39147 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbZH3EGR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 00:06:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0B70B3C85B;
	Sun, 30 Aug 2009 00:06:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d3gLfviNhwBKuTh+EOG1KUJr76o=; b=HqyhPq
	MXq9660/o7d+k5uWuFMgIpU7AvurX0QiLJAhSn8Vn+Wp931gcVczjQAqGx184l2d
	WoEf6kjKp4YhlmXJxEj7lSTcOGXMl/TPohTSFMviemIRxQrMTBmzKabe4bvEdbD0
	hyZWmLx7xcqumQKlYaiYfzSiyrPSUTyeYujmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QuX6j0EB01HaSthJO/Osq3396j7UgizV
	4Gjn/LNa9YXkBr2D599RIxHf+/riBsGYUbYeFihBYbaJU7EJ+IgHbjYdMLTQ89GH
	QEaAF/l9fwZjX1n3r+bZExtq0iFlgWdloCRq3ic0LLckdPoLlhTejPuJohRoyyyL
	YiOCP5MbvOA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E493C3C85A;
	Sun, 30 Aug 2009 00:06:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3E0E63C859; Sun, 30 Aug 2009
 00:06:11 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.00.0908292116060.28290@iabervon.org> (Daniel
 Barkalow's message of "Sat\, 29 Aug 2009 21\:46\:03 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7695233C-951A-11DE-864E-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127392>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> There was a discussion that suggests that the use of colon ':' before vcs
>> helper name needs to be corrected.  Nothing happened since.
>
> I believe the outcome of that discussion was:
>
>  - We want to keep supporting using regular location URLs that are URLs of 
>    git repositories (e.g., http://git.savannah.gnu.org/cgit/xboard.git), 
>    and we probably want to do it with a helper which runs when 
>    run_command() is given "remote-<scheme>". I think installing hardlinks 
>    in EXECPATH ended up being the best implementation here.

That is different from what I recall.

I think you said <scheme> in the above to mean that in the general URL
syntax, <scheme> refers to the token before the colon, and you would be
feeding the rest (i.e. after the colon, and for many <scheme>'s it
typically begins with //) to the scheme.

A flaw with this that was pointed out was that this conflicts with the
scp-like syntax.  A remote.$name.url of foo:bar/baz could name
$HOME/bar/baz on host foo (perhaps a nickname in .ssh/config), or the
source "foo" helper recognizes with the name bar/baz.

If I recall correctly, suggestions made later in the discussion were to
use either <helper>+ or <helper>:: as the prefix to avoid this issue, and
use it to choose remote-<helper> (and I think I probably would vote for
double-colon, if only to avoid confusion with our own earlier misdesigned
syntax git+ssh://), so the canonical syntax would be:

	<helper>::<whatever is fed to the helper, typicall a URL>

while we would support obvious short-hands for transports we traditionally
supported without explicit "<helper>::" prefix when we choose to eject it
from "built-in" set of transports.

E.g. http://git.savannah.gnu.org/cgit/xboard.git would be handled by curl
based walker, so if you spell it in the very canonical form, the url would
be curl::http://git.savannah.gnu.org/cgit/xboard.git, but nobody has to
use it.  Instead, the transport dispatcher internally recognizes http://
and picks the curl based walker helper, which is remote-curl without any
extra hardlinks.

And from my point of view, this is what is blocking the series; and there
still is no -rc0 yet (I've been hoping to do a 1.6.5 mid September before
I leave for Japan for about a week), because I think it is pointless to do
a new release without "the ejection of curl from builtin".

>  - We want to support a separate "vcs" option for cases where repositories 
>    in the foreign system need to be addressed through the combination of a 
>    bunch of options, which will be read from the configuration by the 
>    helper. The helper which gets run is "remote-<value of vcs option>". 
>    This is in pu.

After you explained this in the thread (I think for the second time), I
see no problem with this, except that I think to support this we should
notice and raise an error when we see a remote has both vcs and url,
because the only reason we would want to say "vcs", if I recall your
explanation correctly, is that such a transport does not have the concept
of URL, i.e. a well defined single string that identifies the repository.
