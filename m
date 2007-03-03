From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Quick description of possible gitattributes system
Date: Sat, 3 Mar 2007 21:27:55 +0100
Message-ID: <200703032127.56343.jnareb@gmail.com>
References: <200703011206.47213.andyparkins@gmail.com> <es9aal$5gf$1@sea.gmane.org> <Pine.LNX.4.64.0703020850470.3953@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 03 21:25:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNanZ-0008Ac-HD
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 21:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbXCCUZn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 3 Mar 2007 15:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbXCCUZn
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 15:25:43 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:39681 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166AbXCCUZm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 15:25:42 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1678197nfa
        for <git@vger.kernel.org>; Sat, 03 Mar 2007 12:25:40 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=sCFcrCOd/kJjanc3B2VLc1gXFI53Yicu/15oZp5zLmAeGW7AiYdunkjmv12iyfjRPzKGmLKOpPa0yF5obZUoRURhMejSwXqVHsMX8EOQI++U0B+e0hYMM+4E3eZ4EFD0n+mix7EQhFoaYrGrypFktyzba8ViuHvDoxJN/FKvM8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=g39z2byCMJcp6hvmR8Wx45pnlFZiN44SICkoREcfBxUQlXAVkNN4ESQlFwaaW8zZZHAfxtihdKS31rhaLRcqhmUAEMJm5LmqC9cZvnW90P+FZqp0fmKEtON3URaZZ0KWPTq0Oofifje1K+sX+ruSpP8rGZFc1bhWIW64T5W320w=
Received: by 10.82.148.7 with SMTP id v7mr2493007bud.1172953540550;
        Sat, 03 Mar 2007 12:25:40 -0800 (PST)
Received: from host-81-190-25-43.torun.mm.pl ( [81.190.25.43])
        by mx.google.com with ESMTP id y6sm11331059mug.2007.03.03.12.25.37;
        Sat, 03 Mar 2007 12:25:38 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0703020850470.3953@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41323>

On Fri, 2 Mar 2007, Linus Torvalds wrote:
> On Fri, 2 Mar 2007, Jakub Narebski wrote:
>> Andy Parkins wrote:
>>=20
>>> + - prettyfilter
>>> + =A0 Run by git-cat-file or git-show when content is being pretty-=
printed
>>> + =A0 for display to the user. =A0If no prettyfilter is set, then i=
t should
>>> + =A0 default to outfilter.
>>=20
>> I'd rather have plumbing operate without filters (if it is possible)=
,
>> so git-cat-file would not run prettyfilter, and git-show would run i=
t.
[...]
> So I really think that the issue here is that the *pager* should do t=
he=20
> right thing. Which gets us to:
>=20
>> Or at least detect if output is tty, so one can do something like
>> "git cat-file -p v1.0.0:gitweb/git-logo.png > git-logo.png" and get
>> expected result, while "git show v1.0.0:gitweb/git-logo.png" would
>> show the image.
>=20
> Yes. How about just having the built-in git pager do the right thing?
>=20
> Right now we actually wait for data to start arriving (commit 35ce862=
) due=20
> to working around a bug in less. But what if we could make the pager=20
> actually do the right thing here automatically? With "less" just bein=
g the=20
> default action for *text*?

Wouldn't it be better and simplier instead of creating built-in magic
(as in DWIM) pager, to have in place of "prettyfilter", "pretty",
"show" handler "pager" handler, which would define _default_ pager for
given attributes.

It would mean that the filter/sink would be run only when pager is run,
i.e. for "git show" and "git -p cat-file"/"git --paginate cat-file".
I guess that would mean that handler action would be run only for tty.
And you could always override it by setting PAGER environmental variabl=
e.

So it would be:

+ - pager
+   Change default pager for this content. If it is not set, it default=
s
+   to `less'. You can always override default pager by setting PAGER
+   environmental variable.

--=20
Jakub Narebski
ShadeHawk on #git
Poland
