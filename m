From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/4] update-index: migrate to parse-options API
Date: Tue, 26 Oct 2010 21:19:08 -0700
Message-ID: <7vfwvse08z.fsf@alter.siamese.dyndns.org>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino> <20101022064258.GB6081@burratino>
 <7v8w1qnkr1.fsf@alter.siamese.dyndns.org> <20101024072032.GA23455@burratino>
 <20101024081316.GA29630@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 06:19:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAxUE-0000Jz-HD
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 06:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802Ab0J0ET1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 00:19:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab0J0ET0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 00:19:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C0A64E2FCE;
	Wed, 27 Oct 2010 00:19:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pXoZCpBpHHlr/2NqjGP72J9IZms=; b=VLx5HZ
	E6N5yh+wmTu9N1r/6nRAOghUHzj2WZl5DkSjbqRG9PHOMmqEkf/Cd9shNR35tpoU
	oDOf6uiK6JRahYvif2nvCYOdNoZK3l8mJYTwaUdam3/B2pc6pjQ/YQVm0r7xqXHU
	w3fLSIyoJiXeKavkVqMxzH4V5Z1O7zDjx0+Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DmwmITfMuUzvVrYyteBQZiHI6+gxtwI0
	OIucezp2N28Z3npildqedP+3lQ2NDQUQASlGNGw9Zg3xlrWD50plSOQrNpnZHscy
	Nf8PL2nNCDJ7uaTG3O2/Fd8F1aZSjnMmaFeTcJU5+CHLbB/HKkFDuEVLQj98d+Zl
	KA1MPh8Nwp4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 23A1EE2FC5;
	Wed, 27 Oct 2010 00:19:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1972E2FC2; Wed, 27 Oct
 2010 00:19:09 -0400 (EDT)
In-Reply-To: <20101024081316.GA29630@burratino> (Jonathan Nieder's message of
 "Sun\, 24 Oct 2010 03\:13\:16 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5CF6E3D4-E181-11DF-9234-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160019>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jonathan Nieder wrote:
>
>> Here's a helper to make it easier for commands that use parse-options
>> to adopt that nicer behavior.  It writes its output to stdout, so it
>> should only be used to be used to handle the -h option.
>
> Alas, "git update-index" does not use parse-options yet.  But that
> is easily enough changed...
>
> Patch 1 introduces an OPTION_LOWLEVEL_CALLBACK backdoor to
> parse-options, so new option types (like the three-argument type
> used by update-index --cacheinfo) can be supported without tempting
> inventors of other commands through mention in the public API.

I like the idea of this one.  I imagine it can also be used to finally
whip the command line parsing of "log -L" series Thomas mentored into a
reasonable shape, which needs to parse the -L option that takes <range>
and an optional <path> (not <pathspec>) as arguments.
