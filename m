From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC] remove/deprecate 'submodule init' and 'sync'
Date: Fri, 30 Nov 2012 13:17:09 -0500
Message-ID: <20121130181709.GA967@odin.tremily.us>
References: <20121130032719.GE29257@odin.tremily.us> <50B54A68.60309@web.de>
 <20121130175309.GA718@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>, Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 19:17:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeV9d-0006wQ-Lh
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 19:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021Ab2K3SRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 13:17:22 -0500
Received: from vms173011pub.verizon.net ([206.46.173.11]:48921 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161017Ab2K3SRV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 13:17:21 -0500
Received: from odin.tremily.us ([unknown] [72.68.90.80])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MEB007Z7C4LT170@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 30 Nov 2012 12:17:11 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 38E1B6E36EC; Fri,
 30 Nov 2012 13:17:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354299429; bh=HfysHlc1j8qAELBu4w9BDbNmVRK9wDCKMar0G1l7ZMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HO7mQDhXwne65Z9yQrQoDKirNrgc4ZKsWSw8NWfj/ex+ABxI3rgUZUorm3IDc5SCg
 kGQDFznQm4PeJOn0Lybcqxm5h/yLsk/7dIfaf8sgPhnf+YVaNGgPIkc9X63FISKTCW
 HAZ7WwzQWOcDT+LNogHsxrl1MkEXiZsBsf/hmQLQ=
Content-disposition: inline
In-reply-to: <20121130175309.GA718@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210936>

On Fri, Nov 30, 2012 at 12:53:09PM -0500, W. Trevor King wrote:
> Likewise for `submodule sync`, which seems to be
> quite similar to `init`.

Ah, I'd remove the part of `sync` that touches the superproject's
.git/config, but keep the part that stores the superproject-reorded
URL in the submodule's config:

    url=$(get_submodule_config "$name" url)
    up_path=$(get_up_path "$sm_path")
    url=$(resolve_relative_url "$url" "$up_path") &&
    if test -n "$url"
    then
      if test -e "$sm_path"/.git
      then
      (
        clear_local_git_env
        cd "$sm_path"
        remote=$(get_default_remote)
        git config remote."$remote".url "$url"
      )
      fi
    fi

I should probably also tweak sync to do similar things with
submodule.<name>.branch and .remote as part of my `--update remote`
series.

Cheers,
Trevor

-- 
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy
