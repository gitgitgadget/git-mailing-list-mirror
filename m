From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [RFC] git blame-tree
Date: Wed, 2 Mar 2011 22:24:29 +0100
Message-ID: <AANLkTi=hqVcGw16q6uJBO5kPjKtsa=ujtQxg4FRj_+i6@mail.gmail.com>
References: <20110302164031.GA18233@sigill.intra.peff.net>
	<20110302171653.GA18957@sigill.intra.peff.net>
	<AANLkTim4fKO=Lb0dY0DzRu1QqC8NHPoF8iveYQ2E6OBH@mail.gmail.com>
	<20110302180722.GA20287@sigill.intra.peff.net>
	<AANLkTi=m_WTohMfJZxTqObRT3rhhtxo=QfnDJCHO=U0K@mail.gmail.com>
	<20110302211035.GC20400@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 22:24:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PutX9-00039F-Os
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 22:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757280Ab1CBVYa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2011 16:24:30 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35668 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab1CBVYa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2011 16:24:30 -0500
Received: by vxi39 with SMTP id 39so404973vxi.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 13:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7smMWhJbX4++94wkhb+qCU5hAzeDUEj06Pe0lmSma3M=;
        b=gTdyB9FDHWvWtM+rqLJW7d2j3zp1bzXkVMbA+jAvKqXTELdZwbHB/tu+ELyivRXfBP
         EbBq+TV/tbxzJ5Zh/A9/lZS35DZi2KlKKv47l/Rrj6aXnZNNNZYRk5MuFpu2KNcLHCoV
         gBOwBfArR3SfvlQQoc6nl3upNx9sHrnfvR/Ss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JF4P3jlvFgLTVQJZgLK7/eGaR4c86cVjZ8cexOUncgn9WdUt0FQbN+R8EfgZwW0KPB
         NUgt+aNZ47IxG20e4zqtwswbkorEbAgqhz8swaiVTZ84Oqi/lqFkqPXfQzeGcWU/FKRS
         sZ26nwA12ThwpfLOs6iarBWuoFU2ecm/H08to=
Received: by 10.52.159.170 with SMTP id xd10mr530022vdb.51.1299101069113; Wed,
 02 Mar 2011 13:24:29 -0800 (PST)
Received: by 10.220.61.140 with HTTP; Wed, 2 Mar 2011 13:24:29 -0800 (PST)
In-Reply-To: <20110302211035.GC20400@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168345>

On Wed, Mar 2, 2011 at 10:10 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 02, 2011 at 07:39:20PM +0100, Piotr Krukowiecki wrote:
>
>> I'd expect this to be something like union. Currently I can only thi=
nk about
>> following case:
>>
>> Some files were changed in branch1, some in branch2, some in both.
>> Show me how the files are changed. For example:
>> =A0 file1 changed in branch1 in commit1
>> =A0 file2 changed in branch2 in commit2
>> =A0 file3 changed in branch1 in commit3 and in branch2 in commit4
>>
>> If file was not changed since branch creation then don't show it (op=
tionally).
>
> I think we are getting into something different here, because you are
> caring not just about the commit in some traversal that touched a fil=
e,
> but for each source, which commits got us there and potentially multi=
ple
> such commits, one per source for each file.

Yah, it might be something for git-log or git-diff.


> And that's a bit more expensive to compute, and the answers are not
> always unambiguous. For example, let's say branch1 and branch2 fork f=
rom
> some merge-base M. In the parent of M, file "foo" was changed. We
> traverse from branch1 and branch2, not seeing anything interesting fo=
r
> "foo". We hit M, and then finally see that its parent touched "foo".

So it's like this?

B1
|
M - B2
|
P <- changes foo


> What do we output? Both branches have equal claim to the commit.

That's easy. In "show only differences" we don't show anything,
because on both branches last-change-commit of "foo" is the same.
In "show all" last-change-commit is P so show it (with message like
"changed in common root" or whatever).


> I think you could figure out semantics that make sense if you spent
> enough time on it. But I also think it is making the relatively simpl=
e
> problem of blame-tree a lot more complex.

I think this is simple, but maybe I don't understand some git
internals that make it hard.


--=20
Piotrek
