From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn.perl: fix a false-positive in the "already
 exists" test
Date: Tue, 21 Feb 2012 18:16:39 -0800
Message-ID: <7vk43feho8.fsf@alter.siamese.dyndns.org>
References: <20120219105442.GA11889@dcvr.yhbt.net>
 <1329747474-17976-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: normalperson@yhbt.net, gitster@pobox.com, git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 03:16:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S01lA-0000ON-Nk
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 03:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802Ab2BVCQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 21:16:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63195 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719Ab2BVCQn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 21:16:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A17F97682;
	Tue, 21 Feb 2012 21:16:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rTyoI3aNk2zvuo3BvjvTilqa9/s=; b=csdaBv
	qMsUCg6/pS5jTlFYMijTvoPO+NegOXFtxLr5l+156/FwevZuh8Wbbcyh3TyJFICS
	dyyTc3dN7EqAOQp4gROQzi/urpAfHaMjrP8++NteFV632B2/L2F9thZmouAhu0zK
	Es2mnqSM7VOf9kAHhw4yId6SNhHabhe2ettEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pEgxlTHHbjTB13A/pK0N98uN54sJqCAF
	CVk+BHUwBhQhp7R25qQMfMAk/bevPGaz+A7JFArGeDxzuagEpswDoxHcdLfw3m9H
	1V7J2t3up+B0y8g1AyBeMM5JrKlTuM03HSYYchR1b6QYzM2hr5C5tL+R975EBgDa
	MAMqQnkesZ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 987FB7681;
	Tue, 21 Feb 2012 21:16:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97D567680; Tue, 21 Feb 2012
 21:16:41 -0500 (EST)
In-Reply-To: <1329747474-17976-1-git-send-email-stevenrwalter@gmail.com>
 (Steven Walter's message of "Mon, 20 Feb 2012 09:17:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4247372C-5CFB-11E1-AD3C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191221>

Steven Walter <stevenrwalter@gmail.com> writes:

> diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
> index b041516..4029f84 100755
> --- a/t/t9100-git-svn-basic.sh
> +++ b/t/t9100-git-svn-basic.sh
> @@ -92,9 +92,11 @@ test_expect_success "$name" '
>  	echo yyy > bar/zzz/yyy &&
>  	git update-index --add bar/zzz/yyy &&
>  	git commit -m "$name" &&
> +	git svn set-tree --find-copies-harder --rmdir \
> +		${remotes_git_svn}..mybranch3 &&
> +	svn_cmd up "$SVN_TREE" &&
> +	test -d "$SVN_TREE"/bar/zzz &&
> +	test -e "$SVN_TREE"/bar/zzz/yyy ' || true

Care to explain what this " || true" is doing here, please?
