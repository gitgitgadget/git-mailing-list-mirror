From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: Re: [PATCH/RFC v3 10/16] Create a note for every imported commit containing svn metadata.
Date: Wed, 15 Aug 2012 22:10:18 +0200
Message-ID: <3474533.sTggvtNqe8@flomedio>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1344971598-8213-11-git-send-email-florian.achleitner.2.6.31@gmail.com> <7v1uj85427.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 22:10:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1jvL-0002sO-3R
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 22:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757040Ab2HOUKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 16:10:30 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:29475 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756957Ab2HOUK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 16:10:27 -0400
Received: from flomedio.localnet (91-115-86-169.adsl.highway.telekom.at [91.115.86.169])
	(authenticated bits=0)
	by mailrelay1.tugraz.at (8.14.4/8.14.4) with ESMTP id q7FKAJcL027458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 15 Aug 2012 22:10:20 +0200 (CEST)
User-Agent: KMail/4.8.4 (Linux/3.0.0-24-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7v1uj85427.fsf@alter.siamese.dyndns.org>
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.6
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 15 August 2012 12:49:04 Junio C Hamano wrote:
> Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:
> > To provide metadata from svn dumps for further processing, e.g.
> > branch detection, attach a note to each imported commit that
> > stores additional information.
> > The notes are currently hard-coded in refs/notes/svn/revs.
> > Currently the following lines from the svn dump are directly
> > accumulated in the note. This can be refined on purpose, of course.
> > - "Revision-number"
> > - "Node-path"
> > - "Node-kind"
> > - "Node-action"
> > - "Node-copyfrom-path"
> > - "Node-copyfrom-rev"
> > 
> > Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> > ---
> > 
> >  vcs-svn/fast_export.c |   13 +++++++++++++
> >  vcs-svn/fast_export.h |    2 ++
> >  vcs-svn/svndump.c     |   21 +++++++++++++++++++--
> >  3 files changed, 34 insertions(+), 2 deletions(-)
> > 
> > diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
> > index 1ecae4b..796dd1a 100644
> > --- a/vcs-svn/fast_export.c
> > +++ b/vcs-svn/fast_export.c
> > @@ -12,6 +12,7 @@
> > 
> >  #include "svndiff.h"
> >  #include "sliding_window.h"
> >  #include "line_buffer.h"
> > 
> > +#include "cache.h"
> 
> Shouldn't it be near the beginning?  Also if you include "cache.h",
> it probably makes git-compat-util and strbuf redundant.

Ack.

> 
> >  #define MAX_GITSVN_LINE_LEN 4096
> > 
> > @@ -68,6 +69,18 @@ void fast_export_modify(const char *path, uint32_t
> > mode, const char *dataref)> 
> >  	putchar('\n');
> >  
> >  }
> > 
> > +void fast_export_begin_note(uint32_t revision, const char *author,
> > +		const char *log, unsigned long timestamp)
> > +{
> > +	timestamp = 1341914616;
> 
> The magic number needs some comment.
> 
> > +	size_t loglen = strlen(log);
> 
> decl-after-statement.  I am starting to suspect that the assignment
> is a leftover from an earlier debugging effort, though.

Oh yes sorry. Leftover from a previous experiment.
Thx for your reviews Junio, I got too blind to see this.
