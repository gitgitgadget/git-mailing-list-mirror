From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Enable core.fsyncObjectFiles by default
Date: Tue, 23 Jun 2015 15:21:44 -0700
Message-ID: <xmqqpp4maww7.fsf@gitster.dls.corp.google.com>
References: <1435096643-18159-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net, torvalds@linux-foundation.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 00:23:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Wbc-0002Ee-BL
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 00:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754997AbbFWWVt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2015 18:21:49 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36759 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754938AbbFWWVr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 18:21:47 -0400
Received: by iecvh10 with SMTP id vh10so21680782iec.3
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 15:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=8BYMO1uSTsiQGcV4Fwe4U2ROkfkIZ7UX/dZH73Myou0=;
        b=O4FJ4+vRRY7mbFCf1adi4vXe9lNsgqhAJhUXuueacJz/8kgT8XYAmsvP1BLnNbgVY1
         +xIkazQpkkE8W8C7VHCa8YA+gIyU2arKE4KrZXUp/FPCWR5o/WAIqqffViRJJjSLys8j
         9Hpen5TpNT1z95+v9A9LFpfVrcxrGqxFNRiD0VbCtqZgao3P4UZWGRzCPJY5HP4rHzp7
         Bc+6FhbTIlEzaIlPSbjEhmV+OmY/xpWokCN3naGfAy79yXvlG0wypTFZDXKdZzqyHOo8
         FawKfH5dYwzeeF9eMOy7pLKlZV1D2p8/frLQiaXrky5pD9lKE5RlD7xKKW76sfIFlly6
         CT9g==
X-Received: by 10.107.9.88 with SMTP id j85mr11750961ioi.37.1435098107043;
        Tue, 23 Jun 2015 15:21:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3c90:65f7:f86b:dfda])
        by mx.google.com with ESMTPSA id qs10sm669442igb.14.2015.06.23.15.21.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jun 2015 15:21:46 -0700 (PDT)
In-Reply-To: <1435096643-18159-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 23 Jun 2015 14:57:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272524>

Stefan Beller <sbeller@google.com> writes:

> Linus Torvalds started a discussion[1] if we want to play rather safe
> than use defaults which make sense only for the most power users of G=
it:
>
>> So git is "safe" in the sense that you won't really lose any data,
>> but you may well be inconvenienced.  The "fsync each object" config
>> option is there in case you don't want that inconvenience, but it
>> should be noted that it can make for a hell of a performance impact.
>
>> Of course, it might well be the case that the actual default
>> might be worth turning around. Most git users probably don't
>> care about that kind of "apply two hundred patches from Andrew
>> Morton" kind of workload, although "rebase a big patch-series"
>> does end up doing basically the same thing, and might be more
>> common.=EF=BB=BF
>
> This patch enables fsync_object_files by default.

Sorry, but I fail to see which part of what Linus said (which is the
only thing you quoted from the discussion) argues for this patch.
If anything, I read that as cautioning people against making a
tradeoff based on an incorrect perception of risks and blindly
flipping this bit ON (the original discussion a few days ago, where
Ted says he has this bit ON while clarifying that he does so on SSD,
is also a sensible description on how he made his trade-off).

It's a different matter whom you would want to align with when
assessing your own risk tolerance.  If you quoted Corbet's original
message, then that would have been more consistent.

>
> [1] https://plus.google.com/u/1/+JonathanCorbet/posts/JBxiKPe3VXa
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/config.txt | 8 ++++----
>  environment.c            | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 43bb53c..dce2640 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -693,10 +693,10 @@ core.whitespace::
>  core.fsyncObjectFiles::
>  	This boolean will enable 'fsync()' when writing object files.
>  +
> -This is a total waste of time and effort on a filesystem that orders
> -data writes properly, but can be useful for filesystems that do not =
use
> -journalling (traditional UNIX filesystems) or that only journal meta=
data
> -and not file contents (OS X's HFS+, or Linux ext3 with "data=3Dwrite=
back").
> +This ensures objects are written to disk instead of relying on the
> +operating systems cache and eventual write. Disabling this option wi=
ll
> +yield performance with a trade off in safety for repository corrupti=
on
> +during power loss.
> =20
>  core.preloadIndex::
>  	Enable parallel index preload for operations like 'git diff'
> diff --git a/environment.c b/environment.c
> index 61c685b..b406f5e 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -35,7 +35,7 @@ const char *git_attributes_file;
>  int zlib_compression_level =3D Z_BEST_SPEED;
>  int core_compression_level;
>  int core_compression_seen;
> -int fsync_object_files;
> +int fsync_object_files =3D 1;
>  size_t packed_git_window_size =3D DEFAULT_PACKED_GIT_WINDOW_SIZE;
>  size_t packed_git_limit =3D DEFAULT_PACKED_GIT_LIMIT;
>  size_t delta_base_cache_limit =3D 96 * 1024 * 1024;
