From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] Documentation: describe --thin more accurately
Date: Mon, 15 Feb 2010 12:44:34 -0800
Message-ID: <7vfx52xm8d.fsf@alter.siamese.dyndns.org>
References: <1265961646-28585-1-git-send-email-bebarino@gmail.com>
 <1266262395-11864-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 21:44:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh7oI-0003B4-IR
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 21:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755733Ab0BOUop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 15:44:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467Ab0BOUon (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 15:44:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE6BD9AF59;
	Mon, 15 Feb 2010 15:44:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=uEk7VduFj3ytt3xHnIHwmn1aW7U=; b=gXgBFi2Q8m9YAf4z82Qbw/t
	7dAWNXE7kftYCJjjVejxrX5d7tzm23qxySovwMgmDvkVAJ6Z7f++bPb83v1QDL5x
	10dJ+1ZLWB7hQbiRYDQDnDaiwHHkksakRaWkPxlfjxhOhA5JLNBQWCIZCzCXGXtq
	O6/UiCDaDOvmemUzzaw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=O8MM25GHYTKl0lQWXE4qnryevobrMbP4d0FLUCggR2mdHmPg7
	6tLVJNyPV6SSngXJv5lzCdQPStahspZkeAJcmGSBso7hHN1PBkzS/n3uojzNGsjZ
	3X5x3fcIUk1csEhrxnVF8mb5I8rLMkVktHsiB5XTnqLzzs7ZNExUtYKpX8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9817A9AF29;
	Mon, 15 Feb 2010 15:44:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A10409AF25; Mon, 15 Feb
 2010 15:44:35 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EFC787EE-1A72-11DF-A612-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140031>

Stephen Boyd <bebarino@gmail.com> writes:

> The description for --thin was misleading and downright wrong. Correct
> it with some inspiration from the description of index-pack's --fix-thin
> and some background information from Nicolas Pitre <nico@fluxnic.net>.
>
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---

Looking better, thanks.

> index 65a301b..b4fa98e 100644
> --- a/Documentation/git-index-pack.txt
> +++ b/Documentation/git-index-pack.txt
> @@ -46,14 +46,15 @@ OPTIONS
>  	'git repack'.
>  
>  --fix-thin::
> +	It's possible for 'git pack-objects' to build a
>  	"thin" pack, which records objects in deltified form based on
>  	objects not included in the pack to reduce network traffic.
> +	The excluded objects are expected to be present on the receiving end
>  	and they must be included in the pack for that pack to be self
> +	contained and indexable. This option fixes the "thin" pack by
> +	adding the missing objects to the pack. Without this option any
> +	attempt to index a "thin" pack will fail. This option only makes
> +	sense in conjunction with --stdin.

Assuming that the reader knows only what "git objects" are, and that a
"pack" contains "git objects" either in full or in a "deltified form based
on another object", the description needs to explain three points:

 - "self-containedness" requirement to be directly usable by git;
 - "thin" pack reduces transfer by violating "self-containedness"; and
 - "--fix-thin" makes "thin" into "self-contained".

I however think the first two points might be better covered by the
description of `--thin` of `pack-objects` and we should simply refer to it
from here, like this:

    --fix-thin::
            Make a "thin" pack produced by `git pack-objects --thin` (see
            linkgit:git-pack-objects[1] for details) directly usable by
            git, by adding objects that the objects stored in the
            deltified form are based on to the packfile.

And we can thicken the --thin description of pack-objects like this:

> +--thin::
> +	Create a "thin" pack, which records objects in deltified form based
> +	on objects not included in the pack to reduce network traffic.
> +	The excluded objects are expected to be present on the receiving end
> +	and eventually must be included in the pack for that pack to be self
> +	contained and indexable (see the \--fix-thin option of
> +	linkgit:git-index-pack[1] for more details). This option only makes
> +	sense in conjunction with --stdout.
> +

    --thin::
            Create a "thin" pack in order to reduce network transfer.
    +
    For a packfile to be usable directly by git, any object in the pack
    that is represented in the deltified form must be based on an object
    that exists in the same pack.  Such a pack is called "self-contained".
    +
    If the sender sends an object in the deltified form based on an object
    both the sender and the receiver have, but excludes the common object
    itself from the datastream, it can often reduce the network traffic
    dramatically.  Such a datastream is called a "thin" pack.
    +
    Note that a thin pack violates the self-containedness requirement and
    is not directly usable by git on the receiving end without making it a
    self-contained pack by running `git index-pack --fix-thin` (see
    linkgit:git-index-pack[1]).
