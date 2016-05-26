From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] config: return configset value for current_config_ functions
Date: Thu, 26 May 2016 09:42:48 -0700
Message-ID: <xmqq7fegydmf.fsf@gitster.mtv.corp.google.com>
References: <20160518223712.GA18317@sigill.intra.peff.net>
	<20160518224323.GD22443@sigill.intra.peff.net>
	<20160519000821.GA22543@sigill.intra.peff.net>
	<CACsJy8Ad=yN6aLkH9B6ujUNUvPT-b+jw+CwJORD5Fh1jYeOUZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 18:42:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5yN7-0002d3-C8
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 18:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbcEZQmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 12:42:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752366AbcEZQmw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 12:42:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 240FA1EDA9;
	Thu, 26 May 2016 12:42:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cAxbf4hPD2n3iSc5WVpebs8v/Yo=; b=X6DQLF
	AFpRWT1oJLD7CJv1oa/oiaQGC5VEhXUIar55VHfLRYkF/zrF85xk4oIP7YCs8UCU
	v7qA4Tq98R65nDReGg77ehUyYKYNcbOl8+uppvM9hs+P+ILdL471SVZtcN8J+Q1D
	RqpelCKA82cMXshTdd99lAGanPVPYx9MaLEd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p4dwbXJAF9iHPbowobPxexOskDoNwRTQ
	c2oVOrmEVp+UJA0KVxtUKe/xxsD1OcQPswHuE+W/5mEyQFOyCl6WszsNBXhUDmzP
	CFHXWVCYztQ8CcGJUL1bZAZ0l8ZtvSnzflRZrK5bxisOecdJL6+P3G1iEMPzOt/f
	dBr/9ly0bDQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 19F301EDA7;
	Thu, 26 May 2016 12:42:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D38E1EDA6;
	Thu, 26 May 2016 12:42:50 -0400 (EDT)
In-Reply-To: <CACsJy8Ad=yN6aLkH9B6ujUNUvPT-b+jw+CwJORD5Fh1jYeOUZQ@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 26 May 2016 14:47:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E28A487A-2360-11E6-B313-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295668>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, May 19, 2016 at 7:08 AM, Jeff King <peff@peff.net> wrote:
>> On Wed, May 18, 2016 at 06:43:23PM -0400, Jeff King wrote:
>>
>>>  cache.h                |  1 +
>>>  config.c               | 51 +++++++++++++++++++++++++++++++++++++++++---------
>>>  t/helper/test-config.c | 20 ++++++++++++++++++++
>>>  t/t1308-config-set.sh  | 23 +++++++++++++++++++++++
>>> [...]
>>> +test_expect_success 'iteration shows correct origins' '
>>> +     echo "[alias]test-config = !test-config" >.gitconfig &&
>
> How about using 'which' to get absolute path for test-config and put
> it here? Then we don't rely on $PATH anymore.

Don't use which, which is not portable.

Remind me why we end up running ./test-config instead of
./bin-wrappers/test-config?  Should our tests be running 
bin-wrappers early in their $PATH, perhaps?
