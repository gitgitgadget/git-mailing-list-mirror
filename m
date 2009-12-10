From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git gui: Use git diff --submodule when available
Date: Thu, 10 Dec 2009 14:52:54 -0800
Message-ID: <7vskbi8mrd.fsf@alter.siamese.dyndns.org>
References: <4B2179E4.3070603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 10 23:53:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIrsm-0000eH-Cm
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 23:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761986AbZLJWxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 17:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761980AbZLJWxA
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 17:53:00 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761857AbZLJWw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 17:52:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E62B1337;
	Thu, 10 Dec 2009 17:53:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EfEj4H6usJHRRmIXE1nZxJROZyQ=; b=i0NqQE
	EJEZ6QQakWrHb592GEQ5ccwgF2nqo0cqDVIC1p9Om1oD+g0ihY/nMHndZRAquT30
	xJ10zbolkchDBUy2y56Q979Ac2uVRFZFD3ss35UDVthGSEt5TbA/eWV3i9NiuIaR
	GwR1a3MOINkvPkoFlWlam3s26Y3FypZms5b3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pLtWxVtdq9G7jjMDoNOxaW6bjVun5jzn
	B/k1bWs6BWkaZbrwbOk2FalLdLnr6v841O2/lCx9GyLdy2RYZdXVje9nYWYKfQbQ
	p1WOEjgidodBXPI6ReBXy/m1IAA8WWxFdwUjNc0ebTwZnpuV0dBR0uj24FmKhLhp
	iLCpKXsLf8Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9A9E1331;
	Thu, 10 Dec 2009 17:53:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12323132A; Thu, 10 Dec
 2009 17:52:55 -0500 (EST)
In-Reply-To: <4B2179E4.3070603@web.de> (Jens Lehmann's message of "Thu\, 10
 Dec 2009 23\:44\:52 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C5A65814-E5DE-11DE-813C-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135048>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Changed the use of submodule summary to diff --submodule because the
> implementation in C is much faster than the submodule script. Also a test
> has been added to make sure that the underlying git supports the diff
> option --submodule (which was introduced in 1.6.6).
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
> @@ -296,16 +304,6 @@ proc start_show_diff {cont_info {add_opts {}}} {
>  		lappend cmd $path
>  	}
>
> -	if {[string match {160000 *} [lindex $s 2]]
> -        || [string match {160000 *} [lindex $s 3]]} {
> -		set is_submodule_diff 1
> -		if {$w eq $ui_index} {
> -			set cmd [list submodule summary --cached -- $path]
> -		} else {
> -			set cmd [list submodule summary --files -- $path]
> -		}
> -	}
> -

Heh, I didn't even know that it originally came from git-gui ;-)
