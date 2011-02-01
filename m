From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] Change branch --set-uptream to take an argument
Date: Tue, 01 Feb 2011 13:15:36 -0800
Message-ID: <7v7hdj1mo7.fsf@alter.siamese.dyndns.org>
References: <AANLkTinUn2SMijphe3EmPMVOOwBjPB5ffFwwqZVxQmW0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 22:15:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkNZs-0006UK-VY
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 22:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216Ab1BAVPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 16:15:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37524 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075Ab1BAVPq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 16:15:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5E77743F2;
	Tue,  1 Feb 2011 16:16:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7s1GNzVzpIwi9anZZmFevQFNnfU=; b=BSJUBA
	CYx67zBLZDQPzzBKC57uVLDH7wyH18kdk6TSsl+5Ryiu2HlExuhAVoor9T+spiuO
	mzg8X5GNjbwCh4vOh0w00E726Rw797DuGAVtBJ4Ch/7EqKedTKTANFSn/GxWD85x
	sGDJcGvS6xyIflLaQdDUQVBqOJNcog25/62S8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TJ9J42P5t0hhaL7/4WSlyJIMvPZ3jQ9n
	V8fDl2IRu9/LB7flXw25wh3Y94I7wAzyRiUMlR+F5U4rxrmsw/9FwnZ0YOiN5SO4
	GQldpoQXgfca+n7by6STnfYQw6efyGmV1ny1pawhBHqL1QjjND0zaVGlIGTIna38
	1kTu2FbVerM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3A86043F1;
	Tue,  1 Feb 2011 16:16:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 085BB43ED; Tue,  1 Feb 2011
 16:16:30 -0500 (EST)
In-Reply-To: <AANLkTinUn2SMijphe3EmPMVOOwBjPB5ffFwwqZVxQmW0@mail.gmail.com>
 (Jay Soffian's message of "Tue\, 1 Feb 2011 01\:57\:03 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8BE9CBCA-2E48-11E0-9D42-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165856>

Jay Soffian <jaysoffian@gmail.com> writes:

> Proposal:
>
> Currently it is very easy to misinvoke --set-upstream if you assume it
> takes an argument:
>
> e.g.
>
>   (master)$ git branch --set-upstream origin/master
>   Branch origin/master set up to track local branch master.

With "git branch <name>" (or for that matter "git branch -d <name>"), we
are manipulating some attribute of the branch <name> (namely, "what does
it point at", "does it exist?") not of the current branch.  So it is
natural to expect that some attribute of the named branch origin/master is
being changed.

> In order to make its usage unambiguous, and to allow it to be used w/o
> specifying the current branch, require it to take an argument like so:
>
>   (master)$ git branch --set-upstream=origin/master

Even though I think I understand the issue you are trying to tackle, I
think your proposal seems to make things worse.  In either "--set-upstream
A" or "--set-upstream=A", it is unclear if you are manipulating "what
other branch does this follow" attribute of A or the current branch.

I think it was a misdesign to allow --set-upstream without argument to
default to the current branch.  Wouldn't it be simpler to just fix the
parser so that "--set-upstream A" and "--set-upstream=A" both mean the
same thing?  The branch whose attribute is manipulated defaults to the
current one in either case.

IOW, I don't think

>   (master)$ git branch --set-upstream origin/master
>   Branch origin/master set up to track local branch master.

is a sane behaviour from day one, and is simply a bug.  Changing this
behaviour would merely be a bugfix, not a flag-day event that changes an
established behaviour.

But that may be just me.  I don't use --set-upstream myself, and people
may have learned to be comfortable with the current behaviour.

        If there are people who want to keep the current behaviour, please
        speak up.  Then we can introduce the usual migration procedure to
        first add a configuration to flip the behaviour (default off),
        then warn if you use 0-argument --set-upstream to default to the
        current branch without setting the configuration, and eventually
        flip the default to always require argument to --set-upstream.

> (I've misinvoked it so often, I've had to train myself to always
> invoke it this way: git branch master --set-upstream origin/master)

If "git branch master --set-upstream origin/master" is accepted, we have
another bug in its parser to fix.  The canonical command line should
always be dashed-options, then refs and then pathspecs.
