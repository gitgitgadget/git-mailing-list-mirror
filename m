From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: What should "git fetch origin +next" should do?
Date: Mon, 17 Oct 2011 10:35:19 -0400
Message-ID: <4E9C3D27.3060504@xiplink.com>
References: <7v7h45s8rh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 16:36:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFoIx-0001x8-2t
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 16:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072Ab1JQOgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 10:36:33 -0400
Received: from smtp132.iad.emailsrvr.com ([207.97.245.132]:60965 "EHLO
	smtp132.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756024Ab1JQOfc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 10:35:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp23.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id B173C3486B0;
	Mon, 17 Oct 2011 10:35:31 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp23.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 83E93348630;
	Mon, 17 Oct 2011 10:35:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110922 Thunderbird/3.1.15
In-Reply-To: <7v7h45s8rh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183794>

On 11-10-16 03:20 AM, Junio C Hamano wrote:
> As some might know, I use the traditional non-separate-remotes layout in
> many of my working trees. I am old fashioned.

Being hip and modern :) I use separate remote refspecs.  As I read your post,
I kept thinking that it makes no sense for fetch to ever update local refs
and that you're a victim of your stodgy old ways.

> I just tried to update one of them with "git pull --ff-only", and after
> seeing that the fetch phase failed with non-ff on 'next', ran
> 
> 	$ git fetch origin +next
> 
> which happily copied the tip of updated next to FETCH_HEAD and nowhere
> else. Of course, a colon-less refspec means do not store it anywhere,
> i.e. "<colon-less-refspec>" === "<colon-less refspec>:", so prefixing it
> with '+' to force would logically be a no-op.  But it nevertheless was
> somewhat surprising and irritating.
> 
> This is one of the many things that is so minor that it probably is not
> worth risking backward compatibility issues to change, but something that
> we would design differently if we were starting from scratch. Maybe in Git
> 2.0.
> 
> The question however is what should it do. I can see three possibilities:
> 
>  (1) Forcing to fetch into FETCH_HEAD does not make any sense, so instead
>      of silently ignoring the '+' prefix, error it out and do not fetch
>      anything. This is easy to explain and logically makes more sense than
>      the current behaviour.

I think this makes the most sense.

I'd even go so far as to make fetch error out if there's a colon in the
refspec.  Fetch has no business updating local refs.  There are other
commands for that, and which command you use depends on how you want your
local ref updated.  I think it would be a mistake to start going down a path
where fetch learns different ways to update a local ref.  Madness!

		M.
