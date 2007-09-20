From: Dan Libby <danda@osc.co.cr>
Subject: Re: [PATCH] git-svnimport: Use separate arguments in the pipe for git-rev-parse
Date: Thu, 20 Sep 2007 13:40:16 -0600
Message-ID: <200709201340.17023.danda@osc.co.cr>
References: <200709161857.06065.danda@osc.co.cr> <7vlkb4wdzq.fsf@gitster.siamese.dyndns.org> <20070918092909.GU31176@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Thu Sep 20 21:40:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYRsx-0004LP-NQ
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 21:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbXITTkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 15:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbXITTkV
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 15:40:21 -0400
Received: from 207-36-180-175.ptr.primarydns.com ([207.36.180.175]:42991 "EHLO
	mail.osc.co.cr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838AbXITTkU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 15:40:20 -0400
Received: from [192.168.0.11] (unknown [200.122.156.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.osc.co.cr (Postfix) with ESMTP id 0C11DD0B95;
	Thu, 20 Sep 2007 12:40:19 -0700 (PDT)
User-Agent: KMail/1.9.4
In-Reply-To: <20070918092909.GU31176@kiste.smurf.noris.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58802>

Hi Matthias,

So the svnimport (with your patch) chugged along for quite a while, but now 
I've run into a new (related?) problem.  Here's the output:

--
Merge parent branch: 57b2ce794c20e71efa9c7bd0cc71df72e01f5d39
Commit ID 37f501fd2fd0d309b4d3fdce77bac13c84646423
Writing to refs/heads/Verny
DONE: 2385 Verny 37f501fd2fd0d309b4d3fdce77bac13c84646423
Switching from 37f501fd2fd0d309b4d3fdce77bac13c84646423 to 
0e1b0bb88f077b66c6cf537899ab6c0a69d5ec30 (/Cristian new code)
we do not like 'Cristian new code' as a tag name.
Cannot create tag Cristian new code: Bad file descriptor
--

This is a fatal error that stops the import.

regards,

On Tuesday 18 September 2007 03:29, Matthias Urlichs wrote:
> Some people seem to create SVN branch names with spaces
> or other shell metacharacters.
>
> Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>
> ---
>
> Junio C Hamano:
> > > -		open(H,"git-rev-parse --verify $parent |");
> > > +		open(H,'-|',"git-rev-parse","--verify",$parent);
> >
> > I seem to be missing the context, but please describe what
> > problem this fixes in the commit log message.  I guess some
> > people use shell metacharacters and/or SP in their branch names
> > and this is about that problem?
>
> Exactly. Sorry; it seems that the original question hasn't been posted
> to the mailing list.
>
> diff --git a/git-svnimport.perl b/git-svnimport.perl
> index d3ad5b9..aa5b3b2 100755
> --- a/git-svnimport.perl
> +++ b/git-svnimport.perl
> @@ -633,7 +633,7 @@ sub commit {
>
>  	my $rev;
>  	if($revision > $opt_s and defined $parent) {
> -		open(H,"git-rev-parse --verify $parent |");
> +		open(H,'-|',"git-rev-parse","--verify",$parent);
>  		$rev = <H>;
>  		close(H) or do {
>  			print STDERR "$revision: cannot find commit '$parent'!\n";

-- 
Dan Libby

Open Source Consulting
San Jose, Costa Rica
http://osc.co.cr
phone: 011 506 223 7382
Fax: 011 506 223 7359
