From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 02/15] read-cache: allow to keep mmap'd memory after
 reading
Date: Wed, 20 Apr 2016 15:41:24 -0400
Organization: Twitter
Message-ID: <1461181284.5540.169.camel@twopensource.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
	 <1461108489-29376-3-git-send-email-dturner@twopensource.com>
	 <alpine.DEB.2.20.1604201059530.2826@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 20 21:41:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asy0B-0007K4-2v
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 21:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbcDTTl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 15:41:27 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:34183 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbcDTTl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 15:41:26 -0400
Received: by mail-qg0-f42.google.com with SMTP id c6so35552127qga.1
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 12:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=3RZOrUPWRIUIoGIbCJcH82SHgoOac7LlgfrztWyyv9Q=;
        b=X6R7/tqxXDX23rWhHo1F4c3IL2UnrkEB22R41fAR8Ic3DDZhu8T8+jzu3YVcqRi/Gs
         XaX8lopbM+9tbxhILDIcdvXTpOKIx8EL+86LhZ9gz/2P/EwtDA7bM1Oq9IAJk3uaQEtu
         pnTb0i2M3rARMSeuCy0tQDZ5mahI6YYSHYWWQRfeTO5T0Bcenus3zpSmRCWxnfPitve3
         fQJvIqdHYb1wlf53DwAm6HOW1CZZCTnsy7jnZCUqfjcDqiWFcyz6g2DT6ZGzY6d8kO5p
         Jh9twMQgq5QlcxcRojR+/Wm7yKh1IlqGKgnyRfJ2TUZWqNIyt4uHN3x/bi+etn+zEFmj
         equQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=3RZOrUPWRIUIoGIbCJcH82SHgoOac7LlgfrztWyyv9Q=;
        b=NW6saptXQBvl9vz+4A16FYG6MZWZTkuUAAFCFM5kF0p0vrJv5SdSoSPAQo2EjSX8aE
         XXWkaPKPG73EDr2eH7cX0LA6WvscITzSQNPj/jnB4G0eAPrXAWIdn5PF/66LzVJygwJ6
         10gs8yjhyctYmDPpeVdrwfnfFoSvqtNzC3JSlZwBfOfScgYKHnnhzkLJE/gK5QP9aDEm
         Xx/YnWpzkNItRU88ecZ+jXQNzdrRVh25FLGyhkrLiL5iACcJVnIdHvYrZN/YO/Tg4Y+A
         PTUl4iM9peeoQlxsFe9gQjzUGW+ejtzQJDyc9fF8wNdPysLG5YqoqAfEehc0lOkNE8jv
         3Auw==
X-Gm-Message-State: AOPr4FXb4vtcFMtOWzKS7EriCwcVKbyZbkP2RJhy2bmikmndRSuVs1SNnrBZeL4yGH4pJw==
X-Received: by 10.140.96.78 with SMTP id j72mr4624257qge.84.1461181285690;
        Wed, 20 Apr 2016 12:41:25 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id h6sm10240756qgd.28.2016.04.20.12.41.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Apr 2016 12:41:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1604201059530.2826@virtualbox>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292062>

On Wed, 2016-04-20 at 11:01 +0200, Johannes Schindelin wrote:
> Hi Dave,
> 
> On Tue, 19 Apr 2016, David Turner wrote:
> 
> >  unmap:
> > +	istate->mmap = NULL;
> >  	munmap(mmap, mmap_size);
> >  	die("index file corrupt");
> >  }
> > [...]
> > @@ -1698,6 +1705,10 @@ int discard_index(struct index_state
> > *istate)
> >  	free(istate->cache);
> >  	istate->cache = NULL;
> >  	istate->cache_alloc = 0;
> > +	if (istate->keep_mmap && istate->mmap) {
> > +		munmap(istate->mmap, istate->mmap_size);
> > +		istate->mmap = NULL;
> > +	}
> >  	discard_split_index(istate);
> 
> Just curious: any reason why the first hunk munmap()s after resetting
> the
> field to NULL and the second hunk does it in the opposite order?

No idea.  Will change the first hunk.
