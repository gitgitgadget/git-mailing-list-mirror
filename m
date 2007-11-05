From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] Use parseopts in builtin-fetch
Date: Mon, 05 Nov 2007 12:02:54 -0500
Message-ID: <1194282174.13968.8.camel@hinata.boston.redhat.com>
References: <Pine.LNX.4.64.0711042233590.7357@iabervon.org>
	 <20071105085513.GB25574@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 18:03:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip5MA-0007WV-QX
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 18:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729AbXKERDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 12:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753778AbXKERDJ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 12:03:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54630 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753729AbXKERDI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 12:03:08 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA5H31CY018538;
	Mon, 5 Nov 2007 12:03:01 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA5H31iH032496;
	Mon, 5 Nov 2007 12:03:01 -0500
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA5H2xYN032585;
	Mon, 5 Nov 2007 12:03:00 -0500
In-Reply-To: <20071105085513.GB25574@artemis.corp>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63527>

On Mon, 2007-11-05 at 09:55 +0100, Pierre Habouzit wrote:
> On Mon, Nov 05, 2007 at 03:35:34AM +0000, Daniel Barkalow wrote:
> > I mostly did this and the next one for practice with the API. I'm 
> > impressed that "git fetch -vv" is even handled correctly without anything 
> > special.
> 
>   About that: OPTION_BOOLEAN increments the associated variable, to
> support this case specifically.
> 
>   The last thing that really miss in parse-options is a way to recurse
> into a sub-array of struct option, to be able to port the generic diff
> and revision arguments.
> 
>   Though, there is a difficulty here that I've not yet found how to
> circumvent tastefully: right now options take an absolute pointer to
> _the_ variable that will be filled with values. I need to be able to
> relocate such a structure for sub-arrays for quite obvious reasons, and
> that is quite hard to achieve without hazardous APIs. I currently lean
> in the direction of simply memdup-ing the array and do fix-ups on
> *values pointers. Though how to do that in a graceful way is not obvious
> to me yet :)

What about requiring sub-arrays entries to take a pointer to a struct as
their 'value' and requiring that all value pointers in the sub-array be
relative to this struct, ie

  (void *) offsetof(struct diff_options, detect_rename)

Then you can have something like

   OPT__SUBARRAY(diff_options, &rev.diff_opt);

in your options array and it will fill out the specified my_diff_opts.

cheers,
Kristian
