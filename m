From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH_v1] add 'git credential' plumbing command
Date: Mon, 11 Jun 2012 08:35:40 -0700
Message-ID: <7vhauh97zn.fsf@alter.siamese.dyndns.org>
References: <1339267502-13803-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
 <7vzk8baca0.fsf@alter.siamese.dyndns.org> <vpq1ulnnw81.fsf@bauges.imag.fr>
 <20120610203259.GA2380@burratino> <20120610210224.GA3112@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Javier.Roucher-Iglesias@ensimag.imag.fr, git@vger.kernel.org,
	Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 17:36:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se6er-0005gv-22
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 17:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588Ab2FKPfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 11:35:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53323 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755511Ab2FKPfn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 11:35:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEE679300;
	Mon, 11 Jun 2012 11:35:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J8yl1I4ulvaQH7rMaRd1O1y4/tY=; b=hLSwfB
	xcO/ihh5YIlqVthFvak7tyKkl8V4CMY241UMlYTh6rYAQuA9XSV9m3lsOwnaI2dD
	7fodv0m9cwDhD8kLptAOMcgDqyv2Blvarho2WXUT7eNd1s+SzvyJfPmvN1p5+JWU
	TeeQi01m752vxsRRGg15JwDftzodL0MZJ2lqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aoS1vELWVYWigf5iJ9j8u8fwkMCsRDd6
	SQ9OOCG+cbNAPkU1jOYoq6D3tT2HPXlPWoQPO0ktB/tbJoHA7d24JBUmkT7omLMU
	zq04NPdo/KNdi9kdI0eGz3DYx2PYGEs30Xt6uuT+Lj6zSv6NSjHTXjXcP6Jv1Bz/
	BWMqWv6/b5I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E46F992FF;
	Mon, 11 Jun 2012 11:35:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EF0F92FE; Mon, 11 Jun 2012
 11:35:42 -0400 (EDT)
In-Reply-To: <20120610210224.GA3112@burratino> (Jonathan Nieder's message of
 "Sun, 10 Jun 2012 16:02:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1AAB7F70-B3DB-11E1-904C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199663>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jonathan Nieder wrote:
>> Matthieu Moy wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>
>>>> Does "git credential" need to have a git repository (i.e. run in a
>>>> git repository or in a working tree that is controlled by one)?
>>>
>>> It shouldn't (hence, should use RUN_SETUP_GENTLY).
>>
>> Rather, that means it should use 0:
>>
>> 			{ "credential", cmd_credential },
>
> ... and it turns out I'm talking nonsense.  RUN_SETUP_GENTLY would
> be a sensible choice indeed, to allow the command to discover the
> current repository and read .git/config from there indeed.

Yeah, I think "it is OK to be called outside a repository, but if
inside we read and honor the configuration" is a sensible behaviour
for this command.
