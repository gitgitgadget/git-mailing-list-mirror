From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Makefile: do not compile git with debugging symbols by
 default
Date: Tue, 27 Jan 2015 00:43:39 -0800
Message-ID: <20150127084338.GA37443@gmail.com>
References: <1421931037-21368-1-git-send-email-kuleshovmail@gmail.com>
 <20150122130036.GC19681@peff.net>
 <CANCZXo7ocgG27Y48NjYxurVMWOvHkvGqDrLuntkSTxHUK6hcNw@mail.gmail.com>
 <vpqa91ahg46.fsf@anie.imag.fr>
 <20150122183538.GA20085@peff.net>
 <20150122225517.GB31912@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Alexander Kuleshov <kuleshovmail@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Jan 27 09:43:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YG1kV-0001UB-2M
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 09:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559AbbA0Inr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 03:43:47 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35601 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbbA0Inp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 03:43:45 -0500
Received: by mail-pa0-f53.google.com with SMTP id kx10so17165737pab.12
        for <git@vger.kernel.org>; Tue, 27 Jan 2015 00:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nH78c7KjhgbklBq1q70TqYfmu388M5W+LhzeC27A1Q0=;
        b=nIqdyQM8kt+/D0U9T1HW4RMCZI6+CDy3tt6JsXqlQBiAiFmgvfQb6SRvOhE0lsBTt0
         f+0V5n+ixURr0oOB1VNH7gBk+JlBrhINDRB51Chr7auGL7HdhpAVppnhhe62jR37WA9o
         /hYOMQYC8pevjBHH3Fn/YpDxUm6pWvIgovLjNFeL3n2PMdFx9BQc0dCWCYN9E1/8LSyH
         z1pitHveIhC0fL+wEuTwVSVT33ZOVVbaco3hjaaV+ShrRBaKetToTJhdaP8u22s8QMf1
         gsTa3hVRaX/7/bCYues1Q+GA243kcUcxUHIJ4w2KiFc615yBh9hK2qOjaWI+LuVrYeS1
         DBXw==
X-Received: by 10.66.184.48 with SMTP id er16mr31202pac.61.1422348225082;
        Tue, 27 Jan 2015 00:43:45 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id ej7sm860040pac.21.2015.01.27.00.43.43
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 Jan 2015 00:43:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150122225517.GB31912@glandium.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263062>

On Fri, Jan 23, 2015 at 07:55:17AM +0900, Mike Hommey wrote:
> On Thu, Jan 22, 2015 at 01:35:38PM -0500, Jeff King wrote:
> > On Thu, Jan 22, 2015 at 06:36:41PM +0100, Matthieu Moy wrote:
> > 
> > > > Yes, main point is size of executable.
> > > 
> > > The Git executable is a few megabytes, i.e. 0.001% the size of a really
> > > small hard disk. The benefit seems really negligible to me.
> > 
> > I don't know the layout of the symbols with respect to the code, or
> > whether the stripped version might reduce memory pressure. So in theory
> > it could have a performance impact.
> 
> It doesn't. Debugging info is in a part of the file that is not mapped
> in memory, and in a part that can be removed without affecting the rest
> of the file, so it's more or less at the end.

It goes even further.  These days Fedora systems strip debug
info out into separate files and packages while creating rpms
debuginfo packages are created automatically and provide
debuginfo files under /usr/lib/debug, where gdb knows to look by
default.

Alexander, one nice thing about the Makefile is that it supports
you creating a file in your Git worktree called "config.mak"
with the following content:

CFLAGS = -O2 -Wall

If you do that then git will build without debug info and you
won't have to specify CFLAGS when invoking "make".
Hopefully that's easy and convenient enough.

cheers,
-- 
David
