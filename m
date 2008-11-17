From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git-remote: simplifying get_one_entry
Date: Mon, 17 Nov 2008 08:48:14 -0800
Message-ID: <7vabbywb75.fsf@gitster.siamese.dyndns.org>
References: <1226920551-28303-1-git-send-email-crquan@gmail.com>
 <1226920551-28303-2-git-send-email-crquan@gmail.com>
 <1226920551-28303-3-git-send-email-crquan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: crquan@gmail.com
X-From: git-owner@vger.kernel.org Mon Nov 17 17:51:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L27Jn-0005xg-7U
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 17:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbYKQQuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 11:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752120AbYKQQuE
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 11:50:04 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48216 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbYKQQuD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 11:50:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 02B927F26A;
	Mon, 17 Nov 2008 11:50:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 756C47F253; Mon,
 17 Nov 2008 11:48:20 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C655A4F2-B4C7-11DD-92F0-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101234>

crquan@gmail.com writes:

> From: Cheng Renquan <crquan@gmail.com>
>
> The loop for remote->url_nr is really useless, set to the last one
> directly is better.

Is it really useless?  Be more descriptive.

> -	if (remote->url_nr > 0) {
> -		int i;
> -
> -		for (i = 0; i < remote->url_nr; i++)
> -			string_list_append(remote->name, list)->util = (void *)remote->url[i];
> -	} else
> -		string_list_append(remote->name, list)->util = NULL;
> +	string_list_append(remote->name, list)->util =
> +		remote->url_nr > 0
> +		? (void *)remote->url[remote->url_nr-1] : NULL;

When you have more than one URL associated with the remote (this makes
sense only for pushing), the current code adds that many string_list_item
to the list, each holding the URL.  "git remote -v" shows all of them.

Your change instead creates only one string_list_item and hold the last
URL.  Doesn't it make show_all() to show only one URL for the remote?
