From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3] worktree: add 'list' command
Date: Mon, 10 Aug 2015 22:55:25 -0400
Organization: Twitter
Message-ID: <1439261725.5283.9.camel@twopensource.com>
References: <1439239982-42826-1-git-send-email-rappazzo@gmail.com>
	 <1439239982-42826-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, sunshine@sunshineco.com, git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 04:55:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOziu-0004G1-Qk
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 04:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933630AbbHKCz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 22:55:28 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33694 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932991AbbHKCz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 22:55:27 -0400
Received: by igbpg9 with SMTP id pg9so82481710igb.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 19:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=CzKKMaQeDG/7t3O4IzPjtxn/tkszWTUp4UGuwn/UlKo=;
        b=HcKqmZssorIqv7O4jbjRjtOSGEV30Du3GLhl7spUPWDSPSrX+udFj954EAEOR6rpzP
         iHhKn4IIpMg9IpaMlF99z/ENe4mtulsM59/Ax8aoNN93PvVXkAXWUAYxnDvabx6ni9EL
         P9vpWpgBClJmji3FzgoUAORYHw+IBohlcdk1SSaouYGN6DQ/FZXkTba6PYfgmU9hM666
         /Shj4CHE8lPxB/gfWjeD2+eNansCDzfZWKz6bXdQDhY3VVJUXhl4Q+T4LQ34D83SDkm0
         zey7siTHrkIZoPiY0udDKTwoCFXBl3d5NBxll2rXXmDCk+7M3kyZoYGpubmF7Fqpuw3T
         GOng==
X-Gm-Message-State: ALoCoQlO9oxEu1Vm00jNFIc+eav1BNT3BDhuF4/sLhZeULYb/oUPsETpTbBOG6D2yYsPBxiK4aVR
X-Received: by 10.50.108.98 with SMTP id hj2mr14505073igb.52.1439261727397;
        Mon, 10 Aug 2015 19:55:27 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id g12sm620169ioe.28.2015.08.10.19.55.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Aug 2015 19:55:26 -0700 (PDT)
In-Reply-To: <1439239982-42826-2-git-send-email-rappazzo@gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275670>

On Mon, 2015-08-10 at 16:53 -0400, Michael Rappazzo wrote:
> +			while ((d = readdir(dir)) != NULL) {

I think it would be useful to break this loop out into a
for_each_worktree function.

While looking into per-worktree ref stuff, I have just noticed that git
prune will delete objects that are only referenced in a different
worktree's detached HEAD.  To fix this, git prune will need to walk over
each worktree, looking at that worktree's HEAD (and other per-worktree
refs).  It would be useful to be able to reuse some of this code for
that task.
