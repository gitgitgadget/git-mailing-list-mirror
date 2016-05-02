From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/10] shell helpers usage: always send help to stderr
Date: Mon, 02 May 2016 16:28:10 -0700
Message-ID: <xmqqtwigox9x.fsf@gitster.mtv.corp.google.com>
References: <1461976845-18228-1-git-send-email-sbeller@google.com>
	<1461976845-18228-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 03 01:28:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axNGE-0008ER-NG
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 01:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbcEBX2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 19:28:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64816 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932260AbcEBX2O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 19:28:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D328E18013;
	Mon,  2 May 2016 19:28:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d5zNGR7b4dh43/WvvDm+7szRvvE=; b=IG5d5S
	rAipGJmal7wG0qJY7inr6xyhs5ogmrnoL4WKKgHJjKjIQI0gZ6FGiMQJykg8yCrx
	6S1mhSI/+HukLlMUT/QrDJivMmtzd2agyuFBIS4MqC9HL0vfihzPL0TqbTnu8DA+
	DjGTRfWS3vDsKO8G+IKGuxdElyWf8O0LiZlwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mPmKxHjyXxXwQxXGhT4zuHBMD1vOjpnx
	uWMH2IOoiWkBYDqJlw8vJv+WPTmbRJ+MFR/PVXxFESBPoAwbMUbmSn9s5be/hxdF
	IjYNsJhQqe5cEu3x0hd/YOmIyJf82wcRAKlPWYdFP/Mazl4jpuz6yThQwNQ0cVoe
	mfVOv1tMFk8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA53818012;
	Mon,  2 May 2016 19:28:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 318B518011;
	Mon,  2 May 2016 19:28:12 -0400 (EDT)
In-Reply-To: <1461976845-18228-5-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 29 Apr 2016 17:40:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 89720260-10BD-11E6-B929-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293303>

Stefan Beller <sbeller@google.com> writes:

> `git submodule asdf` would trigger displaying the usage of the submodule
> command on stderr, however `git submodule -h` would display the usage on
> stdout. Unify displaying help for shell commands on stderr.

The primary output from "git cmd --help" is the usage message.  It
is debatable why it should go to the standard error output when it
is the primary thing the user asked for.



>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-sh-setup.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index c48139a..5c02446 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -65,7 +65,7 @@ say () {
>  
>  if test -n "$OPTIONS_SPEC"; then
>  	usage() {
> -		"$0" -h
> +		"$0" -h 1>&2
>  		exit 1
>  	}
