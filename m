From: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: the war on trailing whitespace
Date: Tue, 28 Feb 2006 10:29:55 +1100
Message-ID: <44038B73.4030004@bigpond.net.au>
References: <20060225174047.0e9a6d29.akpm@osdl.org>	<7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>	<20060225210712.29b30f59.akpm@osdl.org>	<Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>	<20060226103604.2d97696c.akpm@osdl.org>	<Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>	<20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer>	<Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>	<20060227011832.78359f0a.akpm@osdl.org> <7vhd6kxuea.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 00:30:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDroY-00066J-BB
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 00:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWB0X37 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 18:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbWB0X37
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 18:29:59 -0500
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:45283 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750952AbWB0X36 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 18:29:58 -0500
Received: from [192.168.0.4] (really [147.10.133.38])
          by omta02sl.mx.bigpond.com with ESMTP
          id <20060227232955.HLAM18661.omta02sl.mx.bigpond.com@[192.168.0.4]>;
          Mon, 27 Feb 2006 23:29:55 +0000
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd6kxuea.fsf@assigned-by-dhcp.cox.net>
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 27 Feb 2006 23:29:55 +0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16893>

Junio C Hamano wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> 
>>That's not a good reason.  People will discover that git has started
>>shouting at them and they'll work out how to make it stop.
>>
>>The problem is getting C users to turn the check on, not in getting python
>>users to turn it off.
> 
> 
> This whitespace policy should be at least per-project (people
> working on both kernel and other things may have legitimate
> reason to want trailing whitespace in the other project),

I'd be interested to hear these reasons.  My experience is that people 
don't put trailing white space in deliberately (or even tolerate it if 
they notice it) and it's usually there as a side effect of the way their 
text editor works (and that's also the reason that they don't usually 
notice it).  But if my experience is misleading me and there are valid 
reasons for having trailing white space I'm genuinely interested in 
knowing what they are.

> so we
> would need some configurability; the problem is *both*.
> 
> We could do one of two things, at least.
> 
>  - I modify the git-apply that is in the "next" branch further
>    to make --whitespace=error the default, and push it out.  You
>    convince people who feed things to you to update to *that*
>    version or later.
> 
>  - I already have the added whitespace detection hook (a fixed
>    one that actually matches what I use) shipped with git.  You
>    convince people who feed things to you to update to *that*
>    version or later, and to enable that hook.
> 
> I think you are arguing for the first one.  I am reluctant to do
> so because it would not help by itself *anyway*.  In any case
> you need to convince people who feed things to you to do
> something to prevent later changes fed to you from being
> contaminated with trailing whitespaces.
> 
> Having said that, I have a third solution, which consists of two
> patches that come on top of what are already in "next" branch:
> 
>  - apply: squelch excessive errors and --whitespace=error-all
>  - apply --whitespace: configuration option.
> 
> With these, git-apply used by git-applymbox and git-am would
> refuse to apply a patch that adds trailing whitespaces, when the
> per-repository configuration is set like this:
> 
>         [apply]
>                 whitespace = error
> 
> (Alternatively,
> 
> 	$ git repo-config apply.whitespace error
> 
> would set these lines there for you).
> 
> I think there are three kinds of git users.
> 
>  * Linus, you, and the kernel subsystem maintainers.  The
>    whitespace policy with this version of git-apply (with the
>    configuration option set to apply.whitespace=error) gives
>    would help these people by enforcing the SubmittingPatches
>    and your "perfect patch" requirements.
> 
>  * People who feed patches to the above people.  They are helped
>    by enabling the pre-commit hook that comes with git to
>    conform to the kernel whitespace policy -- they need to be
>    educated to do so.
> 
>  * People outside of kernel community, using git in projects to
>    which the kernel whitespace policy does not have any
>    relevance.
> 
> While I do consider the kernel folks a lot more important
> customers than other users, I have to take flak from the third
> kind of users, and to them, authority by Linus or you does not
> weigh as much as the first two classes of people.  Making the
> default to --whitespace=error means that you are making me
> justify this kernel project policy as something applicable to
> projects outside the kernel.  That is simply not fair to me.
> 
> You have to convince people you work with to update to at least
> to this version anyway, so I do not think it is too much to ask
> from you, while you are at it, to tell the higher echelon folks
> to do:
> 
> 	$ git repo-config apply.whitespace error
> 
> in their repositories (and/or set that in their templates so new
> repositories created with git-init-db would inherit it).
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
