From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] Add support for subversion dump format v3
Date: Tue, 12 Oct 2010 21:24:15 -0500
Message-ID: <20101013022415.GA21670@burratino>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 04:27:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5r4F-0005la-1q
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 04:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483Ab0JMC1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 22:27:40 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:59310 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474Ab0JMC1j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 22:27:39 -0400
Received: by qyk5 with SMTP id 5so1531641qyk.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 19:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=S4KN9nnUyynetUqHJ7x93QrmtzHYM8gDyXD1eHhqOHQ=;
        b=nBQmmxZY/AIo1McmpE01XrI7aXlbaEnH8bZKPtuj4vL373bAN2QrAoZ/c67wZJzU0l
         kmZyvDY3XlD1L9Va5hhikj4Vh2snnmhh+KU79XHjJaX+L8MDiEz/h40CCs7R+rlpB/ti
         /VkqNsygLgEm1ESeEdlWrBAwwweWtTs5pWkeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oX8FTgyTsYmdIdVBFN/YkrteUA4X6b2VonZPPGdyfMYGJxufHasxWG9PY/IJpiB5P7
         5iVrvP2joWY+CYMUpl2CfA9zs7ERF1PY745AlZwvOaq1PegMUQNFFEuCNsBBKr0NI9QU
         WEDZU2l1QmsTedA84piiAuk5M5GHvZw/SSc84=
Received: by 10.224.190.196 with SMTP id dj4mr6392145qab.210.1286936858323;
        Tue, 12 Oct 2010 19:27:38 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id nb14sm6898203qcb.0.2010.10.12.19.27.36
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 19:27:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158904>

David Barr wrote:

> This series follows Jonathan Nieder's svn diff applier series.
>
> Patches 1 to 4 add the required infrastructure to fast-import.
> The primary feature is the addition of the cat-file command to
> fast-import. This allows access to objects written to the
> the current pack prior to a checkpoint and is critical to
> retrieving full-texts to drive the diff applier.
>
> Patch 5 adds the basic parsing necessary to process the v3 format.
>
> Patch 6 adds logic around decoding prop deltas.
>
> Patch 7 integrates svn-fe with svn-da to decode text deltas.
> It was primarily authored by Jonathan but inspired by Ram and
> completed by myself.
> This is probably the most sprawling of the series and likely the
> heaviest target of review.

Just wanted to say: thank you for working on this.  The code
(especially on the fast-import side) needs some pruning and the result
needs tests, but in the end, we are not far from an svn-fe that can
work with "svnrdump dump" output.

In case someone is feeling generous, here is a wishlist:

 - simplify the interface or add a wrapper script so callers do not
   have to use mkfifo

 - keep track of whether an error was encountered and exit nonzero
   in that case

 - rely on git to fetch old revisions (for copyfrom_rev etc) and stop
   keeping track of them in svn-fe.  This would simplify svn-fe a lot
   and pave the way for:

 - incremental imports (since no state has to persist)

And for the sake of tests:

 - a simple delta producer (the remote helper would need this to
   drive "svnrdump load", anyway)

 - clarification (sharpening) of the notes/svndiff and
   notes/dump-load-format.txt specs in Subversion
