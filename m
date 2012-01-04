From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Wed, 04 Jan 2012 10:00:07 -0800
Message-ID: <7vy5tnpcuw.fsf@alter.siamese.dyndns.org>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
 <1325692539-26748-1-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Jan 04 19:00:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiV8M-0001TI-2f
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 19:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084Ab2ADSAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 13:00:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39891 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab2ADSAL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 13:00:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D63B85BF6;
	Wed,  4 Jan 2012 13:00:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z3oHHRz8hJoBU7qCX/U5Ghw8lCU=; b=yDA1Yo
	AB/gN+TklrBHBgZuNAkhUdkov/Oxkj0FqmxaA+M66TS5BJufRyB7Unv+XSdAACCi
	7pwBzlbfzFfVwsWlMyqT9GDfl0LzuXcHsezak3UG6lAmUdTUXdFya+woFJOwhUmL
	DB1srEnFgrRY3yjPn/u3vAAjzkl+kYOrLURSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tk1VNLx2cjuTbvXdFXFT5EHUPQLCTMM0
	4Z0s26u0s22xjxfyNakmC3pDGW2OXE9vgILOu0o+oqAx+InSXmEkzuagrR4jVKXO
	qZXyaYX5IBGKQ3Wm5BZfBz3HicSzg1MzsyqVTnnAjybvWe9EJt+CUT95qo+6FdzT
	VT9YMM3vgtM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDE4F5BF5;
	Wed,  4 Jan 2012 13:00:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56B675BF4; Wed,  4 Jan 2012
 13:00:09 -0500 (EST)
In-Reply-To: <1325692539-26748-1-git-send-email-drizzd@aon.at> (Clemens
 Buchacher's message of "Wed, 4 Jan 2012 16:55:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0E4F928-36FD-11E1-B5CB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187936>

Clemens Buchacher <drizzd@aon.at> writes:

> Are you saying that the name "daemon" is too general, and it should
> instead be "lib-git-daemon.sh" and GIT_TEST_GIT_DAEMON? Or do you
> mean that it is not general enough and it should be called
> lib-networking.sh and "GIT_TEST_NETWORKING"?

The former. "daemon" is too general and letting "git daemon" squat on that
name makes it harder for other people to build daemons for new git
services and write tests for them.

> Either way, I have no preference here. Feel free to change any way you
> like.

No thanks.

>> >> +	# kill git-daemon child of git
>> >> +	say >&3 "Stopping git daemon ..."
>> >> +	pkill -P "$DAEMON_PID"
>> 
>> How portable is this one (I usually do not trust use of pkill anywhere)?
>
> I read that it is supposed to be more portable than skill or killall.
> But I have no way to research this. I have implemented a workaround
> using only 'ps' and 'kill' in [PATCH 3/6] avoid use of pkill.

Yuck, that patch looks even uglier X-<.

Do you really need to kill the children but not the daemon?
