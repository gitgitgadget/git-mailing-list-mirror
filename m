From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] diff --color-words -U0: fix the location of hunk headers
Date: Thu, 29 Oct 2009 17:29:23 +0100
Message-ID: <200910291729.23562.markus.heidelberg@web.de>
References: <1256732672-11817-1-git-send-email-markus.heidelberg@web.de> <200910291222.42598.markus.heidelberg@web.de> <alpine.DEB.1.00.0910291425010.3687@felix-maschine>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 29 17:30:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Xte-0008VK-2i
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 17:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbZJ2Qag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 12:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752832AbZJ2Qag
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 12:30:36 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:51910 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbZJ2Qaf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 12:30:35 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 76FCC134587B7;
	Thu, 29 Oct 2009 17:29:13 +0100 (CET)
Received: from [89.59.78.39] (helo=pluto.fritz.box)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1N3Xs9-0007QO-00; Thu, 29 Oct 2009 17:29:13 +0100
User-Agent: KMail/1.9.10
In-Reply-To: <alpine.DEB.1.00.0910291425010.3687@felix-maschine>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX181E2l29vZZ3Q56I4XVerx9LxAK3NFvPBAi7kRf
	KJ7QC6lc2WyCb9AeHiydyQHxniChCHxM9O6g8rphUakFui3JAD
	Johw0aSoopKecd7FxFeA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131610>

Johannes Schindelin, 29.10.2009:
> Hi,
> 
> On Thu, 29 Oct 2009, Markus Heidelberg wrote:
> 
> > Indeed my initial fix was in the same fashion:
> > 
> > @@ -772,6 +772,15 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
> >         }
> > 
> >         if (line[0] == '@') {
> > +               if (ecbdata->diff_words) {
> > +                       /*
> > +                        * The content of the previous hunk, necessary for
> > +                        * 0-context.
> > +                        */
> > +                       if (ecbdata->diff_words->minus.text.size ||
> > +                           ecbdata->diff_words->plus.text.size)
> > +                               diff_words_show(ecbdata->diff_words);
> > +               }
> >                 len = sane_truncate_line(ecbdata, line, len);
> >                 find_lno(line, ecbdata);
> >                 emit_line(ecbdata->file,
> > 
> > But then I thought I should not put the diff output from --color-words
> > into the block that deals with the hunk header, but save another place
> > where diff_words_show() is called.
> 
> I found this paragraph, as well as the patches 2/3 and 3/3, hard to 
> follow.

I try to reword:
With 2/3 and 3/3 I wanted to keep --color-words specific code in the
block starting with

	if (ecbdata->diff_words) {

and didn't want to contaminate the block starting with

	if (line[0] == '@') {

with non-hunk-header content.

But I'm not sure what's the better way and am content with either.

> And besides, flushing in that block is the correct thing to do.  The 
> function diff_words_show() is a function for that exact purpose.

Yes, 2/3 and 3/3 just don't introduce a new invocation of this function
at another place in the code.

Markus
