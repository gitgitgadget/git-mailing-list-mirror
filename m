From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2 1/3] sh-setup: export GIT_DIR
Date: Wed, 23 Apr 2014 13:18:22 -0700
Message-ID: <xmqqwqefyf3l.fsf@gitster.dls.corp.google.com>
References: <1398282160-26151-1-git-send-email-felipe.contreras@gmail.com>
	<1398282160-26151-2-git-send-email-felipe.contreras@gmail.com>
	<20140423200150.GA31356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Ilya Bobyr <ilya.bobyr@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 23 22:18:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd3cm-0004at-MS
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 22:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbaDWUS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 16:18:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42613 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755714AbaDWUSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 16:18:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51DC37E5F1;
	Wed, 23 Apr 2014 16:18:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LPwTIRsDqwn1WSZg5VGmh5bu6uA=; b=CGselX
	T4bfEobCnHY307agH0vjNfzeaWRLZBJpKFwgD19u1wM5zEHUsmQQ3nM4519ZxABL
	7Z/rKEVtTWGvJGWOU9BcLktSTN2k0O0zj1CJxTyhOjEgWOAED3QaJmh2hbZ3Y+gr
	N42RWSFhkZk+ME8QHPDQuHY3DxF02Qy//kD8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OGkvbnfn20WqMpHkQFiybo3Afbwrtrif
	WYK1R3KIa2kkWBgY8x4mAItsYkZ5Cr3MspYHjKI88orJhq/B/WWs+9lBYDltnWlE
	ueHPl3atojWJapHmBc67sTYMj8+64jQbQ/EqdIAVMvtf9sAuqXpMVAcTpIKxIeGg
	7UjYR14GVqQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 355237E5F0;
	Wed, 23 Apr 2014 16:18:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CEDB7E5ED;
	Wed, 23 Apr 2014 16:18:23 -0400 (EDT)
In-Reply-To: <20140423200150.GA31356@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 23 Apr 2014 16:01:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6B99AF30-CB24-11E3-BFFE-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246887>

Jeff King <peff@peff.net> writes:

> On Wed, Apr 23, 2014 at 02:42:38PM -0500, Felipe Contreras wrote:
>
>> It is what the clients of this library expect.
>
> Is it? Passing GIT_DIR to sub-invocations of git will change how they
> determine the repo and working tree. Your patch seems to cause failures
> all over the test suite.
>
> Without looking too hard, I'd guess the problems are one of:
>
>   1. Setting GIT_DIR fixes the repo directory for all sub-invocations. A
>      script that does "cd some-other-repo.git && git ...". You'd need to
>      teach calling scripts to unset GIT_DIR when trying to move to
>      another repo.
>
>   2. If GIT_DIR is set but GIT_WORK_TREE is not, then GIT_WORK_TREE will
>      default to ".". It might be sufficient to set GIT_WORK_TREE when
>      you are setting GIT_DIR here. But as I said, I didn't look too
>      hard, so there might be other complications.
>
> -Peff

I do not recall the details but I do remember that it is very
deliberate not to export GIT_DIR but only set in git-sh-setup.
