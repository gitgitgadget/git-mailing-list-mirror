From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: pack-object poor performance (with large number of objects?)
Date: Tue, 4 Oct 2011 09:59:08 +0200
Message-ID: <CAA01CsoSTsBLNcbv5o6Jx6YrjG4g8T=yodX811ymBLXg7sjDJQ@mail.gmail.com>
References: <CAA01CspZijOO_xbR=OcaRaesTeSy=6RM4DR01-07qimVzxvJZA@mail.gmail.com>
	<CAJo=hJtw+sYrP09zrDbZJNGHDYOeguQLkOe88FBYQDZrnaqsAw@mail.gmail.com>
	<CAA01CsppPf_6Zp5UPYBsxa1JEwLGF-FqacRa7kBJ45Ges2ujrw@mail.gmail.com>
	<7v62k5g988.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 09:59:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAzuP-0002HD-Op
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 09:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299Ab1JDH7K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 03:59:10 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42298 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271Ab1JDH7I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 03:59:08 -0400
Received: by ywb5 with SMTP id 5so203158ywb.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 00:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=OIEmVeANDAtiJ3mU9gaXoXA841UfMLgUnrTYQVs9bU0=;
        b=wjt7WFHro663FbmAvdMffoJT2eW/GbEWM5tIkjODbo1STrYgtk/ms9z4F3nLBApXrD
         lzG8wFfrYNphvgqhqpKfZUYF3/5s14TQrrp+PpOEmbIMDE2K++7NrNAhWttp1pbEg4ZW
         Z5MXUvov1WWZYKEBBWI5219hMC6zzCB50e8SE=
Received: by 10.150.160.13 with SMTP id i13mr903455ybe.2.1317715148110; Tue,
 04 Oct 2011 00:59:08 -0700 (PDT)
Received: by 10.150.196.1 with HTTP; Tue, 4 Oct 2011 00:59:08 -0700 (PDT)
In-Reply-To: <7v62k5g988.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182743>

On Mon, Oct 3, 2011 at 9:34 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> This is on my box [*1*] that is idle (other than running the repack).=
 The
> above is starting from an already reasonably well packed state and re=
uses
> deltas; with "-f" to repack everything from scratch it would take
> significantly longer:
>
> =A0 =A0linux-3.0/master$ time git repack -a -d -f
> =A0 =A0Counting objects: 2138578, done.
> =A0 =A0Delta compression using up to 4 threads.
> =A0 =A0Compressing objects: 100% (2118691/2118691), done.
> =A0 =A0Writing objects: 100% (2138578/2138578), done.
> =A0 =A0Total 2138578 (delta 1749156), reused 344219 (delta 0)
>
> =A0 =A0real =A0 =A03m26.750s
> =A0 =A0user =A0 =A08m41.857s
> =A0 =A0sys =A0 =A0 0m6.716s

I've run the command and it took about 20 minutes in "Counting
objects" to count up to 500000 on idle machine and there's still 700MB
RAM free.

I wonder, when you do the repacking from a packed state, does it
physically create files on file system? In my case I have lots of
files in objects dir:

$ ls objects/ | wc -l
258
$ ls objects/00 | wc -l
6173

When I tried 'find objects | wc -l' previously (when repack was not
running) it got "stuck" too and I got impatient and killed it ;)

So it looks it's not a problem with git but rather with my disk/file
system/linux...


--=20
Piotr Krukowiecki
