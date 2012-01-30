From: Shawn Pearce <spearce@spearce.org>
Subject: Re: How often does git calculate SHAs?
Date: Mon, 30 Jan 2012 06:59:55 -0800
Message-ID: <CAJo=hJtEPTPTwdoFaoZH4OBpfnCR3VDUNGdNtCprmPf=13xrdQ@mail.gmail.com>
References: <4F26A864.1080702@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael Cook <mcook@bbn.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 16:00:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrsik-0003G5-CU
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 16:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758Ab2A3PAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 10:00:18 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48171 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748Ab2A3PAP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 10:00:15 -0500
Received: by dadi2 with SMTP id i2so3613730dad.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 07:00:15 -0800 (PST)
Received: by 10.68.234.199 with SMTP id ug7mr42248888pbc.6.1327935615078; Mon,
 30 Jan 2012 07:00:15 -0800 (PST)
Received: by 10.68.50.10 with HTTP; Mon, 30 Jan 2012 06:59:55 -0800 (PST)
In-Reply-To: <4F26A864.1080702@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189366>

On Mon, Jan 30, 2012 at 06:25, Michael Cook <mcook@bbn.com> wrote:
> How often does git actually calculate a file's SHA?
>
> `strace git status` shows that git stat'ed many files, but opened only a
> few. So I assume git has some heuristicsbased on the stat infofor when to
> recalculate the SHAs.
>
> Any pointers to how I could have figured this out myself from looking at the
> source code would be appreciated. Google wasn't helpful.

During `git status` Git performs an lstat() of every file in the
working tree. If the file matches stat structure data with the cache
held in .git/index, Git assumes the file is unmodified.

Things Git are looking for is usually size, mtime, inode number,
creation time, etc.
