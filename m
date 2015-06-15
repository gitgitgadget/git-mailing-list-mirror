From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile / racy-git.txt: clarify USE_NSEC prerequisites
Date: Sun, 14 Jun 2015 17:07:05 -0700
Message-ID: <xmqqr3pdltqu.fsf@gitster.dls.corp.google.com>
References: <557C9526.6080000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 02:07:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Hvq-0007IA-Qy
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 02:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbbFOAHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 20:07:10 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36730 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbbFOAHI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 20:07:08 -0400
Received: by iecrd14 with SMTP id rd14so21153214iec.3
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 17:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=YFeqq5+K4ZqnFtWmMFMHY664+GO2HJvJQAJGhCcABA4=;
        b=Re7dUJT22oElc2hBuP8jNYKEUBXp5193ikuSYaPFTkbdo8qIsrsMAQ8wkh4bxjPDNu
         VHqaneRoGkz7xhVXBbAgjfar72lgCPG790Ch/Jc7Mji78uI3F7jGXuKLRDkFAHbv5yU6
         dfzz+TzUJVZb7CJYHWJun1eIvHtNX0aNGv7Vys7iC8SV3ExL8kpFUBa2BmfFyydOfOvM
         Z+PHAoBDcAscW28hI2k/LtB/HXGbgOlePVgXII6/Hf8u6sIW1It6quhnEG/VNxUZM1X6
         AY4ElCpE90gBqeHNb1Hz+fdhDBG9qvlWp78SWGZoOKq5v8DkwGAwqjpSG2DLMxhzVFjY
         7g9Q==
X-Received: by 10.50.43.194 with SMTP id y2mr17200180igl.35.1434326827519;
        Sun, 14 Jun 2015 17:07:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8cf8:478e:8162:753f])
        by mx.google.com with ESMTPSA id a82sm7672552ioe.22.2015.06.14.17.07.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jun 2015 17:07:06 -0700 (PDT)
In-Reply-To: <557C9526.6080000@gmail.com> (Karsten Blees's message of "Sat, 13
	Jun 2015 22:40:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271656>

Karsten Blees <karsten.blees@gmail.com> writes:

>  members are also compared, but this is not enabled by default
> -because in-core timestamps can have finer granularity than
> +because on Linux, in-core timestamps can have finer granularity than
>  on-disk timestamps, resulting in meaningless changes when an
>  inode is evicted from the inode cache.  See commit 8ce13b0
>  of git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
>  ([PATCH] Sync in core time granularity with filesystems,
> -2005-01-04).

Hmm, the above makes one wonder if on systems other than Linux it
may be better enabled by default.  Perhaps

	members are also compared.  On Linux, this is not enabled by
	default because ...

would make the logic and text flow better?

>  # Define USE_NSEC below if you want git to care about sub-second file mtimes
> -# and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
> -# it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
> -# randomly break unless your underlying filesystem supports those sub-second
> -# times (my ext3 doesn't).
> +# and ctimes. Note that you need recent glibc (at least 2.2.4) for this. On
> +# Linux, kernel 2.6.11 or newer is required for reliable sub-second file times
> +# on file systems with exactly 1 ns or 1 s resolution. If you intend to use Git
> +# on other file systems (e.g. CEPH, CIFS, NTFS, UDF), don't enable USE_NSEC. See
> +# Documentation/technical/racy-git.txt for details.

This looks good.
