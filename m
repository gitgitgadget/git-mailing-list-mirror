From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 7/9] parse-options.h: add macros for '--contains' option
Date: Mon, 08 Jun 2015 12:32:23 -0700
Message-ID: <xmqqr3pm9et4.fsf@gitster.dls.corp.google.com>
References: <5573520A.90603@gmail.com>
	<1433621052-5588-1-git-send-email-karthik.188@gmail.com>
	<1433621052-5588-7-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 21:32:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z22md-0004l9-8o
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 21:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825AbbFHTc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 15:32:26 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33394 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbbFHTcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 15:32:25 -0400
Received: by igbpi8 with SMTP id pi8so67100713igb.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 12:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=q+otAeShnRMLTM8FSz0EdQ2Vz/vxlYjENxywmUdnw4c=;
        b=a7/6PefK754t93P2U4Ycss3MkPMC4x0x0CboXSwMR7wLjJWEQDVs5KFQymiIMzDqKi
         XytczzzZABRYMJzxVVi5SDR0vWiHgqxt7YsQNiDaPjjE1nYo4soc/ZriRSFoTELVdFbj
         Eeuy1T7q3umOwzGTYvR+PmxchHD4RD2ds8vcCwrJC8Ccjj8kKO+4yYawYha6VQTLHVXP
         klVwJP/OIXomIoo9LawjRrhmVG4tLp6/KHYPCyc3X4A6hXJ2Cztx38Lou+5o94Hf4bSw
         PokQiNE/MnuIQbH325zug+TPwLmcafz4s0CZ9/M2ZXrSWF8J/wpln100Il08cIi0FGA3
         obvQ==
X-Received: by 10.107.160.141 with SMTP id j135mr22364129ioe.43.1433791945242;
        Mon, 08 Jun 2015 12:32:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id r34sm2355581ioi.34.2015.06.08.12.32.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 12:32:24 -0700 (PDT)
In-Reply-To: <1433621052-5588-7-git-send-email-karthik.188@gmail.com> (Karthik
	Nayak's message of "Sun, 7 Jun 2015 01:34:10 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271116>

Karthik Nayak <karthik.188@gmail.com> writes:

> +#define OPT_CONTAINS(filter, h) \
> +	{ OPTION_CALLBACK, 0, "contains", (filter), N_("commit"), (h), \
> +	  PARSE_OPT_LASTARG_DEFAULT, \
> +	  parse_opt_with_commit, (intptr_t) "HEAD" \
> +	}
> +#define OPT_WITH(filter, h) \
> +	{ OPTION_CALLBACK, 0, "with", (filter), N_("commit"), (h), \
> +	  PARSE_OPT_LASTARG_DEFAULT, \
> +	  parse_opt_with_commit, (intptr_t) "HEAD" \
> +	}

The redundancy bothers me.  Can't we do a bit better than that,
perhaps like this?

#define _OPT_CONTAINS_OR_WITH(name, variable, help) \
	{ OPTION_CALLBACK, 0, name, (variable), N_("commit"), (help), \
	  PARSE_OPT_LASTARG_DEFAULT, \
	  parse_opt_with_commit, (intptr_t) "HEAD" \
	}
#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h)
