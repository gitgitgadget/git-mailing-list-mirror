From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: add --verify-signatures
Date: Thu, 17 Dec 2015 10:22:20 -0800
Message-ID: <xmqq60zxc4v7.fsf@gitster.mtv.corp.google.com>
References: <20151210130228.GA22641@netblarch.tu-darmstadt.de>
	<xmqq37vai0ev.fsf@gitster.mtv.corp.google.com>
	<xmqqy4d2gjw6.fsf@gitster.mtv.corp.google.com>
	<20151216133915.GA3586@blarch>
	<xmqqfuz2e003.fsf@gitster.mtv.corp.google.com>
	<20151217010422.GA19500@blarch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 19:22:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9dC7-0001qq-Ul
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 19:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbbLQSWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 13:22:24 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51018 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752743AbbLQSWX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 13:22:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7111C35AD1;
	Thu, 17 Dec 2015 13:22:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+edCP9i/9ge35QFV/1H3hvi6UAs=; b=MfhNLQ
	0MEebcLGHvgLr0dw2BZxN5EMUCLfof3P8Z1TnAKs4tOX6aMLXcj+WHtwrJ2gxMkh
	5o6Nt2foA27KMxRx6I+EyQPeIax5NC+J3LZkYL+m0kd2/5zkZJ2jus/QxBhjt0OD
	9NIW1loMkwGXhFcnJhcaM3EGLgEBqmORfo3ug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e1JjevkTOewcNNgwZzoguV8t+tmvnMcD
	kgvEc/QQzxqsSDyFHVj09EmSL/B07z/ds9Yg1KsvXkLaTLLqcfp0qg12GH3PNQOL
	eJ0D1ojuQMf8WTj/ydeUyb41glsJ2s5gQtORlcSTCjvjv3vJLj32YHaTxCL8JZSW
	eJcyOcfZ1BI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 68F7135AD0;
	Thu, 17 Dec 2015 13:22:22 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E1C5635ACD;
	Thu, 17 Dec 2015 13:22:21 -0500 (EST)
In-Reply-To: <20151217010422.GA19500@blarch> (Alexander Hirsch's message of
	"Thu, 17 Dec 2015 02:04:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1D3BB8AE-A4EB-11E5-B327-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282663>

Alexander 'z33ky' Hirsch <1zeeky@gmail.com> writes:

> As I understand it, this is the same reason for the existence of
> --verify-signatures for git-merge. Otherwise the same argument could be
> made for git-merge 

I suspect that you are missing the bigger workflow issues, if you
think this and merge are the same.

git-merge will check the other history on the side branch that you
are merging _into_ the trunk, to give you an opportunity to reject
what does not pass and keep the trunk sane without doing anything
else.  How you (or others who asked you to pull) clean up the side
branch is outside the scope of its verification.

Your change to "git pull --rebase" checks the other way---the
history, which is already the trunk, onto which your work will be
rebased.  There is nothing you can do without messing with the trunk
if the validation did not pass, be it with a rewind-and-rebuild or a
sealing empty commit which is pointless.
