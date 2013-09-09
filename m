From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Mon, 09 Sep 2013 17:48:49 -0400
Message-ID: <522E4241.1040105@bbn.com>
References: <20130908041805.GB14019@sigill.intra.peff.net> <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com> <20130908172605.GF5359@vauxhall.crustytoothpaste.net> <CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com> <20130909000153.GG5359@vauxhall.crustytoothpaste.net> <CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com> <vpqr4cy4g5q.fsf@anie.imag.fr> <xmqq1u4x4yst.fsf@gitster.dls.corp.google.com> <20130909195231.GA14021@sigill.intra.peff.net> <20130909202435.GJ2582@serenity.lan> <20130909204415.GC14536@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 23:49:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ9KX-00011D-D7
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 23:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539Ab3IIVs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 17:48:59 -0400
Received: from smtp.bbn.com ([128.33.0.80]:19864 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752806Ab3IIVs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 17:48:58 -0400
Received: from socket.bbn.com ([192.1.120.102]:55426)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VJ9KE-000L5l-Ag; Mon, 09 Sep 2013 17:48:50 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 0E64A3FFAE
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <20130909204415.GC14536@sigill.intra.peff.net>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234382>

On 2013-09-09 16:44, Jeff King wrote:
> On Mon, Sep 09, 2013 at 09:24:35PM +0100, John Keeping wrote:
>> I think we need to make sure that we give instructions for how to go
>> back if the default hasn't done what you wanted.  Something like this:
>>
>>     Your pull did not fast-forward, so Git has merged '$upstream' into
>>     your branch, which may not be correct for your project.  If you
>>     would rather rebase your changes, run
>>
>>         git rebase
>>
>>     See "pull.mode" in git-config(1) to suppress this message in the
>>     future.
> 
> Yes, that's a good point. I don't know if just "git rebase" is the right
> advice, though; it would depend on whether we were actually pulling from
> the upstream or not.

Another reason 'git rebase' might not be the right advice:  We don't
want to encourage users to flatten intentional merges.  For example:

    $ git checkout master
    $ git merge --no-ff just-finished-feature-branch
    $ git push
     ! [rejected]        master -> master (non-fast-forward)
    $ git pull
    WARNING: Your pull did not fast-forward [...] run git rebase

If 'git rebase' is run here, the commits on just-finished-feature-branch
will be linearized onto @{u}, which is not what the user wants.

Perhaps one could argue that a user that gets into this situation and is
normally comfortable running 'git rebase' is already experienced enough
to know to ignore the advice to run 'git rebase'.

(Sidenote:  Unfortunately there's not an easy way to recover from this
case without adding another merge commit.  But that's a topic for
another thread.)

-Richard
