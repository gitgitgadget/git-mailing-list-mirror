From: Shawn Pearce <spearce@spearce.org>
Subject: Re: java zlib woes (was: Reading commit objects)
Date: Tue, 21 May 2013 22:56:21 -0700
Message-ID: <CAJo=hJtkbCeJA4ao2CkPODrNX_QaKDo4uBS4qvBVTRQ=x-Os3A@mail.gmail.com>
References: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com>
 <CAEBDL5XwrD8ZbRRSrM1iJGtcRgziH5bFVwRHzg9=_PYzaTfgAg@mail.gmail.com>
 <CABx5MBSnpZTthOHECqkbpdbFfkb4e_uSo-rh4owBc8B_oSKjJQ@mail.gmail.com> <20130522045131.GA6257@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Chico Sokol <chico.sokol@gmail.com>,
	John Szakmeister <john@szakmeister.net>,
	git <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 22 07:56:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf22Y-000284-Gf
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 07:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165Ab3EVF4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 01:56:42 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:60936 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773Ab3EVF4l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 01:56:41 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so4379131ief.12
        for <git@vger.kernel.org>; Tue, 21 May 2013 22:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=k6kyH+tbozuuXAxt6R92x8E0lAvg0ZWWZyKBpOocgz0=;
        b=eJHi3/5PXWOqlK5eg9vc4UquJdVbqQL+p857/BLLa0s9gMEJLTBxbOnJ7i+DMBlfOe
         0fGtxD4/vdVY/SRUV0OqxwZH+hKPZSt3rEaZo/l7cu990//yE0tYH+eRejDlF/TUOIwv
         hRnzkUurToyEDXycAO7e3TGWK+/pdCgwwsJEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=k6kyH+tbozuuXAxt6R92x8E0lAvg0ZWWZyKBpOocgz0=;
        b=DGT9C8lRUdcG3wWF8NvVALrnWlx1yNpSeor2W5Ni1mLYXN43vg2jbjQQ1348OTUVLd
         4P9NcYplnE/M/X9IOFS2gCjOs/XBrXyH8Ee0vAMPSpDXtQxNW7Xgu74Pl3QlVpZhppnm
         4u2eQN5+5cfLAtSt+ij8FQDQ750oLOSrR1aM1+Hf1cG4iC8MvD+RJyMLFd9JN4RSLGuo
         dz1lQ94rqiAw7DSEKFmBJ42vA42wNVHB60na3taqpSYU+xFwJhTrvIFtrHoujjYa8Yy+
         ZFavubQoxDbsgsWvf/M2qxEvMc63qdo6GMfHAe/dM2hQLrloG/WVcPeUQ3+1+9rOBqb8
         44lg==
X-Received: by 10.42.58.201 with SMTP id j9mr2895329ich.20.1369202201514; Tue,
 21 May 2013 22:56:41 -0700 (PDT)
Received: by 10.64.82.38 with HTTP; Tue, 21 May 2013 22:56:21 -0700 (PDT)
In-Reply-To: <20130522045131.GA6257@inner.h.apk.li>
X-Gm-Message-State: ALoCoQlWv7IsGmzN3zqSViWPRAd72kTTwwJ+417z1AUYN/LkP/Vu1NA6y8G1xAjWmGecWAw57gLQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225130>

On Tue, May 21, 2013 at 9:51 PM, Andreas Krey <a.krey@gmx.de> wrote:
> On Tue, 21 May 2013 19:18:35 +0000, Chico Sokol wrote:
>> Ok, we discovered that the commit object actually contains the tree
>> object's sha1, by reading its contents with python zlib library.
>>
>> So the bug must be with our java code (we're building a java lib).
>
> That's interesting. We ran in a similar problem: We had a fetch
> with jget hanging within the zlib deflater code in what looked
> like a busy loop. Unfortunately we don't yet have a publishable
> repo on which this happens.

This was with JGit?  A stack trace and JGit version (so we can
correlate line numbers) would be a much more useful bug report than
nothing at all.
