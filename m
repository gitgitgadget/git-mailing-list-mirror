From: "Paolo Teti" <paolo.teti@gmail.com>
Subject: Re: git-rebase (1.5.0.6) errors
Date: Fri, 18 May 2007 13:29:44 +0200
Message-ID: <34a7ae040705180429w454e900cp12426e7164725d45@mail.gmail.com>
References: <Pine.LNX.4.64.0705181130570.28356@kivilampi-30.cs.helsinki.fi>
	 <34a7ae040705180331x1a86782fh3b2c6a87db32030e@mail.gmail.com>
	 <86y7jmmmnq.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri May 18 13:29:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp0ee-0002ap-At
	for gcvg-git@gmane.org; Fri, 18 May 2007 13:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756308AbXERL3q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 May 2007 07:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756408AbXERL3q
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 07:29:46 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:43731 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756308AbXERL3q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2007 07:29:46 -0400
Received: by an-out-0708.google.com with SMTP id d18so209868and
        for <git@vger.kernel.org>; Fri, 18 May 2007 04:29:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o85+SDDtE6pI6Eaj+rPRGfGK0O7qccy7nk2QBYw7z+IvlLhtoLIKAUsTJ12PYtPvk0B8LJwLidAnduIVVmTF5lDwLRcUVVHvCTBLdXRkpiqbETQC+TVCtNV7wZw1JAFpkvxJwvVn/5R65Ku+yI7o3rkCvI4WI/TsQq7cvgrInUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TaKe7NQWumtSUWmCUO9LL7RplZdHPuGnsFYp16H3xpZZlW+Ly+OKXoayILKTlZdpmcdS2BTij+4iPaLfowDThtWRktjxc1R14uARjpAZrPX3qphIzrLbI1q9YGxkU3hXbvsMycp/Jjt/Ua//D/XA33gU4qSQqMuYd9NZyQc9R1o=
Received: by 10.114.144.1 with SMTP id r1mr809773wad.1179487785048;
        Fri, 18 May 2007 04:29:45 -0700 (PDT)
Received: by 10.115.58.17 with HTTP; Fri, 18 May 2007 04:29:44 -0700 (PDT)
In-Reply-To: <86y7jmmmnq.fsf@lola.quinscape.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47594>

2007/5/18, David Kastrup <dak@gnu.org>:
> "Paolo Teti" <paolo.teti@gmail.com> writes:
>
> > 2007/5/18, Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi>:
> >> Hi,
> >>
> >>
> >> ijjarvin@kivilampi-30:~/work/src/submit$ git-rebase net-2.6.22-ori=
gin
> >> First, rewinding head to replay your work on top of it...
> >> HEAD is now at d739437... [IPV4]: Correct rp_filter help text.
> >> fatal: cannot convert from utf-8 to utf-8
> >
> >
> > Now I can't test or try to reproduce your error,
> > but looking at the source code (only with gitweb)
> > I have found another bad use of size_t instead of ssize_t
> > in the reencode_string(..) that take part at the conversion process=
=2E
> >
> > Using size_t in the next portion of code the check "count =3D=3D -1=
" is
> > never true.
>
> Only if size_t is a larger type than int (could be on x86-64 and alph=
a
> architectures).  Other than that, this comparison would work.  Which
> does not mean that this does not warrant fixing, but it is not
> necessarily the cause of this problem.

1. Yes this is not necessarily the cause.. I agree.

2. size_t as I know is unsigned and ssize_t is the signed version of
size_t.. so to
    compare with -1 we want ssize_t.
