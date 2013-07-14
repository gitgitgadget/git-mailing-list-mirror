From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] diff-no-index: Remove unused variable.
Date: Sun, 14 Jul 2013 15:07:39 -0700
Message-ID: <20130714220739.GC13444@google.com>
References: <1373837749-14402-1-git-send-email-stefanbeller@googlemail.com>
 <1373837749-14402-3-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 00:08:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyUSe-0004yp-IO
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 00:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351Ab3GNWHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 18:07:50 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35198 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299Ab3GNWHu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 18:07:50 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so10501183pac.40
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 15:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1gDbTAI6CdvYqeqDEVQ3H42LFJHmsP6vUobGF2o/qQ4=;
        b=gWo8aU6uK/iGeO5xP6afy9Xl1ng1QcU34yvqB7c6hc21tM1jKz2tIYEaBkisw+6qTl
         mlJdi2a3qtToDW4nE8/en91tHnYLXeEcvI7HvYI96kBZdJqaMrOW+at/3fzgcHc7HaUP
         uIo4hR85lRqE6Om3XDQy1283Zpw1Fxu9NqxKOOWbBnURwsbZV97vvzrxB3/vqjnnmRQu
         i02uXhKeJ5anZflNdRbH3lkg3zVg3oBs8gnOwmzXnzpWrsVILN5rFbNzsjRlHVq7gNEQ
         zff54CfVCIlmDkFK9U5xXF+kGmZS23z5J6oCj7n7abQR5sl4OZNuWNP701zXJzI0PDAa
         JP2A==
X-Received: by 10.66.27.169 with SMTP id u9mr6228799pag.130.1373839669762;
        Sun, 14 Jul 2013 15:07:49 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ot4sm60608904pac.17.2013.07.14.15.07.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 15:07:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373837749-14402-3-git-send-email-stefanbeller@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230400>

Stefan Beller wrote:

> [Subject: diff-no-index: Remove unused variable.]
[...]
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
[...]
> -		else if (!strcmp(argv[i], "-q")) {
> +		else if (!strcmp(argv[i], "-q"))
> -			options |= DIFF_SILENT_ON_REMOVED;
>  			i++;
> -		}

This feature was obviously never tested with --no-index, so I agree it
makes sense to remove it.  Probably the commit message and a comment
should say so, though.  E.g.:

	diff --no-index: remove nonfunctional "-q" handling

	Before v1.5.6-rc1~41^2~2, the option parsing for diff --no-index
	and "git diff-files" shared code.  In "git diff-files", "-q" means
	to be silent about removed files.  In "git diff --no-index", in
	various versions it has been an error, an infinite loop, or a no-op.

	Simplify the code to clarify that it is now a no-op, continuing to
	accept and ignore the -q option in "git diff --no-index" to avoid
	breaking scripts.

I wouldn't mind removing support for "-q" altogether, by the way (as a
separate change).

Hope that helps,
Jonathan
