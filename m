From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] submodule update: Initialize all group-selected submodules by default
Date: Thu, 21 Jan 2016 12:47:18 -0800
Message-ID: <xmqqk2n2y815.fsf@gitster.mtv.corp.google.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<1453260880-628-4-git-send-email-sbeller@google.com>
	<xmqqr3hc3pmz.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYJJ+JxgLBqD1Y_UWACUd7yJGnU+rnwEnU6X041deftjQ@mail.gmail.com>
	<xmqqlh7jzgsx.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbHvPRa9vn7_BjiNJ+PGT3LWXZXMdTZRJmHP9bJ-_rHZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 21:47:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMM8c-0005Pa-FG
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 21:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbcAUUrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 15:47:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64047 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750814AbcAUUrV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 15:47:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A5D723C479;
	Thu, 21 Jan 2016 15:47:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Srko3DPFPq9EzHf3YJSKpGqALK8=; b=joNVHC
	lS9a/qyJyb3zVq4qI0ZRxy/xerYiyS13hC3c1ftlpPejY1eSe/aU9BXi8GfEpwWn
	XYJm3ZyHdhZ9JoRsoYSkGebJrg7eX2PKQPpq3LHOx6lQfCPu0Z9af0zUZMVmSLOK
	knEX6cpMeDOGR3QU4ljQs5KbbEsI84DPnU22Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gDO/ZFWceqHHwmsQ7v7Bojxe+uR5PiRp
	jeNN3BGXUnsVA71qmRvdl2mwYA4wM8OxN/NYhK3NY06YsydOuPbLglPM95GGwawQ
	+5yM7WPJktUWLt4JQ1BprkHYDBhONeS9XGUrrSta/RzAG9khaCIeZpN8ybFAlXuL
	RKRtxQs9uiw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9D8B03C478;
	Thu, 21 Jan 2016 15:47:20 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 20BC83C472;
	Thu, 21 Jan 2016 15:47:20 -0500 (EST)
In-Reply-To: <CAGZ79kbHvPRa9vn7_BjiNJ+PGT3LWXZXMdTZRJmHP9bJ-_rHZA@mail.gmail.com>
	(Stefan Beller's message of "Thu, 21 Jan 2016 11:39:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2A3A825A-C080-11E5-B70D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284523>

Stefan Beller <sbeller@google.com> writes:

> "submodule.$name.group" to be found in .gitmodules, maybe overwritten in
> .git/config tells for each submodule its memberships of groups.
>
> "submodule.group" should be found in .git/config only, to tell some time
> after cloning which group selection was made, such that we can check
> if new submodules need to be initialized (or even automatically removed).

Ahh, it wasn't clear that was what you were trying to do.  If that
is the case, then ...

>     "git submodule update" may initialze and fetch new modules if the
>     .gitmodules file changed their view of what "default" is.
>
>>  The name of the operation, i.e. what is to be done to the
>> chosen modules, should be orthogonal, so I do not think you should
>> have "submodule.autoinitgroup" or somesuch.
>
> I agree there.

... I do not agree that the name of "submodule.group" variable
should be neutral to the operation that is done to the groups of
submodules named by the variable at all.

You are recording the criteria to choose a set of submodules there
in the configuration, with a plan to keep doing something to them
(e.g. "they will never be left uninitialized, i.e. initialied if a
new submodule is added to the set").  The name of the configuration
must have something that tells what that "something" is, in order to
(1) hint the purpose of specifying the group selection criteria
there, and (2) allow different selection criteria to keep doning
another kind of something to them and distinguish these two group
selection criteria.

E.g. "submodule.autoInitialize = *default !:foo" may mean all the
modules in the default group (now or added in the future) except the
module with name 'foo' will be initialized as needed, while
"submodule.autoDistim = *optional" may want to be defined to allow
the system to automatically distim (whatever that operation is that
will be added to Git in later versions) the modules in the optional
group.

> I am hoping we can put that in shorter options, such as
>
>     clone --init-module=A --init-module=\*B --init-module=/C \
>         --remember-init-for-tracking
>
> whereas:
>
>     --remember-init-for-tracking: Submodule groups which are given
> to clone will be remembered, such that each invocation of "update"
> will make sure that group is fully there, i.e. new submodules in
> the group will be initialized before updating.

Is there a need for --no-remember-init-for-tracking?  I do not think
it would be useful.

When the upstream adds a new module and defines it to be part of the
default group _after_ you cloned with --init set to 'default', and
you do not need that new module, at that point you can tweak your
submodule.autoInitialize definition to exclude that new module.

Tweaking submodule.autoInitialize definition to contain nothing
after cloning with --init because you do not want the autoinit
criteria kept in the resulting repository is merely a special case
of that.

So I do not think --remember-init-for-tracking is necessary.  Just
make it _always_ on and be done with it, I would say.
