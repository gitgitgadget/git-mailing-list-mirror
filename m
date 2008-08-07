From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fail properly when cloning from invalid HTTP URL
Date: Wed, 06 Aug 2008 17:24:41 -0700
Message-ID: <7v63qdn03a.fsf@gitster.siamese.dyndns.org>
References: <1218067590-31590-1-git-send-email-pasky@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, barkalow@iabervon.org
To: pasky@suse.cz
X-From: git-owner@vger.kernel.org Thu Aug 07 02:25:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQtKC-00033l-PP
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 02:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbYHGAYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 20:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbYHGAYv
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 20:24:51 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbYHGAYu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 20:24:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3FB574D924;
	Wed,  6 Aug 2008 20:24:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3C53F4D920; Wed,  6 Aug 2008 20:24:44 -0400 (EDT)
In-Reply-To: <1218067590-31590-1-git-send-email-pasky@suse.cz>
 (pasky@suse.cz's message of "Thu, 7 Aug 2008 02:06:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3EDA6D2E-6417-11DD-A233-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91552>

pasky@suse.cz writes:

> diff --git a/transport.c b/transport.c
> index 6eb65b8..b88b89b 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -464,16 +464,15 @@ static struct ref *get_refs_via_curl(struct transport *transport)
>  		if (results.curl_result != CURLE_OK) {
>  			strbuf_release(&buffer);
>  			if (missing_target(&results)) {
> +				die("%s not found: did you run git update-server-info on the server?", refs_url);
>  				return NULL;

Hmm, I do not see a deletion of a line here...

Everybody else in the get_refs_via_ family just die()s, and the caller of
them do not notice nor treat NULL as anything special; I think your patch
is a sensible thing to do.
