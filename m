From: Aaron Schrab <aaron@schrab.com>
Subject: Re:  Adding hooks.directory config option; wiring into run_hook
Date: Fri, 16 Dec 2011 22:03:27 -0500
Message-ID: <20111217030327.GD30928@pug.qqx.org>
References: <CADQnX_e76LzuRUDOKFOsRHU=e8Cw+qh5x1BdW5HMEdMmP5PaHg@mail.gmail.com>
 <7vmxasie6k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Christopher Dale <chrelad@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 17 04:03:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbkYu-0004Th-Mk
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 04:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760821Ab1LQDDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 22:03:41 -0500
Received: from pug.qqx.org ([209.177.157.228]:35250 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760818Ab1LQDD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 22:03:28 -0500
Received: by pug.qqx.org (Postfix, from userid 1000)
	id 87BFD20308; Fri, 16 Dec 2011 22:03:27 -0500 (EST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Christopher Dale <chrelad@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vmxasie6k.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187347>

At 10:06 -0800 16 Dec 2011, Junio C Hamano <gitster@pobox.com> wrote:
>Christopher Dale <chrelad@gmail.com> writes:
>
>> ...
>> trusted path execution policies. These systems require that any file
>> that can be executed exhibit at least the following characteristics:
>>
>>   * The executable, it's directory, and each directory above it are
>>     not writable.
>>
>> Since the hooks directory is within a directory that by it's very nature
>> requires write permissions,...
>
>Sorry, but I am not interested at all. If you can write into $GIT_DIR/config
>then you can point at any directory with hooks.directory and that would mean
>it would defeat your "trusted path execution policies".

How does that defeat the policy?  It would certainly allow somebody who 
can write to $GIT_DIR to disable hooks, use hooks that were meant for a 
different repository, or perhaps even use executables that weren't 
intended to be hooks.  If the proposed configuration option were 
modified by an attacker to point to some directory that doesn't meet the 
requirements, then the underlying system would still prevent execution; 
the same result that would happen if they'd try to install hooks in the 
traditional location.

I see other problems with that policy, at least with the short 
description that was provided.  Unless there are also restrictions on 
the allowed owners of the executable and its containing directories, an 
attacker would still be able to install new executables and then remove 
write permissions before trying to use them.  But, that flaw (if it 
exists) wouldn't be affected by the proposed change to git.

Requiring that all executables on a secured system be installed by an 
admin doesn't seem to be a completely unreasonable requirement.  The 
supplied patch looks to be fairly small and easy to understand, so I 
wouldn't think that including it would present much of a problem for 
maintaining git.

The option might also be useful to allow the same hooks directory to be 
used for multiple repositories, although symlinks would likely be a 
better way to do that.
