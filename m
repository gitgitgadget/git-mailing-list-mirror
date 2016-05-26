From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 1/2] fetch: better alignment in ref summary
Date: Thu, 26 May 2016 14:13:46 -0400
Message-ID: <57473CDA.5000408@xiplink.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
 <20160522112019.26516-2-pclouds@gmail.com>
 <xmqqfut9bnff.fsf@gitster.mtv.corp.google.com>
 <CACsJy8BS2n8T1smxEJMPNiXBvMYHWnQ9BQGk_OKqJd1GFcuk7w@mail.gmail.com>
 <574706A1.8040606@xiplink.com> <20160526162940.GB18210@sigill.intra.peff.net>
 <xmqq8tywwwab.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 20:13:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5zn8-0005EJ-4y
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 20:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754679AbcEZSNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 14:13:50 -0400
Received: from smtp122.iad3a.emailsrvr.com ([173.203.187.122]:57841 "EHLO
	smtp122.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752175AbcEZSNt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2016 14:13:49 -0400
Received: from smtp16.relay.iad3a.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp16.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id EDEF718077B;
	Thu, 26 May 2016 14:13:47 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp16.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 4AFCA180776;
	Thu, 26 May 2016 14:13:47 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.5.4);
	Thu, 26 May 2016 14:13:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <xmqq8tywwwab.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295682>

On 2016-05-26 01:42 PM, Junio C Hamano wrote:
>
> True.  One of the entries in Marc's example is easily misread as
> "pclouds/2nd-index branch at its refs/heads/pclouds/2nd-index was
> fetched to its usual place", when Marc wanted to say "they had
> 2nd-index branch at refs/heads/2nd-index, and it was copied to our
> refs/remotes/pclouds/2nd-index".
>
> So even though we might be able to make sure it is unambiguous
> without "this -> that" ("->" is pronounced as 'became'), it is
> easily misread.

Actually, I tend to just think of it as "this is a local name you can 
use to refer to the new thing that was just fetched."  The left-hand 
side describes the thing being fetched (new or updated branch/tag/ref), 
and the right hand side shows how to locally refer to that thing.

The fact that something is buried in some odd part of the ref tree is 
less relevant, IMO.  If I'm using custom fetch refspecs or other 
oddities, I'll have that in the back of my head.  But what I really care 
about is what ref I can use with commands like log and checkout.

So, regarding Peff's examples:

 > $ git fetch origin refs/pull/*/head:refs/remotes/pr/*

Just show me the "pr/foo" refs.  I know where things are coming from. 
Even if I configured that fetch refspec a long time ago, I don't need to 
see the exact mapping every time I fetch.

 > $ git fetch origin refs/pull/77/head refs/pull/78/head

Ah, now this is an odd case.  Maybe there should be a different output 
format altogether for this one.  The problem is that the remote refs 
being fetched are stored without any kind of local ref.  (Commands like 
"git log FETCH_HEAD" only work with the last ref fetched, even though 
all the SHAs get added to the .git/FETCH_HEAD file.  Maybe if git 
supported a "FETCH_HEAD@{x}" syntax...)

I think the output should show the plain SHA values, since those are the 
only things the user can use to work with those refs.  Maybe something like:

	From ...
	 * origin:refs/pull/77/head  abcd0123
	 * origin:refs/pull/78/head  453def00

(Not 100% sure about the "origin:" prefix...)

		M.
