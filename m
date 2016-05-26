From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mingw: make isatty() recognize MSYS2's pseudo terminals
 (/dev/pty*)
Date: Thu, 26 May 2016 15:28:29 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605261525400.4449@virtualbox>
References: <f1408371e14ff10539990ad710681ef17f29fea1.1461770158.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Karsten Blees <blees@dcon.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 15:29:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5vLc-0006iE-1c
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 15:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbcEZN3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 09:29:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:64341 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753499AbcEZN3G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 09:29:06 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MAPoQ-1bGKed3D4M-00Bbxs; Thu, 26 May 2016 15:28:29
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <f1408371e14ff10539990ad710681ef17f29fea1.1461770158.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:mnbyfROYBtyRCfjErqejN8D+0+DK6iipqJMlhLtwBkrbb1qrqYd
 sxzU0z9Y3X6/Mamy0yofe8Ebc7ZGj5MvtqirjeZkfGrzKbASweYBnJdaJRlfBk508KEFe+u
 YeUIaPGWJYr6Pf2qMVc/ecFAHUMWp14j+A/6DkNoZxCKES48FeJLMcFYJC/9e6h7Tf7sZMr
 yxQytwTaBfKEKAByVxvxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IMBfZpT3gR8=:oXyVtHjDZ7933qSJ2EM9/X
 8jpfJiQawoLMHvcVKHXjkLqar4UqPFx6qgTYHlX0L5EfUfJjS2YMhe95BLloIBdFwoFYF4fSX
 AOBiNvsimLGKPb8nrj7+rzybCNy6n9ti6Bc8vIDIehDZoJA3TbtK9IW+xCD7k8yWXHa3+h1Z7
 0KmSvKj+u+SR5Rm5D3yOX4Eo29eeeIyILY1tBh07l82OpAiPDTr6iBs0mIN2hmiaFYaOirQ4x
 luS0UCWpH9uGnPWsOdsh9AhRx+Wittx1+NbHHB57wevDJHyjdAdlefT3jQh7DM3L0rzRP9nm4
 QrZFzTl8vHk5JHN8J7MGXyJW0HQy9ZkgCmv4hnTQAnvdnMoQys2Yh56qQuVwVsc0fSeZqMe6V
 TZciJc1lEeSX6FeeDiCOpoWIKrTWFgdxcWOIzcOTJMNbmJ97UvBKdsRrVciGjTvgfqkBhMr/a
 WIZf7F/9m8Q+AhjdIcL+FgImD07pyyKfGt8Dy07DEbgGG7ATaihboWbGWkol8bPFwwEpQfqv9
 t32Qa2zaarwLiVU+EEkLJzpkx9tkXGA7G4fFIR/Mn257NgwISgbB5sGiVEnASYaLWEVIv+dFr
 HCtxacsG0R0RZY0icPzTG/J2ZL9CA9cQqLHRtKH5Im4slcCWKD7MzEQvKYGav4F4IqvAuG78E
 tI8YXdxZZpIzjBkR/mUvRk181YLjpS/cOlddzBq7xqYrsZDiRLqbbxw2/ix7njYMZxfx+RA2x
 L+DjlozLodksrPSMiJwcJhAsoeds0D/z+e3DZZ2GlPZ6ssDPkjfmaus+fz0WPjEl23C8tOcg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295653>

Hi Junio,

On Wed, 27 Apr 2016, Johannes Schindelin wrote:

> From: Karsten Blees <blees@dcon.de>
> 
> MSYS2 emulates pseudo terminals via named pipes, and isatty() returns 0
> for such file descriptors. Therefore, some interactive functionality
> (such as launching a pager, asking if a failed unlink should be repeated
> etc.) doesn't work when run in a terminal emulator that uses MSYS2's
> ptys (such as mintty).
> 
> However, MSYS2 uses special names for its pty pipes ('msys-*-pty*'),
> which allows us to distinguish them from normal piped input / output.
> 
> On startup, check if stdin / stdout / stderr are connected to such pipes
> using the NtQueryObject API from NTDll.dll. If the names match, adjust
> the flags in MSVCRT's ioinfo structure accordingly.
> 
> Signed-off-by: Karsten Blees <blees@dcon.de>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

For the record, this patch is needed to make the output of `git log` *not*
whizz by when running in MinTTY, the default terminal of Git for Windows
and MSYS2.

I do not see this patch in 'pu'... Anything I can do to get this into
'master' eventually?

Ciao,
Dscho
