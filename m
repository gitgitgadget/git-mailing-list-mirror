From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: basic question about push
Date: Sun, 24 Jan 2010 18:59:10 -0500
Message-ID: <76718491001241559u103d2e8j38687b41bd5401a1@mail.gmail.com>
References: <loom.20100124T074722-510@post.gmane.org>
	 <20100124081513.GA10700@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Russ Paielli <Russ.Paielli@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 25 00:59:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZCMR-0006nC-Oo
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 00:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669Ab0AXX7P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jan 2010 18:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466Ab0AXX7P
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 18:59:15 -0500
Received: from mail-iw0-f183.google.com ([209.85.223.183]:49077 "EHLO
	mail-iw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab0AXX7O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jan 2010 18:59:14 -0500
Received: by iwn13 with SMTP id 13so2475464iwn.20
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 15:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1hIisKxk8L1mZt1xeqAoZwETIJe7FRk9IlFW/1JLNT0=;
        b=frgv6DvQvnXdbtdwpSop4nn8Bd2UMJzsa5xm2s3A5wTt5ifMrsQ1cL4QVe3jkfWG6Q
         FrLV0ZmgYrYneJJMyljV7yqhdMt1eAXmT9iunDVcLG/xZJdOosMIoob3CJI0+5rUg2+l
         252LqJKasGTva9YncEDKHKBG5gfTviOmwkZII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sIXaOYPMII2Yog5SmaTXyQ0a67KlRVvCTW3AwBvWn7cz+PlmR5qwWgUFrazAixXI8N
         iRZ6EOgbH0Xln5YqztBsr522UHVYHq3iRZFAfPUc2dCJZ1GWsbYMEQ+Rv//HG3PLRxfd
         8/I1VWC4T+5E8Qtoh9aA7nHVjpvZ/dFNxMGkA=
Received: by 10.231.59.75 with SMTP id k11mr3607776ibh.87.1264377551020; Sun, 
	24 Jan 2010 15:59:11 -0800 (PST)
In-Reply-To: <20100124081513.GA10700@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137928>

On Sun, Jan 24, 2010 at 3:15 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Jan 24, 2010 at 07:04:59AM +0000, Russ Paielli wrote:
>
>> warning: updating the current branch
>> [...]
>> What does this mean in English? And what is the correct way to trans=
fer my
>> revisions from my home computer to my work computer? Thanks.
>
> It means your workflow will cause problems as the pusher magically
> changes your repository's concept of "the latest commit" behind the
> pushee's back. The workflow you want is described here:
>
> =C2=A0http://git.wiki.kernel.org/index.php/GitFaq#push-is-reverse-of-=
fetch

Aside, and I think we've discussed this before, but I wonder if it
would make sense to:

a) Add an option to clone such as "-p [<name>] | --push-as[=3D<name>]"
where <name> defaults to $(uname -n | cut -f1 -d.) This would setup
the cloned repo with a push refspec
"+refs/heads/*:refs/remotes/<name>/*". e.g.:

$ git clone -o host1 -p host2 ssh://host1/~/repo.git
$ cat repo/.git/config
=2E..
[remote "host1"]
	url =3D ssh://host1/~/repo.git
	fetch =3D +refs/heads/*:refs/remotes/host1/*
	push =3D +refs/heads/*:refs/remotes/host2/*

b) The controversial part: make this option the default the default
when cloning from a non-bare repo. There would need to be some way to
turn it off.

Of course, I'm not sure this would be any less confusing for users.
Would they wonder why they have to merge to see their pushed changes
reflected on the pushed-to repo?

It does nicely make push symmetric to fetch between two non-bare repos
though, and I think maybe that makes more sense.

j.
