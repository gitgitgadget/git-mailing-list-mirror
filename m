From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] run-command: prettify -D_FORTIFY_SOURCE workaround
Date: Wed, 16 Mar 2011 04:25:26 -0500
Message-ID: <20110316092526.GA7886@elie>
References: <d2e97e801001291438k21a652cakb05ec34fc8bee227@mail.gmail.com>
 <20110316035135.GA30348@elie>
 <7v7hbzaan9.fsf@alter.siamese.dyndns.org>
 <4D80801A.1000208@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Wookey <michaelwookey@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 10:25:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzmz4-0006RV-Od
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 10:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441Ab1CPJZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 05:25:35 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62923 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab1CPJZd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 05:25:33 -0400
Received: by yxs7 with SMTP id 7so577091yxs.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 02:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=1ka7Zt0Jr2o810rk79F596Y8qjCObc/IVPUlEz0J/eM=;
        b=EcQPEtZTIRwKhd+uTFmNbqqxVTJdn/wvVQqXsQ768+w3wcS+t0blUPtU36XeR71c6E
         wqWpK8aYLTzKNeAatdsDWW9bYtHIKmKGwla3JCsWYjcfE7gMJOXDUGBxKY2QD3dlAiQz
         vhOl16Bwf5pwy7V2iW+FuMaWMyac5+xa6HNaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Wpx2AOiLd3i2apyJl+H9Wv97iDp1vHEwFJIL3evQUNxRhgo2A7GUcRd9UeCQDSYAaT
         gG5eagseUKfnkG/8BRaQcwIcbguVcGMR2DUEFfB6DWwqzhtNs6PR/hgkI+Eu2a/OXtzt
         8de5Ks8pbOmqRe96IxH5Ts+8KHyAX2Ku6dj3w=
Received: by 10.91.204.2 with SMTP id g2mr1124835agq.71.1300267533056;
        Wed, 16 Mar 2011 02:25:33 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id x32sm988631ana.32.2011.03.16.02.25.30
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 02:25:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D80801A.1000208@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169124>

Johannes Sixt wrote:

> And what about compilers that warn:
> 
> 	';' : empty controlled statement found; is this the intent?
>
> That's from MSVC. Perhaps:
>
> 	if (write(...))
> 		(void)0; /* we know we are ignoring the error, mr gcc! */

Mm, thanks for pointing it out.

Your suggestion is part of a bigger change that imho should go in a
separate patch:

	$ git grep -F -e '	; /*' origin/master | wc -l
	65

I would prefer to see such a patch do

	if (write(...)) {
		/* ... explanation goes here ... */
	}

or something like

	#define do_nothing() do { /* nothing */ } while (0)

	if (write(...))
		do_nothing();	/* ... explanation ... */

but that is a small detail.
