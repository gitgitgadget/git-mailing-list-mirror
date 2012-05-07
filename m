From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v4 6/6] completion: add public _GIT_complete helper
Date: Mon, 07 May 2012 11:56:06 -0700
Message-ID: <7vbolz6cs9.fsf@alter.siamese.dyndns.org>
References: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
 <1336353800-17323-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 20:56:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRT6U-0002bq-PS
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 20:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757556Ab2EGS4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 14:56:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36883 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486Ab2EGS4I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 14:56:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 403ED780B;
	Mon,  7 May 2012 14:56:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=90LNy9BG9p/K+QW3BXqFYWJu2pA=; b=jLsOl+
	ceqdClXvyCzunUVtMo3bVYbQrPF7+ZNDZRw7Ri/ZI31n4zHU0Uki/kPWVqRpcQgm
	36/IS0tKYGukpR3OuRHLMExPlf4HoWAtpJS61qgTodig/mYNxL4ia44Bva06jej9
	HM7x1K8jzIJ23rmsAIU/6D2NvCUOBYIn/qrr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BNTV29bdZb7KbRD04Py/OV2VDk3fpu34
	zC4I9L7z3xcljzhjoFJYxCXF50yko+zhRomDrdBawsBTXGG6QOmjuK2cEeCXzJUA
	IwsU0XSqjEe2fCWqcvmgh7gwh/QqXdkigxLDxX6XTX5dNREFBgXPK+I3OgI6DxQQ
	eUFHwpEmwMI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37C9B7809;
	Mon,  7 May 2012 14:56:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9234277F6; Mon,  7 May 2012
 14:56:07 -0400 (EDT)
In-Reply-To: <1336353800-17323-7-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Mon, 7 May 2012 03:23:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DC435DA-9876-11E1-983B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197295>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> So that users can easily define aliases, such as:
>
>  _GIT_complete gf git_fetch
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash |   10 +++++-----
>  t/t9902-completion.sh                  |    9 ++++++++-
>  2 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 049110e..2b7ef02 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2678,6 +2678,7 @@ _gitk ()
>  
>  __git_func_wrap ()
>  {
> +	local cmd="${1#git_}" cmd_pos=1
>  	if [[ -n ${ZSH_VERSION-} ]]; then
>  		emulate -L bash
>  		setopt KSH_TYPESET
> @@ -2695,8 +2696,7 @@ __git_func_wrap ()
>  	_$1
>  }
>  
> -# this is NOT a public function; use at your own risk
> -__git_complete ()
> +_GIT_complete ()

If it is now a public function, please have some description as to how to
use it for people who find this in the tarball extract.

I am guessing that

	_GIT_complete frotz git_fetch

is a way to declare that 'git frotz' wants the same kind of completion as
'git fetch' command, but I am not sure, as if it were the case it strikes
me somewhat odd that it is not "_GIT_complete frotz fetch".
