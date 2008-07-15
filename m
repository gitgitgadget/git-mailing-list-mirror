From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 15 Jul 2008 09:48:51 -0700
Message-ID: <7f9d599f0807150948x14c09b0dmb932e86378f0c46d@mail.gmail.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
	 <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
	 <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
	 <7vprpwhp7t.fsf@gitster.siamese.dyndns.org>
	 <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org>
	 <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org>
	 <7vabgqsc37.fsf@gitster.siamese.dyndns.org>
	 <7vtzetjbif.fsf@gitster.siamese.dyndns.org>
	 <7f9d599f0807142038w62ccb69fv42d6dcf3dd4f2afd@mail.gmail.com>
	 <alpine.DEB.1.00.0807151117450.3487@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 15 18:50:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KInjD-0004U7-FS
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 18:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856AbYGOQsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 12:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752960AbYGOQsx
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 12:48:53 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:62150 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029AbYGOQsw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 12:48:52 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6083610rvb.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 09:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=F0tV4KiJGhGeeUvO8M/UMgckA/ojfRrqo+p+C5VC7Go=;
        b=LwE4hYF4YgfiPAORQfaLQ6m515awOPQEHhj69PomHBP21LcacyUTsOzyTe3Kh0aELf
         E+eZGiRrt3dy6yOUqne3ou6w8iMnP43tfRDb/mrlb08dUWi1Jl+BNUt4/7ChZk/rSXbz
         HyP4wyVdKL6mLRMVv4THTYRGGSFZ+ZuWpBD48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=WnK6CEhUs1HOUyNCQc0jdDBgXVrPh6OLB9rOxiEMYGtX8RFRmkCyCX86tvAdT9ApMD
         VvdHhaV49Ae52Lbj1wA0oR2jzk7x7WvGofgHXbc+u/MtIfqKk53XmJJ98SKlc/c6QXRp
         RJbVqXWd3wmxc2KSM3vV91NuAQLU7AQplcnY4=
Received: by 10.140.127.20 with SMTP id z20mr7586254rvc.77.1216140532152;
        Tue, 15 Jul 2008 09:48:52 -0700 (PDT)
Received: by 10.141.202.6 with HTTP; Tue, 15 Jul 2008 09:48:51 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807151117450.3487@eeepc-johanness>
Content-Disposition: inline
X-Google-Sender-Auth: 9f9b9edc7ebe8ec3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88579>

On Tue, Jul 15, 2008 at 2:22 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 14 Jul 2008, Geoffrey Irving wrote:
>
>> The problem (beyond the basic problem of me not having tried running the
>> tests) is that the current caching code isn't taking into account the
>> changing values of diff_options.  t6007 computes a patch-id for a commit
>> with one value of options.paths, and then tries to compute a _different_
>> patch-id for the same commit using a different value of options.paths.
>>
>> Here are a few different ways of fixing this:
>>
>> 1. Modify commit_patch_id in patch-ids.c to compute a sha1 of the
>>    diff_options structure and xor it with the commit sha1 to get a truly
>>    unique hash of the input.  This means the optimization can be safely
>>    applied for all patch-id computations regardless of the diff_options.
>>    I can add a diff_options_sha1 function in diff.[ch] to compute the
>>    checksum.
>>
>> 2. Restrict commit_patch_id in patch-ids.c to apply the optimization
>>    only if options.nr_paths is zero, and perhaps a few other conditions.
>>    This is rather fragile, since it would mean that the cache would
>>    break if someone decided to change the default diff options.
>
> Funnily, (2) contradicts (1).  The patch id is _different_ when you have
> nr_paths > 0.  At least in the general case.
>
> So what you propose in (1) will not work, unless you also hash the path
> names (in the correct order, otherwise you'll end up with two hashes).

The sha1 would include paths, of course, since it's part of diff_options.

> OTOH I would be really surprised if you needed --cherry-pick with paths
> and/or diff options more than once for the same commits.  So the caching
> does not make sense to begin with (especially since we do not have a
> proper way of gc'ing it, right?).
>
> So I'd suggest saving diff_opts before the command line parsing, and
> disable the cache when it is different _and/or_ (||) nr_paths.

I'll attach the patch to the other thread.

Geoffrey
