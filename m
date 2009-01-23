From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [RFC/PATCH v3 3/3] archive.c: add basic support for submodules
Date: Fri, 23 Jan 2009 22:15:21 +0100
Message-ID: <8c5c35580901231315va79d89bu6e323d47a1b3547e@mail.gmail.com>
References: <1232659071-14401-1-git-send-email-hjemli@gmail.com>
	 <1232659071-14401-2-git-send-email-hjemli@gmail.com>
	 <1232659071-14401-3-git-send-email-hjemli@gmail.com>
	 <1232659071-14401-4-git-send-email-hjemli@gmail.com>
	 <alpine.DEB.1.00.0901230044300.3586@pacific.mpi-cbg.de>
	 <8c5c35580901231040i380c6458x1a6103cd6f55c479@mail.gmail.com>
	 <7vzlhhu8qo.fsf@gitster.siamese.dyndns.org>
	 <8c5c35580901231215q2be36abbla443975cdbb031f0@mail.gmail.com>
	 <7vljt1u4pc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 22:16:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQTOS-00053c-5h
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 22:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755454AbZAWVPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 16:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755429AbZAWVPY
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 16:15:24 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:21112 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755183AbZAWVPX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 16:15:23 -0500
Received: by wa-out-1112.google.com with SMTP id v33so49769wah.21
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 13:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/oGE8jhuKrjQnCEkw+fGhHJaLZudbi4+Rk4z5p8Kt50=;
        b=hA0Z/PYUkCL46ukVdzo3N4Q+Ij/DFg6TKZGQ3uzx7ZNuBNXvePFIoKY3t6iwNioDLY
         DpZXRKIfr7CoJesp1jv3zcq37dzLNpE05yn3NWp1IzLG1PoBSlvYthcAzy4ebKDqdR3m
         AqlNdP89bgHGL3exPaMmyCEfp5e8XCxSqPPQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=R1widXCk3ockJzMAeXwrvVKY97dd58VrXO1hCQmKn9P3xXJ8RBamBM9zGK87WEie7E
         KKagg8qtEv8V/890egTjmak1EHCtPQ57NUbf8xWHkZwtPFfp7JmAs++i+DR/wxsabsU0
         moB+W91q4/45m+9liIrmYRidrPAgsL73Z+WYY=
Received: by 10.115.94.1 with SMTP id w1mr105750wal.30.1232745321885; Fri, 23 
	Jan 2009 13:15:21 -0800 (PST)
In-Reply-To: <7vljt1u4pc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106915>

On Fri, Jan 23, 2009 at 21:50, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
>> I would find the H flag practical for my own usage of submodules. I
>> almost never modify the content of the currently checked out submodule
>> but I often check out a different HEAD than what is registered in the
>> gitlink in the superproject (typically due to testing the superproject
>> against different versions of the submodule). And for such a use case,
>> being able to create a tarball of my currently checked out state seems
>> useful to me.
>
> That would be more like an enhanced version of "git archive" that takes
> the work tree state, similar to how "git grep" operates on the work tree
> today.
>
> I agree that would be useful, but I have a moderately strong suspition
> that your "H" hack that includes the work tree state for checked out
> submodules into a view that is primarily about the "tree" object in the
> superproject, without the same "take from the work tree" semantics for
> paths in the superproject, is more harmful than being helpful to the users
> in the longer term.  It might be simple to implement, but I do not think
> its semantics can be explained sanely.

Ok. When someone gets the itch for 'git archive --worktree', it would
be easy enough to resurrect the idea of including the tree of the
currently checked out HEAD in selected submodules.

Do you think the other options makes any sense, i.e. is it any point
in me trying to implement this?

--
larsh
