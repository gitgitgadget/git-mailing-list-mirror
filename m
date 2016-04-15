From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 21/21] bisect: get back halfway shortcut
Date: Fri, 15 Apr 2016 15:53:19 -0700
Message-ID: <xmqqlh4e7acg.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294692-7402-1-git-send-email-s-beyer@gmx.net>
	<1460294692-7402-2-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Apr 16 00:53:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arCcC-0001UU-7X
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 00:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbcDOWxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 18:53:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751024AbcDOWxW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 18:53:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8942B137A5;
	Fri, 15 Apr 2016 18:53:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SjVsPTuomOldYbelPL6ro4nzlEY=; b=A7YUu4
	JR7R6tDVxGKHxqtcJu0NnTH8xcLXab8HXnzpqlMtE1445ln5snd4yp/bTVtov+Cq
	qjIOfutrKTwctrtrPTOIJ/qHz0yVKdstgC2MeaemzIBL+RVUQr6djDUgpC60bvh3
	L+oulZIgCx6wSH3SqmSADZSOerclS9+xqzAMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QlgVio/u4wXiFimlv0+XRSFDZU6v4ugw
	KR1TJ2b4UwApghqeHNkFSiMgY91jNH4hIDQ5Co1cQcdwlHi8cS+TBukXY2IUKJ4q
	CU0iyzYLFMdO9MiQvB4E9Y2U2e7OS5w82jjMHhNbp7KLoMiVrhk5hnU6PaaxM4iu
	uZ+8IVUMKRM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 812B2137A4;
	Fri, 15 Apr 2016 18:53:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE6B2137A3;
	Fri, 15 Apr 2016 18:53:20 -0400 (EDT)
In-Reply-To: <1460294692-7402-2-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Sun, 10 Apr 2016 15:24:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D9F3E640-035C-11E6-8C41-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291690>

Stephan Beyer <s-beyer@gmx.net> writes:

> The documentation says that when the maximum possible distance
> is found, the algorithm stops immediately. That feature is
> reestablished by this commit.
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
>
> Notes:
>     I plugged a memory leak here.

... relative to patch series v1, I presume?

> @@ -391,7 +391,13 @@ static void traversal_up_to_merges(struct commit_list *queue,
>  		}
>  
>  		update_best_bisection(top);
> +		if (distance_direction(top) == 0) { // halfway

Say /* halfway */ without // double-slash comment.

The remainder of the patch makes sense to me.
