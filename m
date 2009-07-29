From: demerphq <demerphq@gmail.com>
Subject: Re: Adding files to a git-archive when it is generated, and whats the 
	best way to find out what branch a commit is on?
Date: Wed, 29 Jul 2009 11:21:32 +0200
Message-ID: <9b18b3110907290221o8afc72s157969ef7d707d4d@mail.gmail.com>
References: <9b18b3110907290115v1f30eeat748631bb09f92517@mail.gmail.com>
	 <adf1fd3d0907290141v24cf129eue3939bf1afd518d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 11:21:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW5Lz-0007pc-Pf
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 11:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbZG2JVe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 05:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbZG2JVd
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 05:21:33 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:58960 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbZG2JVc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 05:21:32 -0400
Received: by gxk9 with SMTP id 9so1201435gxk.13
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 02:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RAQvHDYXZ644/E02NpxiJEYCSY+8KbmxPNJ8XVvYAQk=;
        b=JPjMWxYrtuJmzg/T+AuL0OQtVNiH4KRDG5M3Qwjko0OsNluf44S6IxQgIe6U00Azoq
         w+IDm59vuLRfWruF5u8xoGBO1s0MlhI35wkE6xYwJy+B2Xs/mvTQFYLiWaY1Z+UI9N8B
         tjja56SaXskubv6H+rWFsfLTM1uqj1eK1OJn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ord+8W2MJeHxg4bydiQnzvpqNKjckB6/gRol5eCfp/8z44yWOasVtyFlVjcDafIXnt
         WnVLzig8yQF2u24QJgodPhZKO63nFVPo7dGwLEwN/V7jpdYc5r7QvWgG08j8C5beI20Z
         gY5Pzb5jLv3OxRDR18jrcmHMRGtq49osdCh0w=
Received: by 10.231.11.136 with SMTP id t8mr2788716ibt.50.1248859292058; Wed, 
	29 Jul 2009 02:21:32 -0700 (PDT)
In-Reply-To: <adf1fd3d0907290141v24cf129eue3939bf1afd518d2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124335>

2009/7/29 Santi B=E9jar <santi@agolina.net>:
> 2009/7/29 demerphq <demerphq@gmail.com>:
>> I was wondering if anybody had any suggestions on a sane way to add =
a
>> file to a git-archive when it is being produced.
>>
>> For =A0instance build procedures that expect to be run inside of a g=
it
>> WD wont work if built from an archived version of the tree. Being ab=
le
>> to provide a file of additional data to the archive package would be=
 a
>> very convenient way to work around this.
>>
>> Ideally id like to be able to specify a set of additional files to
>> include in the archive as part of the git-archive command line
>> interface, but I'd be nearly as a happy with almost any solution oth=
er
>> than the one I came up with, which is to use archive to generate a t=
ar
>> file, then use tar to append the additional files to the tar, and th=
en
>> compress it. This process turns out to be quite slow in comparison t=
o
>> producing a compressed archive directly from git-archive.
>
> Then I don't know. It is exactly the way it is done in git.git itself=
,
> look the dist target in the makefile.

So then git also would benefit from support in git-archive for adding
arbitrary files to the archive during generation?

One problem here is that we (the Perl project) are supporting VMS
smoke-testers and need the ability to provide snapshots that are
buildable without using git at all. So we hacked the snapshot support
in gitweb to do this. However we dont want to do this for every
commit, just the ones that people actually fetch. So while the process
we use is fine for rolling a dist, its not so fine when people are
expecting a download to start promptly after clicking on the snapshot
link.

>
>>
>> Another question is whether anyone has any advice on the best way to
>> find out the "best" branch an arbitrary commit is on. Where best can
>> be flexibly definied to handle commits that are reachable from
>> multiple branches. =A0I have hacked a solution involving git-log and
>> grep, but it performs quite poorly. I was wondering if there is a
>> better solution.
>
> The "best" tag is easy: git describe commit. For branches I think you
> could use "git name-ref --refs=3Drefs/heads/* commit", because git
> describe does not have a --branches flag.

Dang, I guess this is from a newer release than mine. So now i have an
excuse to upgrade.

:-)

Yves




--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
