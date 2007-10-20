From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 09/14] Use the asyncronous function infrastructure in builtin-fetch-pack.c.
Date: Sat, 20 Oct 2007 20:22:33 +0200
Message-ID: <200710202022.33782.johannes.sixt@telecom.at>
References: <1192823286-9654-1-git-send-email-johannes.sixt@telecom.at> <1192823286-9654-10-git-send-email-johannes.sixt@telecom.at> <20071020025352.GA6569@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 20 20:22:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjIyG-0002Jr-In
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 20:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757185AbXJTSWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 14:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756099AbXJTSWi
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 14:22:38 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:41633 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200AbXJTSWh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 14:22:37 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 98EAF98050;
	Sat, 20 Oct 2007 20:22:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 6A4FB59DE5;
	Sat, 20 Oct 2007 20:22:34 +0200 (CEST)
User-Agent: KMail/1.9.3
In-Reply-To: <20071020025352.GA6569@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61847>

On Saturday 20 October 2007 04:53, Shawn O. Pearce wrote:
> > diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
> > index 871b704..51d8a32 100644
> > --- a/builtin-fetch-pack.c
> > +++ b/builtin-fetch-pack.c
> > @@ -457,42 +457,37 @@ static int everything_local(struct ref **refs, int
> > nr_match, char **match) return retval;
> >  }
> >
> > -static pid_t setup_sideband(int fd[2], int xd[2])
> > +static int sideband_demux(int fd, void *data)
> >  {
> > -	pid_t side_pid;
> > +	int *xd = data;
> >
> > +	close(xd[1]);
>
> If this is a threaded start_async() system this close is going
> to impact the caller.

Yes, I noticed this, too. I think that a solution calls for a member .in of 
struct async analogous to .in of struct child_process.

How do we continue from here? Could you park the series in pu so that I don't 
have to resend if it turns out that the fix is just another followup patch 
(which is how I'd prefer to solve the issue)? Then I tell you no or go after 
I have it tested on mingw.git.

-- Hannes
