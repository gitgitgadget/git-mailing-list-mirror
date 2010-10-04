From: Shawn Pearce <spearce@spearce.org>
Subject: Re: large files and low memory
Date: Mon, 4 Oct 2010 11:05:54 -0700
Message-ID: <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
References: <20101004092046.GA4382@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: weigelt@metux.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 04 20:08:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2pSD-0006hV-IU
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 20:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756691Ab0JDSHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 14:07:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48681 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756482Ab0JDSHs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 14:07:48 -0400
Received: by iwn5 with SMTP id 5so7198877iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 11:07:47 -0700 (PDT)
Received: by 10.231.32.140 with SMTP id c12mr10162168ibd.90.1286215575552;
 Mon, 04 Oct 2010 11:06:15 -0700 (PDT)
Received: by 10.231.168.70 with HTTP; Mon, 4 Oct 2010 11:05:54 -0700 (PDT)
In-Reply-To: <20101004092046.GA4382@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158079>

On Mon, Oct 4, 2010 at 2:20 AM, Enrico Weigelt <weigelt@metux.de> wrote:
>
> when adding files which are larger than available physical memory,
> git performs very slow. Perhaps it has to do with git's mmap()ing
> the whole file. Is there any way to do it w/o mmap (hoping that
> might perform a bit better) ?

The mmap() isn't the problem.  Its the allocation of a buffer that is
larger than the file in order to hold the result of deflating the file
before it gets written to disk.  When the file is bigger than physical
memory, the kernel has to page in parts of the file as well as swap in
and out parts of that allocated buffer to hold the deflated file.

This is a known area in Git where big files aren't handled well.

-- 
Shawn.
