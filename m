From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bug? "git branch" failing to list all branches
Date: Thu, 3 Jun 2010 01:55:28 -0500
Message-ID: <20100603065527.GA23439@progeny.tock>
References: <AANLkTimTOucIfzSxsYNvmML7MALwj0E3BUASIIKIN1lN@mail.gmail.com>
 <20100603042218.GA21254@progeny.tock>
 <AANLkTinCNgsIf_MsiysfphKm3MCW2Uio_xiemfDZraH7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Simo Melenius <simo.melenius@iki.fi>
X-From: git-owner@vger.kernel.org Thu Jun 03 08:55:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK4Kp-0000YV-9R
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 08:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862Ab0FCGzS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 02:55:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48740 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749Ab0FCGzP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 02:55:15 -0400
Received: by iwn6 with SMTP id 6so1673329iwn.19
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 23:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5paKxHuFJQIUaBcRV6CYyBB1Dgdp/joZ4dHRnVhKjio=;
        b=EV7d2nnQwE4KTVlmYyfSvBrNUqBaZFDCaEgUYzYxTTf9zQ8X75eilQZ91Zjm0LLCLO
         SoQaLG8Bv/3k+pyhmxA8CzOPJno1sUECsPgo4JSyMtJzsl+/4JKOdtvl2mark385lUlw
         5ZFTNUMSnlAkEsi3pnuIe5T63jKpe2WTdajG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=smLHFOeHON68e1akBvGpVnB+0j/mISx9i27ni/brAXgv61dI+HCgmqXRo46cdirSSm
         EwAP87xAQz8R2rFtQeIrFiMFMZSX9Rv8B+xXkwCZW5z09kSKD92cubMdaZXqkoVcJC0+
         neZHkhlLK7HMX9PQwluUCOA1cDdwVbhNhZaIU=
Received: by 10.231.169.129 with SMTP id z1mr11413840iby.26.1275548112890;
        Wed, 02 Jun 2010 23:55:12 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a8sm40547961ibi.11.2010.06.02.23.55.11
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 02 Jun 2010 23:55:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinCNgsIf_MsiysfphKm3MCW2Uio_xiemfDZraH7@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148294>

Simo Melenius wrote:

> My change doesn't change the current behaviour. At least git 1.7.0.4
> didn't give a nonzero exit status either. It would be good if it did.
>=20
> I could add that to my patch. I'm, however, unsure of what's the best
> way to communicate the error from append_ref() to cmd_branch(). A
> static variable in branch.c would of course do.

I see.  You can use the cb_data argument to pass a result back:

 struct append_ref_cb {
 	struct ref_list *ref_list;
 	int err;
 };

A static variable might be simpler.

But that is a separate topic (for a separate patch).  I can pick it up
if you don=E2=80=99t.

>> If I have 37 branches and an error is encountered looking up one of
>> them, with this patch the error message will scroll off the screen.
>> Is this worth worrying about? =C2=A0It depends on what the usual cau=
ses for
>> broken branch refs are and whether they require attention or can be
>> safely ignored.
>
> Since this only concerns the printing of branches, often for
> interactive viewing or bash completion, and does not affect any of th=
e
> operations that modify the repository, I think it's sufficient that
> the error message is still readable from stderr for those who are
> interested.

Sorry, I must have been unclear.  Let me illustrate with an example:

 $ git branch
 * (no branch)
   cc/sequencer-rebase-i
   db/svn-fe
 error: branch 'dk/hash' does not point at a commit.
   gp/debian-pu
   gp/sid-patches
   jl/gitk-submodule
   jk/pull-rebase-message
   jn/debian-build-depends
   js/grep-open
   ks/gitk-notes
   nd/gitbox
   nd/setup
   rr/svn-remote
   sb/sequencer-dev
   sb/sequencer-rfc
 ...

If this scrolls on for too long, I will not see the message.  Now if
the error is due to some kind of corruption or a broken script, I
would want to know about it right away, even if I can carry on with
my work without.  So in that case, it would make sense to add at the
end:

 fatal: some refs could not be read.

On the other hand, maybe there is some harmless process that often
creates these broken refs and such a message would be a nuisance.

Hoping that is clearer,
Jonathan
