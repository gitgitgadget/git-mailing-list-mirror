From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] fast-import: fix corner case for checkpoint
Date: Sun, 18 Sep 2011 14:28:51 -0500
Message-ID: <20110918192851.GE2308@elie>
References: <1316372508-7173-1-git-send-email-divanorama@gmail.com>
 <1316372508-7173-3-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 21:29:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5N3D-0001nF-Lg
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 21:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317Ab1IRT24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 15:28:56 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56059 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756598Ab1IRT24 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 15:28:56 -0400
Received: by iaqq3 with SMTP id q3so4491603iaq.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 12:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rQ2VDElO3o7TcDb/KOk0IybZnqYRi1/mDUJIecHMTMM=;
        b=vNoA2Npqeu6rtHFuVH1cCicPtPp0FMzWhSSqZJIjGrpKDr6iBW2Jxb3e4Qe5wm6WUL
         zZP4guRiN5Jl3nn95ZzB9lqAoBoncpX8poMtLDei6QXTuMSOD4nN+s53SuCSMM4H9zvU
         OOYq8FEOTWO5lD5g+3NptoavSOLsDJHCEj3Xg=
Received: by 10.42.152.7 with SMTP id g7mr3119402icw.182.1316374135392;
        Sun, 18 Sep 2011 12:28:55 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id 37sm21903573iba.5.2011.09.18.12.28.54
        (version=SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 12:28:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1316372508-7173-3-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181628>

Dmitry Ivankov wrote:

> checkpoint command makes fast-import finish current pack and write out
> branches/tags and marks. In case no new objects are added in current
> pack fast-import falls back to no-op. While it is possible that refs
> or marks need to be updated (to point to old objects).
>
> Make fast-import always dump them on checkpoint. But as before do not
> cycle_packfile if there are no objects to write.

Yeah, that would be annoying to run into.  Rearranging the description
a little for clarity and brevity:

	fast-import: update refs on checkpoint even if there are no new objects

	During an import using the fast-import command, it is possible for
	no new objects to have been added between two checkpoints requested
	with the SIGUSR1 signal or the "checkpoint" command.  Even in this
	case, fast-import should write out any updated refs and marks to
	fulfill the second checkpoint request.

	As before, fast-import will not write an empty pack and start a new
	one when there are no new objects to write out.

With that change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
