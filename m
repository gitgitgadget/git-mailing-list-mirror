From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Change set based shallow clone
Date: Fri, 8 Sep 2006 10:20:06 -0400
Message-ID: <9e4733910609080720s7a143d9bp5a1dd36869967c22@mail.gmail.com>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com>
	 <7vpse7tjp0.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90609072054u5ec8bc46x9878a601953b2c5d@mail.gmail.com>
	 <7vac5ancvo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 16:20:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLhDP-0007Gb-OI
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 16:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWIHOUJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 10:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWIHOUJ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 10:20:09 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:64913 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750713AbWIHOUH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 10:20:07 -0400
Received: by py-out-1112.google.com with SMTP id n25so840869pyg
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 07:20:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LXPYjWXTDVDcPPWzz7HKrm1RRsUFH+BC3FNFl/K8XSr3bSF+qqMj5zo49CcVOlxP06u40QjE9LKMB+IKWeeLS+8JwEcBtpZyZHgmBcJCVGzz0zq9+gkRHcNFVuNHTm9cL/yO/+YO9rcq4il4vaubL/GwwM5PxblRdNiGpL1KWyw=
Received: by 10.35.66.12 with SMTP id t12mr3645840pyk;
        Fri, 08 Sep 2006 07:20:07 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Fri, 8 Sep 2006 07:20:06 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vac5ancvo.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26699>

On 9/8/06, Junio C Hamano <junkio@cox.net> wrote:
> [*4*] In git, there is no inherent server vs client or upstream
> vs downstream relationship between repositories.  You may be
> even fetching from many people and do not have a set upstream at
> all.  Or you are _the_ upstream, and your notebook has the
> latest devevelopment history, and after pushing that latest
> history to your mothership repository, you may decide you do not
> want ancient development history on a puny notebook, and locally
> cauterize the history on your notebook repository and prune
> ancient stuff.  The objects missing from the notebook repository
> are retrievable from your mothership repository again if/when
> needed and you as the user would know that (and if you are lucky
> you may even remember that a few months later), but git doesn't,
> and there is no reason for git to want to know it.  If we want
> to do "fault-in on demand", we need to add a way to say "it is
> Ok for this repository to be incomplete -- objects that are
> missing must be completed from that repository (or those
> repositories)".  But that's quite a special case of having a
> fixed upstream.

A 'not-present' object would be a normal git object, it would contain
a list of sha1s that it is stubbing for. These alias sha1s need to end
up somewhere where the git tools can find them. Maybe put all of the
'not-present' objects into their own pack and add the aliases to the
index. If the aliases point back the 'not-present' object everything
can be validated even if the alias sha1s don't match the one of the
object. This pack would be private and not sent to other repositories.

It would be useful to maintain a list of possible remote repositories
to search for the missing objects if needed. This list could be shared
with people that clone from you.

If you clone from a remote repository that is a partial copy you may
not be able to get all of the objects you want. The only choice here
is to point them to 'not-present' stub and try searching the
alternative repository list.

If you really want to build something for the future, have all of the
git repositories on the net talk to each other and use a distributed
hash scheme to spread redundant copies of the objects out over the
cloud of servers. This will have the effect of creating a global
namespace for all git projects.

-- 
Jon Smirl
jonsmirl@gmail.com
