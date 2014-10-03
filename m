From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: Submodules and GIT_ALTERNATE_OBJECT_DIRECTORIES
Date: Fri, 03 Oct 2014 13:56:00 +0200
Message-ID: <87tx3l4ban.fsf@steelpick.2x.cz>
References: <878ul19r5y.fsf@steelpick.2x.cz> <542E85B5.3020101@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Vokac Michal <michal.vokac@comap.cz>
To: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 14:01:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa1Y9-0008ME-I8
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 14:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbaJCMBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 08:01:22 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:53060 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbaJCMBV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 08:01:21 -0400
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Oct 2014 08:01:21 EDT
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id 36A695CCF7B;
	Fri,  3 Oct 2014 13:56:05 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id WNLeEnfkNTyt; Fri,  3 Oct 2014 13:56:00 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 897245CCF76;
	Fri,  3 Oct 2014 13:56:00 +0200 (CEST)
Received: from wsh by steelpick.2x.cz with local (Exim 4.84)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1Xa1Sq-00024Y-8H; Fri, 03 Oct 2014 13:56:00 +0200
In-Reply-To: <542E85B5.3020101@web.de>
User-Agent: Notmuch/0.18.1+101~g56b0ff0 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257838>

On Fri, Oct 03 2014, Jens Lehmann wrote:
> Am 30.09.2014 um 15:25 schrieb Michal Sojka:
>> I'd like to shorten the time needed by our continuous integration (CI)
>> tool to clone the source repositories. Currently the full clone takes
>> about 10 minutes (even from local server). Our main repository has
>> several submodules so the CI tool runs "git submodule update --init". My
>> idea was to use GIT_ALTERNATE_OBJECT_DIRECTORIES to cache objects from
>> several submodule repositories locally. However, this does not work
>> because GIT_ALTERNATE_OBJECT_DIRECTORIES is considered local to the
>> super-project and is not propagated to the "git clone" for submodules
>> (git-submodule.sh calls clear_local_git_env).
>  >
>> My question is why is GIT_ALTERNATE_OBJECT_DIRECTORIES considered local
>> to the repository? If I could modify the command-line I would use the
>> "git submodule update" with the --reference option, which is propagated
>> to clones of all submodules. Letting GIT_ALTERNATE_OBJECT_DIRECTORIES
>> propagate to the submodules should have the same effect as --reference
>> option. So why it is not propagated?
>
> Because then it would /always/ propagate? So while that would have the
> same effect as using the --reference option, not using the --reference
> option would behave differently, no?

That's a good reason, thanks. Fortunately, I found a way how to add
--reference to the submodule update command issued by the CI tool
(Bamboo). Instead of calling git directly, the CI tool calls my "git"
script, which modifies the command line in case of "submodule update"
and then calls the real git.

Best regards,
-Michal
