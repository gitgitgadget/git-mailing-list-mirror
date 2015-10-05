From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 28/43] refs.c: add ref backend init function
Date: Mon, 05 Oct 2015 16:37:04 -0400
Organization: Twitter
Message-ID: <1444077424.5158.14.camel@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	 <1443477738-32023-29-git-send-email-dturner@twopensource.com>
	 <561236E7.1050508@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ronnie Sahlberg <rsahlberg@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 05 22:37:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjCVW-0005SN-9k
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 22:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbbJEUhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 16:37:08 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35987 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbbJEUhG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 16:37:06 -0400
Received: by qgx61 with SMTP id 61so161039157qgx.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 13:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=ioik+6t4F/PzxRwn5As7YlBM4om2dERPWde2sZNZOBw=;
        b=dRM3LMJJmhKAKcUjPDNgzkI5u69FjQ2aqlEyB5DxYsTbdBHgBPWjlWclefcrp5nrg3
         avQPGVZZt0UvbyVFI4DAM3mafoE0hH5gRUNdUv6caYxMsBrHye9AHNaTNvBSQGbtxcxc
         NSch+CP21vhHYXvafk/BXw8QlTg1R4UJG3TALjh5HQs6FSjhaxkO30DUynndEsnZyw+R
         B7+quhNvFB53NQg+hv3tD7u2FO1yOhYgBYdB4MfiPiJrDCtwg5aHdoHVnnKb8SXD8WI4
         VbGocU9kQG5upoyM9cCJxqrCV8t62F4ZpyU8jR3jMUE3iAS7IPtfYsB0pbkuU3FwEM5Q
         qfVw==
X-Gm-Message-State: ALoCoQkIWfx88KdxBrprp0WtYNhzfPEZMyYNSH7u0yNG2YryP4RZ7sdwAtLC/qtMXFxphaKEG2CE
X-Received: by 10.140.164.141 with SMTP id k135mr44414676qhk.40.1444077425656;
        Mon, 05 Oct 2015 13:37:05 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id f1sm12059357qhe.42.2015.10.05.13.37.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2015 13:37:04 -0700 (PDT)
In-Reply-To: <561236E7.1050508@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279088>

On Mon, 2015-10-05 at 10:37 +0200, Michael Haggerty wrote:
> On 09/29/2015 12:02 AM, David Turner wrote:
> > The file backend doesn't need this function, but other backends might.
> > 
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
> > ---
> >  refs-be-files.c | 1 +
> >  refs.c          | 4 +++-
> >  refs.h          | 4 +++-
> >  3 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/refs-be-files.c b/refs-be-files.c
> > index 37e244a..eaa74b6 100644
> > --- a/refs-be-files.c
> > +++ b/refs-be-files.c
> > @@ -3737,6 +3737,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
> >  struct ref_be refs_be_files = {
> >  	NULL,
> >  	"files",
> > +	NULL,
> >  	files_transaction_begin,
> >  	files_transaction_update,
> >  	files_transaction_create,
> > diff --git a/refs.c b/refs.c
> > index 769574d..9ce10b7 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -19,13 +19,15 @@ struct ref_be *refs_backends = &refs_be_files;
> >  /*
> >   * This function is used to switch to an alternate backend.
> >   */
> > -int set_refs_backend(const char *name)
> > +int set_refs_backend(const char *name, void *init_data)
> >  {
> >  	struct ref_be *be;
> >  
> >  	for (be = refs_backends; be; be = be->next)
> >  		if (!strcmp(be->name, name)) {
> >  			the_refs_backend = be;
> > +			if (be->init_backend)
> > +				be->init_backend(init_data);
> 
> I don't like that this virtual function, alone among all of them
> introduced so far, is allowed to be NULL. That seems non-obvious and
> something extra that devs have to remember.
> 
> I think it would be better for the files backend to define a do-nothing
> function that can be stuck in this slot.

Will change, thanks.
