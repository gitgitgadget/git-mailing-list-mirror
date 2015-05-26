From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v3 0/4] submodule config lookup API
Date: Tue, 26 May 2015 17:46:10 +0200
Message-ID: <20150526154610.GB31115@book.hvoigt.net>
References: <20150521170616.GA22979@book.hvoigt.net>
 <xmqqy4khixjn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 26 17:46:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxH45-0006Yy-CB
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 17:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbbEZPqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 11:46:35 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:33973 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706AbbEZPqb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 11:46:31 -0400
Received: from [188.108.15.115] (helo=book.hvoigt.net)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1YxH2w-00068E-3r; Tue, 26 May 2015 17:45:38 +0200
Content-Disposition: inline
In-Reply-To: <xmqqy4khixjn.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269947>

On Thu, May 21, 2015 at 11:40:44AM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > This is finally the next iteration of the submodule config api. The last
> > iteration can be found here:
> >
> > http://article.gmane.org/gmane.comp.version-control.git/252601
> >
> > This iteration fixes the lookup of submodules by name
> > (submodule_from_name()) where one needed to pass in the gitmodule sha1
> > by mistake. To keep it simple for the user and behave as documented we
> > should take the commit sha1 which is now fixed here. We now also test
> > the lookup by name in the api tests.
> >
> > This should be ready for inclusion.
> >
> > Cheers Heiko
> >
> > Here is the interdiff to the last iteration:
> >
> > diff --git a/submodule-config.c b/submodule-config.c
> > index 96623ad..177767d 100644
> > --- a/submodule-config.c
> > +++ b/submodule-config.c
> > @@ -25,6 +25,11 @@ struct submodule_entry {
> >  	struct submodule *config;
> >  };
> >  
> > +enum lookup_type {
> > +	lookup_name,
> > +	lookup_path,
> > +};
> 
> Please lose the comma after the last element in enum.  Some
> compilers do not like it, I was told.

Fixed.

> > +	switch (lookup_type) {
> > +		case lookup_name:
> > +			submodule = cache_lookup_name(cache, sha1, key);
> > +			break;
> > +		case lookup_path:
> > +			submodule = cache_lookup_path(cache, sha1, key);
> > +			break;
> 
> Is this too deeply indented?

It seems I accidentially used vim's default indenting. Fixed.

Will wait a little longer if there are more comments than the style
fixes before sending another iteration.

Cheers Heiko
