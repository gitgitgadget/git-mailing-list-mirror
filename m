From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/3] commit: add function to unparse a commit and its
 parents
Date: Mon, 25 May 2009 11:17:18 +0200
Message-ID: <4A1A621E.10703@viscovery.net>
References: <20090517153307.6403.73576.> <20090517153647.6403.44036.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon May 25 11:17:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8WJG-0003ql-6u
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 11:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbZEYJRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 05:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbZEYJRU
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 05:17:20 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:64859 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbZEYJRT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 05:17:19 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M8WJ4-00080u-9i; Mon, 25 May 2009 11:17:18 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0CA0254D; Mon, 25 May 2009 11:17:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090517153647.6403.44036.chriscool@tuxfamily.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119904>

Christian Couder schrieb:
> +static void unparse_commit_list(struct commit_list *list)
> +{
> +	for (; list; list = list->next)
> +		unparse_commit(list->item);
> +}
> +
> +void unparse_commit(struct commit *item)
> +{
> +	item->object.flags = 0;
> +	item->object.used = 0;
> +	if (item->object.parsed) {
> +		item->object.parsed = 0;
> +		if (item->parents) {
> +			unparse_commit_list(item->parents);
> +			free_commit_list(item->parents);
> +			item->parents = NULL;
> +		}
> +	}
> +}

I see a recursion here. Could this not overflow the stack if there is a
long ancestry chain?

-- Hannes
