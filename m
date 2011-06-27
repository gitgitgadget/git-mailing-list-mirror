From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking submodules out of main directory.
Date: Mon, 27 Jun 2011 12:05:48 -0700
Message-ID: <7vvcvrw0vn.fsf@alter.siamese.dyndns.org>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>
 <7vvcvrxlol.fsf@alter.siamese.dyndns.org> <4E08C89E.5020109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	henri GEIST <henri.geist@flying-robots.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 27 21:08:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbHAC-00032Y-9l
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 21:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138Ab1F0THD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 15:07:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60039 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598Ab1F0TFv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 15:05:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 86E3D6CF0;
	Mon, 27 Jun 2011 15:08:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8i848/RN9LTvul4x+SbKL/D4qGc=; b=NYXWPS
	Z1uv4vsf9YwZZKx81+5IiA+3AEEV8ftjrl+Ex/7JoaYAAW8ejg/kH2ihf2YQksqj
	8aiOO7DXnvkByhXZnjlrW6Mwt32qTBfnmYvWJOYgN0hsXa+CoJo2+7gDUoOuIQXh
	6LmZkBLb1LRODKI5Xc4B7WgiT4tVc9LD5RBqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nSm+nUj+dUFqG7P8Whk9vzoUS/ZTKY89
	06TEXHM3TN7UPQJe0ciPG2lx7x6ykW/E+L6EJZn8471m7yAxO5PklhaQpnu+scxA
	/s0ktYmtAlRIKb6N/9x9yzL2UIGmp1joGEjujkiJeJtOnG6pFNmKdt92LJ4jJ3Wj
	S0Vmh1Yr7Hk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7F9096CEF;
	Mon, 27 Jun 2011 15:08:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D02596CEE; Mon, 27 Jun 2011
 15:08:01 -0400 (EDT)
In-Reply-To: <4E08C89E.5020109@web.de> (Jens Lehmann's message of "Mon, 27
 Jun 2011 20:14:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C75F2086-A0F0-11E0-ABFE-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176365>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 27.06.2011 18:51, schrieb Junio C Hamano:
>> One possible working tree organization may look like this:
>> 
>> 	-+- lib1
>>          +- project1/Makefile -- refers to ../lib1
>>          +- project2/Makefile -- refers to ../lib1
> ...
>> An interesting point your situation raises is that there is no direct way
>> to express module dependencies in .gitmodules file right now, I think.
>> Ideally you would want "submodule init project1" to infer automatically
>> that project1 needs lib1 and run "submodule init lib1" for you. My gut
>> feeling is that it belongs to .gitmodules of the superproject
>
> That is where this is handled now, but having a submodule refer to a
> submodule outside of it as a dependency is an interesting thought. But
> as that only matters at the moment you add project1 (and it won't compile
> because ../lib1 is missing, which can easily handled by: "oh, then I have
> to add lib1 as a submodule to the superproject too"), ...

That is what I called "there is no direct way". Wouldn't it be nicer if
the .gitmodules file in the superproject said something like

	[module "project one"]
		path = project1
        	url = ...
                depends = lib1
	[module "lib1"]
        	path = lib1
                url = ...

and then "git submodule init project1" run by the end user implied running
also "git submodule init lib1"?
