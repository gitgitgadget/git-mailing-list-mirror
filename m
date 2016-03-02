From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] bundle: keep a copy of bundle file name in the
 in-core bundle header
Date: Wed, 2 Mar 2016 15:49:47 -0500
Message-ID: <20160302204947.GA6608@sigill.intra.peff.net>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com>
 <1456950761-19759-1-git-send-email-gitster@pobox.com>
 <1456950761-19759-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 21:50:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abDih-00027k-Rl
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 21:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755729AbcCBUtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 15:49:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:53679 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755668AbcCBUtu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 15:49:50 -0500
Received: (qmail 12408 invoked by uid 102); 2 Mar 2016 20:49:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Mar 2016 15:49:50 -0500
Received: (qmail 30629 invoked by uid 107); 2 Mar 2016 20:50:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Mar 2016 15:50:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Mar 2016 15:49:47 -0500
Content-Disposition: inline
In-Reply-To: <1456950761-19759-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288155>

On Wed, Mar 02, 2016 at 12:32:40PM -0800, Junio C Hamano wrote:

> +	free((void *)header->filename);

This cast is necessary, because...

> diff --git a/bundle.h b/bundle.h
> index f7ce23b..e059ccf 100644
> --- a/bundle.h
> +++ b/bundle.h
> @@ -10,12 +10,14 @@ struct ref_list {
>  };
>  
>  struct bundle_header {
> +	const char *filename;
>  	struct ref_list prerequisites;
>  	struct ref_list references;
>  };

...this is const, even though we know it is allocated on the heap.

I am OK if we want to keep it "conceptually const" so that anybody
looking at the struct knows they should not touch it. But I am also OK
with just making it "char *".

-Peff
