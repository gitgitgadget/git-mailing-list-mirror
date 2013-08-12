From: David Jeske <davidj@gmail.com>
Subject: Re: ephemeral-branches instead of detached-head?
Date: Mon, 12 Aug 2013 12:05:09 -0700
Message-ID: <CA+CP9O6LG-dfeEKOCs48Qv9kSS4NqW1bKY8HrLeJmx2drqqSdg@mail.gmail.com>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
 <7veh9z1gym.fsf@alter.siamese.dyndns.org> <CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com>
 <CA+CP9O7--HXQdZXH9MJEh0VqdwpYqb052KYrvZqYhbfajpPG0A@mail.gmail.com> <CACsJy8A-aSjNdSkiBUBSH43G_FBMnShfpkcwQqM9-6d41rfCUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 21:05:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8xRF-0002AO-AB
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 21:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915Ab3HLTFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 15:05:53 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:53081 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429Ab3HLTFw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 15:05:52 -0400
Received: by mail-oa0-f49.google.com with SMTP id n10so10112225oag.22
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 12:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mvbX415QwpEaduyNy0mZmxUg3NQKwr9Pei7vaSPbCKo=;
        b=Ii30VRXzueES4MNWAo4qqaGmPvnziTNY6LyjrGj7vb61D7T//J5PfqMKwkEWzVkoJs
         aitW7ZGO3a/yRkMBmcE9tvCOn00Lm1dkCPXjIpUqjbBrm1HL00nc8iMg32zvLTqQdyTf
         PcL0Xi3IG6+alOI97JNW7cMiErsV6SSMq/DY3We2oIAnpN2/qRPVuOJdIyKiM06q4N29
         ihOMalVNWZi/siMiY6hcKOnl6iVGti2BEOGqgyufJKr7fLAZbexfCLc/ky+BuOFkVCef
         V4Gq2ngricn1LGAoXDwkTB3ZJ6wrvCFg1pNMIqZosa9hlMHWMzqcZz5Ac8oVjXBf6SVj
         AiPQ==
X-Received: by 10.60.76.72 with SMTP id i8mr474857oew.11.1376334350072; Mon,
 12 Aug 2013 12:05:50 -0700 (PDT)
Received: by 10.60.120.65 with HTTP; Mon, 12 Aug 2013 12:05:09 -0700 (PDT)
In-Reply-To: <CACsJy8A-aSjNdSkiBUBSH43G_FBMnShfpkcwQqM9-6d41rfCUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232204>

On Mon, Aug 12, 2013 at 6:23 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> That would annoy me as I often work on top of detached HEAD on purpose
> and only create a branch when I want to save something. If the warning
> is to be moved, it should warn at the next checkout.

Yes, you're absolutely right ...

My point about the current checkout warning is that it's crying wolf,
and nullifying the value of the warning. Most of the time I checkout a
ref, I'm not doing anything dangerous because I'm not going to check
anything in. The warning would be more effective if it warns in as
narrow a situation as possible. You're correct that the clobber is
even more narrow than the checkin.

The warning on clobber would be similar to (but shorter than) the one
which could be removed from checkout..

Clobbered detached HEAD 'cce40d6'!

   git log cce40d6 ^master      # log detached changes vs master
   git branch <name> cc340d6    # name the changes with a branch

Personally, I'd prefer for explicit action to discard a detached head.
It's true that this is an explicit step, but for me it generally takes
a heck of alot less time to explicitly discard than it did to checkout
the detached head, make changes (or apply a patch), and then decide to
throw them away.

My "ephemeral branch" idea was a way to make this explicit discard as
passive and lazy as possible. Basically, never stop you from doing
your work, assume you know what you are doing. If the user
names-the-branch it disappears. If the user merges or rebases the
detached head, it disappears. The only time the "ephemeral branch"
would survive is if the user really clobbered a detached head and then
didn't do anything about it. Even if they missed the warning (in the
middle of a script or automated process), eventually they would see
the ephemeral branch lying around.

Clobbering a detached head with "ephemeral branches" could show no
warning at all, or a warning like:

Clobbered detached HEAD.

   git log cce40d6 ^master           # log detached changes vs master
   git branch -D tmp/cce40d6         # Discard these changes
   git branch tmp/cce40d6 <newname>  # name this branch
