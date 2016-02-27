From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] recursive submodules: paths are hard
Date: Sat, 27 Feb 2016 08:58:43 +0700
Message-ID: <CACsJy8Bsy1-14RhKES7AWWS8RSKbvPtu46cgGnmkuSXrUsq84g@mail.gmail.com>
References: <1456519912-10641-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 02:59:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZUAB-0005p6-PR
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 02:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906AbcB0B7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 20:59:15 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36054 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821AbcB0B7O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 20:59:14 -0500
Received: by mail-lb0-f172.google.com with SMTP id x1so55481583lbj.3
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 17:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pWvWdxAEUaZBBw/pEDIB7qHJFczpR3gzWdJrH+nN4Oo=;
        b=p+jaHeHFR0lQ1Z8Kbmjxu5pG4iAVzIRWV+X+8xOW2Oisb5O9vBbp7xDiPpVvE1/Elv
         5uE3WartEDKGfwzJ1lE+n7FyaPfniqdEksEa0JHVt3L//dPfdOE/AcsSN5rWKEHuCAcW
         LuWMxMDm+H/M8gwlGEoM8tjJ7umxdn9duCLbJEJT2Lx6gYz/19buJzklMTiAts8jHP0q
         bE0HXNw9NJIpxHuzr77eoGXStQ7SSGMAl++4SP99N8PSi8evTfxh+/p++HMRkr5Gn/rR
         KClYr4DWEBgmz156n+nR0AcCMnkrddLAypdTl36h0vvnZ69E768UVDowHchNQ5x8pcWL
         VhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pWvWdxAEUaZBBw/pEDIB7qHJFczpR3gzWdJrH+nN4Oo=;
        b=lKi9ki4j2QbjTJ+pycn6l+UAIhV48JQfcYQ+lm+qM8gNmApvADj8zOVw4TZZQJLaHI
         m3pLikAoDmzS8co8SEfSZvlftMrh+LmTPx7ImDlQnuFJKG1EbCZ4fQjekmtoliObfPYW
         HTngsNz5tO+Ujl0Q9hz7YS+3TY8ilCPQQ28tY0Jnep0joOiRAfSxh3A6MdKy9GZBCrjY
         nig+LieY6UJmjAmPRxIrNFP2mduEowAPF8msFTvkguB9hrQuzdyG+TiPkKrDMEb3ZcSj
         AGqRWKxQv8Zi1EkthprIkV7D/rXsMaRK1Dfp3X1vyYgaqAz/Mt7IalUij09V30ZiTYtG
         EDWg==
X-Gm-Message-State: AD7BkJJ+TwHOQ7RZQSgxxzC25ZcRNSDIRi6Tqyg4k2Kv+jHaUL62mxukQCDV37IK0fjq/nHqRVboRQJNKcDMnQ==
X-Received: by 10.112.166.68 with SMTP id ze4mr1661053lbb.137.1456538352563;
 Fri, 26 Feb 2016 17:59:12 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Fri, 26 Feb 2016 17:58:43 -0800 (PST)
In-Reply-To: <1456519912-10641-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287651>

On Sat, Feb 27, 2016 at 3:51 AM, Stefan Beller <sbeller@google.com> wrote:
> I think we may need to enable Git to pass in 'negative' pathes for the prefix,
> i.e.
>   Although operating on this repository, your reference for displaying paths
>   should be '../untracked' for the example above, when the submodule is in the
>   root directory of the superproject.
>
> This seems currently not possible with the standard way to pass down the prefix.

The problem is, prefix is meant for inside worktree area only. Many
code paths are not ready for prefix "../". Worse, in some cases when
you launch outside worktree, prefix is empty and I think some builtin
commands rely on that. However, I think you can introduce "prefix v2"
that is used in parallel with "prefix v1".
-- 
Duy
