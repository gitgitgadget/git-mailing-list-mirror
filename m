From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Add optional parameters to the diff option
 "--ignore-submodules"
Date: Tue, 08 Jun 2010 10:28:28 -0700
Message-ID: <7vhbldtow3.fsf@alter.siamese.dyndns.org>
References: <4C0E7037.8080403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 08 19:28:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM2bZ-00019w-JX
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 19:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982Ab0FHR2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 13:28:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200Ab0FHR2n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 13:28:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D460BA778;
	Tue,  8 Jun 2010 13:28:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4fpAZmV/STStsRbg0wiI7N5QyOw=; b=fc+ewV
	gHCLnPAd+ljuwgOywDMBzH9VacaIu01dYLRreoXlfG69/rreSHYrzMC9Ald+/Plm
	RZGc94eQkmI+92D68EcuoqXmYQSIoh1MqLPsj3FDLcC+tspVGqly2jb+0lcpiajH
	5a49UKhAKaknxpXSMZ3SJrI07RY71+0pcRc0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sfPYBmSBQZJCLHIpdJlOt0820dw+GYBH
	hcrvMx8DWJOkAN46u92Oa351/fL/vKNpxP0fo1GGFSiBcd7VzJmSoJ3wP90CpRI7
	jFGrBdGlB9mUcL2sjDyDiMGGcj4QswLseVj0KhLU8K8ppB8V+LEXSEi2YTB8tleB
	9H/GjFM1f9k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CA4B0BA773;
	Tue,  8 Jun 2010 13:28:37 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FEB0BA76F; Tue,  8 Jun
 2010 13:28:30 -0400 (EDT)
In-Reply-To: <4C0E7037.8080403@web.de> (Jens Lehmann's message of "Tue\, 08
 Jun 2010 18\:30\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 45DEF5DC-7323-11DF-9B20-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148695>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> After thinking some time about peoples expectations and troubles
> with the recursive scanning of submodules, I came up with this:
>
> What about expanding the "--ignore-submodules" option of the git diff
> family with three parameters:
>
> --ignore-submodules=all : Same behavior as "--ignore-submodules",
>   submodules show never up as modified.
>
> --ignore-submodules=untracked : Don't consider submodules as modified
>   when they only contain untracked files, but do if the commits in the
>   superproject are different or tracked content is modified.
>
> --ignore-submodules=dirty : Don't consider submodules as modified
>   when their work tree is dirty, no matter why. This is the pre 1.7.0
>   behavior and doesn't recurse into submodules at all.
>
> The first patch is just a resend of a test case rename, the second
> contains the implementation.
>
>
> To make that more useful the default could be controlled by the
> .git/config or .gitmodules file. So you could have two submodules:
>
> [submodule "sub1"]
> 	path = sub1
> 	url = /home/me/sub1.git/
> 	ignore = dirty
> [submodule "sub2"]
> 	path = sub2
> 	url = /home/me/sub2.git/
> 	ignore = untracked
>
> Where sub1 will not be scanned for work tree modifications by "git
> diff" and "git status" and for sub2 any untracked files inside the
> submodule will be ignored. And then "git status" should learn the
> "--ignore-submodule" option too. With a fourth parameter "none" it
> would be possible to override the defaults from the configuration
> anyway you want.
>
> Opinions?

The above outline (I haven't looked at the code) sounds sane.  We might
even want to make untracked (or dirty) the default, if nothing is given
from the command line nor configuration.

I don't see a reason for patch 1/2, though.

Thanks.
