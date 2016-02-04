From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/7] t0027: Add tests for get_stream_filter()
Date: Thu, 04 Feb 2016 11:52:06 -0800
Message-ID: <xmqqpowcgsnt.fsf@gitster.mtv.corp.google.com>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
	<Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
	<1454608188-5300-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Thu Feb 04 20:52:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRPwt-0002mE-2T
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 20:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933174AbcBDTwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 14:52:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932594AbcBDTwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 14:52:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 885F341703;
	Thu,  4 Feb 2016 14:52:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OKPJVLrJuHVkjLZQGH23LoLojQM=; b=a3/xb2
	2A2FEy8hqqOmKOISRmWGvwz1HUeKQ9eqG753LrkBJvl9VFjqGQEq7gt0dCF1MEqr
	3U+nQ7j7vsh0J2lcYEBH++abaQBqH7IC/6QXHij1OjKSDYQJ1QidFm2uuGobGA6+
	qSOFKcs5AQpQ10WJozpcyzfEPNSpaJ+P0HnYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MH4sR354r21i5gJjJs5xsUd6b5lNR/rm
	TzThi+RgbPEMaL5BoHopLlQ7kMp5W+D2RB1CdoZs5N+v8TI4hZtlVdIs2GFeTgz5
	2jIBGvh67Sik6kBgEGFGRX+znCK4qWa03kEWYOSjeSd8yezH/bscFNqnObwlIT2n
	435T/9DoJ8c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7922041702;
	Thu,  4 Feb 2016 14:52:08 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C0325416FF;
	Thu,  4 Feb 2016 14:52:07 -0500 (EST)
In-Reply-To: <1454608188-5300-1-git-send-email-tboegi@web.de> (tboegi@web.de's
	message of "Thu, 4 Feb 2016 18:49:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C5B2C3E8-CB78-11E5-A759-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285487>

tboegi@web.de writes:

> +		while test "$#" != 0
> +		do
> +			case "$1" in
> +				auto)	 echo '*.txt text=auto' ;;
> +				i)     echo '* ident' ;;
> +				text)	 echo '*.txt text' ;;
> +				-text) echo '*.txt -text' ;;
> +				crlf)  echo '*.txt eol=crlf' ;;
> +				lf)    echo '*.txt eol=lf' ;;
> +				"") echo '' ;;
> +				*)
> +				echo >&2 invalid attribute: $attr
> +				exit 1
> +				;;

Perhaps use the right style as you are rewriting pretty much
everything in this helper function?  case/esac aligns with the
labels of case arms, and commands under each arm are indented one
level down, i.e.

	case "$var" in
        $arm1)	... do short thing ...;;
        $arm2)
        	... do a lot of
                ... things
                ;;
	esac


I still do not see the value of accepting a cryptic 'i' (or an empty
string) to this thing, though.  Also what $attr does the error
message refer to now?  Perhaps it wants to refer to "$1" (quoted)
instead?
