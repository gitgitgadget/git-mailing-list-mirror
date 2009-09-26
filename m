From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: [PATCH] Remove various dead assignments and dead increments found 
	by the clang static analyzer
Date: Sat, 26 Sep 2009 22:20:18 +0100
Message-ID: <3f4fd2640909261420h2588df4cld8dd3e49f9654e9e@mail.gmail.com>
References: <87ab0hepcn.fsf@master.homenet>
	 <alpine.DEB.1.00.0909261756510.4985@pacific.mpi-cbg.de>
	 <871vltefdj.fsf@master.homenet>
	 <fabb9a1e0909261134qd90dba1n9637fe4adc253fc1@mail.gmail.com>
	 <87ske9cya9.fsf@master.homenet>
	 <20090926204604.GA2960@coredump.intra.peff.net>
	 <3f4fd2640909261403n78a7e45cm3d2cd48408b5ff52@mail.gmail.com>
	 <20090926211220.GA3387@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Giuseppe Scrivano <gscrivano@gnu.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 26 23:20:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mregv-0003qC-H7
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 23:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbZIZVUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 17:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbZIZVUQ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 17:20:16 -0400
Received: from mail-vw0-f203.google.com ([209.85.212.203]:46026 "EHLO
	mail-vw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712AbZIZVUP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 17:20:15 -0400
Received: by vws41 with SMTP id 41so2192657vws.4
        for <git@vger.kernel.org>; Sat, 26 Sep 2009 14:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=QX4P7oeh/XZXCgPPQ/16wvFtYAbd+Ena/2xeDTAjhKE=;
        b=TUAbI3bPC4bNT/0en60BsxMnBFTWz7pvSO3nhPdHuIcmr73+fWwRqt/BgcA1ZzJ4Rf
         QwXinyv70ZSzEW6ANzh/jTeKR9hZ5F7kkNN6Sdg8+MJy7YRYAqq8Cw4lcL8nSUUX9/GX
         OHeg1s+8ol33bnbXZAxxT08GCeuLZjID4etaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XM+LlAR+Yp2rju/O/U0isjXwdeJtSXztxlknUfx7QVvJcxyJBexzgUp1L1ur4Y+C1m
         OQMDxJQ4P/zyGVsXoOBs3/gB/k9fP0Q9YTdsLmjj/YJ1gPAVLQqkMzYeL0VmqHCWtRiG
         yrQvm+HGlyvKw+0ftIbtzVO5d6YcUHN8l5znI=
Received: by 10.220.111.80 with SMTP id r16mr2928740vcp.76.1254000018816; Sat, 
	26 Sep 2009 14:20:18 -0700 (PDT)
In-Reply-To: <20090926211220.GA3387@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129181>

2009/9/26 Jeff King <peff@peff.net>:
> On Sat, Sep 26, 2009 at 10:03:27PM +0100, Reece Dunn wrote:
>
>> > Now this is one that I do think is sensible. The variable isn't used, so
>> > don't even bother declaring it.
>>
>> The status variable is removed in this patch.
>
> Yes. Sorry if I wasn't clear, but what I meant was "this does not fall
> under the same idioms as the other ones, and it is a fine thing to be
> removing".

Sure.

>> But then shouldn't the status returned be checked and acted on? That
>> is, are failures from run_command_v_opt being reported to the user, or
>> otherwise reacted to?
>
> Perhaps. This is the post-update hook, so at that point we have already
> committed any changes to the repository. Usually it is used for running
> "git update-server-info" for repositories available over dumb protocols.
>
> So there is no useful action for receive-pack to do after seeing an
> error. But I said "perhaps" above, because it might be useful to notify
> the user over the stderr sideband that the hook failed. Even though we
> have no action to take, the user might care or want to investigate a
> potential problem.
>
> I suspect nobody has cared about this before, though, because the stderr
> channel for the hook is also directed to the user. So if
> update-server-info (or whatever) fails, presumably it is complaining to
> stderr and the user sees that. Adding an additional "by the way, your
> hook failed" is just going to be noise in most cases.

It could be used to return an error status from main if it is used in
a chained command in a script. Other than that, I agree.

>> Thus having the same effect (removing the status variable). Callers of
>> run_update_post_hook should be checked as well, as should other
>> run_command_* calls.
>
> There is exactly one caller, and it doesn't care about the return code
> for the reasons mentioned above.

Including being called from a script?

- Reece
