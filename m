From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 02/10] Define utility functions for object IDs.
Date: Sun, 8 Mar 2015 16:57:36 +0700
Message-ID: <CACsJy8DBpRPq34=JwJJEOp=DoCP_dkRQB60xPCyqoBFjui416A@mail.gmail.com>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net> <1425770645-628957-3-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Andreas Schwab <schwab@linux-m68k.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Mar 08 10:58:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUXyQ-0003PI-OI
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 10:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbbCHJ6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 05:58:10 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:44619 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbbCHJ6H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 05:58:07 -0400
Received: by iery20 with SMTP id y20so2787589ier.11
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 01:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dHOyVK9lhRmlx+3BQdVnEFDwn5zTxnbRvpO7movw/5c=;
        b=zishOaG+ob+WDEdPER4YPndFSxnKaWH1kD/U9fnM8n8uvblJZPUwHrEnamKJJyoxjR
         S90twlE2PFptXBtile9RIJDMoRn8WBoX5oMBoURyrnRcwHZoU8GlkVUScQWhXMfZKe5Y
         HY/4gV+QgzU2OxA38Z26rffahRRNKPUP3SRFTo9lNKIZhL2omX9hTiegjhmhJIMkMlKR
         fo3To+NXpWjaeAgIm0xzGGBqwPUrQka0M+bZDztuIS9fwZaFsSZ94b/CzUzJ2DOSMwQ5
         RssfSuMHyIYwDdU6WxtxMQ9ApvRtSHsFQjNmhvTYbsv7dkASeV9txXA8elLHNUwtvteV
         co1g==
X-Received: by 10.107.8.215 with SMTP id h84mr15290096ioi.89.1425808686975;
 Sun, 08 Mar 2015 01:58:06 -0800 (PST)
Received: by 10.107.131.33 with HTTP; Sun, 8 Mar 2015 01:57:36 -0800 (PST)
In-Reply-To: <1425770645-628957-3-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265051>

On Sun, Mar 8, 2015 at 6:23 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> There are several utility functions (hashcmp and friends) that are used
> for comparing object IDs (SHA-1 values).  Using these functions, which
> take pointers to unsigned char, with struct object_id requires tiresome
> access to the sha1 member, which bloats code and violates the desired
> encapsulation.  Provide wrappers around these functions for struct
> object_id for neater, more maintainable code.  Use the new constants to
> avoid the hard-coded 20s and 40s throughout the original functions.
>
> These functions simply call the underlying pointer-to-unsigned-char
> versions to ensure that any performance improvements will be passed
> through to the new functions.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> I'm not very excited about having to put the #include in the middle of
> cache.h.  The alternative, of course, is to move enum object_type up,
> which I can do if necessary.  Another alternative is to simply move the
> struct object_id definitions to cache.h instead of object.h, which might
> be cleaner.
>
> I'm interested in hearing opinions about the best way to go forward.

I think declaring struct object_id in cache.h would be simplest.
Another alternative is do it in git-compat-util.h. This is not the
first abuse of git-compat-util.h (because it's included everywhere).
starts_with(), ends_with() and friends are already in
git-compat-util.h
-- 
Duy
