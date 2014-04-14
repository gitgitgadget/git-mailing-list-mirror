From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 0/6] transport-helper: fixes
Date: Mon, 14 Apr 2014 13:41:17 -0700
Message-ID: <xmqq61mbod8y.fsf@gitster.dls.corp.google.com>
References: <1397333575-11614-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Richard Hansen <rhansen@bbn.com>,
	Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 22:41:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZnh0-0005AQ-Am
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 22:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbaDNUlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 16:41:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49167 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbaDNUlV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2014 16:41:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1F7D7DE3B;
	Mon, 14 Apr 2014 16:41:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qbi1WdSYWx84AkugtxRyFhqiDDI=; b=Zypovq
	xQp0zxD5nh3grxjy//9u94XTv45hk7ZB3CrLP4UJbAhbIzoHpYF+Ibro9AdKUx/3
	ajxe+GWa9wEBvHzfMVlV1BNzJ5X/OgHti+1DJVhETtj1v6IL5Mw/x5wzD9vy7YXC
	+SqXHvGX8RNpYDIBBveJkdteoekXhs6QhlfWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lm1S6u8RPC223TzXKLfZ4Yz2wdAuRXjC
	pv494rm+mJtslIeL7KQx3jQzjhuqtQh61izEvR7pVnde1Pk+pp7qUc/mcmerbBXl
	D6tjLdPChhF8BqYp90B5EQVDVJYEH1pas01Z4H/aOLZ9qe3NUYgoswhUHNxSGrAX
	21YUtcw/n80=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B717C7DE3A;
	Mon, 14 Apr 2014 16:41:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 379FE7DE38;
	Mon, 14 Apr 2014 16:41:19 -0400 (EDT)
In-Reply-To: <1397333575-11614-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 12 Apr 2014 15:12:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 21DB1DAE-C415-11E3-A7C6-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246264>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> These patches add support for remote helpers --force, --dry-run, and reporting
> forced update.
>
> Changes since v8:
>
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -734,7 +734,7 @@ static int push_update_ref_status(struct strbuf *buf,
>         }
>  
>         (*ref)->status = status;
> -       (*ref)->forced_update = forced;
> +       (*ref)->forced_update |= forced;
>         (*ref)->remote_status = msg;
>         return !(status == REF_STATUS_OK);
>  }

Hmph, isn't v8 already in 'master' as of 90e6255a (Merge branch
'fc/transport-helper-fixes', 2014-03-18)?


> Felipe Contreras (4):
>   transport-helper: mismerge fix
>   transport-helper: don't update refs in dry-run
>   transport-helper: add 'force' to 'export' helpers
>   transport-helper: check for 'forced update' message
>
> Richard Hansen (2):
>   test-hg.sh: tests are now expected to pass
>   remote-bzr: support the new 'force' option
>
>  Documentation/gitremote-helpers.txt   |  4 ++++
>  contrib/remote-helpers/git-remote-bzr | 31 ++++++++++++++++++++++++++++++-
>  contrib/remote-helpers/test-bzr.sh    | 22 +++++++++++++++++++++-
>  contrib/remote-helpers/test-hg.sh     |  4 ++--
>  git-remote-testgit.sh                 | 18 ++++++++++++++++++
>  t/t5801-remote-helpers.sh             | 13 +++++++++++++
>  transport-helper.c                    | 25 +++++++++++++++++--------
>  7 files changed, 105 insertions(+), 12 deletions(-)
