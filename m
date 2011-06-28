From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC 2/2] Don't push a repository with unpushed submodules
Date: Tue, 28 Jun 2011 18:06:35 -0400
Message-ID: <4E0A506B.6040407@xiplink.com>
References: <1309112987-3185-1-git-send-email-iveqy@iveqy.com> <1309112987-3185-3-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, hvoigt@hvoigt.net,
	jens.lehmann@web.de
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Wed Jun 29 00:07:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbgR8-0006uX-Bz
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 00:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257Ab1F1WHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 18:07:00 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:52707 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239Ab1F1WG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 18:06:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp59.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 2150B3F03C4;
	Tue, 28 Jun 2011 18:06:55 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp59.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 87A843F08EB;
	Tue, 28 Jun 2011 18:06:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Thunderbird/3.1.10
In-Reply-To: <1309112987-3185-3-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176422>

On 11-06-26 02:29 PM, Fredrik Gustafsson wrote:
> When working with submodules it is easy to forget to push a submodule
> to the server but pushing a super-project that contains a commit for
> that submodule. The result is that the superproject points at a
> submodule commit that is not avaliable on the server.
> 
> Check that all submodule commits that are about to be pushed are present
> on a remote of the submodule and require forcing if that is not the
> case.

I have a few concerns about what this is trying to do.

First, I expect performance will be terrible in repositories with large
and/or many submodules.  I'd go so far as to say that it's pretty much a
show-stopper for our repository.

Second, there are many times where I'm working in a submodule on branch
"TopicA" but not in branch "TopicB".  If I've made submodule changes in
TopicA then try to push up TopicB, won't I have have to tell push to "-f"?
But that turns off other checks that I'd rather keep.

I'd feel a lot better about this patch if the check was *off* by default and
there was a config setting / command-line option to turn it on.

I also agree with Junio that this kind of verification makes more sense in a
hook on the server side.

		M.
