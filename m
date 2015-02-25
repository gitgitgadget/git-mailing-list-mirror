From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer: preserve commit messages
Date: Wed, 25 Feb 2015 10:22:38 -0800
Message-ID: <xmqqoaohonpt.fsf@gitster.dls.corp.google.com>
References: <1424540906.15539.22.camel@scientia.net>
	<f58ae048d7fd468cfdd7f7d369b3b4fc0a564641.1424697676.git.git@drmicha.warpmail.net>
	<xmqqsidwtq4i.fsf@gitster.dls.corp.google.com>
	<54EC98BD.7060100@drmicha.warpmail.net>
	<xmqq8ufnrwm1.fsf@gitster.dls.corp.google.com>
	<54ED9AF7.6080908@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Christoph Anton Mitterer <calestyo@scientia.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 19:22:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQgbd-0000NY-Pi
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 19:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbbBYSWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 13:22:41 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55905 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752503AbbBYSWl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 13:22:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 735273AD7D;
	Wed, 25 Feb 2015 13:22:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AmQ6/aWA6B7rJKEgg4z634GadEA=; b=HwYKC2
	EJ9M9MIvESUMhyO8Z654xVDK772sVrDZ0WjwE/aEB7HcBYeGFbDBE+Cvrw420rzj
	+AAYfs29S8Owi+gAqlJA6JmjDQjswXgwmc5CpaiLokFP3Q2ToUm5R2htodSDnAsZ
	EGlT6bgsmfJETxDnxDqcPq5Wk+LBJ+gemWTWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xfyPRx6ub/SLksf8AhmOJm9BNJWdbNmH
	G1mfB8u52X3JidXYwbSANRRh7AjD8DIEgut+SNb2rg5r3Z7ntlxyZfj9fmrGjSG9
	oJbvHUS50xIDQB0sbnIi/b+DBz/ix5FGkbHMxbqAWIL9Z579WSuWzheir4CDRR5+
	lg1pjL7Pb9M=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AF2A3AD7C;
	Wed, 25 Feb 2015 13:22:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DC4373AD7A;
	Wed, 25 Feb 2015 13:22:39 -0500 (EST)
In-Reply-To: <54ED9AF7.6080908@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Wed, 25 Feb 2015 10:50:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4815E648-BD1B-11E4-8A05-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264399>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 24.02.2015 19:29:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> 
>>>> Hmm, wouldn't it introduce a grave regression for users who
>>>> explicitly ask to clean crufty messages up (by setting their own
>>>> commit.cleanup configuration) if you unconditionally force
>>>> "--cleanup=verbatim" here?
>>>>
>>>
>>> That's what I meant by possible side-effects below.
>>> ...
>>> But git cherry-pick without conflict should no re-cleanup the commit
>>> message either, should it?
>> 
>> Hmm, but if it does not, wouldn't that countermand the wish of the
>> user who explicitly asked to clean crufty messages up by setting
>> their own commit.cleanup configuration?
>
> Note that "verbatim" is not the default - we cleanup commits even
> without being asked to. And this makes sense for "git commit", of course.

I am fine with the result of the updated code if the user does not
have anything in the config and uses the "default".  Not touching in
"cherry-pick" would be more desirable than cleaning.  We are in
agreement for that obvious case.

But your response is sidestepping my question, isn't it?

What does your change do to the user who wants that the clean-up to
always happen and expresses that desire by setting
commit.cleanup=strip in the config?  Doesn't the internal invocation
of "commit --cleanup=verbatim" that is unconditional override it?
