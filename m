From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: Re: [PATCH] bisect: improve output when bad commit is found
Date: Mon, 11 May 2015 22:10:24 -0400
Message-ID: <20150512021024.GE18112@tsaunders-iceball.corp.tor1.mozilla.com>
References: <1431377939-13887-1-git-send-email-tbsaunde@tbsaunde.org>
 <xmqq4mni3jjg.fsf@gitster.dls.corp.google.com>
 <20150511231125.GC18112@tsaunders-iceball.corp.tor1.mozilla.com>
 <xmqqbnhq1r9t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 12 04:10:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrzeZ-0000oh-S2
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 04:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbbELCKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 22:10:35 -0400
Received: from tbsaunde.org ([66.228.47.254]:44035 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbbELCKf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 22:10:35 -0400
Received: from tsaunders-iceball.corp.tor1.mozilla.com (unknown [66.207.208.102])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id F34BBC072;
	Tue, 12 May 2015 02:10:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqbnhq1r9t.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268838>

On Mon, May 11, 2015 at 07:08:46PM -0700, Junio C Hamano wrote:
> Trevor Saunders <tbsaunde@tbsaunde.org> writes:
> 
> >> > +	file=$1
> >> > +	hash=$2
> >> > +	grep "the first bad commit is" $file || return $?
> >> > +	grep $hash $file || return $?
> >> 
> >> Is it OK to have these strings anywhere in the $file?
> >
> > Its not great, but the test seems to log multiple invokations of git
> > bisect into the same file, so there may be text about previous runs
> > before we are told which commit is bad.
> 
> So if we had a previous entry that happens to match $hash, even if
> the current test stopped and pointed at a different thing, this test
> declares a success?

err yeah, didn't think of that :(

> This function knows how the $file should end, so it might be more
> sensible to craft the expected output and compare the tail end of
> the $file with it, something like:
> 
> 	(
> 		echo "The first bad commit is"
>                 git show -s "$hash"
> 	) >expect &&
>         cnt=$(wc -l <expect) &&
>         tail -n $cnt "$file" >actual &&
>         test_cmp expect actual
> 
> perhaps?

seems about right.

Thanks!

Trev
