From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] Teach rebase to rebase even if upstream is up to date 
	with -f
Date: Fri, 13 Feb 2009 07:02:10 +0100
Message-ID: <bd6139dc0902122202r25e2e320m19810097cbb54225@mail.gmail.com>
References: <1234468061-29923-1-git-send-email-srabbelier@gmail.com>
	 <7vbpt7jq4c.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0902121357l1eea7b8xe890513b756e97c2@mail.gmail.com>
	 <7viqnfi6la.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0902121524o776703bdw1bb199caecbc9c21@mail.gmail.com>
	 <7vhc2zglz4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>,
	"Shawn O. Pear, Sverre Rabbelier <srabbelier@gmail.com>"@b-sasl-quonix.sasl.smtp.pobox.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 07:04:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXr9J-0000o3-Lr
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 07:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbZBMGCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 01:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbZBMGCN
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 01:02:13 -0500
Received: from mu-out-0910.google.com ([209.85.134.191]:11504 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbZBMGCM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 01:02:12 -0500
Received: by mu-out-0910.google.com with SMTP id i10so392118mue.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 22:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=ARStnCo6NLgYACLqoYQW3jNFVDreszw9sd/oGXvr6s0=;
        b=bx3BD9yNEMavboN2th8Ha1G1FwWvb4Tp2fysYI402BhBQ5hkw59DsNSlSoKxFo03S5
         PwBvYVorDOqv3WXez/UhBOIYATH0+k4R41GP7VdotnSG9jjaYN92i+Ge8xPgNN+tBJnU
         G01zwqpw907sI1Rj3nnZIgzSLAxK9/RFY5J8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=uY6Cgk1Ce3t8tjdMJG2zH7qZS9SOMDKHdoHEEUMT1Xq436OkrsG7tuMmlUiWumVVI1
         TVmeYLWxaigihLeGmQ2lkfL2wVtiX1zx391BUDgOt2BXgUF0JGauMnyYpKxd1ohbYgxU
         u2OYlMBLQ0uoGBbhFTtP17cWDxugvgxUkj7tg=
Received: by 10.86.70.3 with SMTP id s3mr78979fga.56.1234504930418; Thu, 12 
	Feb 2009 22:02:10 -0800 (PST)
In-Reply-To: <7vhc2zglz4.fsf@gitster.siamese.dyndns.org>
X-Google-Sender-Auth: b9dfcbf897944f8f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109709>

On Fri, Feb 13, 2009 at 02:32, Junio C Hamano <gitster@pobox.com> wrote:
> I wonder if we can (and if so should) make this a bit more automatic
> without having to say "rebase -f --whitespace=fix".

I have been thinking of that, having whitespace=fix imply -f, but I
wasn't sure whether it makes sense for all workflows that might use
rebase together with whitespace=fix. I aliased 'fixwhitespace' to
'rebase -f --whitespace=fix origin' myself, so I figured I'd send the
patch as-is and see what people think :).

> The logic is the same as "git rebase --interactive origin" that does not
> refuse to work even if you are already ahead of the origin.

This makes sense, and after thinking about it some, I don't really see
any harm in running 'git rebase --whitespace=...' even if the branch
is up to date.

> So my suggestion would be to add --force (or -f) like your patch does, and
> also detect --whitespace=$option given from the command line, and if it is
> fix (or its synonym "strip"), automatically enable --force, perhaps as a
> follow up patch, or in the same patch.

The patch to do so would be fairly trivial I think? That is, add
'force_rebase=t' in the --whitespace=... part. Is that change small
enough to be a single patch, or should it be a follow-up since the
first patch is a-means-to-an-end for the second one?

-- 
Cheers,

Sverre Rabbelier
