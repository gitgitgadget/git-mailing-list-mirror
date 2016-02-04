From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git grep argument parser bug
Date: Thu, 04 Feb 2016 14:18:01 -0800
Message-ID: <xmqqzivgf7c6.fsf@gitster.mtv.corp.google.com>
References: <CANzEV58SgS6P_qBequGSfA0vFy9s0-KM3xOFaU2DDz_S3OyN3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dylan Grafmyre <dylang@conversica.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 23:18:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRSEI-0001UT-0M
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 23:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbcBDWSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 17:18:07 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61307 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751093AbcBDWSF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 17:18:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D50142D0B;
	Thu,  4 Feb 2016 17:18:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aICuoUt7G+usQW1kJKWEh1sNaxI=; b=QwR2WS
	3nfuCh66urElXCYBISxnl+gzX3uRoMqAioTgPABu/UbZoVDGbgA158sfj0F34d/I
	nEpZoK5nm4CFTol2MCFjuhdK4blBpOKzeezJuse7z60QavUq5BQN40MW+pNkvA1N
	MN8FWzgwHq1t/AhFTRBnnSPz/0sAMg85iiTrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OTyQnhB2pp4+ZnoAQ57JOf53N4n5NhEi
	wMifuh2Vvf57IDtZNNp6mJY4nJxCmpoTYmyAk5HUMPGxXd6s1Elk5yfCsF4+u8kE
	p1X1P4eAeeJzNPlAOPfg+C4p6CXEMTMStlGCs9iGraE3gn0+0vGmYxh3FwAnbyv8
	BTIZMCPn4Ow=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4554042D0A;
	Thu,  4 Feb 2016 17:18:04 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1E29B42D08;
	Thu,  4 Feb 2016 17:18:03 -0500 (EST)
In-Reply-To: <CANzEV58SgS6P_qBequGSfA0vFy9s0-KM3xOFaU2DDz_S3OyN3g@mail.gmail.com>
	(Dylan Grafmyre's message of "Thu, 4 Feb 2016 14:02:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2848C67E-CB8D-11E5-AC30-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285510>

Dylan Grafmyre <dylang@conversica.com> writes:

> In both ubuntu versions of git 1.9.1 and 2.7.0
>
>     git grep '-test'
>     git grep '--help'
>
> Or any other expressions literal leading with a single dash or double
> dash get interpreted as argument flags and not as search expressions.
> ...
> What I expect is grep results for the literal strings "-test" and "--help"

I think you'd need to adjust your expectations, then ;-).

This is how "grep" (not "git grep") works, and you use "-e", i.e.

	grep -e "-anything that begins with a dash" FILES...

to disambiguate.  If you are scripting, if you do not know what you
have in a variable, and if you are looking for the value in that
variable, you would always do

	grep -e "$variable" FILES...

not

        grep "$variable" FILES...

I think all of the above is pretty much the standard practice and
"git grep" merely follows suit, i.e.

	git grep -e "-help"

is designed to work that way to match users' expectations.
