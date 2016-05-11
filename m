From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] perf: let's disable symlinks on Windows
Date: Wed, 11 May 2016 10:09:14 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605110857510.4092@virtualbox>
References: <cover.1462894344.git.johannes.schindelin@gmx.de> <alpine.DEB.2.20.1605101738390.4092@virtualbox> <xmqqoa8dofmu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 10:10:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0PE5-0004n8-5w
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 10:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbcEKIKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 04:10:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:54820 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbcEKIKb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 04:10:31 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0McluX-1bIDBp1EP3-00Hxep; Wed, 11 May 2016 10:10:24
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqoa8dofmu.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:UXxlQSAzpnel21lGIbl/kT3q3solAhm4BwhHuEmMwPiJLeaoWID
 PGh74AIATIpz2KdsCiECbgb1VxyV16AgwAFVD6Qw5vr38ODd8TIGRL2GJV9+zFfl/lH7eLt
 rvnyluyYMYSgxbyJ3S4L+WVgtrzk2s8xlYJuJ3tLp0m+uC9fhLPiKO/NSrt9UqGq0yFMzac
 1AD9WMPyqigSOe8odFw2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5/JFhuHEYKc=:8dK2vFJwBv38bh+Zoj7QUi
 m4ABb53DtkPLxh9wZxS97O+7xdNOjEcj/OsW3o7LWLAsR1fWRt0t73TZS2w1UCV0E5xbyu02m
 CoUFpedkoL7AISs3RJTT+rHOrEQv8F9tWEqY5o6Qk8qhPR/K2WcTx0vOKU9OAFrynWYqUP1O7
 YvDDgnnBU4LmYulA+O0ILPwsgzybmjPyAFhzrdYbnaDlvTH3yQ/lEVnjg+JdbLB0VKuAxXVrF
 HkbFFRgJv8TCp1qLULWlj2G5Zy4mrN4LAE0kdeSnF/uolD9RLsPw899SrHOjKEs7GGs5bYi2q
 PABZnkSmQfnGYKrFor51R5WQlPYTG9D/hIC6Uog7esorNkPWZf/jcxFXtto5yjLCwlGOZBJQa
 jlO68SeVDUE8t9xfo/Eyta/b6u1LIoHXWTKVbPRUF2ut/I1Rcroo+1IKsAFN5ueXNoCzT47E+
 PPtyWCP+HjCQtO+1wGfuVo4XW9alOkdgMNdVBg6Pxbzlimq7j9dGJ1fQe6vQ4XdvpsPjHkBqx
 oix8T5dBjXjp3TCYOV6IJpqKxJlwr6xi9W8muyppJWWmc6Apfxwt1PDLsdxg4eGjTOrkwsK+q
 YsXJHNVjaS+oLIDvIKHaQzr8YOq2HwUalipr2BmDcPVSZbiw4tmkfAag8tM2pHrfuBJFFc84F
 tDZ7OvIo78F6VN7LAytKXIP7qFjYRjVybGfDh0BCo3M8rxci1n/PuOTFbixCoXTVaB4esxN+r
 d0pre5yamxjHYQsqL+NVQMkmqceLqFjAYuG1yVFuq+rOnwt+J0OQv7KFPQsd7Lrn+7OP6zdX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294236>

Hi Junio,

On Tue, 10 May 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > In Git for Windows' SDK, Git's source code is always checked out
> > with symlinks disabled. The reason is that POSIX symlinks have no
> > accurate equivalent on Windows [*1*]. More precisely, though, it is
> > not just Git's source code but *all* source code that is checked
> > out with symlinks disabled: core.symlinks is set to false in the
> > system-wide gitconfig.
> >
> > Since the perf tests are run with the system-wide gitconfig *disabled*,
> > we have to make sure that the Git repository is initialized correctly
> > by configuring core.symlinks explicitly.
> 
> Is MINGW the right prerequisite to use here, or is SIMLINKS more
> appropriate?

Oh, you're absolutely correct! It has nothing to do with MINGW itself, of
course.

Fixed in v2,
Dscho
