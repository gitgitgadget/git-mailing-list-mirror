From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Auto update submodules after merge and reset
Date: Wed, 14 Dec 2011 10:16:39 -0500
Message-ID: <4EE8BDD7.1080507@xiplink.com>
References: <4ED57EED.4040705@qualcomm.com> <4ED5E9D2.4060503@web.de> <jbnadt$hf8$1@dough.gmane.org> <4EDFE75C.5050201@web.de> <4EE07FCD.8090702@ursus.ath.cx> <CABURp0rcT2FR3uOmhyPUV5W3pu7WuJzjXktmUq0eb4nOiUwDKA@mail.gmail.com> <4EE51D7B.7020806@ursus.ath.cx> <4EE682A3.8070704@web.de> <4EE71E9F.90204@ursus.ath.cx> <4EE7C733.4010209@web.de> <4EE7DA2C.7000300@ursus.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
To: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>
X-From: git-owner@vger.kernel.org Wed Dec 14 16:16:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaqZb-0005n8-PK
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 16:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755333Ab1LNPQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 10:16:43 -0500
Received: from smtp152.iad.emailsrvr.com ([207.97.245.152]:33889 "EHLO
	smtp152.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab1LNPQm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 10:16:42 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp55.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id EB3462E0362;
	Wed, 14 Dec 2011 10:16:41 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp55.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id AF4C32E02E5;
	Wed, 14 Dec 2011 10:16:41 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111124 Thunderbird/8.0
In-Reply-To: <4EE7DA2C.7000300@ursus.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187126>

On 11-12-13 06:05 PM, Andreas T.Auer wrote:
> 
> On 13.12.2011 22:44 Jens Lehmann wrote:
>>
>>  If you follow a tip there won't be any new SHA-1s recorded during
>>  that following so you could not do a bisect and expect the submodule
>>  to be what the developer had when doing the commits, no?
> 
> If you never commit something to the superproject, you wouldn't get SHA1s
> recorded, that's right. But when you commit something to the superproject,
> why shouldn't the current submodule SHA1 be stored? Floating is about
> _ignoring_ the recorded SHA1 in _some_ cases, not about disabling the
> recording. So you can bisect to the bad superproject commit. If you suspect a
> bad submodule commit causing the problem then you could still bisect the
> submodule commits between the recorded SHA1s.

To me this question is one of the more problematic aspects of floating
submodules: When to commit submodule SHA1s.

Andreas suggests always committing them whenever a submodule's tip is moved.
 I don't think this is practical because commits end up with extra changes
that likely have nothing to do with the commit's topic.  This makes it
difficult to merge (or even cherry-pick) a commit elsewhere without also
picking up an unwanted submodule update.

Jens suggests never committing submodule SHA1s.  This makes it difficult to
restore the submodules to the state they were in when a super-repo commit was
made.  To me this is unacceptable -- if commits don't encompass the entire
state of the repo (including its submodules) then they're pretty much
useless.  Well, maybe commits themselves don't need to do that, but I sure
need some way to restore the entire state of the repo.

I'm not sure there's a good or easy answer here.  I suspect that it should
always be up to the user whether or not submodule changes are included in a
commit.  The way git currently works, that means that a floating checkout
would always have a modified status when in fact it isn't really dirty but
merely smudged.

Wish I could propose a solution, but all I have are questions!

		M.
