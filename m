From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 09/13] Honour the refspec when updating refs after 
	import
Date: Thu, 5 Nov 2009 02:45:46 +0100
Message-ID: <fabb9a1e0911041745x577f7e4rc678da4d7d559193@mail.gmail.com>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com> 
	<1257364098-1685-10-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0911041601170.14365@iabervon.org> 
	<fabb9a1e0911041321i1ccec898r53ddafb9405c6331@mail.gmail.com> 
	<alpine.LNX.2.00.0911041624401.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Nov 05 02:46:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5rQo-0002ur-7m
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 02:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbZKEBqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 20:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753989AbZKEBqF
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 20:46:05 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:17453 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939AbZKEBqB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 20:46:01 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1041130eyd.19
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 17:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=1X22jbCOmevNQUHrxRDLeKvt/wDaZWHzmvR7KHZuphM=;
        b=QaZUBH3cBZSvBLIFqTbQt1esSzDgTmWYFAfQQERyDBhRrREIW84svLp9k4sdij0h+Z
         IsTxwmwZaFTReTvRt5QCzbqrkEOspNHhRCxKyJ0vr2o+0isTYrszFkHMeue+EC0YDa3w
         0jdWc16wbfzkugY2yhW2l6M15FsCyXEAP/xDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=VY7Kh8CVZAC5jrzPMFE//nqfXJVGNHgzItzo7NQuSaBvhf/Z/69XCSk5SRf8FB3z9c
         AoqttcFAury8glfc7qLXIyeq+WOiFO1/7Ao26Zrql3nRJvSyNy3p9gPhPyA9Yotr5GEL
         7+peKiCTxPbjEdyvqQ9wfACfbimySt09L4qA8=
Received: by 10.216.90.195 with SMTP id e45mr639075wef.189.1257385566125; Wed, 
	04 Nov 2009 17:46:06 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0911041624401.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132188>

Heya,

On Wed, Nov 4, 2009 at 22:30, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Wed, 4 Nov 2009, Sverre Rabbelier wrote:
>> On Wed, Nov 4, 2009 at 22:20, Daniel Barkalow <barkalow@iabervon.org> wrote:
>> > That's not true for "git pull <url> <branch>"; we do want the remote ref,
>> > but it doesn't have a local peer.

No, I don't think that's right, when doing a fetch we want to store
the refs somewhere, sure, but not under 'refs/heads/<branch>', perhaps
'refs/hg/fetch/<branch>', either way, the current code does not work.

>> >I think going straight to the refspec
>> > command is the right answer.
>>
>> Can you clarity what you mean with "the refspec command"?
>
> Whatever it is that lets the helper tell the transport code where in the
> helper's private namespace to look for refs. I'd been thinking the helper
> would advertize the "refspec" capability, and the transport code would
> call the "refspec" command in order to get the helper to report that; but
> then I actually only said that the helper reports refspec, and not
> proposed a name for the command.

Currently I'm implementing so that it would work like this for the svn helper:

$ echo capabilities | git remote-svn origin /path/to/hg/repo
import
refspec +refs/trunk:refs/svn/origin/trunk
refspec +refs/branches/*:refs/svn/origin/*

That way we can put the refspec in the config file at clone time.

Now I've been browsing through the builtin-fetch code, and it looks
like the main problem is going to be to apply this refspec at all.
I'll have a more extensive look tomorrow.

-- 
Cheers,

Sverre Rabbelier
