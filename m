From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] hooks--update: new, required, config variable: hooks.envelopesender,
Date: Fri, 23 Mar 2007 16:15:26 +0000
Message-ID: <200703231615.28350.andyparkins@gmail.com>
References: <874poc88ix.fsf@rho.meyering.net> <200703231412.41591.andyparkins@gmail.com> <87lkho6ky8.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jim Meyering <jim@meyering.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 17:15:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUmQa-0006Pr-Kb
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 17:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbXCWQPh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 12:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbXCWQPh
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 12:15:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:32452 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbXCWQPf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 12:15:35 -0400
Received: by nf-out-0910.google.com with SMTP id o25so2085803nfa
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 09:15:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mNLV/RKzDm1sbVLBQ18SZHPRfPBsWaXZ8sW7/H0sqWRWuql0DWWxswfK7lznaQgBMJ99+dEzetLqmOoiHqqUNfeDpjdNUqtIG8WLc0VJdvj8TSzPOiGooYgvcTskJ3dfeDmUi15jlwbqueYltI8QmrukHIX168UmUUSNE4iogl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kRymJbZ+N/axfg+BqPvd/SJe226J2xsrQKb1eLIkUdusWb1wVjcP3Ys7tilq+0C9C7xVF1UG8TkdOO6EQtkQy9TL8+9UY+1tRkcAycP8MsKWTs7NjKMVYTkaV5LerEQt8ZyxBo6Lat6wfObCXEH6qUIQtVVzl5TGKL0IxY9bbbY=
Received: by 10.78.157.8 with SMTP id f8mr1672540hue.1174666533773;
        Fri, 23 Mar 2007 09:15:33 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id c1sm12019736nfe.2007.03.23.09.15.32;
        Fri, 23 Mar 2007 09:15:33 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <87lkho6ky8.fsf@rho.meyering.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42946>

On Friday 2007 March 23 15:25, Jim Meyering wrote:
> Andy Parkins <andyparkins@gmail.com> wrote:
> > On Friday 2007 March 23 13:29, Jim Meyering wrote:
> >> It works for me using the sendmail from sendmail, and I have tested
> >> this with the one from postfix, too.
> >
> > Is your user set as a trusted user for sendmail though?
>
> No.  There is no need for that.
>
> > As a normal user wouldn't be allowed to do it.
>
> You mean with exim's sendmail?
> sendmail -f alt-envelope-sender works just fine when run by a
> non-privileged user when it's Sendmail's sendmail or the one from Postfix.
> It's a shame if it doesn't work with exim's implementation.

Okay; I went and found a sendmail manpage:

"-fname       Sets the name of the ``from'' person (i.e., the sender of the
              mail).  -f can only be used by ``trusted'' users (normally
              root,  daemon, and network) or if the person you are trying to
              become is the same as the person you are."

Seems the same as exim to me.  Perhaps your distribution sets it up to allow 
if for anyone?

> case.  FYI, the first case was to allow commit email to be sent from
> the GNU coreutils git repository in a vserver on savannah.gnu.org.
> The second was at work last night.

> Not the *final* recipient, of course.
> Some *internal* MX servers are very careful about sender addresses
> in outbound mail, verifying them before forwarding the message on.

Fair enough.

> Thanks for the explanation of how email works, but you may
> assume that I know a little more than the average hacker :-)

My apologies; I didn't mean to be patronising - I wrongly assumed you were 
just confused about who was authenticating whom.

So; in short: I don't have a good answer to offer you, and it seems that "-f" 
is working for you.  However, I'm still not convinced that this is the 
correct thing to do in the default hook.  My main gripe is still all 
these "trusted user" paragraphs in the MTA manual pages.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
