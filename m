From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] hooks--update: new, required, config variable: hooks.envelopesender,
Date: Fri, 23 Mar 2007 14:12:38 +0000
Message-ID: <200703231412.41591.andyparkins@gmail.com>
References: <874poc88ix.fsf@rho.meyering.net> <200703231258.34339.andyparkins@gmail.com> <87wt186qcd.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jim Meyering <jim@meyering.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 15:13:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUkWD-0006DR-2W
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 15:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934061AbXCWOMt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 10:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934279AbXCWOMt
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 10:12:49 -0400
Received: from ik-out-1112.google.com ([66.249.90.183]:28507 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934061AbXCWOMs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 10:12:48 -0400
Received: by ik-out-1112.google.com with SMTP id c21so1251121ika
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 07:12:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YVjkEyDBtPUPaDo7d+jgyWBUkDuFSmS73+B2CDW6wOlz9zraBHEDONEJDfqPjeul5QgxAhG24NNCWEAU0PAcItBA08eyT/IxlnqjAD4TOGM2AUK4E1ZU6s4sh5OTy45n2pzWYj33kL+YivXFZLHQWKAJMaeS5cO2etkyAomwHEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=G8PUF32QJCzlkfkazcZd1rrG4zalCtdrZcxGRmi+BS8LWM3r7RcCm04M7KOCUSse/B4wiBoCvWqpn/pzEF1eyjefVsv7DKPBI1NamATAVr0pmo5LZbxecm242hkOzO5Kj/M/jMYM4OSHKdwNP3iH72CXEYKjCCVsaMkexnRCG4Y=
Received: by 10.70.66.18 with SMTP id o18mr5826861wxa.1174659165962;
        Fri, 23 Mar 2007 07:12:45 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id r34sm11700208nfc.2007.03.23.07.12.44;
        Fri, 23 Mar 2007 07:12:45 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <87wt186qcd.fsf@rho.meyering.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42933>

On Friday 2007 March 23 13:29, Jim Meyering wrote:

> It works for me using the sendmail from sendmail, and I have tested
> this with the one from postfix, too.

Is your user set as a trusted user for sendmail though?  As a normal user 
wouldn't be allowed to do it.

> It has a dramatic effect for me.
> With it, mail is sent, without, it's not.

Of course - I didn't doubt that it would, otherwise you wouldn't have bothered 
posting your patch :-)  The point is that I don't think it's universally 
applicable.  It's working for you; in your particular situation, but I'm 
guessing that you are set up as a trusted user for sendmail on your system, 
and so it's letting you rewrite the sender address.

> Part of the problem was that sendmail used a mangled hostname.
> Without -f, it would use user@foo.domain.com.domain.com.

Ah right; the fault lies not with the hook script but with your mail set up.  
I don't know how it would be done with sendmail; but for me, with exim I 
write an /etc/email-addresses file which contains:

andyp: andyparkins@gmail.com

This catches my username "andyp" on outgoing emails and rewrites the address 
to my real email "andyparkins@gmail.com".  I guess there will be an 
equivalent for other mailers.

> But IMHO, relying on the current behavior (using envelope sender same as
> the From: address) is not an option.  It must be configurable.  I want

That's not the current behaviour.  The "From:" in the email is set from the 
committer information from the revision.  The sender address is set using the 
local user account running sendmail; most email systems will ignore 
the "From:" header and let you write what you want.  The sender field, 
however is tightly controlled.

> the envelope sender to be the same admin address for all outgoing mail,
> since that's where reports of delivery problems are sent.  Besides, the

Erm: tough.  What you're asking for requires root/trusted privileges on the 
box for the user sending the email.  If it didn't, what would there be to 
stop any user sending emails that appeared to be from the admin?

> users in question don't even have "real" shell or email access on the
> server system, so receiving systems would not be able to authenticate them.

I'm not sure you've got the right idea about email; the receiving system 
doesn't have to authenticate the /user/ sending the email (if it did, then 
you'd need an account on every email server in the world).  It does need to 
authenticate the sending /machine/ (some ISPs go a bit further than that, and 
do you're sending emails that you're entitled to, but let's ignore that).  So 
whatever your email set up is; the box that has the repository must be set so 
that whomever it routes its mail to trusts it do so.  Most email servers will 
only accept incoming email for addresses local to itself; for outgoing email 
they will only relay for a defined set of machines.

> In fact, some of the "users" in question are fake accounts used solely
> for write access (via git-server) to the shared git repository, so the
> user name exists only on the server system.

They're not fake accounts then - they really exist on that system.  I'm 
guessing by "fake" you mean that their login shell is set to git-shell.  That 
doesn't stop git-server from running as their UID, and in turn running the 
hook script under their UID.  The difficulty is that those users really are 
sending email - if your system is set so that they're not allowed to then the 
act of using git shouldn't magically give them that permission.

> If we can't do this portably via the sendmail program, then
> perhaps it's a good time to switch to using a module like Net::SMTP.

I don't think that's the right solution either.  That's just making the hook 
script be a mail transfer agent itself, and so it would then connect to your 
receiving server directly.  That implies that it would have to be able to 
solve all the problems that a real MTA solves itself - I don't think it's the 
right place for that level of functionality.

So; that was a whole load of negative stuff, here's some suggestions 
(untested):
 * Run the hook script SUID.  Pretty nasty.
 * Configure /etc/passwd so the fake users all map to the same UID; then use
   that username in /etc/email-addresses (or equivalent) to set up the admin
   address you want to use.
 * Change your local mail setup to include the fake users as trusted

Does anyone know how other VCSs solve this problem?  Short of running some 
sort of privileged process I can't think of a way.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
