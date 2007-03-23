From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] hooks--update: new, required, config variable: hooks.envelopesender,
Date: Fri, 23 Mar 2007 16:25:35 +0100
Message-ID: <87lkho6ky8.fsf@rho.meyering.net>
References: <874poc88ix.fsf@rho.meyering.net>
	<200703231258.34339.andyparkins@gmail.com>
	<87wt186qcd.fsf@rho.meyering.net>
	<200703231412.41591.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 16:25:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUle8-000785-PE
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 16:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbXCWPZh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 11:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbXCWPZh
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 11:25:37 -0400
Received: from mx.meyering.net ([82.230.74.64]:60502 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007AbXCWPZg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 11:25:36 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 582DD188E; Fri, 23 Mar 2007 16:25:35 +0100 (CET)
In-Reply-To: <200703231412.41591.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 23 Mar 2007 14:12:38 +0000")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42941>

Andy Parkins <andyparkins@gmail.com> wrote:

> On Friday 2007 March 23 13:29, Jim Meyering wrote:
>
>> It works for me using the sendmail from sendmail, and I have tested
>> this with the one from postfix, too.
>
> Is your user set as a trusted user for sendmail though?

No.  There is no need for that.

> As a normal user wouldn't be allowed to do it.

You mean with exim's sendmail?
sendmail -f alt-envelope-sender works just fine when run by a
non-privileged user when it's Sendmail's sendmail or the one from Postfix.
It's a shame if it doesn't work with exim's implementation.

>> It has a dramatic effect for me.
>> With it, mail is sent, without, it's not.
>
> Of course - I didn't doubt that it would, otherwise you wouldn't have bothered
> posting your patch :-)  The point is that I don't think it's universally
> applicable.  It's working for you; in your particular situation, but I'm
> guessing that you are set up as a trusted user for sendmail on your system,
> and so it's letting you rewrite the sender address.

There is no need to declare a user "trusted" for sendmail to allow
it to use the -f option.

> That's not the current behaviour.  The "From:" in the email is set from the
> committer information from the revision.  The sender address is set using the
> local user account running sendmail; most email systems will ignore
> the "From:" header and let you write what you want.  The sender field,
> however is tightly controlled.

Thanks for clarifying.  However, in any case, the current behavior
is too constraining.  I've needed to change it now in two totally
different environments, so I really doubt that this is an isolated
case.  FYI, the first case was to allow commit email to be sent from
the GNU coreutils git repository in a vserver on savannah.gnu.org.
The second was at work last night.

>> the envelope sender to be the same admin address for all outgoing mail,
>> since that's where reports of delivery problems are sent.  Besides, the
>
> Erm: tough.  What you're asking for requires root/trusted privileges on the
> box for the user sending the email.

No.
As I tried to make clear, above, for the sendmail programs I use,
sendmail -f works fine for unprivileged users.

> If it didn't, what would there be to
> stop any user sending emails that appeared to be from the admin?

Nothing.  We've always been able to do that, though when we do,
we also get an X-Authentication-Warning header.

>> users in question don't even have "real" shell or email access on the
>> server system, so receiving systems would not be able to authenticate them.
>
> I'm not sure you've got the right idea about email; the receiving system
> doesn't have to authenticate the /user/ sending the email (if it did, then

Not the *final* recipient, of course.
Some *internal* MX servers are very careful about sender addresses
in outbound mail, verifying them before forwarding the message on.

...
Thanks for the explanation of how email works, but you may
assume that I know a little more than the average hacker :-)
