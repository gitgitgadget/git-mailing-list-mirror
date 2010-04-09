From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Getting rid of a stale remote?
Date: Thu, 8 Apr 2010 22:08:35 -0400
Message-ID: <m2nc115fd3c1004081908t15ee034bha4909b56621b4936@mail.gmail.com>
References: <x2jc115fd3c1004061103z3154b6b3ge34493260f12925e@mail.gmail.com> 
	<w2if3271551004061107rb25b83b9p19a284f19e7d4f87@mail.gmail.com> 
	<x2uc115fd3c1004061125i695f66bbi9f949ccc1958750@mail.gmail.com> 
	<20100406184256.GA14281@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 09 04:09:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O03eZ-0005nG-6t
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 04:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401Ab0DICI6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Apr 2010 22:08:58 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:60318 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab0DICI5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Apr 2010 22:08:57 -0400
Received: by gxk9 with SMTP id 9so1763786gxk.8
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 19:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=tFmJ2t/Nf1Sd72jIwit6mkXY3K7Jtf1ffFMAJDhCNUQ=;
        b=dKopxUVOgIu/10+AoCjKWJNaQL4ueZ1YJIyW1MTWfn5QzuScRrMCuacP5FAD5SiWyz
         Z4D72DjLrw7PqYGdrXxG36YomqsRPVxpqtnU98PGCUwgYIy/RxjRQtJUZglY9z3S/8GQ
         vuOBEVhXA/r2w1WgqQjRVO88tzKZFWi1rulU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TwEk5mEBS1IUriMhG8uUSD9zIqJeEx9db3Pgsro++FvvFnO9qP6MJqkInazwm+uvSJ
         yNZbchsnLm4JFE5gmEb50frmackIN4vs7fi+lDy6twxsDso9rPN3XpKZ+0Ah/glYoY1S
         ZUFzxpBGN+XDjA25bXFy6p2KUbxL034bmBeOM=
Received: by 10.100.33.7 with HTTP; Thu, 8 Apr 2010 19:08:35 -0700 (PDT)
In-Reply-To: <20100406184256.GA14281@coredump.intra.peff.net>
Received: by 10.101.21.9 with SMTP id y9mr1846551ani.71.1270778935267; Thu, 08 
	Apr 2010 19:08:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144390>

On Tue, Apr 6, 2010 at 2:42 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 06, 2010 at 02:25:07PM -0400, Tim Visher wrote:
>>     $ git remote rm d
>>     error: Could not remove config section 'remote.d'
>
> And this fails because you have no configured remote 'd', just the
> crufty branch. How you got into that state, I don't know, but I imagi=
ne
> it was from deleting the config in .git/config manually instead of us=
ing
> "git remote rm" in the first place.

%<---lengthy but almost assuredly misleading explanation of how I got t=
here--->%

So I had this long explanation but I realized that it probably wasn't
the case.  If I ever run into this again I'll try to be more aware of
what I did.  I suspect though that it's when I want to make one remote
my origin and make origin something else=E2=80=A6

> It would be tempting to say that "git remote rm" should continue if t=
he
> config simply doesn't exist and remove the crufty branch, but that is
> not quite right. We actually need the config to tell us "here is wher=
e
> we store the tracking branches for remote d". Of course, unless you h=
ave
> munged the config manually, it will always be "refs/remotes/d". So we
> could perhaps guess that for the case of missing config (possibly wit=
h
> "git remote rm -f" or something).

That sounds quite sensible to me.  Also, a message along the lines of:

    You are trying to delete a remote for which there is no config sect=
ion.  (We
    discovered a remote X in refs/remotes/X) and deleted it.|No remote =
X in
    refs/remotes/X. Did you store it elsewhere?)  In the future, use `g=
it
    remote` to alter your remotes

> But if you just want to do things manually, try "git branch -d -r
> d/branch".

That did indeed work like a charm.  Thanks so much.

--=20

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
