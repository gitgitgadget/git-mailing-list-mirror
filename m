From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/RFC 2/2] sha1_file: set packfile to O_CLOEXEC at open
Date: Fri, 02 Oct 2015 12:08:24 +0200
Organization: gmx
Message-ID: <16e4ef29524283f51b2fa00e536cf153@dscho.org>
References: <1443670163-31193-1-git-send-email-max@max630.net>
 <1443670163-31193-3-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Fri Oct 02 12:08:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhxGa-0002Xq-3L
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 12:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbbJBKIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 06:08:35 -0400
Received: from mout.gmx.net ([212.227.15.15]:59184 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbbJBKId (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 06:08:33 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MK17F-1Zh7me39Of-001P8X; Fri, 02 Oct 2015 12:08:25
 +0200
In-Reply-To: <1443670163-31193-3-git-send-email-max@max630.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:2tiQiVlDTo1pw2RqyMCqnSFGqs7Oj/+jgB5dhNJcAUdYTS39vaP
 cv4L+y/VrpJ2n06/sjf5O3yHkyM0+nIfqV1vW/o/g8zOjcz72Vye4ucdwSEGwAUnoJgfnlp
 gQA9fDQBa7ZPgQcHhFnAKiRhXzZK/ThryToNWUQvU392bBszr2mda7J+9UWPeIv0JGuEXkm
 LwwEoT6FTE6VUobW+eMzQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:08NqgkmxLtQ=:7Y0W16DjxcGr0nybmjlXMX
 8rXtiPyNoH9z4F3iGzttq9VtHQnP5QQYQoQX6mDZt7hHVF6j1we4iV6zGIu3cxv6iq7Nd2EpY
 c79BiOopgQMkxsJS+sTcNrP7mb4PtL1Ddg2775wyL6QITqiXVcCjijtxlXzf1wVSMtG4QiNL7
 09uJb4ioAIefqObe61KrxmUYjQWRku23rg1DRfIU3M0/Xi4oIJQILUgR9iSH0HzADH5yrNMVu
 W+ABqf+xRHSl+VZTVU136OO5YfoqrVLM5EXPJnvD7gZtv31Vm+N9RrD9wavCnucZ5rC64v4oK
 yMre1Z9lGQEyq6Ey9bQM03R5D3qFiIu0klGdZkgC/onxMtQlS5yijXgdrpiixVWNsX6b8mQFs
 7DCKqJQ9Me9I+7f043G97MJm3MqAteXYE7vm09qmerOp94ljMWoTGYCOxLO9gL0l5uHvTy8rr
 cUZM2RBVOSNUICPsuGOEKKc/MJdAgxdrpj142Jh4Vg4HlLbMjgBCvm3X/fQeHTz+LboQQVRPy
 6J/ncEErxeJuxg4BlUB98xeMfpAeEA19eIlb26SKQa91fBk4Dhyp9CzYyo54dfJdaxUUPCGVb
 NVYJ8H34JK7mcmyB6FU3Hr1ioZ9a7Ws7nccaM2/hdGBmslk894lks0FxmV1SZuCy4qJ8PWnfc
 N3cEzV3PK+YnccjC9Qm/lWdGNBHYUp/P5eZS6ZyJqdGD3jwp7e0rkeJjm3vkmBBfxWHtaGAWZ
 YrV++LXgRZbJ8qmgYus7e495BdjRIaaDzQT1vgwe9QS3VIR4ZNeqnvBb2HhXxWdf0kGyFoh3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278911>

Hi Max,

On 2015-10-01 05:29, Max Kirillov wrote:
> Windows does not support setting O_CLOEXEC by fcntl,
> but there is an open flag O_NOINHERIT which results in same
> behaviour. Use it in git_open_noatime() and also bring
> setting O_CLOEXEC there also to make it consistent. Rename
> the function to git_open_noatime_cloexec(), to avoid confusion.

Which problem does this solve? I am actually suspecting that this will rather cause problems because now `exec()`ing children might cause bogus file descriptors to be still held on.

So I would recommend to drop this patch. It is not needed to fix the reported bug.

Ciao,
Dscho
