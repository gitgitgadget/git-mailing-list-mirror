From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 10/19] documentation: add documentation of the index-v5
 file format
Date: Sun, 14 Jul 2013 10:59:37 +0700
Message-ID: <CACsJy8Ckcuk11Vmhyo-2wk6bMtNo17=Q9KXU9B-JAi0j7Cmi+A@mail.gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <1373650024-3001-11-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 06:00:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyDUC-00024O-1B
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 06:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742Ab3GNEAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 00:00:17 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:41111 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712Ab3GNEAI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 00:00:08 -0400
Received: by mail-oa0-f50.google.com with SMTP id k7so14429822oag.37
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 21:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HJWlYRCviavHUDoM1cn2FKpxJ49JFydrhKsdQkCmWDk=;
        b=gkmtVLBhGy0K2k/UMGLJt17rac1jZfGwrsP2bCdorT8mTmgXG6YmOyGq34FK/hNx2m
         CfMOYV9ninzBrcr+ynaOAnYrQrSa6efyuArBjCphvdsxi/w1gBs2yRk1EnlmR8Mn7fcL
         7cr+pfUUnsxhxFnpEUwZm+RhQ9+DmDZTulMxhKakdRorXQzTlWgCs8GvJUT9K9kk5r06
         KrM8rTV/LtCbLCsSP9w7HbLFB+wsNsQ6Bg/RbbO8fjB9yWMksDWhLrDV3W7tZ6ORydJN
         E1mZ2jgS6t/mnq0czsM1EvzkzY55prDhn7puISVv1ci4NpEgRl/0vcukfpnbl/gG2Q1V
         /lDA==
X-Received: by 10.182.215.133 with SMTP id oi5mr39995048obc.83.1373774408039;
 Sat, 13 Jul 2013 21:00:08 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Sat, 13 Jul 2013 20:59:37 -0700 (PDT)
In-Reply-To: <1373650024-3001-11-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230307>

On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> +== Directory offsets (diroffsets)
> +
> +  diroffset (32-bits): offset to the directory relative to the beginning
> +    of the index file. There are ndir + 1 offsets in the diroffset table,
> +    the last is pointing to the end of the last direntry. With this last
> +    entry, we are able to replace the strlen of when reading the directory

strlen of what?

> +    name, by calculating it from diroffset[n+1]-diroffset[n]-61.  61 is the
> +    size of the directory data, which follows each each directory + the
> +    crc sum + the NUL byte.
> +
> +  This part is needed for making the directory entries bisectable and
> +    thus allowing a binary search.

Just thinking out loud. Maybe this section and fileoffsets should be
made optional extensions. So far I see no use for them. It's nice for
a program to occasionally look at a single entry, but such programs do
not exist (yet). For inotify monitor that may want to update a single
file's stat, it could regenerate the index with {dir,file}offsets
extensions the first time it attempts to update the index, then it
could do bsearch.
--
Duy
