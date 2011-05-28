From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rebase: learn --discard subcommand
Date: Sat, 28 May 2011 17:50:46 -0500
Message-ID: <20110528225046.GA31449@elie>
References: <1306551495-26685-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vpqn2psjv.fsf@alter.siamese.dyndns.org>
 <SNT124-W247D44D043F692CA06747EC4790@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, martin.von.zweigbergk@gmail.com,
	Git Mailing List <git@vger.kernel.org>, artagnon@gmail.com
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Sun May 29 00:51:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQSLV-0000KK-FG
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 00:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756398Ab1E1Wu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2011 18:50:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59711 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712Ab1E1Wuy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 18:50:54 -0400
Received: by gyd10 with SMTP id 10so1087240gyd.19
        for <git@vger.kernel.org>; Sat, 28 May 2011 15:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+xCc/M5pISRtuLnSxy1+wEunBTpqlBQ/CccDvGzSUIE=;
        b=tCH8yFGd2WxRWrnW5Lx19FF6hiEFtAa8m/mjl6k7Azxtf8etHhd8WaNxMajiEwlX7Y
         Sny+hNkJpIqWWLI3j0C4L8PvknT0oc57GbxjRtYlIjeYhE+R01FXifNP4S9YEqAAWLkE
         3qPtp/9c752BQORPxpTmGU5cte5os2pGShWK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=n0etIdOg6kU2XlSDl4JZDXWmldzfCXESz0Gz6OEzz6XN75OANa1kmqsNa+/LeEjh6s
         MQrr1GMXjNRKlOhW2kkN8qtlKd9Ese/2rPm1Ma4BWESAGVCiizcFwaSpHzkEj6jBbwo9
         nF97ZphlengKpaAFjxktj0/KLkuP8IJNagaBM=
Received: by 10.236.103.172 with SMTP id f32mr3162839yhg.260.1306623054091;
        Sat, 28 May 2011 15:50:54 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.ameritech.net [69.209.65.98])
        by mx.google.com with ESMTPS id a5sm1489241yhj.78.2011.05.28.15.50.52
        (version=SSLv3 cipher=OTHER);
        Sat, 28 May 2011 15:50:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <SNT124-W247D44D043F692CA06747EC4790@phx.gbl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174682>

Hi,

Tim Mazid wrote:

> I'd just like to say that I sometime use "git reset --hard" in the middle
> of a "git rebase" when I want to get rid of some changes completely.
> Now, I'm not saying that this is the best way of doing it ("git checkout --"
> is probably far superior?)

 . "git checkout -- ." to discard unadded changes
 . "git checkout HEAD -- ." to discard uncommitted changes
 . "git reset --keep HEAD^" to work against a different commit
 . "git reset --merge" to discard a merge resolution in progress

While I also would be happy to see "git reset --hard" to abort
am/rebase, I see two problems, one with an obvious solution, the other
not:

1. It would be a big change in behavior that directly goes against
muscle memory, as you mentioned.  This part could be mitigated by
providing "undo" functionality (e.g., renaming the .git/rebase-merge
directory instead of deleting it) and printing advice including a
command that gets the sequencer state back.

2. It does not help people like me who are fearful about scribbling
over accidentally unstaged or uncommitted changes.  This could be
mitigated by also providing forget-sequence functionality through
separate commands like "git rebase --discard".
