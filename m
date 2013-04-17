From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: "What's cooking" between #05 and #06
Date: Wed, 17 Apr 2013 23:25:07 +0200
Message-ID: <516F1333.5070804@web.de>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org> <7v8v4ihw41.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 23:25:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USZr0-0005vX-AN
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 23:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966811Ab3DQVZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 17:25:17 -0400
Received: from mout.web.de ([212.227.17.11]:49647 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965128Ab3DQVZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 17:25:16 -0400
Received: from [192.168.178.41] ([91.3.145.117]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0LiCrz-1Uwhap3YcF-00mfkD; Wed, 17 Apr 2013 23:25:09
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7v8v4ihw41.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:IxNadisCRsWGBy/2FAn6UnnC5jLFemKWEZA6TPnO7ey
 dQzCtG510Qqg3DRv7pS5ksDHn8dyyq3/VDNGtWqWvDZazl2HxU
 DanSlOHu1Fv9S8SekEaxgHyss5LxJuOFSA/axGkNalD1bWOce5
 A2t6WUIvsz0nlMV5cDegD0Uxd/O5oKct1UwFZLzwbLZwkXJRlJ
 nbU2ng0c3GdldzmRzL7xA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221575>

Am 17.04.2013 01:52, schrieb Junio C Hamano:
>> * jk/submodule-subdirectory-ok (2013-04-10) 2 commits
>>  - submodule: drop the top-level requirement
>>  - rev-parse: add --prefix option
>>
>>  Allow various subcommands of "git submodule" to be run not from the
>>  top of the working tree of the superproject.
>>
>>  Waiting for comments.
> 
> Any submodule users wants to weigh in?  The code looked fine, but I
> do not heavily use it (and the repository with a submodule I have, I
> do not have a "subdirectory" ;-, so I am a bad guinea pig).

I like it, as it gets rid of the top-level requirement. But from
my testing it looks like we're not quite there yet.

'summary' and 'status' behave as if they were run in the toplevel
directory, while a "git status" shows all filenames relative to the
current directory. Me thinks 'summary' and 'status' (and all other
submodule commands) should behave like status and print relative
paths too. I'm not really sure yet how $sm_path should behave for
'foreach', but I suspect having it relative to the current
directory would be the way to go (which it currently isn't).

When "submodule add" is run with a relative path it is relative to
the top-level directory, which I find confusing (and won't play
well with shell completion).

'deinit .' doesn't deinit submodules above the current directory
(but prints the path relative to top-level) while 'init' will
initialize all submodules known to the superproject.

So this is a good start, but it looks like there is some work left
to do before this can hit master.
