From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff --color-words -U0: fix the location of hunk
 headers
Date: Fri, 30 Oct 2009 18:32:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0910301831190.5383@felix-maschine>
References: <1256732672-11817-1-git-send-email-markus.heidelberg@web.de> <200910291222.42598.markus.heidelberg@web.de> <alpine.DEB.1.00.0910291425010.3687@felix-maschine> <200910291729.23562.markus.heidelberg@web.de>
 <7v3a50n6hw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: markus.heidelberg@web.de, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 18:32:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3vKu-0005ZF-1I
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 18:32:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbZJ3RcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 13:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932698AbZJ3RcQ
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 13:32:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:54980 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932695AbZJ3RcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 13:32:16 -0400
Received: (qmail invoked by alias); 30 Oct 2009 17:32:19 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO felix-maschine.local) [141.5.11.5]
  by mail.gmx.net (mp072) with SMTP; 30 Oct 2009 18:32:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18oWU4unrMo9YEQyzsUBDOFpwmibL82S8g4eP+MHR
	ooP9gUyME0a4qx
X-X-Sender: johannes@felix-maschine
In-Reply-To: <7v3a50n6hw.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131718>

Hi,

On Fri, 30 Oct 2009, Junio C Hamano wrote:

> Markus Heidelberg <markus.heidelberg@web.de> writes:
> 
> > I try to reword:
> > With 2/3 and 3/3 I wanted to keep --color-words specific code in the
> > block starting with
> >
> > 	if (ecbdata->diff_words) {
> >
> > and didn't want to contaminate the block starting with
> >
> > 	if (line[0] == '@') {
> >
> > with non-hunk-header content.
> 
> The contamination was already done long time ago.

Actually, it was don on purpose.

> diff --git a/diff.c b/diff.c
> index b7ecfe3..8c66e4a 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -541,14 +541,18 @@ struct emit_callback {
>  	FILE *file;
>  };
>  
> +/* In "color-words" mode, show word-diff of words accumulated in the buffer */
> +static void diff_words_flush(struct emit_callback *ecbdata)
> +{
> +	if (ecbdata->diff_words->minus.text.size ||
> +	    ecbdata->diff_words->plus.text.size)
> +		diff_words_show(ecbdata->diff_words);
> +}

Instead of this function, you can check the same at the beginning of 
diff_words_show().

The reason I did not do that was to avoid a full subroutine call, as I 
expected this code path to be very expensive.

Ciao,
Dscho
