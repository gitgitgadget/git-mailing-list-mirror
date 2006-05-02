From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] fetch: optionally store the current remote information in the config
Date: Tue, 02 May 2006 01:59:04 -0700
Message-ID: <7v3bfsol9j.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0604301524080.2646@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 02 10:59:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Faqiu-0003My-PP
	for gcvg-git@gmane.org; Tue, 02 May 2006 10:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWEBI7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 04:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWEBI7J
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 04:59:09 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:49042 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932520AbWEBI7G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 04:59:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060502085905.OWUF25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 2 May 2006 04:59:05 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604301524080.2646@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 30 Apr 2006 15:24:22 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19410>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	This is what the patch series is all about.
>
> 	If there is no interest in a feature like this, let's just forget
> 	about the whole "remote info in config" thing.

Well, I took the liberty of adjusting the first one in the
series and tonight's "pu" has that one and the second one.
I haven't touched the third one yet, though.

About the second one, I think it probably is a good idea to
rename the "refspec used for fetch" as Sean suggested earlier.
I do not like that hidden environment variable that sits in the
command I use everyday, waiting to be triggered to update my
.config file, possibly by my PEBCAK mistake when I did not want
it to do so.

I am not quite sure what this bit is about in the second one:

        sed -n \
        -e "s/^URL: /remote.$name.url . /p" \
        -e "s/^Pull: /remote.$name.pull ^$ /p" \
        -e "s/^Push: /remote.$name.push ^$ /p" \
	< "$f"

I am getting this out of the above:

        remote.ko.url . xxx.kernel.org:/pub/scm/git/git.git/
        remote.ko.pull ^$ master:refs/tags/ko-master
        remote.ko.pull ^$ next:refs/tags/ko-next
        remote.ko.pull ^$ +pu:refs/tags/ko-pu
        remote.ko.pull ^$ maint:refs/tags/ko-maint
        remote.ko.push ^$ heads/master
        remote.ko.push ^$ heads/next
        remote.ko.push ^$ +heads/pu
        remote.ko.push ^$ heads/maint

but I suspect that is not what you intended...

I think easy conversion tool is a good idea, but I would sleep
better if it is outside of git-fetch/push chain and is available
elsewhere, perhaps in contrib/ area.

On a slightly related topic, I think my aversion to your "push
remotes into config" series the last time was primarily because
I do not trust repo-config.  Reading an already built config
seems to work OK and I do not worry too much, but I am still
wary of letting it write.  Typing "git repo-config" in a freshly
initialized empty repository seems to segfault, which does not
help my confidence level either.
