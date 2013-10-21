From: Shawn Pearce <spearce@spearce.org>
Subject: Re: RFE: support change-id generation natively
Date: Mon, 21 Oct 2013 09:35:07 -0700
Message-ID: <CAJo=hJtbciJ3Qg8jo4U5fZ9onf2R2XOospYKGS-jCYz4p-nwRw@mail.gmail.com>
References: <2127507934.9293293.1382367063640.JavaMail.root@openwide.fr> <1382370119.28365.36627953.50C0496E@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeremy Rosen <jeremy.rosen@openwide.fr>, git <git@vger.kernel.org>
To: james.moger@gitblit.com
X-From: git-owner@vger.kernel.org Mon Oct 21 18:35:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYIS5-0006kB-F6
	for gcvg-git-2@plane.gmane.org; Mon, 21 Oct 2013 18:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051Ab3JUQf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Oct 2013 12:35:29 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:56202 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab3JUQf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Oct 2013 12:35:28 -0400
Received: by mail-wg0-f51.google.com with SMTP id l18so6721564wgh.6
        for <git@vger.kernel.org>; Mon, 21 Oct 2013 09:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nQ1uY2gkrN+rUDTy7WEy57ewLfKj/75GknCtuxm9RA4=;
        b=YFA7Uc+Xmip3h9+f+UJWw46ybRbXMhtlaHp/7mmtfan9C9ibFgalJHh+vsJSburlkK
         51jcVhviRz3bA3ZX1zX7bm03LE785UI7DlYPYw9A4RBWYakvic3n+qVHYBG15AoULSDi
         q2H4899ECtAyTxXe74Vf8J2Rz9n+JjZ0rq0JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=nQ1uY2gkrN+rUDTy7WEy57ewLfKj/75GknCtuxm9RA4=;
        b=j2eGJXHAVQJ2DxYu8FaymnhVEwg7nDdryiVwam0A1/e8UPuMBTa7Zhq6qBusLvHF8U
         tABSIYIqUH+4LwCJFI34StwoOeFaxZF+5H/be0OktSPy+72WT819ZbXgbFQ/QNDkhbem
         3oyCYvJUVqnV+LcjF5oVUINPDo6EGnlv8uDMrUB0Y/X5RUyDRQu9wNLAGowVE5ei1SBI
         dPrJNfgFTmyc+OTw/3uhB/kpM73vjWf8iWOKuyfZhOHgfLfu11fF7JmcaubXuTRxlegi
         rq/zCqy81RaQ4/BNBVX6nYyH7Zrl9LwEWRN2+uHlSgrm/A2FtxguqOCNS4cXOIcAmuTv
         XE3A==
X-Gm-Message-State: ALoCoQmEyChbZ0EQAcT1EGyPxGSVZFMOjN8VyijzH81OI9c70CC2226X94Zg0W6yzKY7EZPUt+aU
X-Received: by 10.194.20.202 with SMTP id p10mr3080752wje.39.1382373327163;
 Mon, 21 Oct 2013 09:35:27 -0700 (PDT)
Received: by 10.227.62.140 with HTTP; Mon, 21 Oct 2013 09:35:07 -0700 (PDT)
In-Reply-To: <1382370119.28365.36627953.50C0496E@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236432>

On Mon, Oct 21, 2013 at 8:41 AM,  <james.moger@gitblit.com> wrote:
> The change-id is exactly like a commit-id, it is an SHA-1 value, but it
> is a constant embedded in the commit message.

https://gerrit-review.googlesource.com/Documentation/user-changeid.html
goes into more detail about these.

> Commit-ids change all the time because of amend; change-ids are constant
> and they are the key that links commit revisions to a discussion.

In a mailing list based workflow, when an author revises a patch
series and resends the new patches aren't linked to the old patches in
a MUA, because the Message-Ids of the original versions were not
preserved. Imagine if Git saved that original Message-Id somewhere and
could properly write In-Reply-To headers so that attempt #2 for each
patch replies to the end of the thread discussing attempt #1 of the
same patch. In a 30 patch series. Gerrit does this with Change-Id.


We briefly considered putting the Change-Id into the commit headers
(e.g. below the optional encoding) but could not because `git commit`
doesn't support this. So it went into the footer along with
Signed-off-by provenance data, which is also not expressible in
headers.
