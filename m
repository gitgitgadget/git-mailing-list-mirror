From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT and repo-config
Date: Thu, 25 Jan 2007 23:45:45 +0000
Message-ID: <b0943d9e0701251545w1b34a0dcg545eeab08d767e38@mail.gmail.com>
References: <20070125225512.GF4083@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri Jan 26 00:45:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAEHt-0005W0-UR
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 00:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbXAYXpr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 18:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbXAYXpr
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 18:45:47 -0500
Received: from nz-out-0506.google.com ([64.233.162.224]:21936 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030501AbXAYXpq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 18:45:46 -0500
Received: by nz-out-0506.google.com with SMTP id s1so551907nze
        for <git@vger.kernel.org>; Thu, 25 Jan 2007 15:45:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s1/HWcYtqbzDbrdH+z5pK0HQl8gfGkOUQEY6GE4+A4ZMuRvXTxkLr4eeEIfjmuWRpxz21mCfKC71f1A27BiSKwPDnT38C001Wttc+HnvpR8YvZmL0jOcDoqWPePMhxcAGhuKHCNmxVY8UVReXBTVkH/Zyc84JlJoyQoSJmu+GBA=
Received: by 10.65.185.13 with SMTP id m13mr4057381qbp.1169768745766;
        Thu, 25 Jan 2007 15:45:45 -0800 (PST)
Received: by 10.65.133.13 with HTTP; Thu, 25 Jan 2007 15:45:45 -0800 (PST)
In-Reply-To: <20070125225512.GF4083@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37782>

On 25/01/07, Yann Dirson <ydirson@altern.org> wrote:
> I'm trying to get StGIT to work with git's config information.
> Currently, the stgit.config stuff uses a generic ConfigParser, which
> I'm not sure is adequate for the work:

There are some drawbacks indeed and it currently reads the configs and
transforms them slightly before passing them to ConfigParser. StGIT
initially had its own config files (git config came a bit later).

It would be good to have this re-written. It is even better to use
something like config.get('user.name') rather than config.get('user',
'name') as in ConfigParser.

What I'd like it to have is a single initial call to git-repo-config
--list (in config_setup) and all the options cached in a dictionary
(so that .git/config options would override the global ~/.gitconfig
ones). The dictionary should also be pre-populated with the default
values (only in memory, not going to the config file on disk).

For the options setting, it shouldn't probably need to use --global.
As above, these options should be cached in the dictionary as well.

-- 
Catalin
