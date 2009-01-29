From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] builtin-apply.c: do not set bogus mode in
	check_preimage() for deleted path
Date: Wed, 28 Jan 2009 20:46:20 -0500
Message-ID: <20090129014620.GE13271@redhat.com>
References: <7vocxrj9j9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexander Potashev <aspotashev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 02:45:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSLye-0001T0-Gh
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 02:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbZA2BoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 20:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752835AbZA2BoW
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 20:44:22 -0500
Received: from mx2.redhat.com ([66.187.237.31]:57202 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772AbZA2BoV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 20:44:21 -0500
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n0T1iFBr023615;
	Wed, 28 Jan 2009 20:44:15 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n0T1iEH9010071;
	Wed, 28 Jan 2009 20:44:15 -0500
Received: from redhat.com (dhcp-100-18-183.bos.redhat.com [10.16.18.183])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n0T1iCLV016417;
	Wed, 28 Jan 2009 20:44:15 -0500
Content-Disposition: inline
In-Reply-To: <7vocxrj9j9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107609>

On Wed, Jan 28, 2009 at 03:27:54PM -0800, Junio C Hamano wrote:
>    Also I suspect this codepath has been broken the use case 7a07841
>    (git-apply: handle a patch that touches the same path more than once
>    better, 2008-06-27) wanted to support, and if that is the case, this
>    would fix it.

Actually deleting patches weren't that interesting to me, I deal more with
patches modifying the same patch repeatedly.  Regardless the patch below
seems ok to me.

Acked-by: Don Zickus <dzickus@redhat.com>

> 
>  builtin-apply.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin-apply.c b/builtin-apply.c
> index b415daf..1e7f917 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -2453,7 +2453,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
>  	if (st_mode != patch->old_mode)
>  		fprintf(stderr, "warning: %s has type %o, expected %o\n",
>  			old_name, st_mode, patch->old_mode);
> -	if (!patch->new_mode)
> +	if (!patch->new_mode && !patch->is_delete)
>  		patch->new_mode = st_mode;
>  	return 0;
>  
> -- 
> 1.6.1.1.278.g6a817
> 
