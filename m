From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] mingw: introduce the 'core.hideDotFiles' setting
Date: Wed, 4 May 2016 17:18:01 +0100
Message-ID: <572A20B9.7060301@ramsayjones.plus.com>
References: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 18:18:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axzV9-0002Y9-JJ
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 18:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbcEDQSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 12:18:11 -0400
Received: from avasout08.plus.net ([212.159.14.20]:54903 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbcEDQSK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 12:18:10 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout08 with smtp
	id qGJ41s0042D2Veb01GJ5eZ; Wed, 04 May 2016 17:18:07 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=O6PEx0JW c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=mK_AVkanAAAA:8 a=FP58Ms26AAAA:8 a=pGLkceISAAAA:8 a=7utS9kfsMDNHgE2XvswA:9
 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293552>



On 04/05/16 15:40, Johannes Schindelin wrote:
> From: Erik Faye-Lund <kusmabite@googlemail.com>
> 
> On Unix (and Linux) it is common that files and directories whose names
> start with a dot are not shown by default. This convention is used by Git:
> the .git/ directory should be left alone by regular users, and only
> accessed through Git itself.
> 
> On Windows, no such convention exists. Instead, there is an explicit flag
> to mark files or directories as hidden.
> 
> In the early days, Git for Windows did not mark the .git/ directory (or
> for that matter, any file or directory whose name starts with a dot)
> hidden. This lead to quite a bit of confusion, and even loss of data.
> 
> Consequently, Git for Windows introduced the core.hideDotFiles setting,
> with three possible values: true, false, and dotGitOnly, defaulting to
> marking only the .git/ directory as hidden.
> 
> The rationale: users do not need to access .git/ directly, and indeed (as
> was demonstrated) should not really see that directory, either. However,
> not all dot files should be hidden, as e.g. Eclipse does not show them
> (and the user would therefore be unable to add, say, a .gitattributes
> file).
> 
> In over five years since the last attempt to bring this patch into core
> Git, this patch has served Git for Windows' users well: no single report
> indicated problems with the hidden .git/ directory, and the stream of
> problems caused by the previously non-hidden .git/ directory simply
> stopped.
> 
> Initial-Test-By: Pat Thoyts <patthoyts@users.sourceforge.net>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> 	Let's try this again (I will not point you to the previous
> 	submission, out of personal embarrassment).
> 
> 	This patch has served us so well in the Git for Windows project
> 	that there is little sense in hiding it from core Git.
> 
>  Documentation/config.txt |  6 ++++++
>  builtin/init-db.c        |  1 +
>  cache.h                  |  7 +++++++
>  compat/mingw.c           | 38 ++++++++++++++++++++++++++++++++++++++
>  config.c                 |  8 ++++++++
>  environment.c            |  1 +
>  git-compat-util.h        |  4 ++++
>  t/t0001-init.sh          | 30 ++++++++++++++++++++++++++++++
>  8 files changed, 95 insertions(+)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 42d2b50..a9f599d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -269,6 +269,12 @@ See linkgit:git-update-index[1].
>  +
>  The default is true (when core.filemode is not specified in the config file).
>  
> +core.hideDotFiles::
> +	(Windows-only) If true (which is the default), mark newly-created

The patch (if I'm reading it correctly) and the commit message indicate that
the default is 'dotGitOnly'.

> +	directories and files whose name starts with a dot as hidden.
> +	If 'dotGitOnly', only the .git/ directory is hidden, but no other
> +	files starting with a dot.
> +

ATB,
Ramsay Jones
