From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Thu, 26 Jul 2012 16:28:33 +0200
Message-ID: <1486896.KW3TvzfC56@flomedio>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <358E6F1E-8BAD-4F82-B270-0233AB86EF66@gmail.com> <20120726114039.GA6712@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Steven Michalske <smichalske@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 16:28:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuP3d-0000Dj-Jw
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 16:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287Ab2GZO2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 10:28:47 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:11821 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab2GZO2q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 10:28:46 -0400
Received: from flomedio.localnet (cm56-227-93.liwest.at [86.56.227.93])
	(authenticated bits=0)
	by mailrelay1.tugraz.at (8.14.4/8.14.4) with ESMTP id q6QESYWR022212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 Jul 2012 16:28:36 +0200 (CEST)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120726114039.GA6712@burratino>
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.6
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202269>

On Thursday 26 July 2012 06:40:39 Jonathan Nieder wrote:
> Steven Michalske wrote:
> > On Jul 2, 2012, at 4:07 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> >> [...]
> >> 
> >>> diff: Use fifo instead of pipe: Retrieve the name of the pipe from env
> >>> and open it for svndump.
> >> 
> >> I'd prefer to avoid this if possible, since it means having to decide
> >> where the pipe goes on the filesystem.  Can you summarize the
> >> discussion in the commit message so future readers understand why
> >> we're doing it?
> > 
> > Crazy thought here but would a socket not be a bad choice here?
> 
> Not crazy --- it was already mentioned.  It could probably allow using
> --cat-blob-fd even on the platforms that don't inherit file
> descriptors >2, though it wuld take some tweaking.  Though I still
> think the way forward is to keep using plain pipes internally for now
> and to make the bidirectional communication optional, since it
> wouldn't close any doors to whatever is most convenient on each
> platform.  Hopefully I'll hear more from Florian about this in time.

Would you like to see a new pipe patch?

> 
> > Imagine being able to ssh tunnel into the SVN server and run the helper
> > with filesystem access to the SVN repo.
> 
> We're talking about what communicates between the SVN dump parser the
> version control system-specific backend (git fast-import) that reads
> the converted result, so that particular socket wouldn't help much.
>

Yes .. the network part is already handled quite well by svnrdump.
 
