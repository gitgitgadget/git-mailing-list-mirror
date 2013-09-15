From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] diff: add a config option to control orderfile
Date: Sun, 15 Sep 2013 10:49:00 +0300
Message-ID: <20130915074900.GA30438@redhat.com>
References: <20130831194425.GA14706@redhat.com>
 <xmqqioyhu8wd.fsf@gitster.dls.corp.google.com>
 <20130903210815.GB24480@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 15 09:47:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VL731-0005ke-G9
	for gcvg-git-2@plane.gmane.org; Sun, 15 Sep 2013 09:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014Ab3IOHqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Sep 2013 03:46:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46380 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752741Ab3IOHqx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Sep 2013 03:46:53 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r8F7kpis005364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sun, 15 Sep 2013 03:46:51 -0400
Received: from redhat.com (vpn1-4-98.ams2.redhat.com [10.36.4.98])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r8F7knCw014104;
	Sun, 15 Sep 2013 03:46:50 -0400
Content-Disposition: inline
In-Reply-To: <20130903210815.GB24480@redhat.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234810>

On Wed, Sep 04, 2013 at 12:08:15AM +0300, Michael S. Tsirkin wrote:
> On Tue, Sep 03, 2013 at 10:12:18AM -0700, Junio C Hamano wrote:
> > "Michael S. Tsirkin" <mst@redhat.com> writes:
> > 
> > > I always want my diffs to show header files first,
> > > then .c files, then the rest. Make it possible to
> > > set orderfile though a config option to achieve this.
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > 
> > I admit that I was the guilty one who introduced the orderfile, but
> > I think the feature was misguided (for one thing, it breaks the
> > patch-id, I think).
> 
> This should be easy to fix - just sort before applying the ID, no?

Ping. Any comment on this idea?

> > So I am moderately hesitant to promote its use
> > with an addition like this.
> 
> The status quo just makes people insist on using a script to generate patches for
> mail.  Some projects put interface documentation in the header files, in
> that case it makes sense to put .h before .c in the patch as it makes
> review easier.
> 
> In fact I sometimes reorder chunks in the patch manually for readability -
> it's probably worth finding a way to support this.
> 
> 
> > >  diff.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/diff.c b/diff.c
> > > index 208094f..cca0767 100644
> > > --- a/diff.c
> > > +++ b/diff.c
> > > @@ -264,6 +264,9 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
> > >  		return 0;
> > >  	}
> > >  
> > > +        if (!strcmp(var, "diff.orderfile"))
> > > +                return git_config_string(&default_diff_options.orderfile, var, value);
> > > +
> > >  	if (!prefixcmp(var, "submodule."))
> > >  		return parse_submodule_config_option(var, value);
