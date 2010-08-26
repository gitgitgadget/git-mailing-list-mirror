From: Joshua Juran <jjuran@gmail.com>
Subject: Re: setting working dir in posix_spawn() (Re: Fix 'git log' early pager startup error case)
Date: Thu, 26 Aug 2010 00:16:06 -0700
Message-ID: <65AAB642-0AEB-40F3-8C33-81AA2C110D3E@gmail.com>
References: <alpine.LFD.2.00.1008241029530.1046@i5.linux-foundation.org> <20100825013625.GC10423@burratino> <4C74BFA7.1090907@viscovery.net> <4C752739.3010808@redhat.com> <20100826061815.GH9708@burratino>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Eric Blake <eblake@redhat.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Matthias Lederhofer <matled@gmx.net>,
	=?ISO-8859-1?Q?J=FCrgen_R=FChle?= <j-r@online.de>,
	austin-group-futures-l@opengroup.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 09:16:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoWh6-00024r-8e
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 09:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036Ab0HZHQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 03:16:12 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:39062 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841Ab0HZHQK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 03:16:10 -0400
Received: by pxi10 with SMTP id 10so511751pxi.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 00:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=66V+IW9haAzOFp2JM049OmOWiP6plKC3y8Jz3RylpRE=;
        b=UnBBW9OhXqlk+9meCXRypPE1UtT9EatiZk0xwDLHaHojmn7E1SpkEM+4BeYaOJzO/3
         dAUve5wsh/j1dxhwoNZzHIj8AGCTzlNdzaeVsyOxLa8s6KQk1nHxxDw46s0JR/CfNal/
         jcMmQhSlTJDMmNfoq2XG0K8GqOsNmWj4SI2DE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=hTF01NCIZMZYcE2AOhyQsEWTEh0ac0n9Bt/O2XWt4MITcny01xPzsEzwlMky6Y1YC6
         6PRQvvPIH23byOds93TLoj4PHKif/Wk+KyIXNGuNfmx7p+MTWLi8oXoMSB/sSQDKQF6b
         NqaOA7idyGiJ0kz4n4Jcpvcq9t7ibGqk/+MzE=
Received: by 10.142.232.13 with SMTP id e13mr7959437wfh.117.1282806969756;
        Thu, 26 Aug 2010 00:16:09 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id y16sm2555743wff.14.2010.08.26.00.16.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Aug 2010 00:16:08 -0700 (PDT)
In-Reply-To: <20100826061815.GH9708@burratino>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154528>

On Aug 25, 2010, at 11:18 PM, Jonathan Nieder wrote:

> Eric Blake wrote:
>> On 08/25/2010 01:00 AM, Johannes Sixt wrote:
>
>>> Just FYI, posix_spawn() is not sufficiently capable for the  
>>> demands of
>>> start_command(): It doesn't allow to set a new CWD for the spawned  
>>> process.
>>
>> And even if posix_spawn() were capable, cygwin doesn't yet  
>> implement it.
>
> Hmm, okay.  You have access to win32api, though, right?  So it should
> be possible to reuse code from compat/mingw.c::mingw_spawnvpe.
>
> Do you think there would be any interest in a posix_spawn() variant
> that takes a dir parameter?

Another option would be a variant of vfork() where munging file  
descriptors, cwd, etc. prior to exec is well defined.  In Lamp (Lamp  
ain't Mac POSIX), vfork() does this already; in Linux you'd just use  
fork().  The problem is that currently no common interface exists  
which guarantees behavior which is both sufficient and cheap --  
vfork() promises nothing at all, and fork() is expensive (if available  
at all) on some platforms, guaranteeing much more than is often needed.

It would be useful to have something in between vfork() and fork(),  
though I'm not sure what it should be called.

Josh
