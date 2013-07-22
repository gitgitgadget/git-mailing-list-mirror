From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Cygwin has trustable filemode
Date: Mon, 22 Jul 2013 18:22:51 -0400
Message-ID: <51EDB0BB.3030605@gmail.com>
References: <1373818390-14451-1-git-send-email-mlevedahl@gmail.com> <1374245631-15955-1-git-send-email-mlevedahl@gmail.com> <51EAEA76.9060502@ramsay1.demon.co.uk> <7v7ggjshk7.fsf@alter.siamese.dyndns.org> <51ECA746.7040702@gmail.com> <7vli4zqjap.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 00:23:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1OVP-0003bw-QM
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 00:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685Ab3GVWW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 18:22:56 -0400
Received: from mail-qc0-f179.google.com ([209.85.216.179]:38816 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab3GVWWz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 18:22:55 -0400
Received: by mail-qc0-f179.google.com with SMTP id e11so3884826qcx.24
        for <git@vger.kernel.org>; Mon, 22 Jul 2013 15:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=rlTtX+Nu8H0N6AuGhkeOeKdZO9w9/bSUpgffPFltyBA=;
        b=IxBIIMcLLCMWya5iOQWC5qSOV00pnbGW3tEhs5GeHou6pTktEhl0d1il+4s/acuzSh
         BY5AWYEjH9O+EVuJqvN81s3e0yMFnRYgod/MEpCVjt4TuIxSg79Hy2sgG1IHvOw8x2sB
         ib/Xhaywn5cfRH6AMj8mlfvWYB8vF2W1ewC6gI4rmcMyeuzhqcYO12rvUeOCp5Dolol7
         zFSSE60KR403Meh/c8lG9uaABdWh1ptsPLvysX+pKxUbmZCNsIBdGVHSRqbGIg3/ljcM
         fpyN3XOQyX4AfNUm6pEA5hAg3/VbLXqwda4RTUEfhm7shq5RXjQzbae1MbBfx1dKb3Zt
         1QgA==
X-Received: by 10.224.151.137 with SMTP id c9mr36894732qaw.107.1374531774655;
        Mon, 22 Jul 2013 15:22:54 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id l2sm41041875qez.2.2013.07.22.15.22.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jul 2013 15:22:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <7vli4zqjap.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231001>

On 07/22/2013 01:02 AM, Junio C Hamano wrote:
>> b) The Cygwin project has always shipped git binaries built without
>> NO_TRUSTABLE_FILEMODE
> That is a fair point.  So let's do this instead.
>
> -- >8 --
> From: Mark Levedahl <mlevedahl@gmail.com>
> Subject: [PATCH] cygwin: stop forcing core.filemode=false
>
> We force core.filemode=false since c869753e (Force core.filemode to
> false on Cygwin., 2006-12-30), even when the repository is on a
> filesystem on which Cygwin can give us trustable filemodes, because
> many native Windows applications the users use to edit files in the
> working tree tend to (re)create files with executable bit randomly
> set or reset.  However, binary distribution of Git that is supplied
> by the downstream project to its users has been built without this
> consideration.
>
> Drop NO_TRUSTABLE_FILEMODE from our default configuration so that
> hand-compiled Git out of box will match theirs.
>
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   config.mak.uname | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 7ac541e..779d06a 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -163,7 +163,6 @@ ifeq ($(uname_O),Cygwin)
>   	NO_THREAD_SAFE_PREAD = YesPlease
>   	NEEDS_LIBICONV = YesPlease
>   	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
> -	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
>   	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
>   	# There are conflicting reports about this.
>   	# On some boxes NO_MMAP is needed, and not so elsewhere.
ok by me.

Mark
