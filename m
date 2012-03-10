From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Stop a git commit by a specific author using pre-commit hook
Date: Sat, 10 Mar 2012 13:54:20 -0800
Message-ID: <7vboo415rn.fsf@alter.siamese.dyndns.org>
References: <CAGc=MuCQoQ711uXnB8J80RqsY+pqbaeCOXHjy0-mjq7a_ESdyA@mail.gmail.com>
 <4F5BAE5E.5030407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adrian Cornish <git@bluedreamer.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 22:54:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6UF9-0006sw-8E
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 22:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594Ab2CJVyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Mar 2012 16:54:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40051 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752377Ab2CJVyW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 16:54:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF7F572DA;
	Sat, 10 Mar 2012 16:54:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2wK8gZN/6C7s46RHenIXKaXr/sA=; b=Lol/1v
	PO3HwTbNQGlZxMLIuT5uWdz+EkiHdJGVYKvJGo5SLq79v5dSdCXgkuhc8Og9edSD
	nVHMrMx3DtdmQQGpRxucvAdWdUjUgRU1RhbwAVffb5CydsRdNePEofWJxZw4Dzx9
	PaquDAbrje4z5yE3JS4Sb2nQIxr9Qvj44Fxu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fFPS/zcWkB7qfbyAJPxfYWbmINomUD/v
	PYpY3xbADnXcCKzgoWi+Z28e25J2yxH90x/DY+5Il98FmE3XgOCrhXtZGxvx0DSm
	NaU0IYGspsiIOvXnOa7uq4FiezCUyUEAMFT5VXX8USXAdZ9+4T7hzphkxuGW0fZZ
	jFKp4jxa00A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D661672D9;
	Sat, 10 Mar 2012 16:54:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A20D72D7; Sat, 10 Mar 2012
 16:54:21 -0500 (EST)
In-Reply-To: <4F5BAE5E.5030407@gmail.com> (Neal Kreitzinger's message of
 "Sat, 10 Mar 2012 13:41:18 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97D4C0F2-6AFB-11E1-82CF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192790>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

> On 3/8/2012 7:15 PM, Adrian Cornish wrote:
>> My plan is to use git to keep track of changes in /etc but when
>> committing I want to have the person making the change specify
>> themselves as author by adding the --author option on the commandline.
>
>> So I would like to stop accidental commits as root.
> ...
> We use whoami in our pre-commit hook to see who the user is that is
> doing the commit.  I think you could also use GIT_COMMITTER_NAME or
> linux $USER environment variables.  Either way, the --author seems
> like an unnecessary and unreliable way to get the username.
> ...  If people can su to root
> then $USER will not work because it will still be set to their
> original user name (before they did su to root).  Therefore, "whoami"
> seems like your best solution.

When people want to raise a red flag against a commit made by root,
they are coming from two different schools.

One is "do not run 'git' or any development tool for that matter
while being root". It is a good discipline to follow in general to
limit what you do with escalated privilege to the minimum.

The other is "record who actually did the work, not 'root' that
people cannot later track down who it actually was".  People from
this school do not mind running development tools as root.

And your advice is a good one for the former, but not very relevant
for the latter.

And I think Adrian is asking for the latter.
