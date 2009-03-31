From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] graph API: Added logic for colored edges.
Date: Tue, 31 Mar 2009 12:13:20 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0903311210000.10279@pacific.mpi-cbg.de>
References: <20090318100512.GA7932@linux.vnet> <alpine.DEB.1.00.0903181228420.10279@pacific.mpi-cbg.de> <b2e43f8f0903190959if539048r19e972899bd2132d@mail.gmail.com> <alpine.DEB.1.00.0903191831590.6357@intel-tinevez-2-302> <20090320064813.6117@nanako3.lavabit.com>
 <b2e43f8f0903201213o396de6c0sb52149ed1d889d1@mail.gmail.com> <20090320195806.GC26934@coredump.intra.peff.net> <20090321175726.GA6677@linux.vnet> <20090330141322.GA6221@linux.vnet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 12:12:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoaxR-0008Hx-3d
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 12:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbZCaKLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 06:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbZCaKLG
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 06:11:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:47260 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750789AbZCaKLE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 06:11:04 -0400
Received: (qmail invoked by alias); 31 Mar 2009 10:11:01 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 31 Mar 2009 12:11:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/IX3olWBXI114QMYqVnxACP/gTIpXva576tbOF8N
	o0UPTjurtm1wdj
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090330141322.GA6221@linux.vnet>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115245>

Hi,

On Mon, 30 Mar 2009, Allan Caffee wrote:

> +static void strbuf_write_column(struct strbuf *sb, const struct column *c,
> +		const char *s)
> +{
> +	/*
> +	 * TODO: I get the creeping suspicion that this isn't the
> +	 * right flag to be checking since --no-color doesn't turn
> +	 * this off.
> +	 */

Heh, of course I forgot to remove this with my to-be-squashed-in patch...

> +	if (diff_use_color_default)
> +		strbuf_addstr(sb, c->color);
> +	strbuf_addstr(sb, s);
> +	if (diff_use_color_default)
> +		strbuf_addstr(sb, GIT_COLOR_RESET);
> +}

How about this function instead?

static void strbuf_add_column(struct strbuf *sb,
	const struct column *column, const char *fmt, ...)
{
        va_list ap;

        va_start(ap, fmt);
	if (column->color)
		strbuf_addstr(sb, column->color);
        strbuf_vaddf(sb, fmt, ap);
	if (column->color)
		strbuf_addstr(sb, GIT_COLOR_RESET);
        va_end(ap);
}

Hmm?

Ciao,
Dscho
