From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-tag.c: remove global variable to use the callback
  data of git-config.
Date: Tue, 17 Mar 2009 23:27:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903172326250.10279@pacific.mpi-cbg.de>
References: <1237301031.10001.13.camel@equipo-loli>  <alpine.DEB.1.00.0903171646140.6393@intel-tinevez-2-302> <1b46aba20903171057r4fb4697eo3b8abc62a45fe858@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 23:27:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjhkS-0002Mg-KV
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 23:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbZCQWZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 18:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbZCQWZc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 18:25:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:42495 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751814AbZCQWZc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 18:25:32 -0400
Received: (qmail invoked by alias); 17 Mar 2009 22:25:29 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp028) with SMTP; 17 Mar 2009 23:25:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19HAKUWzIFHqAtJKzMc4RE4xufYZUDVoixw9BJlF0
	pAR1mCHTJw+rqk
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1b46aba20903171057r4fb4697eo3b8abc62a45fe858@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113531>

Hi,

On Tue, 17 Mar 2009, Carlos Rica wrote:

> On Tue, Mar 17, 2009 at 4:47 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> > On Tue, 17 Mar 2009, Carlos Rica wrote:
> >> @@ -164,11 +162,10 @@ static int do_sign(struct strbuf *buffer)
> >>       int len;
> >>       int i, j;
> >>
> >> -     if (!*signingkey) {
> >> -             if (strlcpy(signingkey, git_committer_info(IDENT_ERROR_ON_NO_NAME),
> >> -                             sizeof(signingkey)) > sizeof(signingkey) - 1)
> >> -                     return error("committer info too long.");
> >> -             bracket = strchr(signingkey, '>');
> >> +     if (!signingkey->buf[0]) {
> >
> > It is probably better to ask for !signingkey->len (think of trying to
> > understand the code in 6 months from now).
> 
> I was in doubt here. By avoiding the use of signingkey->len  I was
> trying to say that you cannot rely in such field if we touch the
> buffer directly, as it happens below:
> 
>    bracket = strchr(signingkey->buf, '>');
>    if (bracket)
>       bracket[1] = '\0';

Oh, I missed that.  It should read

	if (bracket)
		strbuf_setlen(signingkey, bracket + 1 - signingkey->buf);

instead.

Ciao,
Dscho
