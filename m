From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH v2] git-p4: avoid syncing duplicate changes
Date: Mon, 23 Feb 2009 18:08:10 +0100
Message-ID: <200902231808.11072.simon@lst.de>
References: <20090128164540.GA2137@padd.com> <200902051624.51636.simon@lst.de> <20090218181214.GA21970@padd.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 18:10:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbeJU-0001ki-Bq
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 18:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbZBWRIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 12:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbZBWRIY
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 12:08:24 -0500
Received: from verein.lst.de ([213.95.11.210]:47852 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069AbZBWRIX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 12:08:23 -0500
Received: from rhea.localnet ([62.70.27.104])
	(authenticated bits=0)
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id n1NH8GIF016324
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 Feb 2009 18:08:17 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.28-8-generic; KDE/4.2.0; x86_64; ; )
In-Reply-To: <20090218181214.GA21970@padd.com>
Content-Disposition: inline
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111158>

On Wednesday 18 February 2009 Pete Wyckoff, wrote:
> When a particular changeset affects multiple depot paths, it
> will appear multiple times in the output of "p4 changes".
> Filter out the duplicates to avoid the extra empty commits that
> this otherwise would create.
> 
> Signed-off-by: Pete Wyckoff <pw@padd.com>

Acked-by: Simon Hausmann <simon@lst.de>


Nice patch, thanks :)

Simon

> Switched to a dictionary to avoid the quadratic behavior,
> as pointed out by Simon.
> 
>  contrib/fast-import/git-p4 |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index a85a7b2..3832f60 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -442,13 +442,14 @@ def p4ChangesForPaths(depotPaths, changeRange):
>      output = p4_read_pipe_lines("changes " + ' '.join (["%s...%s" % (p, 
changeRange)
>                                                          for p in 
depotPaths]))
>  
> -    changes = []
> +    changes = {}
>      for line in output:
> -        changeNum = line.split(" ")[1]
> -        changes.append(int(changeNum))
> +	changeNum = int(line.split(" ")[1])
> +	changes[changeNum] = True
>  
> -    changes.sort()
> -    return changes
> +    changelist = changes.keys()
> +    changelist.sort()
> +    return changelist
>  
>  class Command:
>      def __init__(self):
> -- 
> 1.6.0.6
> 
> 
