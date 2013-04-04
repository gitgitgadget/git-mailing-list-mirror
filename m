From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Fri, 5 Apr 2013 01:06:40 +0530
Message-ID: <CALkWK0mQt7cE0zUECDF4ZC2-9Q+pEL=XGPdaOksyWzae2_W1CA@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
 <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com> <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 21:37:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNpyo-0008FI-Uo
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 21:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764664Ab3DDThW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 15:37:22 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:59308 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764661Ab3DDThV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 15:37:21 -0400
Received: by mail-ie0-f175.google.com with SMTP id c12so3414024ieb.20
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 12:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=zSd7tP6YcMWhshAinsYcKkk0m/CCQDczot1h84QV174=;
        b=qHy6G19Ag38Ypg76KvzP/tt9Jv2Gv4ZPCoI1E14XNiZXRaCeqpIIkPU3WbR3uwSXux
         +m9VCMo5qriqMUXS/nc3T0WxcqBeOLm+HPEapmZLymkrKzpNK9jWxO3s9eKsSNkdbA+n
         tsjJlvpAf5Iv/oPq+uGHtz4znHVYKzOs418BNGRJ08tTgquSDOGYWVYEUlVLHklAT0uJ
         cHbyAu+Ok7G77DZaZc1nBZBSUXgfAUsRpW/vXJq60BDv+NR/GZTgVMobBoxiacGvfkuS
         rklR7WVS3eYKBVfpg2xbg3JoFLEmkvF0sdYMDqP8H5r7v8AWm/0+8yU7I4SpAvC9KijF
         wgqw==
X-Received: by 10.42.204.79 with SMTP id fl15mr3871040icb.57.1365104240787;
 Thu, 04 Apr 2013 12:37:20 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Thu, 4 Apr 2013 12:36:40 -0700 (PDT)
In-Reply-To: <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220076>

Linus Torvalds wrote:
> So the thing is (and this was pretty much the original basis for
> .gitmodules) that pretty  much *all* of the above fields are quite
> possibly site-specific, rather than globally stable.
>
> So I actually conceptually like (and liked) the notion of a link
> object, but I just don't think it is necessarily practically useful,
> exactly because different installations of the *same* supermodule
> might well want to have different setups wrt these submodule fields.
>
> My gut feel is that yes, .gitmodules was always a bit of a hack, but
> it's a *working* hack, and it does have advantages exactly because
> it's more fluid than an actual git object (which by definition has to
> be set 100% in stone). If there are things you feel it does wrong
> (like the "git add" bug that is being discussed elsewhere), I wonder
> if it's not best to at least try to fix/extend them in the current
> model. The features you seem to be after (ie that whole
> floating/refname thing) don't seem fundamentally antithetical to the
> current model (a "commit" SHA1 of all zeroes for floating, with a new
> refname field in .submodules? I dunno)..

Let's compare the two alternatives: .gitmodules versus link object.
If I want my fork of .gitmodules, I create a commit on top.  If I want
my fork of the link object, I create a link object, plus tree object,
plus commit object on top of that.  But the commit still rebases fine.

On malleability, have you looked at [5/7], where I create edit-link
(dead code; half done)?  The buffer looks just like a .gitmodules
buffer.  Fundamentally, what is the difference between this and a
blob?  git-core can parse it into structured data that it can slurp
easily.

I don't want full float or nothing.  I want in-betweens too, and refs are great.
