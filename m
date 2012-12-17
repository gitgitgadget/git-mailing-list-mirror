From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: How to specify remote branch correctly
Date: Mon, 17 Dec 2012 15:27:46 +1100
Message-ID: <CAH5451=7frqa-YHXubvO=dMK2CvVoWR-VFZ3XCmKouNiQz4gAg@mail.gmail.com>
References: <slrnkct0r3.dsp.narkewoody@zuhnb712.local.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Woody Wu <narkewoody@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 05:28:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkSJZ-0002jv-Be
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 05:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049Ab2LQE2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 23:28:08 -0500
Received: from mail-qc0-f180.google.com ([209.85.216.180]:56180 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab2LQE2H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 23:28:07 -0500
Received: by mail-qc0-f180.google.com with SMTP id v28so3603776qcm.11
        for <git@vger.kernel.org>; Sun, 16 Dec 2012 20:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GLKIhNI6MLbGVcW2bHYnfMTFD5oSyjyg8rcy4C9fgds=;
        b=I/CZHUAGmSF5beZ321e3i5fFowCkdqwtnJ0I1uCg4qk7u1DT1wSXkJnUTEIsOsWGUT
         QOyk5B6AAa9h7UEEABdc5aGvY5657xrhYbPHRa9u+fRckyAUqflUh50NNFTabnQAZWDf
         R13Swg/1rr4Ktp2bsxT5iLD1l30Scr6hult7SIRahxX+/pPkB/YYk+O7nQg1bkiFuh/J
         F1R609D/gx7wm2tm0UI/crqnZk/T8wsDSEEvdBA4F3N6JNGxz+ZnqJcX8JL+bDb8cZSA
         5TrKQjkO1Qc9SADLGFymMsWLfS5P3QqL5QpTqRZZw//Dq1wYAwab/TN8GjfK1QkrsYQs
         +JKA==
Received: by 10.49.118.138 with SMTP id km10mr6335368qeb.18.1355718486104;
 Sun, 16 Dec 2012 20:28:06 -0800 (PST)
Received: by 10.49.14.3 with HTTP; Sun, 16 Dec 2012 20:27:46 -0800 (PST)
In-Reply-To: <slrnkct0r3.dsp.narkewoody@zuhnb712.local.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211626>

On 17 December 2012 13:30, Woody Wu <narkewoody@gmail.com> wrote:
> 1. git checkout foo
> 2. git checkout origin/foo
>
> The first method run silently with success, but the second method
> complains that I got a 'detached HEAD'.  So, I think I don't understand
> the difference between 'foo' and 'origin/foo'.  Can someone give me a
> hint?

Hi Woody,

I think you are just missing a couple of important distinctions that
git makes about the different references that exist in your
repository.

A remote reference (origin/foo) describes exactly the state of
somebody else's branch at the time you last synchronised with them. It
does not make sense for you to be able to 'edit' this state, as it
doesn't belong to you. Instead, we create a copy of that reference and
give it a name (git checkout foo origin/foo) and call this a local
reference (foo). Git then provides machinery around keeping these in
sync with each other (git branch --set-upstream foo origin/foo) but we
don't _have_ to keep these in sync at all! In fact, the names can be
completely arbitrary and we don't have to track the upstream at all.

If I have some other remote (remote-x) that has the same branch as
origin but with some other changes I want to look at, we can just
check that out to another branch (git checkout remote-x-foo
remote-x/foo), or simply download it as a remote ref and merge the
changes on top of my existing local branch (git fetch remote-x; git
checkout foo; git merge remote-x/foo).

There are lots of patterns that can emerge from this functionality,
but the main thing to remember is that to create changes on top of a
remote branch, we first need to create a local copy of it. A 'detached
HEAD' here means that we are looking at the remote repository's branch
but don't have a local copy of it, so any changes we make might be
'lost' (that is, not have an easy to find branch name).

Regards,

Andrew Ardill
