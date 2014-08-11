From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v2 04/23] rebase -i: hide interactive command messages in verbose mode
Date: Mon, 11 Aug 2014 20:22:07 +0200
Message-ID: <87bnrqanu8.fsf@thomasrast.ch>
References: <53A258D2.7080806@gmail.com>
	<cover.1407368621.git.bafain@gmail.com>
	<6d4f66b21315661e4f267f59341ebb798232a381.1407368621.git.bafain@gmail.com>
	<87y4uyajd3.fsf@thomasrast.ch> <53E87E47.9060007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 20:22:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGuEa-0005EM-HU
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 20:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbaHKSWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 14:22:13 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:34231 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588AbaHKSWM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 14:22:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 2C5394D664F;
	Mon, 11 Aug 2014 20:22:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id JYiXSB3A1CX5; Mon, 11 Aug 2014 20:22:08 +0200 (CEST)
Received: from linux-1gf2.thomasrast.ch (roaming-195-167.host.udel.edu [128.175.195.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id BF6F14D6575;
	Mon, 11 Aug 2014 20:22:07 +0200 (CEST)
In-Reply-To: <53E87E47.9060007@gmail.com> (Fabian Ruch's message of "Mon, 11
	Aug 2014 10:26:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255127>

Fabian Ruch <bafain@gmail.com> writes:

> Hi Thomas,
>
> Thomas Rast writes:
>> Fabian Ruch <bafain@gmail.com> writes:
>>> @@ -923,6 +923,8 @@ EOF
>>>  	;;
>>>  esac
>>>  
>>> +mkdir -p "$state_dir" || die "Could not create temporary $state_dir"
>>> +
>>>  git var GIT_COMMITTER_IDENT >/dev/null ||
>>>  	die "You need to set your committer info first"
>>>  
>>> @@ -938,7 +940,6 @@ then
>>>  fi
>>>  
>>>  orig_head=$(git rev-parse --verify HEAD) || die "No HEAD?"
>>> -mkdir -p "$state_dir" || die "Could not create temporary $state_dir"
>>>  
>>>  : > "$state_dir"/interactive || die "Could not mark as interactive"
>>>  write_basic_state
>> 
>> Why this change?  I can't figure out how it relates to the output
>> change.
>
> Creating the state directory a few steps earlier into
> 'git_rebase__interactive' is necessary because the changed definition of
> 'output' needs it for 'editor.sh'. This change was triggered by a
> failing test case that used the <branch> argument with git-rebase. The
> 'git checkout <branch>', which is executed if 'switch_to' is set to
> <branch>, is wrapped into an 'output' line and 'output' failed because
> it wasn't able to create 'editor.sh'.
[...]
>> In order to temporarily redirect the editor output, the new
>> definition of `output` creates a script in the state directory to be
>> used as `GIT_EDITOR`. Make sure the state directory exists before
>> `output` is called for the first time.

Ah, makes sense.  Thanks for the explanations!

-- 
Thomas Rast
tr@thomasrast.ch
