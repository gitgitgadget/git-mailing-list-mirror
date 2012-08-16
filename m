From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request: fetch --prune by default
Date: Thu, 16 Aug 2012 16:22:54 -0700
Message-ID: <7vzk5uxvzl.fsf@alter.siamese.dyndns.org>
References: <2C63E314-2EF5-4B8E-B96A-5306E317E045@gmail.com>
 <20120719115558.GC29774@sigill.intra.peff.net>
 <CAPBPrnsFk-Ww-52W-=qkTK7Yifjowx3tpsELznO4ncmqwfP_Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexey Muranov <alexey.muranov@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 17 01:23:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T29PA-0005cH-0z
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 01:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651Ab2HPXXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 19:23:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55356 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932585Ab2HPXW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 19:22:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C9F58E7A;
	Thu, 16 Aug 2012 19:22:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O3Alt12p33zbFCxcVCqHwGOSFlw=; b=h2vcUG
	7LUEtcCbuscgsSlRRmyt4pf4c2FzL+ef70+qlrptgFt12Nr1A0ZLli2/8cjF3GvX
	WmbswpST1RX4RXGgSm1/DqC412n8rWedtdoRInMZ+wBZGYUZLfGoBlnvEDLDgToN
	8bsZvSV7p+69lSgbcScONNdU69MP7FuHkWor0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F1EoknkDdDfU4vivg1HCyU3Vfe2XwL/0
	i9WAjWdDNI9baOwVPlNUUSHGeF4Q+FS4NCo3tGa8Yp1lrf5Qyc49P9ZFRnPQ3kmR
	fdlGgiqtaBYaB34+MnaGRvtEMrCOcLaP+fD/kFItl/zHdfOzomRGdQ734o95MsMO
	y6nQNiXMRik=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79AC88E79;
	Thu, 16 Aug 2012 19:22:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D59BF8E78; Thu, 16 Aug 2012
 19:22:55 -0400 (EDT)
In-Reply-To: <CAPBPrnsFk-Ww-52W-=qkTK7Yifjowx3tpsELznO4ncmqwfP_Qg@mail.gmail.com> (Dan
 Johnson's message of "Thu, 19 Jul 2012 10:03:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F29B3E6-E7F9-11E1-995D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan Johnson <computerdruid@gmail.com> writes:

> On Thu, Jul 19, 2012 at 7:55 AM, Jeff King <peff@peff.net> wrote:
> ...
>> So I think it would be a lot more palatable if we kept reflogs on
>> deleted branches. That, in turn, has a few open issues, such as how to
>> manage namespace conflicts (e.g., the fact that a deleted "foo" branch
>> can conflict with a new "foo/bar" branch).
>
> In the meantime, would it make sense to introduce a configuration
> variable to request this behavior?
>
> If so, should it be global?
>
> fetch.prune = always
>
> or per-remote?
>
> remote.<name>.prune = always
>
> The global option seems to be more in line with what Alexey is looking
> for, but the per-remote one is similar to the tagopt option, which is
> a similar idea.
>
> Of course, this might be just a waste of time to introduce a feature
> no one would use, in which case we obviously should not introduce such
> options.

I was reading through the backlog today and noticed that this topic
veered into the "reflog graveyard" tangent.  I wasn't involved in
the main topic, but I think having both configuration variables,
remote.<remote>.prune taking precedence over fetch.prune, as long as
we make sure "fetch --no-prune" will override any configured
default, is not a bad thing per-se.

As long as the users who elect to use this feature are aware of the
pruning of the refs and logs, that is, but "branch [-r] -d" has been
the way to lose both the branch and its log for a long time, so I do
not see a big issue there, either.

The log graveyard is an independently interesting idea, which I may
ping separately, but I consider it pretty much orthogonal to this
particular topic.
