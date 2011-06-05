From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarified how "git submodule add" handles relative
 paths.
Date: Sun, 05 Jun 2011 11:27:36 -0700
Message-ID: <7vipskb0br.fsf@alter.siamese.dyndns.org>
References: <7vaae2ihe1.fsf@alter.siamese.dyndns.org>
 <1306943792-1825-1-git-send-email-marcnarc@xiplink.com>
 <7vsjrth4iy.fsf@alter.siamese.dyndns.org> <4DE69945.1080601@web.de>
 <7v39jsdulf.fsf@alter.siamese.dyndns.org> <4DE93B29.4030401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Jun 05 20:27:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTI3H-0004uO-M1
	for gcvg-git-2@lo.gmane.org; Sun, 05 Jun 2011 20:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936Ab1FES1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2011 14:27:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414Ab1FES1t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2011 14:27:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 86D374330;
	Sun,  5 Jun 2011 14:29:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BCRz83FY/ZFQ11FbamZyHLTWB80=; b=b9Z1wW
	fsc9ez9HEGxfZf7qnnqIhpc0BFAEBn1G5i9muYFqOJCTRbC4KUIiQfwRrb3G8YDi
	jD/xMR3Ws9VNKGFS+ltuP2If8sJx0hzRffnosj1nhR4RPl8poN00V7gBLeWDVUJ1
	ytIrnznIvm50s+Qy3HG/p6QtXtFtlQkp1GPYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uhL3H60xOufrPkVHHnFzYWya8/JaAZQZ
	6JkTCLAf0xX5DiF+bf7dYodfTdLs4JxiNYZxF2FXI1yGy94ZTqHAquu74usFxcbG
	kHAN1M/Om3uJynMYkFI+xo4kAlTVwYZtR7Y/VF6kzO7i2pjfCVZZwzcEcyodZbJi
	YDJwspiesVc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4068E432C;
	Sun,  5 Jun 2011 14:29:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B27E7432B; Sun,  5 Jun 2011
 14:29:47 -0400 (EDT)
In-Reply-To: <4DE93B29.4030401@web.de> (Jens Lehmann's message of "Fri, 03
 Jun 2011 21:51:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE1D5F74-8FA1-11E0-8B2A-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175082>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 02.06.2011 19:14, schrieb Junio C Hamano:
>> I suspect that it would be a relatively easy fix if your toplevel
>> superproject is its own authoritative upstream.  Something along the line
>> of this patch, perhaps?  It is obviously untested, and we may want to
>> issue an "echo >&2 'info:...'" to tell the user what we are assuming in
>> this codepath.
>
> Maybe it is better to not automagically switch from "path is relative to
> url configured in superproject" to "path is relative to $(pwd)" depending
> on the presence or absence of a default remote in the superproject. When
> a user wants to set up his submodules relative to the superproject and
> simply did forget to configure the url of the superproject first he won't
> notice that anymore after this patch. But instead he will get a local
> submodule url only to find out later that this was not what I wanted (and
> an 'info' can easily be missed).

Sorry, I don't get this. The "how-about-this" patch was not about
"automagically switch depending on ...". Absense of the remote in the
superproject means that the project originates from here, iow, it is its
own "origin" (that is your third use case).

I think I understand the scenario you are worried about; let me illustrate
to make sure I got it right:

 1. You are starting your project that will have subproject locally. You do
    not have "origin" yet.

 2. You create a subproject "xyzzy", still locally, and add it with
    "submodule add ./xyzzy" with a relative URL.

 3. You will deploy your superproject and subproject at "git://host.xz/mine/"
    and "git://host.xz/mine/xyzzy", respectively.

 4. But because in step 2. your .git/config is already set up to point
    your local $(pwd)/xyzzy as the submodule location. This is not what
    you want and you may not notice it.

Is that the problem you are worried about? If so, I think you are solving
it in a wrong way.

By not allowing a relative path, in step 2. you would entice the user to
say "submodule add $(pwd)/xyzzy" (as there is no final upstream location
yet), no? If the project is going to be eventually published at a
different location, not just .git/config but .gitmodules also needs to be
updated as part of step 3. Isn't that going backwards?  If you allow the
user to say "./xyzzy" in step 2., the .gitmodules entry can stay the same
from the get-go.

If you think about "absense of the remote in the superproject means the
project originates from here", what you are doing in step 3. is to
changing the origin of these set of projects. After changing the origin of
these set of projects, isn't "git submodule sync" an established way to
adjust to the change? I was hoping that that would update .git/config in
step 3. so you wouldn't have the problem in step 4. at all.

It is likely I am missing something in the above analysis. Please correct
me.

Thanks.
