From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Sun, 10 Feb 2013 22:35:46 +0700
Message-ID: <CACsJy8CsV9JtgQ60k4gV_P5qi+Uw9zP=By7cpCFxNSLVqrBcog@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
 <20130210111732.GA24377@lanh> <CANgJU+WYSD8RHb19EP0M89=Y_XskfjDtFWf51qjg4ur+rDb3ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 16:36:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4YxO-0007W5-QE
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 16:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886Ab3BJPgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 10:36:19 -0500
Received: from mail-oa0-f54.google.com ([209.85.219.54]:61737 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755772Ab3BJPgT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 10:36:19 -0500
Received: by mail-oa0-f54.google.com with SMTP id n12so5496851oag.27
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 07:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6ir5gqJc6hP3PFxRMCgdv2oHdYhHKIZ8EYE9T3+fu3I=;
        b=sp1J6HC/13+wQ5eeVYkctkx2Pz0AhDW1YK4xoX3GhsHBPYoUVpcLqHLH2nYwHSCjbf
         360GTASfQYRTfIxD9gZs3tpsBjQAwE3WSsgoPlya1wbB8imFe4sig/HrmWStr06zgLnj
         FFNysH8r7W6du69BMAfPIafk+y8cfun8eVGcnqlwTuSrGqoa9PFPVhc1EVXrik2p6SHg
         DjANvkhhI8cucRVcDQD1y26iRbG03qnlmPJ95BobXbNqBYzEBrf5sFtfxhzKdGetoMoR
         JoqUBnk5F5YGDca7PNaJyfctNum8A05xhmAZMmqw/P2OOjqBmWamLkWJSjfduJYmbDDD
         G3HQ==
X-Received: by 10.182.43.103 with SMTP id v7mr8599556obl.17.1360510576740;
 Sun, 10 Feb 2013 07:36:16 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Sun, 10 Feb 2013 07:35:46 -0800 (PST)
In-Reply-To: <CANgJU+WYSD8RHb19EP0M89=Y_XskfjDtFWf51qjg4ur+rDb3ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215922>

On Sun, Feb 10, 2013 at 8:26 PM, demerphq <demerphq@gmail.com> wrote:
> On 10 February 2013 12:17, Duy Nguyen <pclouds@gmail.com> wrote:
>> Bear in mind though this is Linux, where lstat is fast. On systems
>> with slow lstat, these timings could look very different due to the
>> large number of lstat calls compared to open+getdents. I really like
>> to see similar numbers on Windows.
>
> Is windows stat really so slow?

I can't say. I haven't used Windows for months (and git on Windows for years)..

> I encountered this perception in
> windows Perl in the past, and I know that on windows Perl stat
> *appears* slow compared to *nix, because in order to satisfy the full
> *nix stat interface, specifically the nlink field, it must open and
> close the file*. As of 5.10 this can be disabled by setting a magic
> var ${^WIN32_SLOPPY_STAT} to a true value, which makes a significant
> improvement to the performance of the Perl level stat implementation.
> I would not be surprised if the cygwin implementation of stat() has
> the same issue as Perl did, and that stat appears much slower than it
> actually need be if you don't care about the nlink field.

The native port of git uses get_file_attr (in
compat/mingw.c:do_lstat()) to simulate lstat and always sets nlink to
1. I assume this means git does not care about nlink field. I don't
know about cygwin though.

> Yves
> * http://perl5.git.perl.org/perl.git/blob/HEAD:/win32/win32.c#l1492
-- 
Duy
