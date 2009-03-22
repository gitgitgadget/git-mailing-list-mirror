From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Respect core.autocrlf when preparing temporary files for 
	external diff
Date: Sun, 22 Mar 2009 16:30:58 +0100
Message-ID: <bdca99240903220830u50999dfcnee0f0091b4dec835@mail.gmail.com>
References: <cover.1237635609u.git.johannes.schindelin@gmx.de>
	 <8cb424b16f21164ddc26d0be3f6f7727254b3506.1237635609u.git.johannes.schindelin@gmx.de>
	 <7vocvuekjb.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0903220053260.10279@pacific.mpi-cbg.de>
	 <7v8wmybf06.fsf@gitster.siamese.dyndns.org>
	 <7vzlfe9ynj.fsf@gitster.siamese.dyndns.org>
	 <20090322061046.GA14765@coredump.intra.peff.net>
	 <7v63i281py.fsf@gitster.siamese.dyndns.org>
	 <20090322074643.GA4826@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 22 16:36:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlPiU-0005hO-J0
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 16:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbZCVPbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 11:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754131AbZCVPbD
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 11:31:03 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:60168 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbZCVPbA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 11:31:00 -0400
Received: by yx-out-2324.google.com with SMTP id 31so1775691yxl.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 08:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UVglVIID4kS/0ofDda6AUEVqCBgfFsujvSFmTRRYseE=;
        b=wybntm8m2Mg3STf7+X363kxipfdPVmex1paF/w0su/hFvbx//ta/Hbq1mshYzRuvFH
         tMSFX/Q0Wq7AoZ2g5N5kSZkHZlhOYo1+UxRkhpk6t4gnw7kSLVFisw/oAvagkb0wQJLa
         fE3qKTvMVX/JrGZpOJuiQX8/3TAHGc4jO1lNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iFLwYg4y50rY46HzL8Pf4k+0UBHSVsZeYoMhanng5eOKueuanWGH7QwYKq1h16oH9B
         fsFfewSx8QYYSwjgMdn8vj93EuMxEI+hf+/nCvlGJnO5idl3s82Ryfo3Iz2zUEN2KyDV
         kp5lpc3+zfsZzKvhp2n+kmpW4hhuEmrnOqiTU=
Received: by 10.150.185.14 with SMTP id i14mr10953149ybf.114.1237735858125; 
	Sun, 22 Mar 2009 08:30:58 -0700 (PDT)
In-Reply-To: <20090322074643.GA4826@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114147>

>> While the purist in me says #1 above is the right argument to make for
>> feeding "clean" version, I suspect that the textconv or extdiff tools more
>> often are not made from scratch and ported across platforms than are
>> cobbled up together out of tools the script writer finds on his platform.
>> I suspect that Dscho's "a tempfile should look like a checkout" would be
>> much friendlier to them in practice for this reason.
>
> I think you and I have about the same feeling on this, then. As somebody
> who does not actually use smudge/clean filters at all, I am willing to
> defer to Dscho's opinion, which is based on practical experience.

Me being the reporter of the original msysGit issue #177, I'd like to
clarify that my intention not necessarily was to make
"core.autocrlf=true" affect temporary files (i.e. to "smudge" them),
but to ensure that the files fed into "git diff" are always generated
/ acquired in a consistent way, so that they are in fact comparable.
I'd also be happy with a solution that always feeds clean files into
"git diff", although that would probably mean that we could not reuse
working tree files if "core.autocrlf=true" is set.

Maybe it's a good idea to look at how gitk displays the diff, for an
orientation. If the diff gitk shows is based on smudged files, git
diff should probably also always be fed with smudged files, and if the
diff gitk shows is based on clean files, git diff should probably also
always be fed with clean files.

-- 
Sebastian Schuberth
