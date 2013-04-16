From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] push: introduce implicit push
Date: Mon, 15 Apr 2013 19:05:15 -0700
Message-ID: <20130416020515.GE3262@elie.Belkin>
References: <1365780835-2853-1-git-send-email-artagnon@gmail.com>
 <7v38uvcrjl.fsf@alter.siamese.dyndns.org>
 <CALkWK0=-GcOF17Q-y-Aqj0ThX5pPQFrriDqoJ2qsr=CS+wUNGA@mail.gmail.com>
 <7vehed7ilu.fsf@alter.siamese.dyndns.org>
 <CALkWK0k6bmjFxTSMAutgu2EjWRZ_cyTU9jZ3Er-aaV78T16RtQ@mail.gmail.com>
 <7vppxw335o.fsf@alter.siamese.dyndns.org>
 <CALkWK0nNn_dGgr8F-kcQZm9UfkZAKwBd0bPSW9yCex4L9F+4Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 04:05:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URvH5-0004v7-Me
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 04:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935328Ab3DPCFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 22:05:21 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36772 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934994Ab3DPCFV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 22:05:21 -0400
Received: by mail-pd0-f169.google.com with SMTP id 10so6998pdc.0
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 19:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=lyX1VsfCuLpT778ghQicyq+3LSoxnG2zsvoqiIwRdKI=;
        b=YAOpz2W9zlziNjXk8NZxaLhFinxtc2zvI5wJiFvQ8FaqasU0xs/XfAHKl8lsQF3si4
         vzD6qBydhbCG26+6k10a9QbAn8VCNO+I6TD5lRvmBS2aYSpNvkSeErYZywOQOSi5in8g
         o/lNcnTBwQQ2nJafbhkNj/7HR/tqvKrtaY/etKeQsc8fDsO2H+/y+cfoVMNzVt9wIyba
         jMXhcVmypHRDs2Xgkga2WaEQLIYPg0BcG02XrAVrmVrUzOIQWBQXDuIAMXGkwumglTlV
         5eXKmmLQkoI/xsYjYsJ6gbi3qS7rth/KCLBFtTGuesDoSpjfybSO6gYtPuXl5G+ysHGk
         oXzw==
X-Received: by 10.68.238.38 with SMTP id vh6mr377238pbc.63.1366077920587;
        Mon, 15 Apr 2013 19:05:20 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id vk7sm22415618pbc.41.2013.04.15.19.05.18
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 19:05:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nNn_dGgr8F-kcQZm9UfkZAKwBd0bPSW9yCex4L9F+4Qw@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221344>

Ramkumar Ramachandra wrote:
> Junio C Hamano wrote:

>> That "changing the meaning of <name>" in the middle, and doing so
>> will be confusing to the users, is exactly the issue, isn't it?
>
> Yes, but we have to change _something_ if we don't want to hit a WTF
> like 'git push master next' pushing master and next to
> branch.<HEAD>.pushremote.

Yep.  In the usual case, all relevant remotes are "origin" anyway, so
there's no confusion.  In the confusing cases it would be safer to
error out and give the user a hint about how to make the configuration
less confusing.

The manual could say:

	In olden times, each [branch "<name>"] section would often have
	its own remote and pushRemote settings.  Ordinary branch creation
	even created such a configuration.  Nowadays that is
	discouraged: we have found that it is less confusing in
	practice to:

	 A) Typically fetch from one remote "[remote] default = origin"
	    and push to another "[remote] pushDefault = personal".

	 B) In atypical cases, explicitly name the remote being used
	    on the command line.

Thinking more, I suspect there is an asymmetry between "fetch" and
"push" here that we missed.  The manual could say:

	In typical usage, a person ordinarily pushes to a single
	preferred publication point.  You can set your publication
	point using the "[remote] pushDefault" setting:

		[remote]
			pushDefault = myserver.example.com:/path/to/repo.git

	To push a collection of branches to that remote repository,
	pass a list of branch names to "git push" with a
	disambiguating "--" to ensure the first branch name is not
	treated as a remote name:

		git push -- master next pu

	For historical reasons, if "[remote] pushDefault" is not set,
	it defaults to the remote that the branch being pushed is set
	to pull from (its "upstream").  If pushDefault is unset and
	multiple branches being pushed have different upstream
	repositories, Git will error out to allow you to disambiguate.

	To push to a different remote repository, just name it
	explicitly on the command line.

		git push korg -- master next pu

The asymmetry is because a command like "git fetch -- master next pu"
doesn't make much sense, since you have to know what remote you
fetched from to act on the fetch result.

As you hinted before, this would involve reverting the introduction
of "branch.<name>.pushremote", with the explanation that it was a
mistake inspired by that false symmetry, that you noticed and were
uncomfortable with but the rest of us were blind too.

Does that make sense?

Jonathan
