From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Tue, 26 Aug 2008 09:40:44 +0200
Message-ID: <20080826074044.GA22694@cuci.nl>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu> <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org> <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net> <7vbpzgb94q.fsf@gitster.siamese.dyndns.org> <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 09:42:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXtBY-0003eH-TQ
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 09:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208AbYHZHkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 03:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753040AbYHZHkq
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 03:40:46 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:40794 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbYHZHkp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 03:40:45 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 9846E5465; Tue, 26 Aug 2008 09:40:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48B3A948.3080800@viscovery.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93722>

Johannes Sixt wrote:
>Paolo Bonzini schrieb:
>> +	/*
>> +	 * Always open file descriptors 0/1/2 to avoid clobbering files
>> +	 * in die().  It also avoids not messing up when the pipes are
>> +	 * dup'ed onto stdin/stdout/stderr in the child processes we spawn.
>> +	 */

>I see your point, but I don't have an opinion whether this stretch is
>necessary.
>However, *if* we do this, we must do it for all non-builtins as well!

Well, in general the policy I've used in all the tools I created is that:

a. If it's a setuid tool, then you need to make sure that you don't step
   on anything unintendedly.  I.e. for setuid-something programs this is
   desirable and necessary in order to prevent securityleaks.

b. Anything else is started in an environment controlled by the user,
   and if this environment is broken, then that is the user's fault.
   You get what you wish for.  It's a similar problem you get when you
   set PATH to wrong values and then start "make" for example; it has
   the potential to break a lot; but then again there are infinitely
   more ways to shoot yourself in the foot, than there are ways to
   prevent people from shooting in some particular way.

So I'd say, if the tools are setuid (which none of git's tools are) and
are therefore potentially started from a hostile and uncontrolled
environment, please make sure filedescriptors 0, 1 and 2 are sane.
But for the git utilities, it would be a non-watertight extra safeguard
which tries to prevent a situation which rarely occurs and if it does
occur, you probably are doing some other things wrong as well; so
actually exposing those problems to you by letting you feel the pain can
be considered a favour.
-- 
Sincerely,
           Stephen R. van den Berg.

"Good moaning!"
