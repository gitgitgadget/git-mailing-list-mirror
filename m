From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] Try harder to find a remote when on a detached HEAD or
 non-tracking branch.
Date: Mon, 18 Jun 2012 17:40:00 -0400
Message-ID: <4FDFA030.7080408@xiplink.com>
References: <1340038866-24552-1-git-send-email-marcnarc@xiplink.com> <7vaa004j9f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 18 23:40:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgjgu-0005Gv-VO
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 23:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627Ab2FRVkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 17:40:51 -0400
Received: from smtp182.dfw.emailsrvr.com ([67.192.241.182]:51369 "EHLO
	smtp182.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539Ab2FRVku (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 17:40:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp18.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id A58CA2D8369
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 17:40:49 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp138.ord.emailsrvr.com (smtp138.ord.emailsrvr.com [173.203.6.138])
	by smtp18.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id 887542D8346
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 17:40:49 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp22.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 3B6A02000F0;
	Mon, 18 Jun 2012 17:40:01 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp22.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id EC1472001D3;
	Mon, 18 Jun 2012 17:40:00 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <7vaa004j9f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200164>

On 12-06-18 01:33 PM, Junio C Hamano wrote:
> marcnarc@xiplink.com writes:
> 
>> From: Marc Branchaud <marcnarc@xiplink.com>
>>
>> get_default_remote() tries to use the checked-out branch's 'remote' config
>> value to figure out the remote's name.  This fails if there is no currently
>> checked-out branch (i.e. HEAD is detached) or if the checked-out branch
>> doesn't track a remote.  In these cases and the function would just fall
>> back to "origin".
>>
>> Instead, let's use the first remote listed in the configuration, and fall
>> back to "origin" only if we don't find any configured remotes.
> 
> I admit that I wouldn't do anything that relies on any remote to be
> used while on detached head myself, so in that sense I am a biased
> audience, but guessing (or not guessing and blindly assuming
> 'origin') feels wrong, and trying even harder to come up with an
> even wilder guess feels even more wrong.

OK, but what would be right?  AFAIK git doesn't have any real way of
designating an official default remote.  It seems to me that the first one in
the config is actually better than just using "origin".  At least, that
remote seems very likely to be the one used when the repo was cloned.

> Shouldn't we be erroring out instead?

That would be bad for our situation.  As I said, our automated build system
uses detached HEADs a lot.  Erroring-out in this case would break us.  It's
really only the near-ubiquity of the name "origin" that has kept things
working so far.

But we finally ran into a situation where someone used "git clone -o", and
that seems to have broken relative-path submodules in some situations.  (I
would not be at all surprised if "git clone -o" breaks an assortment of other
features, too.  I think there are a few places in the code where "origin" is
presumed to be a valid remote name, and also the one the user wants to use.)

		M.
