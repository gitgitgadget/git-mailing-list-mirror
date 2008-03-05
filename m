From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] shortlog: take the first populated line of the description
Date: Wed, 5 Mar 2008 16:43:22 +0000
Message-ID: <20080305164316.GH17931@shadowen.org>
References: <1204727050.0@pinky> <alpine.LSU.1.00.0803051544160.15786@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 05 17:45:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWwis-0003t1-4E
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 17:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463AbYCEQn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 11:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753526AbYCEQn2
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 11:43:28 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:3235 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbYCEQn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 11:43:28 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1JWwiF-0007oD-0H; Wed, 05 Mar 2008 16:43:27 +0000
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803051544160.15786@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76242>

On Wed, Mar 05, 2008 at 03:48:00PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 5 Mar 2008, Andy Whitcroft wrote:
> 
> > diff --git a/builtin-shortlog.c b/builtin-shortlog.c
> > index af31aba..b22b0ed 100644
> > --- a/builtin-shortlog.c
> > +++ b/builtin-shortlog.c
> > @@ -70,11 +70,12 @@ static void insert_one_record(struct shortlog *log,
> >  	else
> >  		free(buffer);
> >  
> > +	/* Skip any leading whitespace, including any blank lines. */
> > +	while (*oneline && isspace(*oneline))
> > +		oneline++;
> >  	eol = strchr(oneline, '\n');
> >  	if (!eol)
> >  		eol = oneline + strlen(oneline);
> > -	while (*oneline && isspace(*oneline) && *oneline != '\n')
> > -		oneline++;
> >  	if (!prefixcmp(oneline, "[PATCH")) {
> >  		char *eob = strchr(oneline, ']');
> >  		if (eob && (!eol || eob < eol))
> 
> Why do you move the code around?  Makes it harder to read your patch.  
> Besides, you now strip empty lines at the beginning of the commit 
> messages, right?  Who produces such a thing?

I've not moved the code as such.  I added a loop to drop the leading
whitespace.  That made the second loop redundant as its job is already
done, so I killed it.

The point of the patch is to strip the empty lines at the start of
the commit.  I am ending up with them in my repo mostly due to
imcompetant users of SVN I suspect.  The main driver is that I have
those and the original non-C version coped and the builtin does not.

Now if people think that its a stupid idea I might suggest it could be
optional?

-apw
