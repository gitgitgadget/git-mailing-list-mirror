From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: turn on network daemon tests by default
Date: Tue, 11 Feb 2014 15:58:27 -0800
Message-ID: <xmqqzjlxnqvw.fsf@gitster.dls.corp.google.com>
References: <20140210191521.GA3112@sigill.intra.peff.net>
	<20140210212931.GA16154@sigill.intra.peff.net>
	<xmqqa9dxpgw9.fsf@gitster.dls.corp.google.com>
	<20140211200445.GA27946@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 12 00:58:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDNDq-0005KU-Mc
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 00:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbaBKX6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 18:58:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58887 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002AbaBKX6d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 18:58:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCA2F6C473;
	Tue, 11 Feb 2014 18:58:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r4NoWAeNvq2AFbT7Zq/jpwZpT5o=; b=sxtiLF
	LI8sjtuXscrTnFqiGMBe6+V/uru+fXO1OuA2WTwj2XlASXBmLM0XUCu72aI/8Pqd
	tozWXhetZjMFJJaNd8rT4ockEc61LFcJgsfgVb/vQsJzDh7MqLHv1HTOgOtvv3Gb
	iqDrHk/A8bm2gEEWaReL1hi06BN2bku+6L3wM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WReZVdkS1DksogcX1u4MykdYLLpIDa2Z
	BHrH773EH0ZKMZZZDZyY99fHEzyPrg9dpjQt4LRXjb+tQOmzqLc47tdfpGDxi3MN
	hwnuAnybcVhS6o4qchHG6dcjMoabSh/glaTdxT3ePCBG3lngI47HmbvXxVykMv4i
	cuHAy6//hIw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC2D06C472;
	Tue, 11 Feb 2014 18:58:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0C886C46D;
	Tue, 11 Feb 2014 18:58:31 -0500 (EST)
In-Reply-To: <20140211200445.GA27946@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 11 Feb 2014 15:04:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 69106D78-9378-11E3-BBFB-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241963>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 11, 2014 at 11:51:18AM -0800, Junio C Hamano wrote:
>
>> Those who run buildfarms may want to disable the networking test if
>> the buildfarms are not isolated well, for example.  They have to be
>> told somewhere that now they need to explicitly disable these tests
>> and how.
>
> I think they should be OK. The daemons run on the loopback interface, so
> there is hopefully not a security implication. If multiple buildfarms
> are sharing the same loopback space (e.g., running in separate
> directories on the same machine), the "auto" setting should degrade
> gracefully. One daemon will "win" the setup, and the tests will run, and
> on the other, they will be skipped.
>
>> I am in favor of this change but just pointing out possible fallouts
>> might be larger than we think.
>
> Agreed, but I think the only way to know the size of those fallouts is
> to try it and see who complains.  I would not normally be so cavalier
> with git itself, but I think for the test infrastructure, we have a
> small, tech-savvy audience that can help us iterate on it without too
> much pain.

Sure. One immediate complaint is that I would probably need to do
something like this in the build automation:

	if testing a branch without this patch
        then
		: do nothing
	else
		GIT_TEST_GIT_DAEMON=false
	fi

Arguably, it is the fault of the current/original code that treated
*any* non-empty value that is set in the environment variable as
"true"---if it paid attention to GIT_TEST_GIT_DAEMON=NoThanks, we
wouldn't have to have a workaround like this.

I wonder if GIT_TEST_X=$(test_tristate "$GIT_TEST_X") pattern can be
made a bit more friendly, though.  For example, can we behave
differently depending on the reason why $GIT_TEST_X is empty?

 - People who have *not* been opting in to the expensive tests have
   not done anything special; GIT_TEST_X environment variable did
   not exist for them (i.e. unset), and we used to skip when
   "$GIT_TEST_X" is an empty string.

 - We want to encourage people who do not care to run these tests.
   If people do not do anything, their $GIT_TEST_X will continue to
   be an empty string without GIT_TEST_X variable in the
   environment.

If we let people who *do* want to opt out of the expensive tests by
explicitly setting $GIT_TEST_X to an empty string in the new scheme,
wouldn't the transition go a lot smoother?

The caller may have to pass the name of the variable:

	GIT_TEST_DAEMON=$(test_tristate GIT_TEST_DAEMON)

and then the callee may become

	test_tristate () {
		variable=$1
                if eval "test x\"\${$variable+isset}\" = xisset"
		then
			# explicitly set
                        eval "value=\$$variable"
                        case "$value" in
			"")
				echo false ;;
                        false | auto)
				echo "$value" ;;
			*)
				echo true ;;
   			esac
		else
			echo auto
		fi
	}

so that

 - Any non-empty string other than the magic strings "false" and
   "auto" continue to mean "please I want to test";

 - Setting the variable explicitly to an empty string will continue
   to mean "no I do not want to test";

 - Leaving the variable unset will continue to mean "I don't really
   care; just follow the default the project gives me".
