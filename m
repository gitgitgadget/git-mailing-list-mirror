From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Branch deletion (Re: [RFC] fast-import: note deletion command)
Date: Sun, 18 Sep 2011 16:18:36 -0500
Message-ID: <20110918211836.GI2308@elie>
References: <CA+gfSn9sdTzQghqQp6hcO-9kN9mPx2JLRig79Rgx2FqGWXXp=A@mail.gmail.com>
 <20110918203506.GG2308@elie>
 <CAGdFq_hpA95Kj4eMr4e1duuXTpr+OkkwF4K5bTapXEi9UjWcSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Ivankov <divanorama@gmail.com>,
	Git List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 23:18:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5OlA-0000Cy-PV
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 23:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523Ab1IRVSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 17:18:40 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49281 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851Ab1IRVSj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 17:18:39 -0400
Received: by iaqq3 with SMTP id q3so4567149iaq.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 14:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AXU+thexJ83pyyaRZvK2VYOKpdIDDHj8WO92kmKUQ/k=;
        b=E00nV0qQUlC/dC2pSg77e+hKEKybzigiyFhup3QeQ1c5++08ztCk0RGCM8oBShkfS9
         SPxEGy+SodxG4ggEZvqryhtLUx+PIcOatIiy39CwYBnD5kVqwoAJWOjmWCNsdnoab4/f
         RGFOLgyWSFLyenLPmCj2adOc9/8JX9yIUkYc0=
Received: by 10.42.168.132 with SMTP id w4mr2884539icy.198.1316380719393;
        Sun, 18 Sep 2011 14:18:39 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id z11sm22317754iba.6.2011.09.18.14.18.38
        (version=SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 14:18:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGdFq_hpA95Kj4eMr4e1duuXTpr+OkkwF4K5bTapXEi9UjWcSA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181642>

Sverre Rabbelier wrote:

> Is this perhaps a good moment to also think about branch deletion?
> That came up earlier as well, and thinking about that might give us
> some insights in how to deal with deletions uniformly.

Sorry, my earlier reply missed the point.  To answer your question:
Dmitry's RFC was about deleting individual notes rather than entire
notes refs, so it is not too closely related to branch deletion.

A new "deleteref" command would be a very simple addition, and the UI
seems pretty obvious.  The main concern in adding such a thing is that
it destroys history, while currently "git fast-import" without -f does
not provide any commands that can do that.  So presumably one would
want to do one of the following:

 - only allow deletion of refs that were not present at the start of
   the import, or
 - add a command-line option to permit deletion of refs, so it doesn't
   happen by mistake when misparsing a stream.

It would also be interesting to see an example use (do you remember
the earlier thread where it came up?) to make sure the UI fits it
well.  In most typical cases I can imagine, direct use of "git
update-ref -d" would work better.  In the case of remote helpers, IIRC
there was already a need for the transport-helper to handle the final
ref updates so "git fetch" can write a nice notice about them to the
console.
