From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] t9901: fix line-ending dependency on windows
Date: Fri, 14 Oct 2011 22:44:48 -0700
Message-ID: <7vsjmux0z3.fsf@alter.siamese.dyndns.org>
References: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
 <1318632815-29945-6-git-send-email-patthoyts@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Oct 15 07:45:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REx3U-0006nQ-FF
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 07:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427Ab1JOFov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 01:44:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36134 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315Ab1JOFov (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 01:44:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2AA234F1;
	Sat, 15 Oct 2011 01:44:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vg9rBGC+91iyT4p4vkp5i7ep0PI=; b=MP4Jmq
	bvu8PHUa9eM55UOK1bv0SBz9Ey7BOiltWyHNom05V6DJ4UujztBtpMI34ilDPWda
	yXviQLyn0mxBtqxVdqF7o50hclN4x0tMeQLXyWCcEASainaei32hJVpK8cOUhbzY
	UI+vRWtVaXXjgq+OBJpWPwtvRGIPMYt5lXj4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r3w+UfpxZkmlk8qy0JdO1JmAG6izIiL0
	5eo11hJ3xlTc608ZIAcde199x0HlrhMFheNVDkOOpj21XtAg7liIrMOOaur9SCEH
	0+ADT9aoRVBDBb9cqfJ3Nz803bHpoMhoJpbKDoomEFwY0nY780sgD5IkZY7tvZ8U
	rYkm36DKp1o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9EA134F0;
	Sat, 15 Oct 2011 01:44:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2081234EF; Sat, 15 Oct 2011
 01:44:50 -0400 (EDT)
In-Reply-To: <1318632815-29945-6-git-send-email-patthoyts@users.sourceforge.net> (Pat
 Thoyts's message of "Fri, 14 Oct 2011 23:53:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC4F2AD6-F6F0-11E0-84D4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183641>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> ---
>  t/t9901-git-web--browse.sh |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/t/t9901-git-web--browse.sh b/t/t9901-git-web--browse.sh
> index 7906e5d..1185b42 100755
> --- a/t/t9901-git-web--browse.sh
> +++ b/t/t9901-git-web--browse.sh
> @@ -12,7 +12,7 @@ test_expect_success \
>  	echo http://example.com/foo\&bar >expect &&
>  	git config browser.custom.cmd echo &&
>  	git web--browse --browser=custom \
> -		http://example.com/foo\&bar >actual &&
> +		http://example.com/foo\&bar | tr -d "\r" >actual &&
>  	test_cmp expect actual
>  '

This is unnice for two reasons. We have web--browse five times in this
test script, and you add tr exactly the same way to each and every one of
them. And you are losing the error condition from each and every one of
these web--browse invocations.

Having to do the same change to all invocations of the same command
suggests that perhaps you can and should wrap that pattern into a single
helper, perhaps like:

test_web_browse () {
	# browser=$1 url=$2
	git web--browse --browser="$1" "$2" >actual &&
        tr -d '\015' <actual >text &&
        test_cmp expect text
}

or something?
