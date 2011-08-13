From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] Git won't commit
Date: Sat, 13 Aug 2011 16:18:52 -0500
Message-ID: <20110813211852.GA17228@elie.gateway.2wire.net>
References: <1313169225059-6681082.post@n2.nabble.com>
 <CAMOZ1BtxNSnncEJ6frEY0STgfS478krkpxXStP401WLPovb2Gw@mail.gmail.com>
 <CAAC=0R66j43CqpaxXskAwHsitvRFwy7DsjguNPm+sPa4YmTWqw@mail.gmail.com>
 <CAMOZ1Bu3AoQb330hkL+8hDTCvKX+amRfPE3PBxDHUZR17N344Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?RmFicsOtY2lv?= Nascimento <fabricio@tailorbirds.com.br>,
	git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 13 23:22:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsLf5-0007TQ-Je
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 23:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309Ab1HMVTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Aug 2011 17:19:04 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44091 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066Ab1HMVTD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2011 17:19:03 -0400
Received: by ywf7 with SMTP id 7so2633247ywf.19
        for <git@vger.kernel.org>; Sat, 13 Aug 2011 14:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=L3AA9bby2J71GKjjydHnTS85kUo9cKqw3bSufi/vZ5Q=;
        b=bf9fFdBRfYdn7CuzazRwWGpCONo8kUKKpSz6kRaXIW2gZFLmhpB+Pa7aDAkHct+e7x
         RM82tb9xRQuPx8zcYj11QoT0G95ykX29U1QLM42H6ik6CbM57uWOuwkHtGmLInwCitjC
         BfzPIPJ4+HBvFO5Vl2ZmwBfqIrNKacE+H2Jbs=
Received: by 10.146.190.7 with SMTP id n7mr2434172yaf.28.1313270341697;
        Sat, 13 Aug 2011 14:19:01 -0700 (PDT)
Received: from elie.gateway.2wire.net ([68.255.106.30])
        by mx.google.com with ESMTPS id g69sm2893393yhk.16.2011.08.13.14.19.00
        (version=SSLv3 cipher=OTHER);
        Sat, 13 Aug 2011 14:19:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMOZ1Bu3AoQb330hkL+8hDTCvKX+amRfPE3PBxDHUZR17N344Q@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179297>

Hi,

Michael Witten wrote:

> As for why one version works but the other does not, I'm not sure.

It's my fault, I'm afraid:

 $ git log v1.7.4..v1.7.4.4 --grep=template --no-merges
 commit 2140b140
 Author: Jonathan Nieder <jrnieder@gmail.com>
 Date:   Fri Feb 25 03:07:57 2011 -0600

     commit: error out for missing commit message template

     When "git commit" was rewritten in C (v1.5.4-rc0~78^2~30,
     2007-11-08), a subtle bug in --template was introduced.  If the
     file named by a --template parameter is missing, previously git
     would error out with a message:

         Commit template file does not exist.

     but in the C version the --template parameter gets ignored and
     the default template is used.

     t7500 has two tests for this case which would have caught it, except
     that with the default $EDITOR, the commit message template is left
     unmodified, causing 'git commit' to error out and the test to
     succeed.

     Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
     Signed-off-by: Junio C Hamano <gitster@pobox.com>

Fabricio, do you remember what you were trying to do when the
"[commit] template" configuration got set?  Currently the error
message says

	fatal: could not read '<path>'

where <path> is the configured template filename; probably this
should be changed to mention (1) that the file we were expecting to
find is a commit message template and (2) whether we got it from the
commandline or configuration.

What I'm trying to figure out is whether other people were relying on
the accidental "optional template" behavior or if there is some case
where it is more useful.  If so, it should be brought back.
