From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] make diff --color-words customizable
Date: Fri, 9 Jan 2009 12:15:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901091202250.30769@pacific.mpi-cbg.de>
References: <1231459505-14395-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901090121432.30769@pacific.mpi-cbg.de> <200901090151.10880.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jan 09 12:16:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLFLo-0002Ns-LT
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 12:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbZAILPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 06:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbZAILPE
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 06:15:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:54024 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751573AbZAILPD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 06:15:03 -0500
Received: (qmail invoked by alias); 09 Jan 2009 11:15:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 09 Jan 2009 12:15:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19e9tt0I3xemlR3YQoR4UWcKZKC68JNtmbcy9v2IG
	oA99yROhmFRYL0
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901090151.10880.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105005>

Hi,

On Fri, 9 Jan 2009, Thomas Rast wrote:

> Johannes Schindelin wrote:
> > On Fri, 9 Jan 2009, Thomas Rast wrote:
> > 
> > > Allows for user-configurable word splits when using --color-words. This 
> > > can make the diff more readable if the regex is configured according to 
> > > the language of the file.
> > > 
> > > For now the (POSIX extended) regex must be set via the environment
> > > GIT_DIFF_WORDS_REGEX.  Each (non-overlapping) match of the regex is
> > > considered a word.  Anything characters not matched are considered
> > > whitespace.  For example, for C try
> > > 
> > >   GIT_DIFF_WORDS_REGEX='[0-9]+|[a-zA-Z_][a-zA-Z0-9_]*|(\+|-|&|\|){1,2}|\S'
> [...]
> > Interesting idea.  However, I think it would be better to do the opposite, 
> > have _word_ patterns.  And even better to have _one_ pattern.
> 
> I'm not sure I understand.  It _is_ a single pattern.  The examples
> just have several cases to distinguish various semantic groups that
> can occur, as a sort of "half tokenizer".  (The C example isn't very
> complete however.)

Oh, I was fooled by your use of an array of enums whose purpose I did not 
understand at all.

> > BTW I think you could do what you intended to do with a _way_ smaller 
> > and more intuitive patch.
> 
> How?

Intuitively, all you would have to do is to replace this part in 
diff_words_show()

        for (i = 0; i < minus.size; i++)
                if (isspace(minus.ptr[i]))
                        minus.ptr[i] = '\n';

by a loop finding the next word boundary.  I would suggest making that a 
function, say,

	int find_word_boundary(struct diff_words_data *data, char *minus);

This function would also be responsible to initialize the regexp.

However, as I said, I think it would be much more intuitive to 
characterize the _words_ instead of the _word boundaries_.

And I would like to keep the default as-is (together _with_ the 
performance.  IOW if the user did not specify a regexp, it should fall 
back to what it does now, which is slow enough).

Ciao,
Dscho
