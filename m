From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] fetch/push: readd rsync support
Date: Fri, 28 Sep 2007 23:48:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709282348040.28395@racer.site>
References: <Pine.LNX.4.64.0709280602580.28395@racer.site>
 <Pine.LNX.4.64.0709281629270.28395@racer.site> <7vtzpeo5ar.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 00:50:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbOep-0000my-73
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 00:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756632AbXI1Wtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 18:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756605AbXI1Wtz
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 18:49:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:36583 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756287AbXI1Wtx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 18:49:53 -0400
Received: (qmail invoked by alias); 28 Sep 2007 22:49:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 29 Sep 2007 00:49:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19NgmURej9Nfncyov5P5k3+HnWHDe3e45HbcxHJp4
	zTUihjfeDkW6ku
X-X-Sender: gene099@racer.site
In-Reply-To: <7vtzpeo5ar.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59429>

Hi,

On Fri, 28 Sep 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > diff --git a/transport.c b/transport.c
> > index 4f9cddc..c8eed95 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -6,6 +6,330 @@
> > ...
> > +static int direntry_cmp(const void *a, const void *b)
> > +{
> > +	const struct dirent *d1 = a;
> > +	const struct dirent *d2 = b;
> > +
> > +	return strcmp(d1->d_name, d2->d_name);
> > +}
> > ...
> > +/*
> > + * path is assumed to point to a buffer of PATH_MAX bytes, and
> > + * path + name_offset is expected to point to "refs/".
> > + */
> > +
> > +static int read_loose_refs(struct strbuf *path, int name_offset,
> > +		struct ref **tail)
> > +{
> > +	DIR *dir = opendir(path->buf);
> > +	struct dirent *de;
> > +	struct {
> > +		char **entries;
> > +		int nr, alloc;
> > +	} list;
> > ...
> > +	while ((de = readdir(dir))) {
> > +		if (de->d_name[0] == '.' && (de->d_name[1] == '\0' ||
> > +				(de->d_name[1] == '.' &&
> > +				 de->d_name[2] == '\0')))
> > +			continue;
> > +		ALLOC_GROW(list.entries, list.nr + 1, list.alloc);
> > +		list.entries[list.nr++] = xstrdup(de->d_name);
> > +	}
> > +	closedir(dir);
> > +
> > +	/* sort the list */
> > +
> > +	qsort(list.entries, list.nr, sizeof(*de), direntry_cmp);
> 
> Hmmmph...?

Ouch.  Sorry.

Will resend in a few minutes. (After reading the patch -- again)

Ciao,
Dscho
