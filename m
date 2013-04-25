From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5801: properly test the test shell
Date: Thu, 25 Apr 2013 09:20:56 -0700
Message-ID: <7vppxi60pj.fsf@alter.siamese.dyndns.org>
References: <ff7ccf22012f069ceca054d90aa0f72666cc11c2.1366884583.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 25 18:21:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVOuw-0002h4-Mp
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 18:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758854Ab3DYQVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 12:21:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47306 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757988Ab3DYQVA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 12:21:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DDDB17920;
	Thu, 25 Apr 2013 16:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IZ2MUZ3XK40YR4U25LfNeQ5Bn5o=; b=ujc/o5
	R7zzh+vi6Fl7ntJF/dwkf8YOPX/sKClawouAonzDsSRs9borjqCUlSM4FMitzRsZ
	Gv92EIQzm2HSXNmZr43/H1fBOeXdgIsQ2imWb7p7tlSWZ65IygH7FMKioiUtjtxK
	P6XuVwpPRw4wuiXJYtd5Bss9iaFrrXKP34xkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VDTf0tebii4gqNiENrl0a29n/Zu6mhDW
	ToBArnRdu/sb+FFVxJz+KQxXlzkdU6bEMWogZ/gCNOWa1wyyVuZAcZ8TQfb7LrOI
	f9ha7y1xZ10jiX3wxykJmx/72XsZ6Id8GuuEuCnZzuuqyn+lObc1Sioyu6yPEPP2
	6ALc+TswKro=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C14B1791F;
	Thu, 25 Apr 2013 16:20:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 748F91791D;
	Thu, 25 Apr 2013 16:20:58 +0000 (UTC)
In-Reply-To: <ff7ccf22012f069ceca054d90aa0f72666cc11c2.1366884583.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Thu, 25 Apr 2013 12:09:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1CEAD14E-ADC4-11E2-9936-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222388>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> fc407f9 (Add new simplified git-remote-testgit, 2012-11-28) introduced a
> test which was meant to skip the test unless the test shell is bash.
> Unfortunately, it tests for the availability of bash only.

True.

> But users can
> opt to use a different shell (using SHELL_PATH) for the tests even though
> bash is available.
>
> At least for dash,
> 21610d8 (transport-helper: clarify pushing without refspecs, 2013-04-17)
> is the commit which actually introduces a test (pushing without refspec)
> which fails to fail even though it is supposed to. It uses the
> construct:
>
> VAR=value function arguments

The right fix for that is to fix that line, so that the test itself
can run under any sane POSIX shell, isn't it?  The test in turn may
need to run git-remote-testgit, which, without J6t's updates, only
is usable under bash, but to make sure the test will choke on
absence of bash, the existing check should be sufficient, no?

> Make t5801 actually test whether the test shell is bash.
>
> An even better alternative would be to make the test POSIX compliant, of
> course.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  t/t5801-remote-helpers.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> index ed962c4..c979863 100755
> --- a/t/t5801-remote-helpers.sh
> +++ b/t/t5801-remote-helpers.sh
> @@ -8,7 +8,7 @@ test_description='Test remote-helper import and export commands'
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-gpg.sh
>  
> -if ! type "${BASH-bash}" >/dev/null 2>&1; then
> +if test $(basename "${SHELL_PATH}") != "bash"; then
>  	skip_all='skipping remote-testgit tests, bash not available'
>  	test_done
>  fi
