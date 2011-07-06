From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 12/14] revert: Introduce --reset to cleanup sequencer data
Date: Wed, 6 Jul 2011 05:14:23 -0500
Message-ID: <20110706101423.GI15682@elie>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-13-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 12:14:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeP7p-0004rZ-0X
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 12:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914Ab1GFKO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 06:14:28 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42656 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab1GFKO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 06:14:27 -0400
Received: by iwn6 with SMTP id 6so5948280iwn.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 03:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MKBl0Lh5aT4nO+kCDX6x+ZUYOU9YdhnduiGoJX7bkXo=;
        b=qKGvVw2RM1Pkr7BRv6n8d0SpIFNJz4MfKfKvfQ2W1KVMVIiSJKP4DxQWvPeKFKF7VG
         9NnRDMNKiUJVsul8RZYagNlpJeRZogE8hJWyC08+szwjjt6VZzb2Q39mBGUsTW55SuOw
         tXjFjithhElSEKOv7Vtl6hBIW2An1AUoZkrB0=
Received: by 10.42.0.197 with SMTP id 5mr3868736icd.429.1309947267201;
        Wed, 06 Jul 2011 03:14:27 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.sbcglobal.net [69.209.76.243])
        by mx.google.com with ESMTPS id hp8sm8630510icc.23.2011.07.06.03.14.25
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 03:14:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309938868-2028-13-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176679>

Ramkumar Ramachandra wrote:

>  This is perfect but for the fact that 'git reset --hard' doesn't blow
>  away the sequencer state.  Why I haven't implemented that yet: should
>  ONLY a hard reset blow away the state?

I don't know.  What do you think?

The constraints I see are:

 1. outside scripts that use "git cherry-pick" should continue to work

 2. as a small indication that that's vaguely possible, unrelated parts
    of the test suite should not need to be patched

 3. when a person uses commands like "git reset --hard" without
   _intending_ to blow away the sequencer state, it should be possible
   to get the sequencer state back.

For dealing with "git rebase --interactive" and similar porcelain-ish
scripts, the CHERRY_PICK_HEAD code-path has its own trick of falling
back to traditional behavior when the GIT_CHERRY_PICK_HELP environment
variable is set (see v1.5.4-rc0~106^2~1, revert/cherry-pick: Allow
overriding the help text by the calling Porcelain, 2007-11-28).
