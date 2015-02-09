From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Is there some way to suppress Cc email only to stable?
Date: Mon, 9 Feb 2015 13:10:21 -0800
Message-ID: <20150209211021.GB4166@linux.vnet.ibm.com>
References: <20150209194224.GA27482@linux.vnet.ibm.com>
 <xmqq386eby6w.fsf@gitster.dls.corp.google.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mingo@kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 22:10:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKvbN-0001KL-I4
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 22:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761041AbbBIVKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 16:10:37 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:36939 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759723AbbBIVKg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 16:10:36 -0500
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 9 Feb 2015 14:10:35 -0700
Received: from d03dlp03.boulder.ibm.com (9.17.202.179)
	by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Mon, 9 Feb 2015 14:10:34 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 9FA4819D8047
	for <git@vger.kernel.org>; Mon,  9 Feb 2015 14:01:43 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t19LAa2Y18219130
	for <git@vger.kernel.org>; Mon, 9 Feb 2015 14:10:36 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t19LAXU5028645
	for <git@vger.kernel.org>; Mon, 9 Feb 2015 14:10:33 -0700
Received: from paulmck-ThinkPad-W500 (sig-9-65-236-19.ibm.com [9.65.236.19])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t19LANaX027256;
	Mon, 9 Feb 2015 14:10:24 -0700
Received: by paulmck-ThinkPad-W500 (Postfix, from userid 1000)
	id 9F55C38BAA2; Mon,  9 Feb 2015 13:10:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqq386eby6w.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15020921-8236-0000-0000-0000094C74F8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263601>

On Mon, Feb 09, 2015 at 12:57:11PM -0800, Junio C Hamano wrote:
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
> 
> > I need to be able to put the following Cc in a git commit:
> >
> > Cc: <stable@vger.kernel.org>
> >
> > Yet I cannot allow git-send-email to actually send email to that address,
> > lest I get an automated nastygram in response.  I found the --to-cmd=
> > option to git-send-email, but it looks to only add email addresses, never
> > delete them.  I also found the --suppress-cc= option to git-send-email,
> > but it appears to suppress all Cc emails, not just selected ones.
> >
> > One approach that occurred to me is to hand-edit the files produced
> > by git-format-patch, removing stable@vger.kernel.org entirely prior to
> > using git-send-email.  However, this is a bit error-prone.  Yes, I could
> > script it, but with my luck, I will eventually end up having my script
> > mangle some patch, for example to the Linux kernel's MAINTAINERS file.
> > Furthermore, this approach means that people reviewing the patches
> > cannot see the Cc stable entries (though I could presumably comment them
> > out somehow).
> >
> > Another approach is to add the stable Ccs just before doing the pull
> > request, by my upstream maintainer is not fond of that approach.  Nor am
> > I, as it would be all to easy to forget to add the stable Ccs.  Or to
> > get them wrong.
> >
> > I can't be the only person wanting to do something like this.  So is
> > there some git option that I am missing here?
> 
> No, I do not think we have a way to blacklist certain recipient
> addresses from getting passed to the MTA, and I do not object to
> addition of such a mechanism if there is a valid need to do so.
> 
> It feels a bit too convoluted to say "Cc: to this address" in the
> log message and then "nonono, I do not want to send there", though.
> Why do you want to have Cc: in the log message if you do not want to
> send e-mail to that address in the first place?  Allowing the
> behaviour you are asking for would mean that those who see that the
> commit appeared on a branch would not be able to assume that the
> patch has already been sent to the stable review address, no?

I could see where it might seem a bit strange.  ;-)

The reason behind this is that you are not supposed to actually send
email to the stable lists until after the patch has been accepted into
mainline.  One way to make this work is of course to leave the stable
Cc tags out of the commit log, and to manually send an email when the
commit has been accepted.  However, this is subject to human error,
and more specifically in this case, -my- human error.

Hence the desire to have a Cc that doesn't actually send any email,
but that is visible in mainline for the benefit of the scripts that
handle the stable workflow.

							Thanx, Paul
