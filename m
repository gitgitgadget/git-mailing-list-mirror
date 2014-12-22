From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/18] fsck: handle multiple authors in commits
 specially
Date: Mon, 22 Dec 2014 22:53:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412222251160.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <43faa41d4cc98d6c40a393ec590af73ec5c94246.1418055173.git.johannes.schindelin@gmx.de> <xmqqk31zidp5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 22:54:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3AvQ-0007to-O1
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 22:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282AbaLVVx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 16:53:56 -0500
Received: from mout.gmx.net ([212.227.15.15]:65337 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754900AbaLVVxz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 16:53:55 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0Me8di-1YFt1E1Gbm-00Ptna;
 Mon, 22 Dec 2014 22:53:50 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqk31zidp5.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:e/tndVvy/qiGg5Fji2sCx8a7/e3O63wxlp/wMn5byfZPb4VizgW
 VUV3XIbVD1Qt+N+WChFc2JyHdkhLfTQSi5+9qtPafaOo3NCiINOkCuTaBEwQG7UwUTYqXsW
 4RRMYRXzFYu8oXwSAz7IsNPBrzbOuY7IZjtjBEZHFLU30muR2dkM5tOmDYQdUlr804wZzPR
 W9Oz7dPIjI15pXoc4T9Mw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261675>

Hi Junio,

On Wed, 10 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This problem has been detected in the wild, and is the primary reason
> > to introduce an option to demote certain fsck errors to warnings. Let's
> > offer to ignore this particular problem specifically.
> > ...
> > +	while (skip_prefix(buffer, "author ", &buffer)) {
> > +		err = report(options, &commit->object, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
> > +		if (err)
> > +			return err;
> 
> If we have an option to demote this to a warning, wouldn't we want
> to do the same fsck_ident() on that secondary author line?

Good point! I changed the following to use fsck_ident() instead:

> > +		/* require_end_of_header() ensured that there is a newline */
> > +		buffer = strchr(buffer, '\n') + 1;
> > +	}
> >  	if (!skip_prefix(buffer, "committer ", &buffer))
> >  		return report(options, &commit->object, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
> >  	err = fsck_ident(&buffer, &commit->object, options);

Ciao,
Dscho
