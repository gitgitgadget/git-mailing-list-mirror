From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-check-ignore.txt: Clarify exit codes
Date: Thu, 11 Dec 2014 15:01:12 -0800
Message-ID: <xmqqiohhdc5j.fsf@gitster.dls.corp.google.com>
References: <1418323355-23935-1-git-send-email-florian.hassanen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Florian Hassanen <florian.hassanen@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 00:14:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzCuq-0002Vf-34
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 00:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966930AbaLKXBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 18:01:17 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51109 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966933AbaLKXBP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 18:01:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DC1625A51;
	Thu, 11 Dec 2014 18:01:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ag2APdMUVy/RKsQ/xSKHLRRktaU=; b=eBXjOd
	+HYuSynYQGqqTUKpMaPV4e8lAoEQsPvdiEU0cHFhzvycpW9GNRn4DvBpCb7wwGH5
	ROEEEU+ducfAHH+szmkCjEHsN6y7FKc+tQRnSg5AVzQU5qM8b1q7P18urysYrgiE
	3kMfHMIRD29vdFh/PzpQjr1Eppx8Kt9CYWr5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T1Agsx+dg0verR2ydfU3IVpCkxPs9gnq
	FQBjmBxEyFMvOYKvmvDVh5sFkhsu6X2dhUuDqBj5freLieCalff0XQjKNh4AWqmH
	vB9ZytRnq6FA5IRWjkWrA0dxD1X6HybOGQQ6fEiXWTI9Li0M+ZGiTBQbriGsA3Oz
	H7/3qZAJ90g=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 40A5225A50;
	Thu, 11 Dec 2014 18:01:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9DA6325A4D;
	Thu, 11 Dec 2014 18:01:13 -0500 (EST)
In-Reply-To: <1418323355-23935-1-git-send-email-florian.hassanen@gmail.com>
	(Florian Hassanen's message of "Thu, 11 Dec 2014 19:42:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9ADBD4F0-8189-11E4-8CD7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261302>

Florian Hassanen <florian.hassanen@gmail.com> writes:

> check-ignore disregards whether a path is matched by a
> positive or negative pattern. Thus for a file that is _not_
> ignored, but is captured by negative pattern in .gitignore,
> the exit code is 0. The docs suggested otherwise.

I am not sure that is the actual behaviour of the command.  Given
this .gitignore file:

    $ cat .gitignore; echo END
    !vendor.o
    *.o
    END

which is designed to allow binary-only blob "vendor.o" supplied by
the vendor to be tracked, but to ignore all the other usual build
artifacts, you see this:

    $ for o in a.o vendor.o; do git check-ignore $o >/dev/null; echo $?; done
    0
    1

Puzzled...

>
> Clarify docs to explain that only the match matters, not
> whether the path is actually ignored or not.
>
> Signed-off-by: Florian Hassanen <florian.hassanen@gmail.com>
> ---
> Today when working with the check-ignore command, I misunderstood
> the docs into thinking, that I could use check-ignore's exit code
> to determine, whether a file is ignored or not - but this is not
> how the exit code works :(
> Here is a suggestion, on how to update the docs to describe the 
> exit code's behavior more clearly.
>
>  Documentation/git-check-ignore.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
> index ee2e091..bdd8b7c 100644
> --- a/Documentation/git-check-ignore.txt
> +++ b/Documentation/git-check-ignore.txt
> @@ -97,10 +97,11 @@ EXIT STATUS
>  -----------
>  
>  0::
> -	One or more of the provided paths is ignored.
> +	At least one of the provided paths matches some (possibly negative)
> +	pattern.
>  
>  1::
> -	None of the provided paths are ignored.
> +	None of the provided paths match any pattern.
>  
>  128::
>  	A fatal error was encountered.
