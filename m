From: Adam Mercer <ramercer@gmail.com>
Subject: Re: Using filter-branch to move repo contents in subdirectory
Date: Thu, 29 Jul 2010 14:15:31 +0100
Message-ID: <AANLkTin5sv8NQ_8NZkQpW9HG4zYZDZHNF80EWK8Km4Mr@mail.gmail.com>
References: <AANLkTik2dL5jrEjZe0LB6Y4_PEwRt-7t_5CG7gup3pnV@mail.gmail.com> 
	<201007291508.05242.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jul 29 15:15:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeSxq-0002EH-EN
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 15:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756857Ab0G2NPx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jul 2010 09:15:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56504 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755792Ab0G2NPw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jul 2010 09:15:52 -0400
Received: by iwn7 with SMTP id 7so331542iwn.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 06:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=+Wg1WpyXq0gImMA+kTQUH3rMpirqVMJ7EWvGgVB5U/I=;
        b=tsxNJhiyN95cYkjMyCTnpp9F4NBMt0S6PpuG/Yns2rdcraJU3ahjYzZdBMT+zTDM0H
         nOEytBn90DrNJluRmsj7LBs478Ge0C0vAwfJCMOMsqg4VhHtsAyMZpCaFxWAzPm0/2bK
         w0vNhXdtEsskSrrVi/Ezvs7mj8Xr7OUp5bmpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=p7RNZH5rodcD9mi6NmM2WCmpiG/Ye8IRHW/URtrveFRJGOC12eS6Esm6Nf4JpPldCP
         BLSGN3EyyJnkCnLiyNrJDjlVyzqXfx4CbXAXCE9KBRwyLkS6j0t52vFHmwLj7k+HQ5ok
         rl+u2/zPXAAt3KOArVjQBopNxwbm6zgWSLMiE=
Received: by 10.231.148.195 with SMTP id q3mr16728ibv.199.1280409351249; Thu, 
	29 Jul 2010 06:15:51 -0700 (PDT)
Received: by 10.231.182.18 with HTTP; Thu, 29 Jul 2010 06:15:31 -0700 (PDT)
In-Reply-To: <201007291508.05242.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152174>

On Thu, Jul 29, 2010 at 14:08, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> Adam Mercer wrote:
>> $ git filter-branch --index-filter \
>> =A0 =A0 'git ls-files -s | sed "s-\t\"*-&sftlib/-" |
>> =A0 =A0 =A0 =A0 GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new \
>> =A0 =A0 =A0 =A0 =A0 =A0 git update-index --index-info &&
>> =A0 =A0 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
>> Rewrite 223651f2ebd5d5d9341bcfc9e7cb6caaa3f4d171 (56/65)Ignoring pat=
h
>> 00bootsftlib/
>
> What OS is this?

This was on Mac OS X 10.6. Where sed is BSD sed.

> You seem to have a 'sed' version where \t does not
> match the horizontal tab character, or a shell that replaces the '\t'
> inside a double-quoted string with simply 't'.
>
> As a short-term fix, you can try to replace it with $(printf '\t')
> which should always give a tab character. =A0You need to quote the '
> though, so that's
>
> =A0$ git filter-branch --index-filter \
> =A0 =A0 =A0'git ls-files -s | sed "s-$(printf '\''\t'\'')\"*-&sftlib/=
-" |
> =A0 =A0 =A0 =A0 =A0GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0git update-index --index-info &&
> =A0 =A0 =A0mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD

Thanks, that did the trick!

> As for the actual issue: 'man 1p sed' on my system claims
>
> =A0 =A0 =A0 =A0* The escape sequence '\n' shall match a <newline> emb=
edded in the =A0pat-
> =A0 =A0 =A0 =A0 =A0tern space. A literal <newline> shall not be used =
in the BRE of a con-
> =A0 =A0 =A0 =A0 =A0text address or in the substitute function.
>
> but does not mention \t at all, so I guess either that manpage is
> wrong or GNU sed is not POSIX compliant even with --posix (where it
> still treats \t as a tab).

Also using the original command, but specifying GNU sed also does the t=
rick.

Cheers

Adam
