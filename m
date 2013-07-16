From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 4/7] remote.c: add command line option parser for
 --lockref
Date: Tue, 16 Jul 2013 23:13:39 +0100
Message-ID: <20130716221318.GA2337@serenity.lan>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
 <1373399610-8588-1-git-send-email-gitster@pobox.com>
 <1373399610-8588-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 00:13:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzDVM-0001yn-Pa
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 00:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934028Ab3GPWNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 18:13:53 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:34313 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933295Ab3GPWNu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 18:13:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id DB7F2CDA5B4;
	Tue, 16 Jul 2013 23:13:49 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BNd4n02iQPXR; Tue, 16 Jul 2013 23:13:49 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 50792CDA5A9;
	Tue, 16 Jul 2013 23:13:49 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 3C9D8161E0B1;
	Tue, 16 Jul 2013 23:13:49 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZOt0Ut8IxTAa; Tue, 16 Jul 2013 23:13:48 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 4FCD2161E49B;
	Tue, 16 Jul 2013 23:13:44 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1373399610-8588-5-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230591>

On Tue, Jul 09, 2013 at 12:53:27PM -0700, Junio C Hamano wrote:
> diff --git a/remote.c b/remote.c
> index 81bc876..e9b423a 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1938,3 +1938,62 @@ struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fet
>  	string_list_clear(&ref_names, 0);
>  	return stale_refs;
>  }
> +
> +/*
> + * Lockref aka CAS
> + */
> +void clear_cas_option(struct push_cas_option *cas)
> +{
> +	int i;
> +
> +	for (i = 0; i < cas->nr; i++)
> +		free(cas->entry->refname);

Should this be

	free(cas->entry[i]->refname);

?

> +	free(cas->entry);
> +	memset(cas, 0, sizeof(*cas));
> +}
