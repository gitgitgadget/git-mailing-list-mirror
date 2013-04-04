From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Thu, 04 Apr 2013 22:28:19 +0200
Message-ID: <515DE263.2000105@web.de>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com> <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com> <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com> <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com> <7va9pehzql.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 22:29:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNqmY-0002sM-Jh
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 22:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764800Ab3DDU2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 16:28:24 -0400
Received: from mout.web.de ([212.227.15.4]:56434 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764450Ab3DDU2X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 16:28:23 -0400
Received: from [192.168.178.41] ([79.193.90.93]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0Lh6QF-1V0TIp3MMZ-00oAjB; Thu, 04 Apr 2013 22:28:21
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7va9pehzql.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:Tcm04jEixI9q5nA9YdEm8nKFhAsGmhMUEfgAwquYtRJ
 uyl553hvRLsEiglZ6D6LYiOciYu4VJKTD4IHl1eMZx9yh+062K
 m3SMCw8iQ2F7E5W1tmLEwXqf+dpnHka0rhzgqr7Jno6Gp9MNbK
 WA22CUU/7sU0cGdgHwUtMDN3Lag2pmwtileonykTSz5wNL3KTG
 gRy5NJo5dLoG1BjmitqDQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220091>

Am 04.04.2013 21:17, schrieb Junio C Hamano:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
>> ... The features you seem to be after (ie that whole
>> floating/refname thing) don't seem fundamentally antithetical to the
>> current model (a "commit" SHA1 of all zeroes for floating, with a new
>> refname field in .submodules? I dunno)..
> 
> Just on this part.
> 
> I think Heiko and Jens's (by the way, why aren't they on the Cc:
> list when this topic is clearly discussing submodules?  Don't we
> want to learn how the current submodule subsystem is used to solve
> what real-world problems?) .gitmodules updates is exactly going in
> that direction.
> 
>  - A submodule can be marked as floating in .gitmodules and be
>    specified how (typially, "use the tip of this branch in the
>    submodule");
> 
>  - Running "submodule update" a floating submodule does not detach
>    the submodule working tree to commit in the index of the
>    superproject; instead it will use the specified branch tip;
> 
>  - A floating submodule records a concrete commit object name in the
>    index of the superproject (no need to stuff an unusual SHA-1
>    there to signal that the submodule is floating---it is recorded
>    in the .gitmodules).  Thanks to this, a release out of the
>    top-level can still describe the state of the entire tree;
> 
>  - It would be normal for the commit recorded in the index of the
>    superproject not to match what is checked out in the submodule
>    working tree (i.e. the tip of the branch in the submodule may
>    have advanced).  A traditional non-floating submodule has many
>    mechanisms to be noisy about this situation to prevent users from
>    making an incomplete commits, but they may have to be toned down
>    or squelched for floating submodules.
> 
> Anything I missed, Jens, Heiko?

Nope, that perfectly sums it up.
