From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] showing existing ws breakage
Date: Wed, 27 May 2015 11:57:15 -0700
Message-ID: <xmqqa8wpn910.fsf@gitster.dls.corp.google.com>
References: <1432669584-342-1-git-send-email-gitster@pobox.com>
	<1432708232-29892-1-git-send-email-gitster@pobox.com>
	<20150527072218.GB6898@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 27 20:57:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxgW9-00051X-7p
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 20:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505AbbE0S5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 14:57:22 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37378 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbbE0S5S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 14:57:18 -0400
Received: by igbsb11 with SMTP id sb11so21581251igb.0
        for <git@vger.kernel.org>; Wed, 27 May 2015 11:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ws05QzYme9CWJut4l6nFB4Jc7F5XmiGMDNB82/mPfKY=;
        b=IyW60R34BlqXRxNhY5RFAlsD6mjSxT96qj/vLTI7vuXuLHRxey3nOqVMBmyo3fImbD
         vC1ID58mrvb8inEeASZo5Ax0ubaZVfRGwPjW5J5h6HyM9SdTEftfmFjD/dnRSE4Bd7bS
         jOfb/jIXsX84K6KtCopZsdLRT8dmvBEmlFHQqg6/J5A9KlQ/oNVla7rIyqO58YG9T8p0
         SN++jGJVVzM3kPe7+inovpsGPq9f/+seCJiniUczy7xFTY+aCIu+DLDi8dV3YowwPSLI
         nokGDBAcXn5GyiTYif+qpBSS8rX+Xyci4dm9j6T+uMI6UX+qGugEzjVJKNqpj5z995OW
         loUw==
X-Received: by 10.107.129.133 with SMTP id l5mr42859714ioi.32.1432753037648;
        Wed, 27 May 2015 11:57:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4485:3520:962f:d5a5])
        by mx.google.com with ESMTPSA id qh1sm223176igb.17.2015.05.27.11.57.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 11:57:17 -0700 (PDT)
In-Reply-To: <20150527072218.GB6898@peff.net> (Jeff King's message of "Wed, 27
	May 2015 03:22:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270064>

Jeff King <peff@peff.net> writes:

> In color.diff.*, these are called "new", "old", and "plain". I am of the
> opinion that "context" is a far better name than "plain", but perhaps we
> should support both for consistency.
>
> Here's a patch for the color.diff side, if we want to go that route.
>
> -- >8 --
> Subject: diff: accept color.diff.context as a synonym for "plain"
>
> The term "plain" is a bit ambiguous; let's allow the more
> specific "context", but keep "plain" around for
> compatibility.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I didn't bother mentioning the historical "plain" in the documentation.
> I don't know if it's better to (for people who find it in the wild and
> wonder what it means) or if it simply clutters the description.

'plain' does sound a misnomer, as these slot names are about "what"
are painted, not "how" they are painted.  The latter is what their
values represent.  Whoever named that slot was confused by the fact
that 'context' (i.e. "what") lines are by default painted in 'plain'
color without frills (i.e. "how").

We usually try to give a brief mention to historical names primarily
to silence those who pick up stale information from the Web, get
curious, and then complain loudly after finding that we no longer
document them even though we keep accepting them silently, so I am
somewhat tempted to do this on top.

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0a7ffa5..b458590 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -870,7 +870,8 @@ command line with the `--color[=<when>]` option.
 color.diff.<slot>::
 	Use customized color for diff colorization.  `<slot>` specifies
 	which part of the patch to use the specified color, and is one
-	of `context` (context text), `meta` (metainformation), `frag`
+	of `context` (context text - `plain` is a historical synonym),
+	`meta` (metainformation), `frag`
 	(hunk header), 'func' (function in hunk header), `old` (removed lines),
 	`new` (added lines), `commit` (commit headers), or `whitespace`
 	(highlighting whitespace errors). The values of these variables may be
