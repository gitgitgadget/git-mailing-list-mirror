From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH-v3] Allow git-filter-branch to process large repositories with lots of branches.
Date: Wed, 11 Sep 2013 09:06:59 -0700
Message-ID: <xmqqhadruyu4.fsf@gitster.dls.corp.google.com>
References: <xmqqli34uuvy.fsf@gitster.dls.corp.google.com>
	<CE550501.19691%lee.carver@corp.service-now.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Lee Carver <leeca@pnambic.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Lee Carver <Lee.Carver@servicenow.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 18:07:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJmwj-0000lD-Nd
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 18:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539Ab3IKQHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 12:07:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58055 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754959Ab3IKQHE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 12:07:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BEF241037;
	Wed, 11 Sep 2013 16:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H0NaB1yjZneKV9ZARbWjsZ+7xKo=; b=x2ZNdo
	YRZbrTjS3uJq3y5uxmGnrpk3R+e89/toiylL/OlT9IXy7mwChQdli5HXXnc5NdIh
	OdWRSBEfTvvkKCJzCPqAS8ow9aiOlklxnWv29oU0aS6dCXudUs2KXeNzzTmYajKU
	uGFhgdKcrMsx+l6pJCPBAKmxJkWgYLJofjrPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y3P4qJ04Hj4BfKEDNz9sy1JXisjP3IuW
	XcHatov43kr9T3uvVUN25FRQpu7BwCesJk6gCmbUUsvxa01mAWee07i0s1MrjZ8a
	s8533xcJ9GmtdNl12Aj5eW5MzWPbT12aJz2+nzuSa2K4eoFhKKOYpUE68zQtR3x1
	YgtJZycbVuo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D2DF41036;
	Wed, 11 Sep 2013 16:07:03 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9FFE41032;
	Wed, 11 Sep 2013 16:07:01 +0000 (UTC)
In-Reply-To: <CE550501.19691%lee.carver@corp.service-now.com> (Lee Carver's
	message of "Wed, 11 Sep 2013 00:21:15 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3232CCB4-1AFC-11E3-927D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234571>

Lee Carver <Lee.Carver@servicenow.com> writes:

> It is using the same ${tempdir} working directory that git rev-list uses
> below for the ../revs file

Ah, I missed that; then that should be safe.  The patch looks sane.

Can we have your sign-off, too, please?

>
> It's normally .git-rewrite/t, following the normal working directory setup
> near line 205.
>
>>
>>>  
>>>  case "$filter_subdir" in
>>>  "")
>>> @@ -268,7 +268,7 @@ case "$filter_subdir" in
>>>  esac
>>>  
>>>  git rev-list --reverse --topo-order --default HEAD \
>>> -	--parents --simplify-merges $rev_args "$@" > ../revs ||
>>> +	--parents --simplify-merges --stdin "$@" < ../parse > ../revs ||
>>>  	die "Could not get the commits"
>>>  commits=$(wc -l <../revs | tr -d " ")
