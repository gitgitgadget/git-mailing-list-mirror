From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Mon, 06 Jan 2014 13:32:52 -0800
Message-ID: <xmqqsit0hk3f.fsf@gitster.dls.corp.google.com>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
	<d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
	<CALas-ijwb+20dArOGCnZJSqEwU8+ufUpOEktUJ2hAOW_BLpgxw@mail.gmail.com>
	<20140106144708.GC27265@t2784.greatnet.de>
	<xmqqtxdhjbgp.fsf@gitster.dls.corp.google.com>
	<20140106173708.GU3156@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Francesco Pretto <ceztko@gmail.com>, Git <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Jan 06 22:33:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0HnD-0002FD-6r
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 22:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756249AbaAFVc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 16:32:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41547 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755441AbaAFVc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 16:32:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7AD65F7D1;
	Mon,  6 Jan 2014 16:32:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mlLPWc4p6K3KGRWJSyJqK0qaqM4=; b=YNNnom
	sccD/PGl9m6yZSn7feSz0LKQ0o3Qa8YGsEwP/2N2o4CWQAJEtz/9/G9jfCZeRa9K
	FB7suRarAINI7QOpBMbwEGRcIyh4MnAA7PcC1E3bU174WNt4qnjaVwPNojZv7ehV
	OrD7g6VF286SQ1Rjl4uFzAsd0uzk+g43FyeE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gww0yuxTQCF9vI0Jg+z5NaT7LMjUfjbW
	hoN0GQogNqL7s1B+YOZVsleBQ+1zdSA7wsXszDUn/qP9QslCwOZW29YOE8zNsHHT
	dqlGlyb4aluDDGtmO+UMZO55AHHpPn/cEMdSyD5pDjeLxlLTrJGOzJhUgzQUEhsB
	rHZhSE6C9YI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D75AB5F7D0;
	Mon,  6 Jan 2014 16:32:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 082445F7CF;
	Mon,  6 Jan 2014 16:32:56 -0500 (EST)
In-Reply-To: <20140106173708.GU3156@odin.tremily.us> (W. Trevor King's message
	of "Mon, 6 Jan 2014 09:37:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1BCBC672-771A-11E3-8F6A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240067>

"W. Trevor King" <wking@tremily.us> writes:

>> And wouldn't it make it unnecessary to have a new "re-attach" option
>> if such a mode that never have to detach is used?
>
> I think so, but we currently don't have a "never detached" route for
> folks that are cloning submodules via update (instead of via
> 'submodule add').  Currently, new clone-updates will always leave you
> with a detached HEAD (unless you have branch-creation in your update
> !command).  My patch aims to close this detached-HEAD gap, for folks
> we expect will be doing local development, by creating an initial
> branch at clone-update time.

I am not a submodule expert so I may be missing some other gaps, but
what your change does sounds sensible to me.
