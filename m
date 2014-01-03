From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] completion: fix branch.autosetup(merge|rebase)
Date: Fri, 03 Jan 2014 11:13:28 -0800
Message-ID: <xmqqa9fcnajr.fsf@gitster.dls.corp.google.com>
References: <1388415138-11011-1-git-send-email-artagnon@gmail.com>
	<1388415138-11011-4-git-send-email-artagnon@gmail.com>
	<xmqqa9fendj3.fsf@gitster.dls.corp.google.com>
	<CALkWK0=tL4K7UHDBp_jGz5zUaHE9m=OESo2=2a0fUZwXB4auGg@mail.gmail.com>
	<xmqq1u0pnf7b.fsf@gitster.dls.corp.google.com>
	<CALkWK0mGJ2V9V=KzuaAraNX-edEVBEpp-9DcAaBF-dZCqp6bsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 20:13:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzABh-000052-Q9
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 20:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbaACTNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 14:13:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57218 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635AbaACTNf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 14:13:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1B085DD62;
	Fri,  3 Jan 2014 14:13:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eGUVSf7Gv1sKQgd0+DVxyQ23t/g=; b=m4nGTl
	qfs3JsuaEYdpW5UuQ+IjK97X4+GOZTFfuGzU3ufy2V3IhaI0zlc3EZEmoso+ZS/9
	G3VyaI7LluY/sy8b47CmNGiruKTFL6lztWtn7R5c2nbwkrtl3AdkoR9xIi/UYenL
	uFMfFdK+MQB9vyrBwqOZSB2s3dUTXLatgZtXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IkM+vpO+mA/byZWRG/o8090IwEfVAltv
	GuAFJwoCykUFJYjkM6i3D+icgT54DvBkgaqspCTJpd/dCDxYDpCzaUzm7huDyCWo
	tOE1XCVq4e7YvDdFITOydiMq2lVqT7cROC4WrJiwU6Y8ZYchyF3QKhzg0yXlofLT
	xfqcvq8Axqg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89A995DD5F;
	Fri,  3 Jan 2014 14:13:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4C025DD59;
	Fri,  3 Jan 2014 14:13:31 -0500 (EST)
In-Reply-To: <CALkWK0mGJ2V9V=KzuaAraNX-edEVBEpp-9DcAaBF-dZCqp6bsw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sat, 4 Jan 2014 00:28:31 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2291A98E-74AB-11E3-974F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239928>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> You seem to be calling it "incorrect" to give the same degree of
>> completion for a branch the user named "autosetupmerge" as another
>> branch "topic", but I think it is incorrect not to, so I cannot tell
>> if we are agreeing or disagreeing.
>
> No, what's incorrect is providing completions for
>
>   $ git config branch.autosetupmerge.<TAB>
>
> when no branch called "autosetupmerge" exists.  The purpose of the
> hunk (which I now removed) was to prevent such completions, ...

Hmph, but in a repository without 'foo', I just did

	$ git config branch.foo.<TAB>
        branch.foo.merge          branch.foo.rebase         
        branch.foo.mergeoptions   branch.foo.remote         

and got offered the above. How would that removed hunk that special
cased those autosetupmerge etc. helped such case?

If it _were_ about correctness, and the definition of correctness
were that "completing branch.foo.<TAB> to offer these four variables
is wrong until refs/heads/foo materializes", the "fix" would have
checked if there already is such a branch and refused to complete
otherwise, not special case a few known names such as autosetup*.

As there is no reason to forbid setting configuration variables for
a branch 'foo' you are going to create before you actually create it
with "git branch foo", I do not necessarily agree with the above
definition of correctness, either.

So it was completely bogus hunk and it is good we noticed and
decided to remove it, I guess.
