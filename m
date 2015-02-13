From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 8/8] reflog_expire(): lock symbolic refs themselves, not
 their referent
Date: Fri, 13 Feb 2015 09:16:30 -0800
Message-ID: <CAGZ79kbn=0VwZ6t3zE=BFGVeZqe5=H43gHLEzD2-OCar107abw@mail.gmail.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-9-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kaBGAOt-R1=mSG5H-5p=2UWjZEesktVwQcDAWFC-OW2Eg@mail.gmail.com>
	<xmqq61b8t65x.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaaQWRXhph=0g3SRHKXMoW8eAp7QG21yuWXWd7OW4M+uA@mail.gmail.com>
	<54DCDA42.2060800@alum.mit.edu>
	<CAGZ79kZgjRNS3zd4Tif6M66mjkP6-tDpy4FAtio8jiwqHxUtgw@mail.gmail.com>
	<54DE259C.4030001@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 13 18:16:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMJr1-0003dX-EW
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 18:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbbBMRQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 12:16:31 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:33933 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbbBMRQa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 12:16:30 -0500
Received: by iecrp18 with SMTP id rp18so5663746iec.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2015 09:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Qwy+PcAf+Ac3HDHEeXk/Je7HJ5Bg4xOc8s65BAU13ho=;
        b=LlYfB5vUCMnqm9Haj6CLgPpYt3rcGqsz2Ruh0sxhYH4vhgn2PXP7STiH0m/3rLNzrm
         6X1UvlAOi54o9J1u7YcVXdHOClgjoITGc9Hq5AEeWY/DMwIojt/xiT9YDre5XYufYqJp
         bDdgGNOsVxkvr/QOcvbb8rJ3t5InjKxAUK+jQEp90FgF1NYIPv4M0msZ0E2LuHAO1Xu2
         9MxQnByIQKl/N31sb32dORCVn9ZpqFwrqlAZkewyoIw3NYRFhWds5BGC9TTxI91czX1l
         L5zp/PFbN4S3hqhS1QH2mRKCmlNk7yDILpv30uLtn1CsB9sQf1x8BT6/c2j4JLnSodPW
         0gAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Qwy+PcAf+Ac3HDHEeXk/Je7HJ5Bg4xOc8s65BAU13ho=;
        b=AaPXk8c3R8uNSegzCWQR+gE5RK1M51uGfvMeOF3xU7mRZUGpTadz68E0y0mEGWgiw9
         GG3sxQE8CL/7TqA9tzpR01HNExXngYNO+BPI8AnZVNK5GIn/7nEZVDDnGjdfineGJdSE
         PbtWLbcq+6uHkhs0lm2xVZEw/mnK+5v9NmTR6qDBRjksyXTjW/As0Ykd2Bjt7bcapBTc
         Pu3dU9WPPSoXFa+FZGq3XXGJ6VzL4OjNBtYY1vkwItvJ75OszkmSnkuAn94Mu3qpvyJF
         NflCedHPqThhrY4ZSmRDOlFrKwjMsUnmx1i7069ZL6AxfQIrO0hoGIfQU3AhzYnL5k+/
         Z84w==
X-Gm-Message-State: ALoCoQmS4ExMBp/9T9fw6VxrQtOWDWIsCci59JSs9F7FFU1S+XHAf20PBhSu4Up22nxNULagI35W
X-Received: by 10.42.207.129 with SMTP id fy1mr15326121icb.17.1423847790166;
 Fri, 13 Feb 2015 09:16:30 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Fri, 13 Feb 2015 09:16:30 -0800 (PST)
In-Reply-To: <54DE259C.4030001@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263815>

On Fri, Feb 13, 2015 at 8:26 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>
> What is the best way forward?
>
> Switching to holding only "HEAD.lock" while updating "logs/HEAD" is the
> right solution, but it would introduce an incompatibility with old
> versions of Git and libgit2 (and maybe JGit?) Probably nobody would
> notice, but who knows?
>
> Therefore, I propose that we hold *both* "HEAD.lock" *and*
> "refs/heads/master.lock" when modifying "logs/HEAD" (even when running
> "reflog expire" or "reflog delete"). I think this will be compatible
> with old versions of Git and libgit2, and it will also fix some design
> problems mentioned above. Plus, it will prevent updates to the two
> reflogs from appearing out of order relative to each other.

Yeah, I agree on that. It's ok to lock both for now (it doesn't
really harm the user). But we really need to document it in the
source code why we lock both and that the 2nd lock can be removed
after time has passed, something like:

/*
 * We need to lock both the symbolic ref as well as
 * the dereferenced ref for now because of inconsistencies with
 * older and other implementations of git. Originally only the
 * dereferenced ref lock was held, but discussion($gmane/263555)
 * turned out, we actually want to hold the lock on the symbolic ref.
 * For now hold both locks until all implementation hold the lock on
 * the symbolic ref. (Feb/2015)
 */

>
> Someday, when old clients have been retired, we can optionally switch to
> locking *only* "HEAD.lock" when modifying "logs/HEAD".
>
> What do people think?
> Michael
>
> [1] https://github.com/libgit2/libgit2/issues/2902
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>
