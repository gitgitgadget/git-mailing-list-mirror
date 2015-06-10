From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 15/19] pull: teach git pull about --rebase
Date: Wed, 10 Jun 2015 16:02:08 -0700
Message-ID: <xmqqy4jrgob3.fsf@gitster.dls.corp.google.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-16-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Jeff King <peff@peff.net>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 01:02:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2p0i-0006BY-Js
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 01:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbbFJXCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 19:02:12 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:33512 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166AbbFJXCL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 19:02:11 -0400
Received: by igdj8 with SMTP id j8so7259286igd.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 16:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=WqJ5j1RI5+LNiqzLaW4+8WpcD6vZNDlVKo1W5+wnLv4=;
        b=KZ1BdNyWVwOKfLXe0mmlkJO1ZvRx+J2KElO7I/VM28uubX+De1cb2UaEOoCHsll3oq
         5PnKj9/JfMgXxpkZShSiCqASHlSbY5qKbBZVbq05NONObm2hUdVjoVyM3KO10Vgl4yY3
         nNnDxdPUWrUwD+gZ+LcQ7W52rHbiZgLoiZwTj6hmMIV/ChOi/K1KTUl1N8pKATA5PttM
         2G+9y1mdUULpajAJ2JiBS/UrFJxv4X021OmoOiaMzPfJSIxlhcnKimU3JihzpZ5wdKUo
         C1IenjsibQcqC4rEbCJFpnEd9MF//r018Gdi/nbDcKw+Ag7lpN/CZIawD0dIisIp/thY
         CIGw==
X-Received: by 10.107.27.7 with SMTP id b7mr7137960iob.64.1433977330552;
        Wed, 10 Jun 2015 16:02:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id j20sm4194986igt.16.2015.06.10.16.02.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 16:02:09 -0700 (PDT)
In-Reply-To: <1433314143-4478-16-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Wed, 3 Jun 2015 14:48:59 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271365>

Paul Tan <pyokagan@gmail.com> writes:

> +/**
> + * Returns remote's upstream branch for the current branch. If remote is NULL,
> + * the current branch's configured default remote is used. Returns NULL if
> + * `remote` does not name a valid remote, HEAD does not point to a branch,
> + * remote is not the branch's configured remote or the branch does not have any
> + * configured upstream branch.
> + */
> +static char *get_upstream_branch(const char *remote)
> +{
> +	struct remote *rm;
> +	struct branch *curr_branch;
> +
> +	rm = remote_get(remote);
> +	if (!rm)
> +		return NULL;
> +
> +	curr_branch = branch_get("HEAD");
> +	if (!curr_branch)
> +		return NULL;
> +
> +	if (curr_branch->remote != rm)
> +		return NULL;
> +
> +	if (!curr_branch->merge_nr)
> +		return NULL;
> +
> +	return xstrdup(curr_branch->merge[0]->dst);
> +}

This part needs to be rebased, as branch->remote no longer exists in
the recent world order.
