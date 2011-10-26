From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP 03/11] t5403: avoid doing "git add foo/bar" where
 foo/.git exists
Date: Wed, 26 Oct 2011 10:26:30 -0700
Message-ID: <7vr51z3bqx.fsf@alter.siamese.dyndns.org>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-4-git-send-email-pclouds@gmail.com>
 <7vd3dk516p.fsf@alter.siamese.dyndns.org>
 <CACsJy8CjJnO6rDVTV1tC9rWXP51LHBtUvNsgVWNfwC+HuNQ-6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 26 19:26:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ7FP-0003LI-39
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 19:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933672Ab1JZR0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 13:26:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48072 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932940Ab1JZR0d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 13:26:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B875F447E;
	Wed, 26 Oct 2011 13:26:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LbQbEMAt0AVXCg2m14beG2Rlhio=; b=jznmBw
	6R59UCgCEqzFfUiEjLOcCt79l54gh1PWGmc+fsUpruOFDVSKF0QeBFZismT5cO38
	YYihul3UPE7M0bIzvlwtgoZ7QW5mzPPOlhOZGGt09vZr9m4YfJFAveXu8Kz2LGpz
	1HQxi8Yq6cZinTBRzr34+8aP9kcZulGlCCT/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wsq7A31kQoy24udJT7C68WGpRbdzRo8R
	VWbCLhtpX0srJMKiIEPjdi2ZEa/P+yNVcXOqVyjFLaA9ErFmXBp3eBf//FIIcsW5
	w/CYNcBqsEViEznoy2LRPm/M8W6S8JtohyKjwU7dWyKqvehmp4Mc+bTfjPdAQ5uc
	5BPXPH6f1Pw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD7D1447D;
	Wed, 26 Oct 2011 13:26:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32AF9447C; Wed, 26 Oct 2011
 13:26:32 -0400 (EDT)
In-Reply-To: <CACsJy8CjJnO6rDVTV1tC9rWXP51LHBtUvNsgVWNfwC+HuNQ-6Q@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 26 Oct 2011 11:18:51 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A5A51642-FFF7-11E0-9DEB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184268>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Now look from "git add" perspective, it does not really care where
> $GIT_DIR is.
> It assumes that $(pwd) is working directory's top. So it

Now you confused me.

Doesn't it use $GIT_DIR to find the index?  And it decides that it is at
the top level because it is given GIT_DIR but not GIT_WORKING_TREE which
is how working tree discovery is defined.

>  - reads content of current directory, it sees "clone2" as a directory
>  - it descends in and see ".git" so "clone2" must be a git link
>  - because clone2 is a separate repository (again $GIT_DIR is not
> consulted), "b" should be managed by "clone2"
>  - so it stops.
>
> This is the only place I see a submodule (from the first glance) is
> actually top level repository. Yes I guess we can support this, but
> it's just too weird to be widely used in pratice..

Where did you get this idea that submodule is somehow involved in this test?

I do not see there is any submodules involved; the test uses two
repositories 1 and 2 that appear in the working tree of the main
repository test infrastructure created, but otherwise there is no
sub/super relation among these three, and there are many other tests with
"clone" or "mkdir+init" or "init <newdir>" in the main test repository.

The clone2 repository tracks a path without having a corresponding file in
its working tree (i.e. it has "b" but tracks "clone2/b") which I already
is said unusual, but unusual does not mean it is bad or we want to remove
a test that covers the unusual case to let a change that regresses the
case go unnoticed.

>> Running (cd clone2 && git add b) is a _more natural_ thing to do, and it
>> will result in a path "b" added to the clone2 repository, so that the
>> result is more useful if you are going to chdir to the repository and keep
>> working on it. But that does not mean the existing test is incorrect. It
>> does not just pass somehow but the test passes by design.
>>
>> I did not check if later tests look at the contents of commit "new2" to
>> make sure it contains "clone2/b", but if they do this change should break
>> such tests.
>>
>> So I am puzzled by this change; what is this trying to achieve?

So again, what is this change trying to achieve?
