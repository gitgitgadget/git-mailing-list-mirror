From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make strbuf_cmp inline, constify its arguments and optimize it a bit
Date: Sun, 7 Oct 2007 23:57:49 +0200
Message-ID: <20071007215749.GD2765@steel.home>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org> <1190625904-22808-2-git-send-email-madcoder@debian.org> <20071007140052.GA3260@steel.home> <85fy0nknnq.fsf@lola.goethe.zz> <20071007161012.GB3270@steel.home> <851wc6lwkc.fsf@lola.goethe.zz>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Oct 07 23:58:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iee8S-0000pY-K1
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 23:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbXJGV5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 17:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbXJGV5w
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 17:57:52 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:37372 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbXJGV5w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 17:57:52 -0400
Received: from tigra.home (Fc872.f.strato-dslnet.de [195.4.200.114])
	by post.webmailer.de (mrclete mo20) (RZmta 13.4)
	with ESMTP id z00b9cj97IhBxC ; Sun, 7 Oct 2007 23:57:50 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 029DE277AE;
	Sun,  7 Oct 2007 23:57:49 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id D1A0EC502; Sun,  7 Oct 2007 23:57:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <851wc6lwkc.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+ecrQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60227>

David Kastrup, Sun, Oct 07, 2007 18:27:15 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> >> > +static inline int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
> >> > +{
> >> > +	int len = a->len < b->len ? a->len: b->len;
> >> > +	int cmp = memcmp(a->buf, b->buf, len);
> >> > +	if (cmp)
> >> > +		return cmp;
> >> > +	return a->len < b->len ? -1: a->len != b->len;
> >> > +}
> >> 
> >> My guess is that you are conflating two issues about speed here: the
> >> inlining will like speed the stuff up.  But having to evaluate the
> >> (a->len < b->len) comparison twice will likely slow it down.
> >
> > Can't the result of the expression be reused in compiled?
> > Isn't it a common expression?
> 
> No, since the call to memcmp might change a->len or b->len.  A

Huh?! How's that? It is not even given them!
