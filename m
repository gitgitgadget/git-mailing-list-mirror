From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Mon, 05 Nov 2007 13:14:32 -0800
Message-ID: <7vejf4pf7r.fsf@gitster.siamese.dyndns.org>
References: <1194202941253-git-send-email-shawn.bohrer@gmail.com>
	<11942029442710-git-send-email-shawn.bohrer@gmail.com>
	<11942029474058-git-send-email-shawn.bohrer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 22:15:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip9HY-0007yx-HH
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 22:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991AbXKEVOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 16:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbXKEVOi
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 16:14:38 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50947 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986AbXKEVOi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 16:14:38 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id DE2A02EF;
	Mon,  5 Nov 2007 16:14:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4F25692880;
	Mon,  5 Nov 2007 16:14:56 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63551>

Shawn Bohrer <shawn.bohrer@gmail.com> writes:

> This replaces git-clean.sh with builtin-clean.c, and moves git-clean.sh to
> the examples.
>
> Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
> ---
> diff --git a/builtin-clean.c b/builtin-clean.c
> new file mode 100644
> index 0000000..4141eb4
> --- /dev/null
> +++ b/builtin-clean.c
> @@ -0,0 +1,157 @@
> +/*
> + * "git clean" builtin command
> + *
> + * Copyright (C) 2007 Shawn Bohrer
> + *
> + * Based on git-clean.sh by Pavel Roskin
> + */
> +
> +#include "builtin.h"
> +#include "cache.h"
> +#include "dir.h"
> +
> +static int disabled = 1;

This means we are committed to make clean.requireForce default
to true, which is fine by me.  I need to warn the users about
this early.

> +static int show_only = 0;
> +static int remove_directories = 0;
> +static int quiet = 0;
> +static int ignored = 0;
> +static int ignored_only = 0;

Please do not explicitly initialize static variables to zero.
