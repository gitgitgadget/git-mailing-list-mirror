From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git fetch over http:// left my repo broken
Date: Thu, 15 Apr 2010 07:15:04 -0700
Message-ID: <20100415141504.GB17883@spearce.org>
References: <g2y8c627c4f1004150251l3dc2ad17n352b149ac739d309@mail.gmail.com> <4BC6E343.2030105@drmicha.warpmail.net> <20100415114319.GA28326@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	git@vger.kernel.org, jan.sievers@sap.com,
	"Sohn, Matthias" <matthias.sohn@sap.com>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Apr 15 16:15:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Pqj-0007uk-6G
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 16:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773Ab0DOOPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 10:15:14 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:65456 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091Ab0DOOPM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 10:15:12 -0400
Received: by bwz25 with SMTP id 25so1652002bwz.28
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 07:15:10 -0700 (PDT)
Received: by 10.204.154.153 with SMTP id o25mr159137bkw.68.1271340910594;
        Thu, 15 Apr 2010 07:15:10 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id a11sm1088097bkc.15.2010.04.15.07.15.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 07:15:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100415114319.GA28326@LK-Perkele-V2.elisa-laajakaista.fi>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144988>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> On Thu, Apr 15, 2010 at 11:58:27AM +0200, Michael J Gruber wrote:
> > Christian Halstrick venit, vidit, dixit 15.04.2010 11:51:
> > 
> > But still, Git should be able to deal with broken servers. The problem
> > is: If the server does not report any problem but simply serves a broken
> > pack (with correct header), how should Git notice? It would require a
> > fsck before accepting any new pack.
> 
> Pack trailer hash. Apparently dumb HTTP fetch needs to bypass pack to index
> conversion somehow since index-pack aborts if trailer hash check fails (not
> to mention other failures corrupt pack may cause).

Oddly enough, http.c runs verify_pack() after the download,
but does so only after it swings the pack file into position.
If verify_pack() fails, it leaves the corrupt pack file in the
objects/pack directory.  Talk about fail.

I'll put together a patch shortly.

-- 
Shawn.
