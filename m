From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Introducing a test_create_repo_bare (was Re: [PATCHv2 6/6] t5543-atomic-push.sh: add basic tests for atomic pushes)
Date: Wed, 17 Dec 2014 15:51:15 -0800
Message-ID: <xmqq61d996oc.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kY=TP31VJxPZnjb04og-vHU+-c4d+AgAkis2Q7yeDeXbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 00:51:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1ONH-00036u-VE
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 00:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbaLQXvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 18:51:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751078AbaLQXvS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 18:51:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3604028E06;
	Wed, 17 Dec 2014 18:51:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hV8eGldkC2ubYRLOKKMukTy6Sd4=; b=Y+3XIu
	zBdWNAoh7CnGpypoFxILfDcrOJtNYwSEcP9jYfNmtWm3/x+nDLQGAbv74MCfTpU6
	1HXNn24evYwklV5xoPVwCsEFOowv/TR62FTNnaNPiGhiE33xKHvxyDbTEzkgfjs6
	YPOeW31ZNakeM+o/rXgaUFufVYEjodopJy1iU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E6uMX8sr/6uybbtmlqVDNHZhUJqSOnNi
	xuyRW2DRzi60zisASg6Xoc4Av10DEtOQcw8KajXXbZxsKS4MvV2jICsuKO7OOXYo
	9yllW7ZNatSAO+llCb4SNCsbeJ94sVSPUYKkkhc+nOfeMT5F6ryNE2Rs60JoR8Uw
	qYFOcJ35Zhw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A01228E05;
	Wed, 17 Dec 2014 18:51:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2BBC28E04;
	Wed, 17 Dec 2014 18:51:18 -0500 (EST)
In-Reply-To: <CAGZ79kY=TP31VJxPZnjb04og-vHU+-c4d+AgAkis2Q7yeDeXbg@mail.gmail.com>
	(Stefan Beller's message of "Wed, 17 Dec 2014 15:20:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 987893CA-8647-11E4-8395-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261507>

Stefan Beller <sbeller@google.com> writes:

> On Tue, Dec 16, 2014 at 11:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> +     (
>>> +             cd upstream && git config receive.denyCurrentBranch warn
>>> +     ) &&
>>
>> I was wondering how you would do this part after suggesting use of
>> test_create_repo, knowing very well that one of them was a bare one
>> ;-).
>>
>> We might want to extend test_create_repo to allow creating a bare
>> repository, but this is also OK.
>
> So I searching through all the tests, where it would make sense to do that.
> I searched for "denyCurrentBranch" and came up with this list where I think
> it makes sense to replace (git init | test_create_repo | or alike) by a
> test_create_repo_bare or add the --bare option to test_create_repo
>
> places where test_create_repo_bare is easily introducable:
> t5517-push-mirror.sh # setup an upstream repo
> t5543-atomic-push.sh # setup an upstream repo
> t5701-clone-local.sh # Test  'clone empty repository'
>
> not as easy:
> t5400-send-pack.sh # we commit to that repo while being inside
> t5405-send-pack-rewind.sh # we commit to that repo while being inside
> t5516-fetch-push.sh # we test the various denyCurrentBranch options
>
> unsure:
> t5522-pull-symlink.sh # just cloning the repo
>
> So I think we don't need the test_create_repo_bare yet.

Thanks for digging.

We already knew we do not *NEED* it.  We have been surviving without
one.

You need to remember that adding and using a new helper is *NOT* the
ultimate goal; categorizing those that do not want bare repositories
as "not as easy" is misguided.  They truly do not want bare, so they
are not our target audience in the first place.  For the same reason,
"easily introduceable" is not a good criteria to look for.

The issue is if some existing tests will be helped, if we had such a
helper.  That is, do we "git init --bare" by hand in some test?  Are
these tests in such a hand-crafted repositories more susceptible to
future breakages because they do not use the template from the built
location or they do not disable hooks?  If we had such tests, then
they would benefit by having a "bare" mode of test_create_repo.
