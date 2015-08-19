From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] submodule: implement `module_list` as a builtin helper
Date: Wed, 19 Aug 2015 11:17:55 -0700
Message-ID: <xmqqpp2j9m7g.fsf@gitster.dls.corp.google.com>
References: <1439857323-21048-1-git-send-email-sbeller@google.com>
	<1439857323-21048-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, hvoigt@hvoigt.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 20:18:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS7w2-0004gM-K2
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 20:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbbHSSR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 14:17:59 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35604 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbbHSSR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 14:17:57 -0400
Received: by pacgr6 with SMTP id gr6so8284487pac.2
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 11:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wc3WY6kfGqlAB+eAf+TiiEmTpPGgrLh7xdkVIAap+YE=;
        b=LDfI29axp5EC4F3K/01xTnBZ4Pfm7zEmrBM+bX69feSGfH7aeMoGLz8KFnN8nOcoCF
         ReP62x2LkzHdTW5+wFZips56d5Z03+8eEBjlX+cXAaBHy7QlWZ/aCpWIOTD5m+BOqFwq
         2kKEYAxNnJrNiRAN+qBFQ3jlmPUWBl0jRUlhn+NkYIjS91o7JOw6lSQlQZnpeRYmFxSK
         vPCnKGgC6i4yXFGD5zpc+CSw4TS3ZslI7TywnP/40NBt8lv36YaaweI3S7NmRQxUjmmu
         iNKFRfZQAyDqfPTGfv9HCzUIimagKVWrHm3wE6riQBGTgAQTFAI0wmknYKnVnq01ttEp
         o1nw==
X-Received: by 10.68.217.102 with SMTP id ox6mr27603908pbc.158.1440008277181;
        Wed, 19 Aug 2015 11:17:57 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a5d7:91a5:eac5:b635])
        by smtp.gmail.com with ESMTPSA id q1sm1637408pap.20.2015.08.19.11.17.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Aug 2015 11:17:56 -0700 (PDT)
In-Reply-To: <1439857323-21048-6-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 17 Aug 2015 17:22:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276209>

Stefan Beller <sbeller@google.com> writes:

> +static int module_list_compute(int argc, const char **argv,
> +				const char *prefix,
> +				struct pathspec *pathspec)
> +{
> +	int i;
> +	char *max_prefix, *ps_matched = NULL;
> +	int max_prefix_len;
> +	parse_pathspec(pathspec, 0,
> +		       PATHSPEC_PREFER_FULL |
> +		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
> +		       prefix, argv);
> +
> +	/* Find common prefix for all pathspec's */
> +	max_prefix = common_prefix(pathspec);
> +	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
> +
> +	if (pathspec->nr)
> +		ps_matched = xcalloc(1, pathspec->nr);

Micronit.  Even though multiplication is commutative, the order of
arguments to xcalloc() looks odd.  It lets you say "I want an array
with nmemb elements, and each of its is size-bytes long" by giving
it nmemb and then size.

No need to resend; will fix it up while queuing.

Thanks.
