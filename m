From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH 3/4] Head reduction before selecting merge strategy
Date: Wed, 26 Mar 2008 20:10:19 -0700
Message-ID: <402c10cd0803262010x4d707de0h3e5b6b28b5ecaf12@mail.gmail.com>
References: <402c10cd0803252058k2f35b33fr99ec7446235eeb6e@mail.gmail.com>
	 <7vlk45e9xn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 04:11:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeiWL-0002Ec-PH
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 04:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758561AbYC0DK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 23:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758549AbYC0DK0
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 23:10:26 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:21837 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758475AbYC0DKV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 23:10:21 -0400
Received: by fk-out-0910.google.com with SMTP id 19so5082457fkr.5
        for <git@vger.kernel.org>; Wed, 26 Mar 2008 20:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1ziDzeC19o4ICda+Tjcf0oSiYxkKWr/UEJiLFF/3SBI=;
        b=NaJE1ogg8oEnQJ1eDT2d+6zKMxmdIzDU1RVTYUsnI7r2EHwipzdSPYIW697TAjPRUJcXpx6M+za3wO3C81thnEMb0SK0udYVWrtzQS4IRnSydXpoagNW3lNjLC6DnIuZMLw3sYlVPZ//M6W0GzjyHY6N+ojoGM3mmDSlyhBvwpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qMog+j9S72LuL9UCeP50uFQsKptVR8aMAm103pjL/4Z3YxUVE94jj0qPPrMdGrIApLOO20668ialMvf+lj1obIEU2l0LonK9DL7fEgDPe/H+6t4YYJ4TDjbzb+mhUekQPABB5PGutrc4pUtRJnmJ42AC8RwAG26BC8JtRr1cw7U=
Received: by 10.82.187.2 with SMTP id k2mr1946359buf.26.1206587419310;
        Wed, 26 Mar 2008 20:10:19 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Wed, 26 Mar 2008 20:10:19 -0700 (PDT)
In-Reply-To: <7vlk45e9xn.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78323>

On Wed, Mar 26, 2008 at 9:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  In 3/4 you defined "real parents" as "the commits specified to be merged
>  from the command line", and you are picking only the independent ones out
>  of "real parents" to change the set of parents used for the merge
>  operation.  What is the reduced set called?

I was not happy about the split.  2/4 does not make much sense until
you read 3/4, and when you read 3/4 you are confused by 2/4.  Is it OK
that I squash these together again?

>  I think "real" vs "actual" is an invitation for "which is which"
>  confusion.  How about calling them "given" vs "reduced"?

Agree.  But reduced may not be reduced if --ff=never is specified.

>  Anyway, "the commit log message talks about the commits specified by the
>  end user, but the command outsmarts the user and does something different".

This is also the current behavior of git and I don't think anyone have
complained about it until now that we realize how git is actually
doing this.  We want the history to be as simple as possible when
presented in gitk, but the commit message should record what the user
asked for.   The commit message is used for later refferense.  The
commit message will usually only contain branch names which may or may
not make sense when we later look back the history.  That two branches
happen to point to the same commit or one is a fast forward of the
other is just a coincident.  I believe this is how most users want it
and I don't intend to change the log message.

>  > +... The
>
> > +real parents (only including `HEAD` if it is real) are the parents
>  > +recorded in the merge commit object.
>
>  Specifically, "does something different" above is "does not record some of
>  the commits given by the end user as parent commit of the resulting
>  merge".  Hence the name of the operation: "head reduction".
>
>  While I suspect that it would make sense to simplify parents, I do not
>  see why the seemingly deliberate discrepancy between what is recorded as
>  the parents (i.e. "reduced parents" on "parent " lines of the resulting
>  merge) and what the log message talks about (i.e. "given parents" you feed
>  to fmt-merge-msg) is a good idea.  Isn't it more consistent and easier to
>  explain to the users if they match?  Also it might be arguable that this
>  head reduction should be an optional feature.

If you use --ff=never it is turned off.

>  I suspect this would be a _very_ unexpected behaviour to untrained eyes
>  and would be a source of confusion.  You were on 'master' and merged many
>  things into it, but the resulting commit does not have 'master' as its
>  first parent.  So far, ORIG_HEAD would always have matched HEAD^1 unless
>  you fast-forwarded.  This alone may be a reason enough that this behaviour
>  can never be the default.

I am not sure we need to explain this in the manual.  What do you think?

This behavior is also the current behavior of git.  I don't think we
should care.  When we fast-forward, HEAD^1 may not match ORIG_HEAD
anyway.

-- 
Sverre Hvammen Johansen
