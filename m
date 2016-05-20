From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv8 0/5] pathspec magic extension to search for attributes
Date: Fri, 20 May 2016 10:00:47 -0700
Message-ID: <xmqq1t4wfyv4.fsf@gitster.mtv.corp.google.com>
References: <20160519010935.27856-1-sbeller@google.com>
	<xmqqiny9j2sc.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZvZQxPUkECupvqk0KRbq-pRK6y=GksOiYn_zz+TM=dBA@mail.gmail.com>
	<xmqqshxdhi76.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYx_pX81bmpyXCvJSVsZW=t3VpBizUPQ90Wz9=HdG42UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 20 19:08:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3nnM-0005LR-Ks
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 19:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292AbcETRAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 13:00:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756004AbcETRAu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 13:00:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 64DBB19C35;
	Fri, 20 May 2016 13:00:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1efi9bSyL4kzOfkrmr4ofmUitN8=; b=XuT4ra
	SaD27nhD05pLya+yUnEHRi8IveGU2E2gP8oHxsCkVeMuJcp+fSB7GoRnLy0I9+yJ
	T2LlLNG9U02lrxHKINv6qWWHhzcbabABkQgoej7FENJKAOEMloxdAqqfZX4tMZHl
	1WEcgHNG4nt8Sa6GPGhU45kLnoVNqgpP2I1/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gt/862ys5kj5o8Y+gwO0hpcz1IVkzuPU
	YFIVxLVZfqoLU0vQ3YNXIIWkNpChDmS/gpRaIQ06nlCvr0FAWTUmv5/gnyXGas/H
	hDS2xROcxoMeKLGtk5+Q+v7fNnT3eKQBtFfuGrvcQyho22Z5XPoBu2UzYvXS9IR5
	xuzvNblXcoE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5BDA019C34;
	Fri, 20 May 2016 13:00:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB19719C33;
	Fri, 20 May 2016 13:00:48 -0400 (EDT)
In-Reply-To: <CAGZ79kYx_pX81bmpyXCvJSVsZW=t3VpBizUPQ90Wz9=HdG42UA@mail.gmail.com>
	(Stefan Beller's message of "Thu, 19 May 2016 14:25:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 66CA1DB8-1EAC-11E6-B7D5-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295186>

Stefan Beller <sbeller@google.com> writes:

> Right. But upon finding the new name for clone, I wondered why
> this has to be submodule specific. The attr pathspecs are also working
> with any other files. So if you don't use submodules, I think it would be
> pretty cool to have a
>
>     git clone --sparse-checkout=Documentation/ ...

It would be cool, but arent' "sparse" and the various existing
status "submodule" has very different things?

 - A submodule can be uninitialized, in which case you do get an empty
   directory but you do not see .git in it.

 - A path can be excluded by the sparse checkout mechanism, in which
   case you do not get _anything_ in the filesystem.

So "git clone --sparse-exclude=Documentation/" that does not waste
diskspace for Documentation/ directory may be an interesting thing
to have, and "git clone --sparse-exclude=submodule-dir/" that does
not even create submodule-dir/ directory may also be, but the latter
is quite different from a submodule that is not initialied in a
superproject that does not use any "sparse" mechanism.

Besides, I think (improved) submodule mechanism would be a good way
forward for scalability, and "sparse" hack is not (primarily because
it still populates the index fully with 5 million entries even when
your attention is narrowed only to a handful of directories with
2000 leaf entries; this misdesign requires other ugly hacks to be
piled on, like untracked cache and split index).

I do not think we want "submodule" to be tied to and dependent on
the latter.
