From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Mostly Evil
Date: Fri, 02 May 2014 15:58:41 -0500
Message-ID: <53640701f135a_135215292ec1@nysa.notmuch>
References: <5363BB9F.40102@xiplink.com>
 <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
 <5363edc954f8e_70ef0f30c24@nysa.notmuch>
 <xmqqtx989c9d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 23:09:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgKi2-0001nU-QY
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 23:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbaEBVJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 17:09:23 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:52257 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbaEBVJV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 17:09:21 -0400
Received: by mail-oa0-f44.google.com with SMTP id n16so5874510oag.31
        for <git@vger.kernel.org>; Fri, 02 May 2014 14:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=oKcal3RnVEmxftgE1J3rsepsmCL9P0yIMwZ9v7OGGIo=;
        b=I+JX7X2LcjLvoRKWEFN0qN03TELk8h4AVBqbHZZaUNfgSOSSofhsCbv16efoWJzrgg
         h4xG21d2D3Q9DryQkzD84jAYd8wfQJ4j3EuO8nPujf8k9X4QnoGjWoqCEaDRY4O9vdFi
         VQBcPwJg526CwbkIAY+OTrVO1UUH915bdleVI3ZFzMR68MdNWk73MiAlRzHeDFpVBpwK
         5gPdR7te19c9/3JYPU6ZOAFeAuBqS7YJ52lK9oeqaVZZMQQDqgUJ9BpGMk4+EP+vpuXp
         lrT7c3QDGa1BSedFZ1kdIwJo2qqOeqoEptpC4xNZfb8gi5vOwJ/LZhB96mHxlUUd3dEX
         hdag==
X-Received: by 10.60.102.37 with SMTP id fl5mr3522246oeb.65.1399064960834;
        Fri, 02 May 2014 14:09:20 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id a7sm280496obf.19.2014.05.02.14.09.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 May 2014 14:09:19 -0700 (PDT)
In-Reply-To: <xmqqtx989c9d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247983>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> Stepping back even further, and thinking what is different between
> >> these two pulls, we notice that the first one is pulling from the
> >> place we push back to.  Perhaps a way to solve this issue, without
> >> having to introduce a new 'git update' and updating the tutorials,
> >> may be disallow fetch+merge by default only when pulling from the
> >> place the result is going to be pushed back to?
> >
> > Which is basically essentially the same as not specifying anything, or
> > rather, running `git pull` without arguments.
> 
> I cannot tell if you are agreeing or disagreeing, and with what.

I'm agreeing that 'git pull repo branch' is different than 'git pull',
and 'git pull' is the problem. I'm not certain about 'git pull repo',
but I think that probably shouldn't change either.

> Using the "special case 'git pull' without arguments" heuristics
> would take us back to the old jc/pull-training-wheel patch
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=230856

If you mean adding back the 'test $# = 0', then yes, if you mean going
back to 'pull.rebase=false' to force merges (and a bunch of other
stuff), then no.

> which we agreed to drop in
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/233554/focus=234365
> 
> to favor the old series you did with pull.mode, and we rejected that
> patch in $gmane/230856 for a sound reason, I would think.

Because the 'pull.mode=merge' mode option was simply sensible.

> "You are pulling from the place the result is going to be pushed
> back to" is different from "'git pull' was run without arguments".
> In the "pumpking" example in the message you are responding to:
> 
>     When he becomes in charge of producing a new 'maint' (in his
>     original, he says 'maintenance-branch'), he first does this:
> 
>         $ git checkout maint
>         $ git pull --ff-only [ origin maint ]
> 
> the heuristics would trigger the safety only when the optional
> "origin maint" are not given, but we do have enough information
> to see "git pull origin maint" (with where from and what to pull
> explicitly specified on the command line) falls into the case where
> the user needs protection, don't we?

I think 'git pull' and 'git pull origin maint' are different, regardless
of the fact that origin/maint is the upstream.

In the former I would expect 'maint' to be merged to 'origin/maint', in
the latter I would expect 'origin/maint' to be merged into 'maint'. And
if the user has specified that he wants to merge 'origin/maint' into
'maint', I don't see why a non-fast-forward should fail.
 
> Also, with the triangular push configuration, "git pull" without
> argument will fetch from one place that is different from where the
> current branch is going to pushed to, so that heuristics would not
> work at all.

I think that's irrelevant. Both the upstream and publish tracking
branches don't matter when the user has specifically asked for a branch
to be pulled.

-- 
Felipe Contreras
