From: David Turner <dturner@twopensource.com>
Subject: Re: RFC: New reference iteration paradigm
Date: Thu, 31 Mar 2016 16:15:37 -0400
Organization: Twitter
Message-ID: <1459455337.2976.36.camel@twopensource.com>
References: <56FD4CAD.3070100@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 31 22:15:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alj0K-0000Da-Rp
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 22:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757755AbcCaUPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 16:15:40 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35287 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757692AbcCaUPj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 16:15:39 -0400
Received: by mail-qg0-f48.google.com with SMTP id y89so76589632qge.2
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 13:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=p/6z0vrgHvbYxmLjEJIDsZD0riUvWufgOaP73X8M6mM=;
        b=mtqDjP1l02z1Kg1QVPym4m8inlFdIWUPWWaIgTc7BHg6faXZWyG0NfSmUvSq0uUoIG
         YrXoNPtD6Bteyyv9j1+MPMVw7w/CtMrXQkYnXTt3QfrSbCrQc0rtBgAIyulob7Sp3ilh
         rCOgwWTG2WvFgXtHpHaDFNpLjDWb0MxVClTHN54d8am6Rybrem/B364exzw6bc2dAZ/l
         CFBz5SGspoLbJHwKxF/7m4Kg1gL/+1rjntLQm8we8IUSMQHjLb3tUVLohpYb+Ao+MW+L
         XyQcZ1AGVM7VNuZxlIQi+/kogTlJOWthBdzc5uIZumJM4vhZfj4+N6+RNRLXt2zWN/Uk
         HazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=p/6z0vrgHvbYxmLjEJIDsZD0riUvWufgOaP73X8M6mM=;
        b=NfPHUJPDPr7kj5fmfCfBbIaUUstUAv7PdY1XjKWdvRbidRzyypb2JynyKLS6aTeHnA
         O5NeFFZl9Xh7hlUpUXXPJuOMnX5Fpa+gnG0VxEkf92aI2+nq2/4NWQ3+gGzVKoLLPq3M
         7VNFp+a9FyJLCe0L8L3wRbftVw7ozVG3o//JoQztrvDZ18iQmOYeS46//1zIT5RxOkM+
         I0AZ+HzNyR/ZY6Sf1MGFFA87hVYA3eoAESFLHc2bm5Fti7gy+xNKApUjUV/eFPZJsp/+
         P2ew6WjKT/xMYAKkvjCih8hXucy2mtKSXVgIjUColHe6IBqeUdG7u8T6Nw/lrRj0lhFw
         0SWw==
X-Gm-Message-State: AD7BkJKSq1NvFyKWMjSxTFxD6ooklKLM8dY4CFMepNmi/t8gbi17JTa9Yg8MdQrlOP54Dw==
X-Received: by 10.140.96.137 with SMTP id k9mr19465419qge.23.1459455338894;
        Thu, 31 Mar 2016 13:15:38 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 139sm4605619qho.2.2016.03.31.13.15.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 Mar 2016 13:15:38 -0700 (PDT)
In-Reply-To: <56FD4CAD.3070100@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290461>

On Thu, 2016-03-31 at 18:13 +0200, Michael Haggerty wrote:
> Currently the way to iterate over references is via a family of
> for_each_ref()-style functions. You pass some arguments plus a
> callback
> function and cb_data to the function, and your callback is called for
> each reference that is selected.
> 
> This works, but it has two big disadvantages:
> 
> 1. It is cumbersome for callers. The caller's logic has to be split
>    into two functions, the one that calls for_each_ref() and the
>    callback function. Any data that have to be passed between the
>    functions has to be stuck in a separate data structure.
> 
> 2. This interface is not composable. For example, you can't write a
>    single function that iterates over references from two sources,
>    as is interesting for combining packed plus loose references,
>    shared plus worktree-specific references, symbolic plus normal
>    references, etc. The current code for combining packed and loose
>    references needs to walk the two reference trees in lockstep,
>    using intimate knowledge about how references are stored [1,2,3].
> 
> I'm currently working on a patch series to transition the reference
> code
> from using for_each_ref()-style iteration to using proper iterators.
> 
> The main point of this change is to change the base iteration
> paradigm
> that has to be supported by reference backends. So instead of
> 
> > int do_for_each_ref_fn(const char *submodule, const char *base,
> >                        each_ref_fn fn, int trim, int flags,
> >                        void *cb_data);
> 
> the backend now has to implement
> 
> > struct ref_iterator *ref_iterator_begin_fn(const char *submodule,
> >                                            const char *prefix,
> >                                            unsigned int flags);
> 
> The ref_iterator itself has to implement two main methods:
> 
> > int iterator_advance_fn(struct ref_iterator *ref_iterator);
> > void iterator_free_fn(struct ref_iterator *ref_iterator);
> 
> A loop over references now looks something like
> 
> > struct ref_iterator *iter = each_ref_in_iterator("refs/tags/");
> > while (ref_iterator_advance(iter)) {
> >         /* code using iter->refname, iter->oid, iter->flags */
> > }
> 
> I built quite a bit of ref_iterator infrastructure to make it easy to
> plug things together quite flexibly. For example, there is an
> overlay_ref_iterator which takes two other iterators (e.g., one for
> packed and one for loose refs) and overlays them, presenting the
> result
> via the same iterator interface. But the same overlay_ref_iterator
> can
> be used to overlay any two other iterators on top of each other.

I haven't looked at the code yet, but this makes sense to me.  In
general, the major reason to supply a callback style of API is when
iteration is more complicated than whatever will be consuming the data
(I can't remember where I heard this argument, but I found it pretty
convincing).  It seems like this is increasingly not the case, so we
should move towards the iterator style.
