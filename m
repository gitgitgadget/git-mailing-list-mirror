From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t3411: Fix test 1 for case-insensitive file systems
Date: Thu, 29 Jan 2009 18:33:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901291831360.3586@pacific.mpi-cbg.de>
References: <1233244816-67565-1-git-send-email-benji@silverinsanity.com> <7vocxqf2sf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 18:35:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSanC-0001Mn-0P
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 18:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556AbZA2Rdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 12:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbZA2Rdj
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 12:33:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:43651 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751118AbZA2Rdj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 12:33:39 -0500
Received: (qmail invoked by alias); 29 Jan 2009 17:33:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 29 Jan 2009 18:33:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/C1LBfWgLCBD5sncDlVIv48UAHl8xGYwbjyM6VE4
	N+h7L7O3LtaVKI
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vocxqf2sf.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107706>

Hi,

On Thu, 29 Jan 2009, Junio C Hamano wrote:

> Brian Gernhardt <benji@silverinsanity.com> writes:
> 
> > The call to "git reset --hard B1" failed on case-insensitive file
> > systems (such as the default settings for HFS+) because there was both
> > a tag "B1" and a file "b1".  Adding "--" to the command makes it
> > clear that we mean commit B1.
> >
> > Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
> > ---
> >  t/t3411-rebase-preserve-around-merges.sh |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/t/t3411-rebase-preserve-around-merges.sh b/t/t3411-rebase-preserve-around-merges.sh
> > index 6533505..e544451 100755
> > --- a/t/t3411-rebase-preserve-around-merges.sh
> > +++ b/t/t3411-rebase-preserve-around-merges.sh
> > @@ -24,7 +24,7 @@ test_expect_success 'setup' '
> >  	test_commit A1 &&
> >  	test_commit B1 &&
> >  	test_commit C1 &&
> > -	git reset --hard B1 &&
> > +	git reset --hard B1 -- &&
> >  	test_commit D1 &&
> >  	test_merge E1 C1 &&
> >  	test_commit F1
> 
> It is not just B1 that is ambiguous, even though that is the only
> ambiguous one this particular test uses.
> 
> If we really wanted to care about case-folding file systems, shouldn't we
> make test_commit shell function a bit more than the downcasing?  How about
> this patch instead?
> 
>  t/test-lib.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git c/t/test-lib.sh w/t/test-lib.sh
> index c1839f7..8066c25 100644
> --- c/t/test-lib.sh
> +++ w/t/test-lib.sh
> @@ -201,7 +201,7 @@ test_tick () {
>  # Both <file> and <contents> default to <message>.
>  
>  test_commit () {
> -	file=${2:-$(echo "$1" | tr 'A-Z' 'a-z')}
> +	file=${2:-$(echo "$1" | tr 'A-Z' 'a-z').t}

Or

	file=${2:-$1.file}

but I was not quite sure about the impact; I might have checked for 
specific filenames.

Brian, if you would have the time to go through the tests if an automatic 
filename was used, that would be smashing!  (We cannot just run the tests 
and look at the failures, as absence of files could be tested; I don't 
remember, debugging zlib/valgrind currently turns my brain into tatties.)

Ciao,
Dscho
