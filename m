From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 01/18] Introduce fsck options
Date: Mon, 22 Dec 2014 18:26:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412221822310.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <56e9445d6e8a746356146bc565512f53bf8a0c8d.1418055173.git.johannes.schindelin@gmx.de> <xmqqk31zjz8o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 18:26:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y36kU-0001Uz-99
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 18:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460AbaLVR0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 12:26:17 -0500
Received: from mout.gmx.net ([212.227.17.20]:57237 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755089AbaLVR0P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 12:26:15 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0ME33j-1Y7G052iuF-00HLm5;
 Mon, 22 Dec 2014 18:26:10 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqk31zjz8o.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:PC9KmoDGSjTFXYzWybmSKEiRDlP7/CecWORM7H/Rt4gTqZIjbt8
 5JI3NsQ7u408nxTW0DIL7omnSLPiVxlXum566IzSe05YvoBsbmrSDJ94NdfDfM88rV6TSgY
 tiE8aLvJwzbTGCCjNFN/WtA19uZSUX7ziR2jD1z4synKjO7YF16wtFJCdN6YzR/Tu9cx7II
 J4X7I93yk8TtWvPqOXHtA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261654>

Hi Junio,

On Wed, 10 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Subject: Re: [PATCH 01/18] Introduce fsck options
> 
> please make it easier to cluster and spot the series in the eventual
> shortlog by giving a common prefix to the patches, e.g.
> 
> 	fsck: introduce fsck_options struct

I use the fsck: prefix consistently now.

> > +static struct fsck_options fsck_walk_options = FSCK_OPTIONS_DEFAULT;
> > +static struct fsck_options fsck_obj_options = FSCK_OPTIONS_DEFAULT;
> 
> Is it a good idea to allow walker to be strict but obj verifier to
> be not (or vice versa)?  I am wondering why this is not a single
> struct with two callback function pointers.

Unfortunately not. There are two different walkers used, and in fact,
fsck_walk_options() is only used to walk the objects, not to fsck them.

Now, I could use only one struct and set the walker, but that is not
thread-safe, and while code is not threaded yet AFAICT, it might be in the
future. That is why I decided to be rather safe than sorry. If you want it
differently, please just say the word, I will make it so.

> > +struct fsck_options {
> > +	fsck_walk_func walk;
> > +	fsck_error error_func;
> > +	int strict:1;
> 
> A signed 1-bit-wide bitfield can hold its sign-bit and nothing else,
> no?
> 
>     unsigned strict:1;

Oops. Right. For some reason, it worked here, though... Fixed!

Ciao,
Dscho
