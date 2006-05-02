From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] fetch: optionally store the current remote information
 in the config
Date: Tue, 2 May 2006 14:42:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605021422520.7051@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604301524080.2646@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3bfsol9j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 02 14:42:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FauCq-0004t0-Bx
	for gcvg-git@gmane.org; Tue, 02 May 2006 14:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWEBMmQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 08:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWEBMmQ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 08:42:16 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:60593 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932232AbWEBMmP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 08:42:15 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 7F1891F9F;
	Tue,  2 May 2006 14:42:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 72F7A1EC0;
	Tue,  2 May 2006 14:42:14 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 5FC211D7D;
	Tue,  2 May 2006 14:42:14 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bfsol9j.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19418>

Hi,

On Tue, 2 May 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	This is what the patch series is all about.
> >
> > 	If there is no interest in a feature like this, let's just forget
> > 	about the whole "remote info in config" thing.
> 
> Well, I took the liberty of adjusting the first one in the
> series and tonight's "pu" has that one and the second one.
> I haven't touched the third one yet, though.

I don't think it is worth introducing yet another way to specify 
short-cuts for remote information, if there is not at least one problem 
which can get solved easier with it than with the other two ways.

> About the second one, I think it probably is a good idea to
> rename the "refspec used for fetch" as Sean suggested earlier.

Okay.

> I do not like that hidden environment variable that sits in the
> command I use everyday, waiting to be triggered to update my
> .config file, possibly by my PEBCAK mistake when I did not want
> it to do so.

I will refactor it.

> I am not quite sure what this bit is about in the second one:
> 
>         sed -n \
>         -e "s/^URL: /remote.$name.url . /p" \
>         -e "s/^Pull: /remote.$name.pull ^$ /p" \
>         -e "s/^Push: /remote.$name.push ^$ /p" \
> 	< "$f"

That is obviously wrong. Will fix while refactoring.

> I think easy conversion tool is a good idea, but I would sleep
> better if it is outside of git-fetch/push chain and is available
> elsewhere, perhaps in contrib/ area.

Will do.

> On a slightly related topic, I think my aversion to your "push
> remotes into config" series the last time was primarily because
> I do not trust repo-config.  Reading an already built config
> seems to work OK and I do not worry too much, but I am still
> wary of letting it write.  Typing "git repo-config" in a freshly
> initialized empty repository seems to segfault, which does not
> help my confidence level either.

I fixed this error (see separate patch). This was reintroduced by 
carelessly checking argv[1] for "--list" and "-l", even if argc < 2. I am 
sorry that I did not review that patch.

I tried to make really sure that repo-config works as expected by 
introducing quite a few test cases into t1300, but evidently I forgot to 
check for things that do not usually break, like calling without 
arguments. This is fixed with the patch I just sent out.

This patch also introduces the "--get-regexp" flag to repo-config, which 
makes up for the lacking shell wildcards (you can ask questions like: 
which keys in the config end in "coatl"?).

As for the trust in repo-config writing the config: it is all done by 
calling git_config_set() or git_config_set_multivar(), which you use 
yourself to set core.repositoryformatversion, among other values.

Ciao,
Dscho
