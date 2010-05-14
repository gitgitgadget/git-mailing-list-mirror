From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: interactive rebase editor pathname variable
Date: Fri, 14 May 2010 02:59:14 -0500
Message-ID: <20100514075913.GA3690@progeny.tock>
References: <hshglg$p2q$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Fri May 14 09:59:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCpnp-0002Yj-Ga
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 09:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757352Ab0ENH7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 03:59:20 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48508 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785Ab0ENH7T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 03:59:19 -0400
Received: by gyg13 with SMTP id 13so1062955gyg.19
        for <git@vger.kernel.org>; Fri, 14 May 2010 00:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Hu0tQxBKP/rgrhXfk/7ltyxMyXS8JYdBGNvYwFw0s70=;
        b=R3wntyIYJKkkRlY7h9XMScmIVVMnuzl48nG2b7n1OWNHNgM7E8fj8NWJ3ruTO9z2C1
         rfJ9J1brT46vBdEVP44eueLB4O6VKAoBeWH4afWWCEskbg5ot2wh08A4scQaAgjjRFY3
         tpwrqGzL+zo4EajjEpcQMepJUb5/LR0k08KDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PTCgkvbZxXdRDuNaj3QYsB4MixuJoRCRmhHWiZOBpZqbwRW9Vk/w2ExTPSph5Y/knG
         eYjjv1ZOOpUeK+bpN5ezP0JgQj/3rSYulKO5J9VO+SQyp6caijPnKD0i3NLBv+ikX5a2
         PlelNLOuYN5NoB6gHflFIf36Pg7E6EkSEMz1k=
Received: by 10.150.14.10 with SMTP id 10mr1570795ybn.263.1273823958241;
        Fri, 14 May 2010 00:59:18 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id w18sm16087741ybe.22.2010.05.14.00.59.16
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 00:59:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <hshglg$p2q$1@dough.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147055>

Hi Neal,

Neal Kreitzinger wrote:

> git-rebase -i passes an absolute pathname to the 
> core.editor, e.g. 
> "home/someuser/someworkingtree/.git/rebase-merge/git-rebase-todo".  This 
> causes problems in our shop because our proprietary editor cannot handle 
> pathnames beginning with a period (it translates the period to a slash) and 
> therefore our entry for core.editor is 'someeditor "$PWD/$1"'.

For your example, git uses the shell to run the following command.

  someeditor "$PWD/$1" "$@"

I would suggest something like the following instead.

  [core]
	editor = "sh -c '\
		case \"$1\" in \
		/*|[A-Za-z]:*) file=\"$1\";; \
		*) file=\"$(pwd)/$1\";; \
		esac; \
		someruntime someditor \"$file\"' -"

Hope that helps,
Jonathan
