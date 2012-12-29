From: Aaron Schrab <aaron@schrab.com>
Subject: Re: [PATCH 1/4] hooks: Add function to check if a hook exists
Date: Sat, 29 Dec 2012 09:50:32 -0500
Message-ID: <20121229145032.GB3789@pug.qqx.org>
References: <1356735452-21667-1-git-send-email-aaron@schrab.com>
 <1356735452-21667-2-git-send-email-aaron@schrab.com>
 <7vwqw1fw5a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 15:50:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToxkT-00088n-NH
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 15:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024Ab2L2Oud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 09:50:33 -0500
Received: from pug.qqx.org ([50.116.43.67]:58255 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993Ab2L2Oud (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 09:50:33 -0500
Received: by pug.qqx.org (Postfix, from userid 1000)
	id C766F1D0BE; Sat, 29 Dec 2012 09:50:32 -0500 (EST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vwqw1fw5a.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+145 (gd0ebb66) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212311>

At 18:08 -0800 28 Dec 2012, Junio C Hamano <gitster@pobox.com> wrote:
>Aaron Schrab <aaron@schrab.com> writes:
>
>> Create find_hook() function to determine if a given hook exists and is
>> executable.  If it is the path to the script will be returned, otherwise
>> NULL is returned.
>
>Sounds like a sensible thing to do.  To make sure the API is also
>sensible, all the existing hooks should be updated to use this API,
>no?

I'd been trying to keep the changes limited.  I'll see about modifying 
the existing places that run hooks in v2 of the series.

>> This is in support for an upcoming run_hook_argv() function which will
>> expect the full path to the hook script as the first element in the
>> argv_array.
>
>There is currently a public function called run_hook() that squats
>on the good name with a kludgy API that is too specific to using
>separate index file.  Back when it was a private helper in the
>implementation of "git commit", it was perfectly fine, but it was
>exported without giving much thought on the API.
>
>If you are introducing a new run_hook_* function, give it a generic
>enough API that lets all the existing hook callers to use it.  I
>would imagine that the API requirement may be modelled after
>run_command() API so that we can pass argv[] and tweak the hook's
>environ[], as well as feeding its stdin and possibly reading from
>its stdout.  That would be very useful.

I think the attraction of the run_hook() API is its simplicity.  It's 
currently a fairly thin wrapper around the run_command() API.  I suspect 
that if the run_hook() API were made generic enough to support all of 
the existing hook callers it would greatly complicate the existing calls 
to run_hook() while not providing much benefit to hook callers which 
can't currently use it beyond what run_command() offers.

Since I'm going to be changing the interface for this hook in v2 of the 
series so that it will be more complicated than can be readily addressed 
with the run_hook() API (and will have use a fixed number of arguments 
anyway) I'll be dropping the run_hook_argv() function.
