From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Allow cloning branches selectively
Date: Fri, 23 Dec 2011 13:18:36 -0800
Message-ID: <7vmxajaswj.fsf@alter.siamese.dyndns.org>
References: <1324671199-7074-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Dec 23 22:19:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReCW2-0000LD-1m
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 22:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757805Ab1LWVSk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Dec 2011 16:18:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48771 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754554Ab1LWVSj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Dec 2011 16:18:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88BD55915;
	Fri, 23 Dec 2011 16:18:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XEI3mUigtN2e
	NlpJaG17g8MEMno=; b=nQkM9x2s1XI0SagH2Y8fVFDklZj+yOaSc4xVluIDFSq1
	u+sjgiIUqO1emzyhmSN8EHSFsN6mM4EbOB7oU6nHmDERZdTdklVp3nUOL9wswynm
	Na4pNuSk1jDCgWTtTbFnB6XicwWiLxMUQ1JbqNLahmGud8Yo0Kyu8rs/cUPdcPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XEDa7v
	68agH2HlXvn7gPkq4SVzVc3NKLskf3v5VBY5x1uAIvnsRYYG3ASeEl/CiCCiCGda
	n7yqs231tvpAqSwI0r9jmKKRiYQMYrsezDwP8JjGuYd49e6cYErBJZKI4605TtAI
	aCZaBD6U6Am/uX4wVg2Ms1Bi6x1v/AKSOv7RY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F9C75914;
	Fri, 23 Dec 2011 16:18:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0358D5913; Fri, 23 Dec 2011
 16:18:37 -0500 (EST)
In-Reply-To: <1324671199-7074-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Fri, 23 Dec 2011 20:13:19
 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE083E2C-2DAB-11E1-8152-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187642>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Sometimes it's useful to clone only a subset of branches from a remot=
e
> we're cloning. Teach clone the --fetch option to select which branche=
s
> should get fetched.

This is just a knee-jerk reaction without reading the patch text (which=
 I
won't be doing over the holiday weekend anyway), but is the workflow of
the primarly intended audience to clone "a subset of branches" or "a
single branch"?

I have a slight suspicion that this started out as "I often want to cre=
ate
a clone to _track_ a single branch, but because I am mucking with the c=
ode
related to cloning anyway, I might as well allow more than one to be
fetched, even though I do not have any need for that, somebody might fi=
nd
it useful". And that is why it is important to answer the first questio=
n.

If the primary motivation is for a single branch, I suspect supporting
only a single branch and advertising the feature as "tracking only one
branch" might make it much easier to understand to the end users.

Upon "git clone --track cn/single-clone $there x.git", you would do
something like:

  it=3Dcn/single-clone &&
  git init x.git &&
  cd x.git &&

  # configure "git fetch origin" to only get branch $it
  git config remote.origin.url "$there" &&
  git config remote.origin.fetch refs/heads/$it:refs/remotes/origin/$it=
 &&

  # declare that the primary branch at origin is $it as far as we are c=
oncerned
  git symbolic-ref -m clone refs/remotes/origin/HEAD refs/remotes/origi=
n/$it &&

  # Git aware prompt reminds us that this repository is to track branch=
 $it
  git symbolic-ref -m clone HEAD refs/heads/$it &&

  # And Go!
  git fetch origin &&
  git reset --hard remotes/origin/$it &&
  git config branch.$it.remote origin &&
  git config branch.$it.merge $it

Of course you _could_ support more than one pretty easily, but the poin=
t
is that it is unclear how you explain to the end user what the feature
does and what it is for in easily understoodd terms, once you start doi=
ng
so. It will no longer be "this new clone is to track that branch", but
something else, and I do not know what that something else is.

And depending on what that "something else" is, which branch should be
checked out and what refs/remotes/origin/HEAD should name as the primar=
y
branch of the remote would be different.

Thanks.
