From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/18] Provide a function to parse fsck message IDs
Date: Mon, 22 Dec 2014 22:27:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412221836480.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <e217caa9c30b72004eca9b15be3aa1c6674dc278.1418055173.git.johannes.schindelin@gmx.de> <xmqqsignie2k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 22:27:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3AVu-0004pt-Iw
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 22:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755520AbaLVV1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 16:27:34 -0500
Received: from mout.gmx.net ([212.227.15.19]:62267 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755021AbaLVV1e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 16:27:34 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0Le64S-1XXAh33pjY-00pvW4;
 Mon, 22 Dec 2014 22:27:29 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqsignie2k.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:l6/sF2OniCa6yZlAmS708w3nXb3LHlA2GdunNps5ajLXyucnuv9
 4dZzHN6XomZ7kbS0OclvhnURfOztf1iP6KDWry7vqTUSgyPKKJ4NVg6cJrEsrEvpIMYnXsU
 hj/m8g38SZdxGGM+dFO1LJHzxFMgGmT5+yrjokstrTR4pc5/czuXGzMe9D6eFDazNgwbctN
 IQKtsoLzQ6+oUsjnEqb5w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261671>

Hi Junio,

On Wed, 10 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This function will be used in the next commits to allow the user to
> > ask fsck to handle specific problems differently, e.g. demoting certain
> > errors to warnings. It has to handle partial strings because we would
> > like to be able to parse, say, '--strict=missing-email=warn' command
> > lines.
> >
> > To make the parsing robust, we generate strings from the enum keys, and we
> > will match both lower-case, dash-separated values as well as camelCased
> > ones (e.g. both "missing-email" and "missingEmail" will match the
> > "MISSING_EMAIL" key).
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  fsck.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/fsck.c b/fsck.c
> > index 3cea034..05b146c 100644
> > --- a/fsck.c
> > +++ b/fsck.c
> > @@ -63,6 +63,38 @@ enum fsck_msg_id {
> >  	FSCK_MSG_MAX
> >  };
> >  
> > +#define STR(x) #x
> > +#define MSG_ID_STR(x) STR(x),
> > +static const char *msg_id_str[FSCK_MSG_MAX + 1] = {
> > +	FOREACH_MSG_ID(MSG_ID_STR)
> > +	NULL
> > +};
> 
> I wondered what the ugly macro was in the previous step, but as a
> way to keep these two lists in sync it makes sense.

I added a comment to the commit message.

Ciao,
Dscho
