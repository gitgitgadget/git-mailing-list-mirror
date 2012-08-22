From: James McKaskill <james@foobar.co.nz>
Subject: Re: [RFC 0/2] svn-fetch|push - an alternate approach
Date: Tue, 21 Aug 2012 22:30:43 -0400
Message-ID: <CAGwq8_4nKKN5jjR8Z7qvDzuoTjYhjYiudhnPHD-JLgnASAdCKQ@mail.gmail.com>
References: <1345311556-70767-1-git-send-email-james@foobar.co.nz>
	<5030BE33.9000007@gmail.com>
	<5033336C.4050906@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marco Schulze <marco.c.schulze@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 22 04:30:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T40id-0001yA-DQ
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 04:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398Ab2HVCas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 22:30:48 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58654 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755237Ab2HVCap (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 22:30:45 -0400
Received: by obbuo13 with SMTP id uo13so700576obb.19
        for <git@vger.kernel.org>; Tue, 21 Aug 2012 19:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=MromyMoN7fCwWelu0sjxpR3zSNpPKY0WIAqSUJZ65c8=;
        b=UFxqOVAXxevWSPWlYv9u4EOW1B3i9RZFRQ6sAXb9LBLUF3NF0tHopzANQnA9J9tgBn
         qfaYTsmN6VO7pQa01VBdt0UWv4l7H+cJfsdGdeMokBG/uBL6PcIBUMbkX4ppSsPeau60
         Ll+MHN5nmff57/IwBNhj9jqe9wJhktvrU0P9F4Q5aURTYSm9PSFbydDoT//LM7IVTHSg
         rTJMpcW2zdskjWI+Y1MBn5W+WrS3k5J5Ne1pFaJnOPq5LjcSYcl8MPhEUmm5v3XW30uZ
         lWyGWXt0lw9KYDnsGpF48IkBIleYsG699l2fwWbddGTHHBT++rN1lSYu7RGqsIblE0qD
         KnZg==
Received: by 10.60.32.33 with SMTP id f1mr534348oei.71.1345602643859; Tue, 21
 Aug 2012 19:30:43 -0700 (PDT)
Received: by 10.182.193.98 with HTTP; Tue, 21 Aug 2012 19:30:43 -0700 (PDT)
In-Reply-To: <5033336C.4050906@alum.mit.edu>
X-Gm-Message-State: ALoCoQmp6ldmFOkDnlnSAKfBjXJGen3Zp+l9HUfBMZfVd23ucE7dwJmPp/LdW4UVXcyjWTdW/8ms
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204005>

On Tue, Aug 21, 2012 at 3:06 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 08/19/2012 12:21 PM, Marco Schulze wrote:
>> It is a bit of a pain to work with libsvn, but I think it is worth using
>> it, not only due to protocol support, but also due to ready-to-use
>> support for SVN deltas and dumps.  Pipelining could be implemented by
>> maintaining a set of connections (svn_ra_session_t structures) and
>> manually distributing work between them.
>
> Using libsvn would also have the benefit of letting the Subversion
> project worry about forwards and backwards compatibility if the protocol
> ever changes.  (They tend to be quite diligent about that.)

So my goal with the svn support is not so much to support pushing to
svn, but to support it natively. What I mean by that is that it will
use the git configuration for http, auth, ssl, etc. For the svn
protocol there is little to none of this, but frankly the svn protocol
is a one to one mapping to the svn editor interface and very simple to
boot. So working off the interface vs working off of the protocol
there isn't much different in the complexity or amount of code. For
HTTP though there is a huge benefit to working outside libsvn. Namely
reusing the http support in git means all of the credential, http, ssl
config works. Also these days again there isn't much difference
between the http interface and the svn editor interface.

As for diffs and dumps ... Well svn diff parsing and generation is
relatively trivial (200-300 lines currently). I have no real plan
currently to deal with dumps.

I've since added support for HTTP. What I'll do is add a third
interface in the same manner that uses libsvn. If it turns out simple
enough then that would be the way to go for dumps and svn, but I'm
very skeptical about using that for HTTP+svn (can't be fully sure
without trying I suppose).

TLDR: You've convinced me to at least give it a try.

-- James
