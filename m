From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [BUG] Git add <device file> silently fails
Date: Sat, 17 Apr 2010 20:23:26 +0200
Message-ID: <v2o81b0412b1004171123z20c2c042qabb2b76143390a36@mail.gmail.com>
References: <201004171624.17797.agruen@suse.de>
	 <u2s81b0412b1004170744u4cc3c0e1z6d7019fe405a67ec@mail.gmail.com>
	 <7v4oja3uh7.fsf@alter.siamese.dyndns.org>
	 <n2i81b0412b1004171032v713f156ase295cbe7bbedf1f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 20:23:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Cg7-00076g-IO
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 20:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765Ab0DQSXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 14:23:31 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:48477 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab0DQSXb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 14:23:31 -0400
Received: by ywh32 with SMTP id 32so1927129ywh.33
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 11:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=SG4XOJoqBOxJWfEoqOlRgM0tTcuwhi1C/HybChpODOA=;
        b=Cc5BO7op4fdadsMz7ccQ4EgZZYj3ylc6eRcOaweFUshkjUgJLpnhhn2UJsyXaIppYo
         ovlPZWS5/8fGIXkdjWg9EllkNvsC/L8NahQ5m+E08F1gQj/MoIDLNx3PVSkJnRnDV3vi
         eE+iwYZemArPrtGBhrMJTN7Uucr6dO3e8bjYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rPpAZnmiXGkw3uSw0vtKPMj0LCPK5PK95AxAGKmMKXwEexQNhiKRnv2lM1chIJve/w
         p8Iu7G9lQwf11o/qkeY0SVUZLVb6t6lkC4UKPix8Vz7OtIeH/9S4y9dEK1bei7rCTmvo
         gNAdvYBG9IiCDVYPZdiNAq4fZk42r8b+0/6Vs=
Received: by 10.100.212.9 with HTTP; Sat, 17 Apr 2010 11:23:26 -0700 (PDT)
In-Reply-To: <n2i81b0412b1004171032v713f156ase295cbe7bbedf1f6@mail.gmail.com>
Received: by 10.101.160.24 with SMTP id m24mr7509030ano.222.1271528608462; 
	Sat, 17 Apr 2010 11:23:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145168>

On Sat, Apr 17, 2010 at 19:32, Alex Riesen <raa.lkml@gmail.com> wrote:
> On Sat, Apr 17, 2010 at 18:38, Junio C Hamano <gitster@pobox.com> wrote:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>>
>>> I think something like this should make the accident more
>>> noticable:
>>
>> The early skippage done in dir.c (read-directory-recursive) should treat
>> these as ignored just like paths that are ignored with .gitignore
>> mechanism, and if we do so, we shouldn't need this patch to add another
>> codepath to give notification to the user (we would however still need
>> to reword "'add -f' if you really want to add it", though).
>>
>
> I see. Special files are not treated as ignored yet (and there will be
> no way to un-ignore them). I have to read the code for a while,
> ignored pathnames are sometimes stored for later use too.
>

I am tempted to add a mode_t or DT_something to struct dir_entry.
Users of read_directory are likely to do an lstat anyway (well,
builtin/add.c does), and sometimes there is something to fill it with
(get_dtype for DT_UNKNOWN). The only problem is that the structure
is allocated a lot...
