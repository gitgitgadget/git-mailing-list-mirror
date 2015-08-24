From: John Keeping <john@keeping.me.uk>
Subject: Re: git-remote-helper behavior on Windows, not recognizing blank
 line as terminator
Date: Mon, 24 Aug 2015 10:24:18 +0100
Message-ID: <20150824092418.GF1412@serenity.lan>
References: <CAFQ6zU1bdUwn+P3=1v2DoyVubMFz29ZuxHmnZ0pfezA-0MB+mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anish Athalye <anish.athalye@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 11:24:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTnzd-0002u7-FS
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 11:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933206AbbHXJYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 05:24:35 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:36971 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932734AbbHXJYe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 05:24:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 78C93CDA567;
	Mon, 24 Aug 2015 10:24:29 +0100 (BST)
X-Quarantine-ID: <f+wVDlS2koqC>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_20=-0.001, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id f+wVDlS2koqC; Mon, 24 Aug 2015 10:24:27 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 55D63CDA5DE;
	Mon, 24 Aug 2015 10:24:20 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAFQ6zU1bdUwn+P3=1v2DoyVubMFz29ZuxHmnZ0pfezA-0MB+mQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276440>

On Sun, Aug 23, 2015 at 11:40:17AM -0700, Anish Athalye wrote:
> I'm having some issues with git remote helper behavior on Windows.
> 
> According to the protocol
> (https://www.kernel.org/pub/software/scm/git/docs/gitremote-helpers.html),
> when doing things like listing capabilities, git expects the remote
> helper to send back a blank line when it's done.
> 
> I'm having trouble having git recognize the blank line (see
> https://github.com/anishathalye/git-remote-dropbox/issues/13#issuecomment-133894730
> for details).
> 
> Has anyone come across this behavior before? Am I doing something
> wrong, or could there be a bug in git? What's the best way to proceed?
> 
> 
> Any help or suggestions would be greatly appreciated!

The remote-helper parser tends to be very strict about its input.  I
suspect that on Windows you are sending CRLF rather than LF, so Git sees
a line containing CR.

By default the stdio streams are probably open in "text" mode, which
will convert "\n" to "\r\n".  You probably need to reopen stdout in
binary mode to make sure the output is correct.
