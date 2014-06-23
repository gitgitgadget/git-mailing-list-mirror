From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: autopacking twice?
Date: Mon, 23 Jun 2014 17:57:31 +0700
Message-ID: <CACsJy8D3cz9w9RrVLcRgz+xgw0+2B9G_BAotvVzUoJ9Uf-Zoag@mail.gmail.com>
References: <20140622055154.GA13819@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 12:58:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz1wv-00070C-A1
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 12:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbaFWK6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 06:58:04 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:41656 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbaFWK6D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 06:58:03 -0400
Received: by mail-qg0-f43.google.com with SMTP id z60so5849603qgd.30
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 03:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kA96M+XcAUoph0jN3zhZaIwuxv6FMpjqkWofPPBnbPE=;
        b=nEGe2VkcxbYrLjN+aQxp2rrdsgg8AS/opWQ713ZJADikJudylbBtTSjqWd3ctcm7JB
         H0rC0XqPI16jQhrhs/lZ50ySCXPSsShmFhNXU3gAjs2B7XVKqrmnmgmAVg/RA98GihQP
         whOTsYqIqwLFb2UEenk75a+PVrN0X7bbO/H+7WZBfJoSq8wowEmyiCOXrT0fmUZDAy2C
         m8KbGMPsuUi9ybKjwTasweMhVyR1JPWbrEsUmAqcb3uggsao3MfKdc1IQUyvZvVc0R6B
         budn49i1T08TQBbWZyVt3T9L4P7hdxU8nuZrp/P7/8o9MR1X1j3QaAuGp+R/fJlx8hPB
         LGTg==
X-Received: by 10.229.192.5 with SMTP id do5mr30631618qcb.12.1403521082041;
 Mon, 23 Jun 2014 03:58:02 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Mon, 23 Jun 2014 03:57:31 -0700 (PDT)
In-Reply-To: <20140622055154.GA13819@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252340>

On Sun, Jun 22, 2014 at 12:51 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> Why did it auto-pack twice in a single pull?
> None of the changes applied are very large.
>
> Guess: auto-packing was started in background, did not
> complete in time, and was restarted for the second time?
> If true, some kind of lock file would be useful
> to prevent this.

There is a lock, $GIT_DIR/gc.pid. However we are prepared to deal with
stale locks, and may have slipped somehow. The test is in
builtin/gc.c, lock_repo_for_gc(). Oh wait, we check for lock (and exit
if lock exists) _after_ we print the message (in cmd_gc). That might
be it.. If it so, maybe we can reorder some code to prevent this bogus
message, but has to be careful and do it before daemonizing..
-- 
Duy
