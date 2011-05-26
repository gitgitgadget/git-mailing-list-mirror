From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [1.7.2] Please cherry-pick "upload-pack: start pack-objects before
 async rev-list"
Date: Thu, 26 May 2011 01:45:48 -0500
Message-ID: <20110526064547.GA18777@elie>
References: <20110404053626.GA26529@sigill.intra.peff.net>
 <7v8vvnjnyg.fsf@alter.siamese.dyndns.org>
 <20110406175413.GA8205@sigill.intra.peff.net>
 <20110406213333.GA18481@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Aman Gupta <aman@github.com>, Ryan Tomayko <ryan@github.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 08:46:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPUKc-0001CE-3n
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 08:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307Ab1EZGp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 02:45:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58046 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab1EZGp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 02:45:59 -0400
Received: by iwn34 with SMTP id 34so333864iwn.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 23:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=7EDxnZcz7GBK4GrBKeWq8w0KNfaQGyoG7XLtq4Y4qGs=;
        b=UACMWveL+aH03N/y4j4CI0i+JjMSylBnJTgx2nlXeCmuh/muaIHdY8akXcw7SLfYCX
         2CIR4pCi2LKJzEDXRB1icDkRK8/h5PpJAu71wyZhs3qvV1rxyRF71G7Rq/PPdFp1XdZh
         52phN0iNAY7Oii3zCU5le+Kxhszb7JzME/Bz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YaA8p9so/FXj4RnNBaYdD1u9lNyl3qEJSHn1rPkNod43Cd0m5C3AlnBXPN+qHZIyPW
         qHuigNeafMeeShM003jPiVWjIG6OwUhvJxJM0BC4aaObm1X4JQy9TpCHMPl4Ha9X8NJG
         8FEKKKF2/kDkICRaXn3WLh0QtO59bxBKNxtLA=
Received: by 10.42.221.135 with SMTP id ic7mr878646icb.394.1306392357102;
        Wed, 25 May 2011 23:45:57 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.sbcglobal.net [69.209.65.98])
        by mx.google.com with ESMTPS id w5sm348158icv.4.2011.05.25.23.45.54
        (version=SSLv3 cipher=OTHER);
        Wed, 25 May 2011 23:45:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110406213333.GA18481@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174500>

Hi Junio,

Jeff King wrote:

> Subject: [PATCH] upload-pack: start pack-objects before async rev-list
>
> In a pthread-enabled version of upload-pack, there's a race condition
> that can cause a deadlock on the fflush(NULL) we call from run-command.

This server-side deadlock started being triggered by shallow clones
when sv.gnu.org upgraded to v1.7.2.5 a couple of months ago[1].  So it
might be worth thinking about how to help upgrade-averse server admins
to fix it.

Luckily, Jeff's patch (v1.7.5.1~4^2, upload-pack: start pack-objects
before async rev-list, 2011-04-06) applies cleanly on top of the
oldest commit with the problem that I can find (v1.7.2-rc0~31^2~3,
Reimplement async procedures using pthreads, 2010-03-06).  Could you
queue it for inclusion in maint-1.7.2?

If I understand correctly, Windows with threaded async rev-list before
then would not have suffered from this deadlock because it did not
fflush(NULL) in start_command until v1.7.4.1~18 (start_command: flush
buffers in the WIN32 code path as well, 2011-02-04).

[1] http://thread.gmane.org/gmane.comp.version-control.git/172042
