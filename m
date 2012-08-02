From: J Smith <dark.panda@gmail.com>
Subject: Re: [PATCH/RFC] grep: add a grep.patternType configuration setting
Date: Thu, 2 Aug 2012 10:47:43 -0400
Message-ID: <CADFUPgfeEYSOH8scLatTGqCWQQ=goA2KZogLC+UmVNZWi3UrcA@mail.gmail.com>
References: <1343845781-69246-1-git-send-email-dark.panda@gmail.com>
 <7vpq7ae0pj.fsf@alter.siamese.dyndns.org> <CADFUPgdX44pCFhytPj-hHSCPH9UHNBKk5pYkpses86M1ntxvyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 16:48:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwwhB-0004NL-2l
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 16:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361Ab2HBOsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 10:48:06 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:54957 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab2HBOsF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 10:48:05 -0400
Received: by qcro28 with SMTP id o28so5371032qcr.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 07:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xIdCYRbFPCJpdZF5joPQt2iYzL0TG6hXexCm7D3iikU=;
        b=d3ie+72RCfBB283mPuo500jRUeC9ahUh84TX9+AyUA4IO3KbwwUrhG5WkcJvj8qnPv
         NThM03anzrJYyk0bMfOUfQKzwZp9Bfewj4cMwPvfiRBjxsKuqE++80bZz35+26xTE5Kc
         p+MPOKCCIT0OANV2NSALC/gNorz0wFedQAa45XOx6BcCq3XAvSgWtnU4cAV3ddm1IC78
         N/fd7yP6N6U6tkE7wTfTiun/shkLS+893qek8UZABra42G1T5dUDrMkbQmexlua9tRZI
         VB0GiQPEt7SwjzIYLNwqOgx7k+5KuuuFwSuakxmHHdB28Q8hksxWtnU//eLoMa06+EPe
         6+sQ==
Received: by 10.60.12.8 with SMTP id u8mr37047878oeb.46.1343918883276; Thu, 02
 Aug 2012 07:48:03 -0700 (PDT)
Received: by 10.76.168.200 with HTTP; Thu, 2 Aug 2012 07:47:43 -0700 (PDT)
In-Reply-To: <CADFUPgdX44pCFhytPj-hHSCPH9UHNBKk5pYkpses86M1ntxvyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202781>

Alright, I have revised the patch and fixed up the nits that were
picked and made a quick modification. I've added a setting for
grep.patternType for "default" which can restore the default grep
pattern matching behaviour and restores the functionality back to
grep.extendedRegexp. I added this functionality for situations like
where you would have grep.patternType set to, say, "perl" in your
$HOME/.gitconfig but don't want that functionality set in a specific
repo and would rather to have it fall back to the older
grep.extendedRegexp behaviour so you can set it to "default" in the
repo's .git/config.

This change also lets us determine the final set of pattern type
options in one place rather than the current code which does two
checks -- once when we call grep_config to determine the configuration
options and then another a few lines later when we call it for the
arguments given to grep. Now we capture the values we receive from
grep.patternType and grep.extendedRegexp in the grep_opt struct as
pattern_type_option and extended_regexp_option, capture the pattern
type argument given to the command itself, and then make the final
determination for the options to be used in one place rather than the
current manner. I think it should be more obvious this way.

I'll post the latest patch shortly for review if this sounds reasonable. Cheers.
