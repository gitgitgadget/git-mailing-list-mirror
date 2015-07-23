From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] refs: loosen restriction on wildcard "*" refspecs
Date: Thu, 23 Jul 2015 09:44:49 -0700
Message-ID: <xmqqa8umrfge.fsf@gitster.dls.corp.google.com>
References: <1437599133-13012-1-git-send-email-jacob.e.keller@intel.com>
	<1437599133-13012-3-git-send-email-jacob.e.keller@intel.com>
	<xmqqio9brgrj.fsf@gitster.dls.corp.google.com>
	<CA+P7+xo4xYVsoitBk7SJhQtHU9_dXFiOpWefUr_8M96GqX8W1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.iabervon.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 18:46:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIJdd-0005AF-Ln
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 18:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbbGWQpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 12:45:06 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36356 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbbGWQox (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 12:44:53 -0400
Received: by pachj5 with SMTP id hj5so160285743pac.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 09:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ZvGixXeAcn2agmFBuUYe2ZfLK+jgyfvgD85ZV1DzoZ8=;
        b=Y2fis8MyN8PS1R34LtyEFtFj8mB06AVLJVj7dqfcupc+PJ7ftj+4/IKEhQuB/P6p3b
         xYwW1zEnovGR9q4Kp8qj/JTWtgDRpcc9O8KqQgoBeoruos+nu8Qpq3xKDKk6g6h/HK2W
         hlLx4Y5j7FqTTmCrE/Td91nQDTdtSbFTQPalomcsmoJX9ArJQhX6+stZCg0GJDs7MwY7
         LovtVvBmZ2bjS7i41Im9SpMnAmPR+SfNvwtyO7BXmj/iVOFxtc2u11Ee0yuevCyCjSHB
         RSqKvkyzfJn+ATpdoFTK5mki1u6/JKfS6V1I8utggZIu4O9jBgUyLOqFdlwbDZitdMl2
         yCBg==
X-Received: by 10.70.90.42 with SMTP id bt10mr20237312pdb.60.1437669892174;
        Thu, 23 Jul 2015 09:44:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:156f:a37c:e915:d6df])
        by smtp.gmail.com with ESMTPSA id xp10sm9971482pac.34.2015.07.23.09.44.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jul 2015 09:44:50 -0700 (PDT)
In-Reply-To: <CA+P7+xo4xYVsoitBk7SJhQtHU9_dXFiOpWefUr_8M96GqX8W1w@mail.gmail.com>
	(Jacob Keller's message of "Wed, 22 Jul 2015 16:24:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274505>

Jacob Keller <jacob.keller@gmail.com> writes:

>> By the way, have you run test suite before sending this (or any
>> previous round of this) patch?  This seems to break t5511-refspec.sh
>> for me.
>
> Looks like another location I forgot to update. I can send a re-spin
> if you need with the following diff. Basically looks like the tests
> just didn't get updated to count the new behavior is valid.

Yeah, basically looks like an untested patch was sent and nobody
noticed during earlier rounds, even the patch was rerolled a few
times, before I finally took it to 'pu' to take a look.  A typical
slow summer moment---people rightfully find it is more important to
have fun themselves than to help polishing others' patches ;-).

Will squash the changes; no need to resend (unless people discover
other issues; let's hope that I wouldn't be the one to do so ;-).

Thanks.

> diff --git i/t/t5511-refspec.sh w/t/t5511-refspec.sh
> index de6db86ccff0..7bfca7962d41 100755
> --- i/t/t5511-refspec.sh
> +++ w/t/t5511-refspec.sh
> @@ -71,11 +71,11 @@ test_refspec fetch ':refs/remotes/frotz/HEAD-to-me'
>  test_refspec push ':refs/remotes/frotz/delete me'              invalid
>  test_refspec fetch ':refs/remotes/frotz/HEAD to me'            invalid
>
> -test_refspec fetch 'refs/heads/*/for-linus:refs/remotes/mine/*-blah' invalid
> -test_refspec push 'refs/heads/*/for-linus:refs/remotes/mine/*-blah' invalid
> +test_refspec fetch 'refs/heads/*/for-linus:refs/remotes/mine/*-blah'
> +test_refspec push 'refs/heads/*/for-linus:refs/remotes/mine/*-blah'
>
> -test_refspec fetch 'refs/heads*/for-linus:refs/remotes/mine/*' invalid
> -test_refspec push 'refs/heads*/for-linus:refs/remotes/mine/*' invalid
> +test_refspec fetch 'refs/heads*/for-linus:refs/remotes/mine/*'
> +test_refspec push 'refs/heads*/for-linus:refs/remotes/mine/*'
>
>  test_refspec fetch 'refs/heads/*/*/for-linus:refs/remotes/mine/*' invalid
>  test_refspec push 'refs/heads/*/*/for-linus:refs/remotes/mine/*' invalid
>
>
>
>
> Regards,
> Jake
