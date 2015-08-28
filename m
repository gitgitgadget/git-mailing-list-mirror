From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: Add stash.showFlag config variable
Date: Thu, 27 Aug 2015 18:08:39 -0700
Message-ID: <xmqq614043u0.fsf@gitster.mtv.corp.google.com>
References: <1440683528-11725-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 03:09:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZV8A9-0003f6-DP
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 03:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbbH1BIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 21:08:43 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34002 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbbH1BIn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 21:08:43 -0400
Received: by pabzx8 with SMTP id zx8so43381018pab.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 18:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7rhUzL7cbgtV8+aFd51bichrjhhGQ0FDtgyPAg7+9og=;
        b=bhMaPtUtB9OrkJ+tu8UBKeq13m6OSCu7/4W2vE3QjrVCrRLrPNLjT4S0J8ntTxrtzU
         rEs0teKsFRcXFf51tNcsO723gsv+zG7Bbxq3N2eipiAkUjYcwebHYigoDSUfF1EH81vY
         HcQi2mPFd+M4MAK2LaahHKW8WSdJu3Bkkv/0ggfL4zzfDnuVxw/8tCm3Ngx4gwo6cH3S
         ijesCB3DA35vkoP+Qf12jWsmt995pTw4Jp7zeNCMC4cwkASW9OUUZbzMDgIwYZkIiM8i
         OXFCCteffzCBvokkkT9bQv5+lvTXmmTsIQbaTK7AEz50udPrueDhABAiimnJol/MkhXJ
         78KQ==
X-Received: by 10.67.22.169 with SMTP id ht9mr10876247pad.35.1440724122470;
        Thu, 27 Aug 2015 18:08:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:90f4:5e8f:38e5:2da1])
        by smtp.gmail.com with ESMTPSA id hh3sm3735439pbc.8.2015.08.27.18.08.40
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 27 Aug 2015 18:08:40 -0700 (PDT)
In-Reply-To: <1440683528-11725-1-git-send-email-namhyung@gmail.com> (Namhyung
	Kim's message of "Thu, 27 Aug 2015 22:52:08 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276690>

Namhyung Kim <namhyung@gmail.com> writes:

> +stash.showFlag::
> +	The default option to pass to `git stash show` when no option is
> +	given. The default is '--stat'.  See description of 'show' command
> +	in linkgit:git-stash[1].

Doesn't the same discussion in $gmane/275752 apply here?  By
designing the configuration variable in a sloppy way, this change
will force us to spawn "git diff" via the shell forever, even after
somebody ports "git stash" to C.

Which is not great.

Perhaps a pair of new booleans

 - stash.showStat (defaults to true but you can turn it off)
 - stash.showPatch (defaults to false but you can turn it on)

or something along that line might be sufficient and more palatable.

I dunno.


[Footnote]

*1* Besides, showFlag is a strange configuration variable name.  I
thought that by setting it to true, you are making "git stash"
command to somehow show some kind of a flag when it does its
operation ;-).
