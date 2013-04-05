From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Beyond inotify recursive watches
Date: Fri, 5 Apr 2013 22:26:15 +0530
Message-ID: <CALkWK0ngNM-zrybHOtFGzm5aVnkFMPn1DP0h=2aUf=7b9_sh8A@mail.gmail.com>
References: <CALkWK0nRQi+vZeVR4LVzLewhR-dUZqYANRV7yH8grp-1J7=g8Q@mail.gmail.com>
 <20130405155534.GC21852@quack.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-kernel@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jan Kara <jack@suse.cz>
X-From: linux-kernel-owner@vger.kernel.org Sat Apr 06 19:11:19 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1UOWL6-0002u6-3T
	for glk-linux-kernel-3@plane.gmane.org; Sat, 06 Apr 2013 18:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162240Ab3DEQ5U (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 5 Apr 2013 12:57:20 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:56572 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162136Ab3DEQ44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Apr 2013 12:56:56 -0400
Received: by mail-ie0-f173.google.com with SMTP id 9so4596906iec.4
        for <multiple recipients>; Fri, 05 Apr 2013 09:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=TH9gH5YHZIrNSjGlp0/QH5b1PSisaPgy0bHOq2MUj9M=;
        b=pInL3FpivxzKQMHU59tPYU2kZdyhqai8atSLvbLLz9eUipsbbkKJVgJAy5hUS+2taR
         bhIrr9Zq1tzUFCAfw1X8hHHJia3+q0789Oel64FQF9YBDtSV0avjS8N3jbEqgbi13dRi
         yWEXJba3NyG1QMKH9L7IOu6YFwqsc9dNAWF4iwbSw+CQvQtPSJj9XNyw+P5d4kg/St8X
         hyGPqUmC5L+rpF0dFInb5PzxRzHPiT7ieQR2mR+0J/eKuOcoSt/a5Dsbomu73ryg8f74
         ryEiehUfllkL0LfGj45yNrXp44fvxKC9kYVMdPDV2pXkPoGhY9/aEZLg3M1FmtU67sW3
         adOA==
X-Received: by 10.50.50.71 with SMTP id a7mr2094344igo.14.1365181015511; Fri,
 05 Apr 2013 09:56:55 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Fri, 5 Apr 2013 09:56:15 -0700 (PDT)
In-Reply-To: <20130405155534.GC21852@quack.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220195>

Jan Kara wrote:
>   Hum, I have somewhat hard time to understand what do you mean by
> 'magically optimized syscalls'. What should happen in VFS to speedup your
> load?

In retrospect, I think this is a terrible hack to begin with.  Tuning
the filesystem specifically for git repositories is inelegant on so
many levels, I can't recall why I ever thought it would be a good
idea.  Like all software, Git has scaling issues with ultra-large
repositories.  Too many stat() calls is just one of the problems:
there will be too many objects to do any operation at reasonable
speed, and the overall UX would just suck.  Instead of growing to a
huge monolithic beast that spawns off worker threads for everything
and ultimately dying off, I've decided that git should take a
different direction: it should work with well with many small
easily-composable repositories.  I've started work on this already,
and it looks very promising.

Let the filesystem people do what they do best: optimizing for all
applications uniformly.
