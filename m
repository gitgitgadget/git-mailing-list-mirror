From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] checkout, commit: remove confusing assignments to
 rev.abbrev
Date: Tue, 27 Jul 2010 16:09:08 -0500
Message-ID: <20100727210908.GA11317@burratino>
References: <19531.65276.394443.190317@winooski.ccs.neu.edu>
 <20100725130935.GA22083@LK-Perkele-V2.elisa-laajakaista.fi>
 <20100725221539.GA21813@burratino>
 <7vbp9uaii2.fsf@alter.siamese.dyndns.org>
 <20100726190448.GA32367@burratino>
 <7vzkxc7rpn.fsf@alter.siamese.dyndns.org>
 <20100727182942.GB5578@burratino>
 <20100727183706.GD5578@burratino>
 <1280261936.4462.6.camel@walleee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 23:10:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdrPw-0006KK-0d
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 23:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708Ab0G0VKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 17:10:23 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49340 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab0G0VKW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 17:10:22 -0400
Received: by eya25 with SMTP id 25so844079eya.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 14:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gnOLt0mJUOybi/KpuGuN62xP93IcjxKwLJ2e6S2TP+c=;
        b=oQW+f85yzA1rH+3hTb5xay+eKY5yJuUdY78RrcZuhn3UykP9JueSEpdsrJVEzpMmQJ
         RwPhVfk1O67Rq96QkWPuu8o349BqW6dygH4B+NhMzwgEYNvLYvJJUW4GlGMyRIOY2k+j
         4f/334ELbYCYcKgP1TwBTSAcwfDVb65qyHl0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=U7TnsEqKqYvagpRRvAVl5plN9OhP+ILRdu8lmHaDeWgbk6BJlMJ2lEayw8buiposoB
         65aHGVm7aqVS6q7PvOnB2sbU6+WVvuMZUobrPpMzJrbrWcF01a/CNVMC1sy/smfjX12T
         Lp5N4V2b1z08cMEs5194rsBL0sQkSJ4OHnoF4=
Received: by 10.213.28.141 with SMTP id m13mr7747272ebc.25.1280265020781;
        Tue, 27 Jul 2010 14:10:20 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a48sm8245585eei.19.2010.07.27.14.10.17
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 14:10:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280261936.4462.6.camel@walleee>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151988>

Will Palmer wrote:

> the purpose of the patch was to respect --abbrev instead of always
> abbreviating to a minimum of 7 characters. /Not/ to respect abbrev
> "instead of always abbreviating".

Sure, though it had that added effect.

One goal of that series was to be able to write formats like this:

	%C(commit)commit %H%Creset
	%M(Merge: %p
	)Author: %an <%ae>
	Date:   %ad

	%w(0,4,4)%B

to replicate the effect of --format=medium.  With diff-tree (and
rev-list before v1.7.0.6~1^2) that is not possible if %p abbreviates
by default.

Of course, v1.7.0.6~1^2 illustrates that no one seems to have been
relying on the format of Merge: lines, anyway, so I am not saying that
to make diff-tree --format=medium abbreviate by default would be a bad
change.

> Perhaps armed with that phrasing, a
> more general solution, such as equating "0" with "DEFAULT_ABBREV" rather
> than "no abbrev", could be applied?

Maybe.  If so, one would have to deal with the other callers that
explicitly set abbrev to 0.

 probably just confusing no-ops:

 - bisect.c::bisect_rev_setup
 - bisect.c::show_diff_tree (to imitate diff-tree: probably a no-op
   because there is no setup_revisions call)

 means FULL_SHA1:

 - diff-files.c::cmd_diff_files
 - diff-index.c::cmd_diff_index
 - diff-tree.c:cmd_diff_tree
 - revision.c::handle_revision_opt

Hope that helps,
Jonathan
