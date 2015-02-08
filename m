From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: read() MAX_IO_SIZE bytes, more than SSIZE_MAX?
Date: Sun, 8 Feb 2015 12:09:20 -0500
Message-ID: <CAPig+cTbLOV-0yFKp8wwVLSr4OJz7LUaLZgVGHUdFhj7xZEzrw@mail.gmail.com>
References: <loom.20150207T174514-727@post.gmane.org>
	<54D64939.4080102@web.de>
	<loom.20150207T182443-33@post.gmane.org>
	<54D67662.7040504@web.de>
	<CAPc5daUnKcktv0xcz-fGEApckbkQksKuZO53ZL20E1MhtZmn4w@mail.gmail.com>
	<loom.20150207T232422-706@post.gmane.org>
	<CAPc5daXD_7XZD5Vag51BjrSZ0q1r9eMswhLmnpUFqqjrc9oSTw@mail.gmail.com>
	<loom.20150208T125055-287@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Sun Feb 08 18:09:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKVMN-0000nX-Nw
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 18:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbbBHRJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 12:09:21 -0500
Received: from mail-yk0-f173.google.com ([209.85.160.173]:47757 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbbBHRJV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 12:09:21 -0500
Received: by mail-yk0-f173.google.com with SMTP id 142so9619070ykq.4
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 09:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=V+hWRA1ZFp4QsmzSlpno0SASvvmzYPoH/czF6faHBlQ=;
        b=jFGXyEHp0YEmtIEd+TeZC7Vb1WeurBTZDbAVCnEMU5EpIxf4okwZOvRJlTBskA02vi
         Xhb/d0UBxnao3uKFDqzP2fl0VuCj7mChaF7otvcQlJmkv5MwN2bqCXyoQtfD2JRAmzYz
         +mIaVPeAd3A42nZsVCkAYoCK874me03gWNDsKMytNOw/mDF2EQwkE8TNXS150gdF6Yl+
         hlm569Nu4DF6vbcsb/97w6K0ayvn10UoR0GokQY0In/kiutRHPhHJZFY9WN9pp6lU0ri
         IpJDsdcosSa/C0VLl0HCDU2FDJx0HL7ZNtIJhop7aiqqJyJdyvg+ZsqBcmXHoy30+PIL
         RWBQ==
X-Received: by 10.236.10.5 with SMTP id 5mr4716274yhu.148.1423415360341; Sun,
 08 Feb 2015 09:09:20 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Sun, 8 Feb 2015 09:09:20 -0800 (PST)
In-Reply-To: <loom.20150208T125055-287@post.gmane.org>
X-Google-Sender-Auth: hM8k9D_zMu64diHWJ9MlML_C0VA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263528>

On Sun, Feb 8, 2015 at 7:05 AM, Joachim Schmitz <jojo@schmitz-digital.de> wrote:
> Junio C Hamano <gitster <at> pobox.com> writes:
>>  (1) if Makefile gives one, use it without second-guessing with SSIZE_MAX.
>>  (2) if SSIZE_MAX is defined, and if it is smaller than our internal
>> default, use it.
>>  (3) all other cases, us our internal default.
>
> oops, yes, of course
>
> /* allow overwriting from e.g. Makefile */
> #ifndef(MAX_IO_SIZE)
> # define MAX_IO_SIZE (8*1024*1024)
>   /* for plattforms that have SSIZE and have it smaller */
> # if defined(SSIZE_MAX) && (SSIZE_MAX < MAX_IO_SIZE)
> #  undef MAX_IO_SIZE /* avoid warning */
> #  define MAX_IO_SIZE SSIZE_MAX
> # endif
> #endif

A bit cleaner:

#ifndef(MAX_IO_SIZE)
# define MAX_IO_SIZE_DEFAULT (8*1024*1024)
# if defined(SSIZE_MAX) && (SSIZE_MAX < MAX_IO_SIZE_DEFAULT)
#  define MAX_IO_SIZE SSIZE_MAX
# else
#  define MAX_IO_SIZE MAX_IO_SIZE_DEFAULT
# endif
#endif
