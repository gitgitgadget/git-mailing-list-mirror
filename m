From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [GSoC] Add configuration options for some commonly used command-line options
Date: Sun, 15 Mar 2015 13:24:06 -0700
Message-ID: <xmqqlhiyt3fd.fsf@gitster.dls.corp.google.com>
References: <5505DD9D.8010102@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Sun Mar 15 21:24:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXF54-0001kH-Q9
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 21:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbbCOUYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 16:24:11 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751448AbbCOUYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 16:24:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BCE7B3F244;
	Sun, 15 Mar 2015 16:24:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ag2uTiUm0TshJQ32ePp0T8YjZT0=; b=qajYuY
	DxDuMztnsautTWPG99lJ1oRcPfud+j5MV6gPh5OvIiAtXt3mD/gakONcIWCS9eEc
	Bq7uj7+1e4pfnSy4oYailn7bbEBUYxp5sGkGaglvARd+itfKsyt70sa+F3H/yYZC
	lcV1NnJaeEzbfvyZF3suhniR2ZAtFFIN1H2sk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cOmXtEOad36AvKZXWny8fHvUdbSO6HbU
	QQhE+fqdpuj1JKXjd5gnUdcwsoYPz+AsB1ZYdM28Z/ZOA4nE99mosEUN63LCc+b8
	4As3td1h+NQ4mlCZ7lhrb0g5cv0BZdEm9ooIRYLm/Y9DW9no1EsV1fge2Yi0Ea8L
	4WeDZ2l95hE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B44C03F243;
	Sun, 15 Mar 2015 16:24:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 357BB3F242;
	Sun, 15 Mar 2015 16:24:08 -0400 (EDT)
In-Reply-To: <5505DD9D.8010102@posteo.de> (Koosha Khajehmoogahi's message of
	"Sun, 15 Mar 2015 20:29:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3BB2F654-CB51-11E4-92A1-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265520>

Koosha Khajehmoogahi <koosha@posteo.de> writes:

> This patch adds a 'showmerges' config. option for git-log.
> This option determines whether the log should contain merge
> commits or not. In essence, if this option is set to true,
> git-log will be run as 'git-log --no-merges'.
>
> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
> ---
>  Documentation/config.txt | 3 +++
>  builtin/log.c            | 8 ++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1530255..7775b8c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1735,6 +1735,9 @@ log.showroot::
>  	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
>  	normally hide the root commit will now show it. True by default.
>  
> +log.showmerges::
> +	If true, merges will be shown in the log list. True by default.

When you have to help your colleague by inspecting the history in
her repository, and your colleague has this set to false, and you do
want your "git log" to show merge commits, how would you override
this setting?

	git log --merges

is not it.

Avoid introducing a configuration that users cannot override it from
the command line.  If there is a way to override (and for the
purpose of this discussion, "git -c log.showmerges=yes" does not
count), document it here.

Tests need to make sure that (1) with configuration without command
line override, the various settings of the variable give behaviour
you wanted to give, and (2) with configuration with command line
override, the values set to the variable does not have any effect to
the behaviour (i.e. the command line override wins).

Thanks.
