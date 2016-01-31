From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/6] give "nbuf" strbuf a more meaningful name
Date: Sun, 31 Jan 2016 12:54:29 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601311245170.2964@virtualbox>
References: <20160131112215.GA4589@sigill.intra.peff.net> <20160131112526.GA5116@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 31 12:54:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPqaZ-0001vJ-PU
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 12:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757319AbcAaLyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 06:54:40 -0500
Received: from mout.gmx.net ([212.227.15.18]:60198 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757250AbcAaLyj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 06:54:39 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LjaEi-1ZoJuZ2d8C-00bYUT; Sun, 31 Jan 2016 12:54:31
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160131112526.GA5116@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Rwk/Hwtm8BQVAL9N/Uj5Kccte6ZI6vuA6ubt8lTO4/d61q8neh+
 6Icqe2jbpdgutKFoOb8iaK63Gkhe8M6K5zbcVVBDxc6StmqfqR19BF3GKctVv6F2hKWk6F+
 ZOEROY4sVC5HnBokc8jAageFQ8P2kWX3G5T+5vPCWppAVLZBWPoC91BUOpi09L/f0f9qOZe
 MQnrK5RUt0s/mRcMzjHkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Kzkh3hsmE0U=:Zk7KAmk7Tc7fQEN87+v5iR
 /XpHfbUsM3BMjAWyfHo9FQGFd49aFKiFGG2/akCQpPPaohpT15n8vivm0MiROqd8Cwgm4P+LA
 6ioExUC5oeh9Hwd5j8WZjOE4g6V4BqiZIKYDa0oLrfOrkT/2Em8jGLMyJqVeYaqoFkjeDNh3P
 iniQmoDL1n/dMSykUMCSDWGwF2UUsWBylC9Snz48fS3n3GxF8EXMj4Gh7CPy4U7Rwg9JZWLLr
 kDONCnQ/BZqC5HUoPaB4MOfVFFe02ZfPRhpn+3lJvxX0QHGJ/xYIbHJHJefypTe2tsMhzDLxV
 cL2Rg6Ie4HxYEqSbKYV0A2QmbnsctGDL8h9YQxNkjUrgDt/VeR32OgYN44SJbJdoihzqPUhHY
 QOWPNPJSirCa0Sx5r4be2WG6iRXJ69QCCG2Vg1Lf3CdMau0P8bXC164M2p1Q26EjMzJIxtmTH
 QiTyN/ysh9A1aHVsp0vYpPvk85n0rVWTY7dgU5Ju8zeAlWOga/9fVUyLYpjbez8xcNoBvrt24
 xd+/Wk+JTD0K1xcBhT2jmjvgs8ynaaIIQ/JgfbVDSslBVVYG5HgLUmjkEgwLNjt/atPyGJBE0
 4R64mEw2uhWn4cJ4ENQLL1lfGsJzoBVKDt3sli8bz54dB5tPhzL1zHWP7AqwUbMAEhagcVvqQ
 0z09jaIc7KythhHdjB9hhYsGwrdcefW20B9iqtDiwNSHvx23/OOotCMA7L4lbdl14V9SIzPM4
 K4Zp1NA8sq2Ug7tf+iUwZtXyljEwXOS7mfRgjz6v3ru5bKej19phTfsVl3kXyfG8eN5LXQfW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285142>

Hi Peff,

On Sun, 31 Jan 2016, Jeff King wrote:

> > It's a shame that we can't just factor out this common
> > code, but I don't think it's quite long enough to merit
> > the boilerplate. The interesting part of each function
> > happens inside the loop. If C had lambdas, we could do
> > something like:
> > 
> >   foreach_path_from(stdin, nul_term_line) {
> >         /* now do something interesting with "buf"
> >            and some other local variables */
> >   }

Technically, we do not have to do lambdas for that paradigm, we could
introduce a new data type and a reader, i.e. something like this:

struct path_reader {
	FILE *in;
	int nul_term_line;
	struct strbuf path;
};
#define PATH_READER_INIT { NULL, STRBUF_INIT };

int read_next_path(struct path_reader *reader, FILE *in, int nul_term_line)
{
	if (!reader->in) {
		... [initialize] ...
	}

	... [read and possibly unquote path] ...
}

void cleanup_path_reader(struct path_reader *reader)
{
	if (reader->in) {
		fclose(reader->in);
		reader->in = NULL;
	}

	strbuf_release(&reader->buf);
}

And then the repeated code could be replaced by something like this:

	struct path_reader path_reader = PATH_READER_INIT;

	while (read_next_path(&reader, stdin, 1)) {
		... [work with reader->path.buf] ...
	}

	cleanup_path_reader();

Probably this is actually not limited to path names, so the functions
should be renamed...

(totally untested, of course...)

Ciao,
Dscho
