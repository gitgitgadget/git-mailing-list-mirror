From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote.txt: fix wrong remote refspec
Date: Wed, 22 Jun 2011 22:35:17 -0700
Message-ID: <7viprx3yay.fsf@alter.siamese.dyndns.org>
References: <1308804319-6354-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 23 07:36:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZcaH-00063U-Qp
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 07:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421Ab1FWFfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 01:35:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38611 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058Ab1FWFfV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 01:35:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F27F069F9;
	Thu, 23 Jun 2011 01:37:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pakQ2XWarLlYFe+WEGVbPa72Gs8=; b=gS9iMp
	ef+X/eLBg50720IcuLnRGRPEdZPoqpE8G4uey8nMYzDSk4qNReRQ05HCyRfJ101Y
	W6v0OlYDLKcTTlFCXJWGP/ZTqpjTdFaeYaHE1mJZzxUcF3JGo7iA/s7pfMP2AfNa
	6fMCNXWs6BDbl0xWXK+VY0T9Vo+3H1qoPZHGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GBPPddS4uc8VXmljorDr+1dNyByem+pQ
	m+EmHHQFPjXFc2Z5LncA24uWCph0A8Be6ByeHDdoL6AGf22Vzi7sc8c1nK24Y9s+
	RwsVEOsgcDTAC2iAtrB8jMzonR4b4u58X8QhlfZdgfCbyCHWbkvYSsE8JGdzZbT4
	/WWeY6pK3EY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E9F6969F7;
	Thu, 23 Jun 2011 01:37:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4154869F6; Thu, 23 Jun 2011
 01:37:30 -0400 (EDT)
In-Reply-To: <1308804319-6354-1-git-send-email-namhyung@gmail.com> (Namhyung
 Kim's message of "Thu, 23 Jun 2011 13:45:19 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3093162-9D5A-11E0-8F36-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176262>

Namhyung Kim <namhyung@gmail.com> writes:

> $GIT_DIR/remotes/<name>/HEAD should be
> $GIT_DIR/refs/remotes/<name>/HEAD.
>
> Signed-off-by: Namhyung Kim <namhyung@gmail.com>
> ---

Obviously correct; thanks.

There is another questionable one you did not touch, though.

    With `-t <branch>` option, instead of the default glob
    refspec for the remote to track all branches under
    `$GIT_DIR/remotes/<name>/`, a refspec to track only `<branch>`
    is created.  You can give more than one `-t <branch>` to track
    multiple branches without grabbing all branches.

The above says "$GIT_DIR/remotes/<name>/", but it should say

    ... all branches under refs/remotes/<name>/ namespace,...

Also we should try to see if we can come up with a way to say the things
the part your patch touched describe _without_ mentioning $GIT_DIR at
all. "Store in $GIT_DIR/refs/$X" talks too much about the implementation
detail that the ref in question is implemented as a loose ref. We would
pack it into a single entry in $GIT_DIR/packed-refs file when we run gc,
and at that point "$GIT_DIR/refs/$X" is no longer a correct description.
