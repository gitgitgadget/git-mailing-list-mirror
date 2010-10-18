From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: corrupted repo and "git push --mirror"
Date: Mon, 18 Oct 2010 12:06:33 +0300
Message-ID: <20101018090633.GA30603@LK-Perkele-V2.elisa-laajakaista.fi>
References: <AANLkTikZEa4GeQHMXC2vBc8_+1208oEs7d-0KGXBw0p2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 10:59:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7lYt-0000tf-Q9
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 10:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596Ab0JRI7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 04:59:13 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:44979 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526Ab0JRI7M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 04:59:12 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id C6CBA8C756;
	Mon, 18 Oct 2010 11:59:10 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A03198C37E8; Mon, 18 Oct 2010 11:59:10 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id B81D4158A68;
	Mon, 18 Oct 2010 11:59:08 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <AANLkTikZEa4GeQHMXC2vBc8_+1208oEs7d-0KGXBw0p2@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159239>

On Mon, Oct 18, 2010 at 09:38:03AM +0530, Sitaram Chamarty wrote:
> This is probably a stupid question, but in the spirit of extreme
> paranoia *and* because it's kinda hard to "try it and see", I'm going
> to risk the ridicule :)
> 
> Gitolite has mirroring support now, basically using "git push
> --mirror".  The question I was asked, and I couldn't *confidently*
> answer, was: what happens if the source repo suffers some corruption
> for some reason?  Does the corruption propagate?

I think the sending behaves like normal repack. The packfile object
CRCs must match (assuming they are available, i.e. v2 index!). Loose
objects might be down to zlib adler checksum.

However, some errors in pack generation process could cause logically
inconsistent pack to be sent. Against that, one would need to enable
receive-side fsck on receive (this is how the infamous jgit push bug
corrupted repositories).

Transport errors are caught by underlying MACs or packfile SHA-1.

> Secondary question: what happens if the receiving repo is corrupt?

The push might fail or it might not. And not even receive-side fsck
necressary catches the corruption (one would need full fsck for that).

-Ilari
