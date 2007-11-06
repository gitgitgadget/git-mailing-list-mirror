From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 4/4] Implement git commit and status as a builtin
	commands.
Date: Tue, 06 Nov 2007 11:42:46 -0500
Message-ID: <1194367366.20020.5.camel@hinata.boston.redhat.com>
References: <1194017589-4669-1-git-send-email-krh@redhat.com>
	 <1194017589-4669-2-git-send-email-krh@redhat.com>
	 <1194017589-4669-3-git-send-email-krh@redhat.com>
	 <1194017589-4669-4-git-send-email-krh@redhat.com>
	 <20071103150637.GA11172@atjola.homenet>
	 <1194289073.13968.16.camel@hinata.boston.redhat.com>
	 <20071105192347.GA29997@atjola.homenet>
	 <Pine.LNX.4.64.0711052317170.4362@racer.site>
	 <20071106091222.GE4435@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 17:44:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpRX2-0002CW-Sf
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 17:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbXKFQns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 11:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754071AbXKFQns
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 11:43:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44046 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753761AbXKFQnr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 11:43:47 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA6GgrZP006795;
	Tue, 6 Nov 2007 11:42:53 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA6GgqjM018041;
	Tue, 6 Nov 2007 11:42:52 -0500
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA6Ggq7r020193;
	Tue, 6 Nov 2007 11:42:52 -0500
In-Reply-To: <20071106091222.GE4435@artemis.corp>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63685>

On Tue, 2007-11-06 at 10:12 +0100, Pierre Habouzit wrote:
> On Mon, Nov 05, 2007 at 11:18:36PM +0000, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Mon, 5 Nov 2007, Bj?rn Steinbrink wrote:
> > 
> > > On 2007.11.05 13:57:53 -0500, Kristian H?gsberg wrote:
> > >
> > > > The shell script just has
> > > > 
> > > > case "$all,$interactive,$also,$#" in
> > > > *t,*t,*)
> > > >         die "Cannot use -a, --interactive or -i at the same time." ;;
> > > > 
> > > > which doesn't seem to care about the value of $also.  As far as I 
> > > > understand git commit, it doesn't make sense to pass any of -a, -i, -o 
> > > > or --interactive at the same time so I guess I could join the checks
> > > 
> > > Note that there are only two commas. The asterisks catch everything and
> > > $# won't be "t", so that catches anything with at least two t's.
> > 
> > So shouldn't it be
> > 
> > 	if (!!all + !!interactive + !!also > 1)
> 
> Btw, I'm starting to work slowly on the diff_opt_parse conversion to the
> macro we discussed, and the need for new option parsing callbacks
> arised, and I've created a:
> 
>   parse_opt_mask_{or,and,xor} commands that you declare this way:
> 
>     OPT_MASK_OR('a', "all",         &mode, "...", MASK_ALL),
>     OPT_MASK_OR('i', "interactive", &mode, "...", MASK_INTERACTIVE),
>     ...

That's useful here, and it should be useful in a lot of other places
using parse_options() where we end up or'ing flags into a mask based on
boolean options.

cheers,
Kristian
