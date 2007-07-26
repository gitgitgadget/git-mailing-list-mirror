From: David Kastrup <dak@gnu.org>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 20:13:32 +0200
Message-ID: <8564478243.fsf@lola.goethe.zz>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	<46A8378A.6050201@xs4all.nl>
	<Pine.LNX.4.64.0707260737170.14781@racer.site>
	<f329bf540707260002p117937tc9bc70050ef87838@mail.gmail.com>
	<fcaeb9bf0707260429l327f446bq73a8a0a13cd77cf1@mail.gmail.com>
	<46d6db660707260521u15c2bd85j806d48e0f51a3b9@mail.gmail.com>
	<fcaeb9bf0707260537y4233abaamadf4cb6190ea0eeb@mail.gmail.com>
	<Pine.LNX.4.64.0707261534550.14781@racer.site>
	<fcaeb9bf0707260807u476719e3rec2dcf5f780013c0@mail.gmail.com>
	<Pine.LNX.4.64.0707261638100.14781@racer.site>
	<fcaeb9bf0707260911y4091b525kc6b89beb82ec7dc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 20:13:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE7qQ-0002Zp-Tn
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 20:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932832AbXGZSNq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 14:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbXGZSNq
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 14:13:46 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:54244 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762004AbXGZSNo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2007 14:13:44 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 03FEF32EF4D;
	Thu, 26 Jul 2007 20:13:38 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id D8EBC279437;
	Thu, 26 Jul 2007 20:13:37 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-079-089.pools.arcor-ip.net [84.61.79.89])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id ADC1A3425E3;
	Thu, 26 Jul 2007 20:13:37 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 128441C39595; Thu, 26 Jul 2007 20:13:32 +0200 (CEST)
In-Reply-To: <fcaeb9bf0707260911y4091b525kc6b89beb82ec7dc7@mail.gmail.com> (Nguyen Thai Ngoc Duy's message of "Thu\, 26 Jul 2007 12\:11\:20 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3776/Thu Jul 26 17:41:16 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53851>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On 7/26/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>> On Thu, 26 Jul 2007, Nguyen Thai Ngoc Duy wrote:
>>
>> > I make MinGW busybox part of git for some reasons:
>> >
>> > - Making a full MinGW busybox would take lots of time. I don't need
>> > busybox for Windows. What I need is a shell and enough POSIX utilities
>> > to run git shell scripts without any dependencies. Windows users
>> > (including myself when I have to use Windows) hate dependencies.
>>
>> I think that if you succeed to compile ash on MinGW, the rest is easy.
>
> No it's not. With a couple of ifdefs you can compile it fine. Then
> there goes fork(), fcntl(F_DUPFD), /dev/*, job/signal handling...
> Fortunately Git does not use lots of features. It only needs
> /dev/null (and /dev/zero for tests), SIGEXIT and no job usage.. That
> cuts down the effort porting ash.

And here I was tempted to multithread builtin-update-index.c: it is
actually quite natural to let one process scan directories
non-recursively, stat the files, sort them on a per-directory grain
and feed a sorted pseudo-index into a pipeline (recursing to scanning
whenever hitting a directory), then let another process/thread do a
merge-pass of pseudo-index and real index, immediately writing the
output to a new index-to-be.  When this is finished and another
process invalidated the old index already, reuse the index-to-be as
pseudo-index and merge it with the new-index-which-got-in-ahead-of-me.

Would be a fun exercise in particular when merely using
(block-buffered!) pipes, and could presumably make a difference on
multiprocessor-capable machines.

Anyway, just something that had been spinning in my head.  The
"streaming merge" idea has the advantage of keeping memory usage low
pretty much independently of project size: project memory is pretty
much determined by the reader pass since it has to read in a complete
directory level before it can sort it and output the next element, and
it has to retain the not-yet-output elements of the ancestry.

And it is nice to have some potential for parallel processing.  But if
it is a lethal stumbling block for Windows...  It is conceivable to do
the same job instead of with pipes and files with buffers and just
switch manually between the directory scanning and merging phases.
But it would be less fun.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
