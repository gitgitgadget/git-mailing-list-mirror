From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Restart submodule update --recursive
Date: Thu, 28 Oct 2010 13:15:15 -0500
Message-ID: <20101028181515.GB14212@burratino>
References: <loom.20101028T090353-376@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Lukasz Palczewski <l.palczewski@prevac.pl>
X-From: git-owner@vger.kernel.org Thu Oct 28 20:15:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBX0a-00013d-4c
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 20:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760843Ab0J1SPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 14:15:23 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38497 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321Ab0J1SPV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 14:15:21 -0400
Received: by gyg4 with SMTP id 4so1444487gyg.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 11:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mk9vkAem7a3gi44LOiu2tQ1mMkYUDsE1RjZ1O8XbBqo=;
        b=YyGABtlSWFwZMO1QSmV/d5gEMP783fPQ+2+0fgSofH5mE+oJ5/LOUfiPTD1V58eVxb
         PVgFzQMbrmvPdK5FxseB371EbhcKnluiohcMvEZJgB1RIRX+4kQl/BedXHOIJi7QDXVH
         G/IobtHmP9p7jfXuw8HOUz7GF1umCrn3MFJ0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ek9oO68qL8KMRyCnYPpMwAzmJ9cww9qUK0JarjD3y+6/4srAdPWUZUUITOAXEP5gql
         PuIbNqAzrekqf7vsFOEVwmWK3picTzmA1C7U6fvwEbhzUYdS5CPjxtNU6u2agqJSUZxW
         aFBB09x49Relwn8hZ04G42Qc4+QHBYNoL1Wws=
Received: by 10.151.49.1 with SMTP id b1mr5062123ybk.338.1288289720955;
        Thu, 28 Oct 2010 11:15:20 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id q5sm6055469ybe.18.2010.10.28.11.15.18
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 11:15:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20101028T090353-376@post.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160191>

(+cc: Jens of submodule-usability-enhancements fame)

Hi Lukasz,

Lukasz Palczewski wrote:

>                                                                       I use git
> command: git submodule update --recursive
[...]
>                 If I have some local changes in some submodule, the command
> stops and I have to revert the changes and start the submodule update from the
> begining again.
> Is there a way to start the submodule update from the place, where the error
> occured and the command stop? Something like:
> git submodule update --recursive --restart_form_last_error

How many submodules are involved here?  I suspect there is some
optimization possible: if a submodule was already updated, there
should not be much to do on the second pass, right?  What aspect of
the update seems to take the most time (as witnessed by pstree -a, for
example)?  Maybe what would be most useful is a hypothetical

	git submodule update --fetch-only
	(or git fetch --recursive)

followed by

	git submodule update --no-fetch
	(or git checkout --recursive)

?

But if there are many, many submodules, it could be better to script
a --save-progress and --resume along the lines you described.

Two possible approaches:

 - Make a new script using "git submodule foreach --recursive" that
   steps through the list by hand, or

 - Take cmd_update from git-submodule.sh in the git sources and modify
   to taste.

If you follow either of those approaches, please keep up posted.  Such
scripts are inspiring and can be useful to others, too.

Thanks for an interesting example,
Jonathan
