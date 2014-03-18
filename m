From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] tests: set temp variables using 'env' in test function instead of subshell
Date: Tue, 18 Mar 2014 15:16:27 -0700
Message-ID: <xmqqy5075f0k.fsf@gitster.dls.corp.google.com>
References: <244284@gmane.comp.version-control.git>
	<1395144518-2489-1-git-send-email-unsignedzero@gmail.com>
	<xmqqd2hj6y5o.fsf@gitster.dls.corp.google.com>
	<20140318214536.GA10076@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 18 23:18:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ2Kn-0006Bt-MO
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 23:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbaCRWQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 18:16:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39224 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932605AbaCRWQb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 18:16:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D865372571;
	Tue, 18 Mar 2014 18:16:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+uJtQb2LqXzh3xDVoMOPT8k8xo0=; b=eOBp6i
	eOFUlJx2ie82/PdOttZCJYYf2FrlZevWiqF6xP/DPQkVH8vpx8nRiDL/R8dmSQEn
	G7OPzrgzdNtfhqfH5aydoLBo3yX7FeGglCxXpmzUL5Y2IDPzW6Cts4LdACSKNOxY
	Rc9W1uFJM9aVBu9nBz+R8gjlfn+Vq8r+khphM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XUWDEuE1YdXaSuYW62m0/mo0milUbmiy
	hWntXyVyoUvwZYgeP8oOSNrlzApbQ2Dp/1CYPBVN+tJq5kW0CMf+AYfgYAJW7xdH
	QGu2/uVJ2/mldCgEUH8U32T2xts73PQD4zdxp+9o6vOfKiWJBLvbZKqAlwRhQJ6+
	gIoRMYGq8+E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C66F872570;
	Tue, 18 Mar 2014 18:16:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1C077256D;
	Tue, 18 Mar 2014 18:16:29 -0400 (EDT)
In-Reply-To: <20140318214536.GA10076@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 18 Mar 2014 17:45:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F487790E-AEEA-11E3-A7CB-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244387>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 18, 2014 at 01:37:39PM -0700, Junio C Hamano wrote:
>
>> > diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
>> > index c9c426c..3e3f77b 100755
>> > --- a/t/t1300-repo-config.sh
>> > +++ b/t/t1300-repo-config.sh
>> > @@ -974,24 +974,15 @@ test_expect_success SYMLINKS 'symlinked configuration' '
>> >  '
>> >
>> >  test_expect_success 'nonexistent configuration' '
>> > -	(
>> > -		GIT_CONFIG=doesnotexist &&
>> > -		export GIT_CONFIG &&
>> > -		test_must_fail git config --list &&
>> > -		test_must_fail git config test.xyzzy
>> > -	)
>> > +	test_must_fail env GIT_CONFIG=doesnotexist git config --list &&
>> > +	test_must_fail env GIT_CONFIG=doesnotexist git config test.xyzzy
>> >  '
>
> Isn't GIT_CONFIG here another way of saying:
>
>   test_must_fail git config -f doesnotexist --list
>
> Perhaps that is shorter and more readable still (and there are a few
> similar cases in this patch.

Surely, but are we assuming that "git config" correctly honors the
equivalence between GIT_CONFIG=file and -f file, or is that also
something we are testing in these tests?
