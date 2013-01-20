From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How to setup bash completion for alias of git command
Date: Sun, 20 Jan 2013 03:14:24 -0800
Message-ID: <20130120111424.GG16339@elie.Belkin>
References: <CACSwcnQu8Rx83mcGYR6NGzEhoreNR6DfiK876LF7pa9PGm30JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Marc Khouzam <marc.khouzam@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 12:14:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwsrU-0007T0-R4
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 12:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693Ab3ATLOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 06:14:31 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:56185 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358Ab3ATLOa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 06:14:30 -0500
Received: by mail-pa0-f49.google.com with SMTP id bi1so2862089pad.22
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 03:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=AT4ncwJd1jUDLgTRVRbav4tlF1+a9JzRwo+xw6cRWk0=;
        b=jxF2dOIq4e6muDGwVhPbT4CfDDPb3A9YcVbiNth8Vgek/6z61ptgVjUZj2Pb9yX51h
         4kGWBQ70VCbrUTj13m/GWfFCkfU2hWdNwHLKG7tElMFph+8DVUhb7ZmnClsb4b7PyGKT
         sIoUr6/fiTy0TYmzFWenCA9Sv7Ow6HOzcoYK8wINVBGbQZn1YXF6L13NjqQTIcsOeeTJ
         5w0tZFLgCxWHaiPNvjvd1b84Vn6jNQ6yI5D6UJ/F/6yLrhIjV4syvP6STsdpL7UpGLSg
         4myA79ra4q1va6gz5R0xlQMD2OQldhfcp7QuYsBIY5RroHcuIklV8uUDXOiGuZcT2mG9
         3qvA==
X-Received: by 10.66.72.198 with SMTP id f6mr38945002pav.42.1358680470299;
        Sun, 20 Jan 2013 03:14:30 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id qr8sm6605321pbc.64.2013.01.20.03.14.28
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 20 Jan 2013 03:14:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACSwcnQu8Rx83mcGYR6NGzEhoreNR6DfiK876LF7pa9PGm30JA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214004>

Hi Ping,

Ping Yin wrote:

> Following setup works for me  in ubuntu (10.04,11.04) for a long time
>
> alias gtlg='git log'
> complete -o default -o nospace -F _git_log gtlg
>
> However, in debian (testing, wheezy), it doesn't work
>
> $ gtlg or<TAB>
> gtlg or-bash: [: 1: unary operator expected
> -bash: [: 1: unary operator expected

Yes, I can reproduce this.  "git bisect" tells me it was introduced
by v1.7.6-rc0~65^2~4 (completion: remove unnecessary
_get_comp_words_by_ref() invocations, 2011-04-28).  Since then, Felipe
has done work to make reusing subcommand completion easy again, so you
can do

	__git_complete gtlg _git_log

One complication: on some systems, including Ubuntu 13.04, git's bash
completion script is installed to

	/usr/share/bash-completion/completions/git

and sourced on the fly when completing commands starting with "git"
instead of right away from /etc/bash_completion.  On these systems,
the "__git_complete" function would not be usable right away from
your .bashrc file.  I think we should fix this, for example by moving
the function to a separate

	$(git --exec-path)/git-bashrc-functions

library.

Thanks for reporting,
Jonathan
