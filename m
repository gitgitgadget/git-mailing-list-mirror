From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-send-mail in sh
Date: Fri, 25 Nov 2005 18:26:13 +0100
Message-ID: <43874935.2080804@op5.se>
References: <4386DD45.6030308@op5.se> <7v7jaxou5b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 25 18:28:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfhL7-00074k-Vg
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 18:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbVKYR0P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 12:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbVKYR0P
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 12:26:15 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:44191 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932702AbVKYR0P
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 12:26:15 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id C98276BD0A; Fri, 25 Nov 2005 18:26:13 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jaxou5b.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12744>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>>It's worse than the perl version because;
>>1. It doesn't thread the patch-series (which I personally prefer anyway 
>>since it's easier to follow a thread on a particular patch that way).
> 
> 
> I think that is an improvement, actually ;-)
> 

Agreed to that then. Good thing since that was the hardest to solve.

> 
>>2. The patches sent within the same second arrive in random order.
> 
> 
> I think you can fudge the "Date: " yourself.  Count the number
> of messages you are going to send out, grab the wallclock time
> before starting to send the first message, subtract that number
> of seconds and give it to the first message, add 1 second and
> give it to the second message, and so on.
> 
> 3. It does not CC signers and authors.  Although I personally
> consider not doing it "better", some people _might_ want to keep
> that behaviour as an option.
> 

It doesn't CC them, but any number of email-addresses can be specified 
on the command line (so long as they don't include spaces, but that can 
be taken care of).

These below needs a bit of clarification. It's friday afternoon here, so 
I'm a bit slow.

>         <commits> = ".." <top> | <bottom> ".." <top> | <commit>
> 	<bottom> = <extended SHA1 expression>
> 	<top>    = <extended SHA1 expression>
> 	<commit> = <extended SHA1 expression>
> 
>  * ..<top> is a shorthand of "origin"..<top> (the choice of
>    "origin" might be debatable, but probably sane).
> 

I'd rather specify the entry-point, as in "get all patches from this 
commit to HEAD", if only one commit is specified, so:

	git-send-patch git@vger.kernel.org origin

would do just that.

>  * <bottom>..<top> pair is to format changes in <top> but not in
>    <bottom>; typically <top> is the name of a topic branch, and
>    <bottom> is typically "origin".  This is to encourage the use
>    of topic branches.
> 

Would that be

	git-send-patch origin..HEAD

to get the changes in the current branch since head?

>  * <commit> is a shorthand for <commit>^1..<commit>; this is to
>    allow you to quickly pick just one commit and send it out.
> 

Marvellous the things one learn. I didn't know about that syntax before. :)

> 
>># [ "$email" ] || git repo-config --get patch_email_address
> 
> 
> Storing the default addressee in the config is a good idea,
> since typically e-mail submissions are to a single address.
> 

If values can have spaces there can be any number of email-addresses.

> 
>>[ $commits -gt 1 ] && opts=-n
> 
> 
> You can always say -n if you want to do this; format-patch -n
> with a single patch would not say [PATCH 1/1].
> 

Didn't know that. Good thing though.

> 
> This is the first script I saw that uses the standard output
> from format-patch, and I do not think nobody else used it so
> far.  If the standard output from format-patch is useful like
> this, I would like to drop the '* ' prefix from it, so that you
> do not have to sed it out.
> 

I'll do that then. It doesn't really add any value anyways.

> You would probably want to do "format-patch -o $tmpdir" at least
> not to smudge the toplevel directory.
> 

Perhaps support the -o flag in git-send-patch?

I'm wondering if it wouldn't be better to move much of 
git-format-patch's functionality to git-send-patch and support a 
"--todisk" option. After all, how many patches are created but not sent 
anywhere?

That way we could rework the syntax to only support that of 
git-rev-list. I think it's the most standard-like thing there is in git.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
