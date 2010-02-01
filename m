From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: Stream very large blobs directly to pack
Date: Mon, 1 Feb 2010 07:28:26 -0800
Message-ID: <20100201152826.GE8916@spearce.org>
References: <20100129012350.GD20488@spearce.org> <fabb9a1e1001291035l5cd09cb6q1f12037f96dce8a1@mail.gmail.com> <20100129183705.GB22101@spearce.org> <7vockc45ut.fsf@alter.siamese.dyndns.org> <7vmxzw15dt.fsf@alter.siamese.dyndns.org> <7v3a1oyrkp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 16:28:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbyCa-0000gn-Q8
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 16:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248Ab0BAP2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 10:28:31 -0500
Received: from mail-yw0-f173.google.com ([209.85.211.173]:49944 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098Ab0BAP2a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 10:28:30 -0500
Received: by ywh3 with SMTP id 3so1652987ywh.22
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 07:28:30 -0800 (PST)
Received: by 10.150.209.1 with SMTP id h1mr6455635ybg.145.1265038109648;
        Mon, 01 Feb 2010 07:28:29 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 35sm1728581yxh.69.2010.02.01.07.28.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 07:28:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v3a1oyrkp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138615>

Junio C Hamano <gitster@pobox.com> wrote:
> I'll queued this with a result of my conflict resolution to 'pu' for now
> but please double check after I push it out.

The strtoumax call got messed up.  Squash this into your merge:

diff --git a/fast-import.c b/fast-import.c
index e6ebcf6..9c65a24 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2800,7 +2800,7 @@ static int parse_one_option(const char *option)
 	if (!prefixcmp(option, "max-pack-size=")) {
 		option_max_pack_size(option + 14);
 	} else if (!prefixcmp(option, "big-file-threshold=")) {
-		big_file_threshold = strtoumax(option + 21, NULL, 0) * 1024 * 1024;
+		big_file_threshold = strtoumax(option + 19, NULL, 0) * 1024 * 1024;
 	} else if (!prefixcmp(option, "depth=")) {
 		option_depth(option + 6);
 	} else if (!prefixcmp(option, "active-branches=")) {
 
> You may want to add the new option to the output from "cmd -h" and
> probably description of the configuration in the doc before any of this
> gets official.

I'll send an additional patch in a minute with these documentation
related updates.

-- 
Shawn.
