From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: [question] how can i verify whether a local branch is tracking a 
	remote branch?
Date: Mon, 6 Apr 2009 10:30:21 +0200
Message-ID: <4d8e3fd30904060130l985b0a5x331d215ca6106fd4@mail.gmail.com>
References: <4d8e3fd30904050332w394cccbaq5b82d2a53ed357a3@mail.gmail.com>
	 <20090405144413.GC2076@sigill.intra.peff.net>
	 <4d8e3fd30904051425w6739a12fp5666e71e8b2d7958@mail.gmail.com>
	 <20090406043426.GC12341@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 06 10:32:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqkFI-0001qg-HH
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 10:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119AbZDFIaZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 04:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752940AbZDFIaZ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 04:30:25 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:64848 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbZDFIaY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2009 04:30:24 -0400
Received: by fxm2 with SMTP id 2so1760543fxm.37
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 01:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xFA8hppyUxtYOW0vQMIJQIkcdaGoL2H6R+rcGYViy/c=;
        b=rcyEl3Sgp1IyBox/ApsBoWgfd8tkbNU7M95g32W2RQ/YLpdCGkZyH0Q0T5Xy4SsDIZ
         U44f4Cnx1kUIy/8TXAj+qR2zj5H3oYrB2Z36R95SvEJneMwx6gWLNAvCIR4OOyYYa/B+
         NxzT9w0jJu+zc3g0GWgHoyYbmSKTyJCuvraVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=v+1HE/lslH9pDnhpjxMPvhfsb+TLBEJg12WuHqO2aPzgJ5UfCd+GDOWUkzdBGnKqnm
         MFsCbDcpjK9xGbhBwKfVXqylJJKhx28noK3pUowT//rLNTz1J394MQ71BEF/OZKPWDel
         7LmMAIl6cRuMyaWTRa9AJ3riE19CVRgrYGgds=
Received: by 10.86.3.4 with SMTP id 4mr2856286fgc.54.1239006621413; Mon, 06 
	Apr 2009 01:30:21 -0700 (PDT)
In-Reply-To: <20090406043426.GC12341@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115780>

On Mon, Apr 6, 2009 at 6:34 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Apr 05, 2009 at 11:25:29PM +0200, Paolo Ciarrocchi wrote:
>
>> An example:
>> $ git clone -n URL temp
>> $ cd temp
>> $ git branch -r
>> =A0 origin/master
>> =A0 origin/foo
>> =A0 Origin/bar
>> $ git checkout --track -b foo origin/foo
>>
>> Now, how can I know that foo is tracking origin/foo ?
>
> Doing it right is hard. You have to:
>
> =A01. check branch.foo.merge and branch.foo.rebase; if no value, it i=
s not
> =A0 =A0 tracking anything; if it is, remember that value as $m
>
> =A02. check branch.foo.remote for the remote name, $r
>
> =A03. check the fetch refspecs for remote $r; these can come from
> =A0 =A0 the config, or from .git/remotes/* files. Maybe even .git/bra=
nches
> =A0 =A0 files; I don't even remember how those work.
>
> =A04. find the refspec that fetches from $m; then find the matching
> =A0 =A0 destination for that refspec. That is the tracking branch.
>
> E.g., in your example (and using a modern git):
>
> =A01. $m is refs/heads/foo
> =A02. $r is origin
> =A03. The fetch refspec is in remote.origin.fetch, and is generally
> =A0 =A0 "refs/heads/*:refs/remotes/origin/*"
> =A04. So refs/heads/foo becomes refs/remotes/origin/foo.
> =A0 =A0 refs/remotes/origin/foo is your tracking branch.
>
> Steps 1 and 2 are easy, but 3 and 4 are a bit nasty. You can fake it =
by
> assuming that "refs/heads/$m" on "$r" is always "refs/remotes/$r/$m",
> which is true for very vanilla setups.
>
> There is C code that does this, but there is not a good way of access=
ing
> it from the command-line. The best you can do is "git remote show
> origin", which on recent git versions should show something like:
>
> =A0...
> =A0Local branches configured for 'git pull':
> =A0 =A0foo =A0 =A0merges with remote foo
> =A0...
>
> But of course that implies that you already guessed the remote "origi=
n".
> And it's not using plumbing, so it's not very suitable for scripts.
>
> I don't think it would be unreasonable to expose this functionality v=
ia
> "for-each-ref". Something like this (which would need cleanup,
> documentation, and perhaps a :short variant):

Jeff,
thank you very much for your prompt answers and for your patch.

I often act like a GIT "evangelist" trying to help friends and
colleagues in starting using GIT and one of the "complaint" I'm
getting is that people expect to get this information out of the
branch command.

I mean something like:
$ git branch
 * foo <-> origin/foo

What do you think?

Ciao,
--=20
Paolo
http://paolo.ciarrocchi.googlepages.com/
http://mypage.vodafone.it/
