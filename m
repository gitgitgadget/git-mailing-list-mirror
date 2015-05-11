From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: Re: [PATCH] bisect: improve output when bad commit is found
Date: Mon, 11 May 2015 19:11:25 -0400
Message-ID: <20150511231125.GC18112@tsaunders-iceball.corp.tor1.mozilla.com>
References: <1431377939-13887-1-git-send-email-tbsaunde@tbsaunde.org>
 <xmqq4mni3jjg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 12 01:11:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrwrK-0006P0-UV
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 01:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbbEKXLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 19:11:35 -0400
Received: from tbsaunde.org ([66.228.47.254]:43929 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbbEKXLe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 19:11:34 -0400
Received: from tsaunders-iceball.corp.tor1.mozilla.com (unknown [66.207.208.102])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id 941C0C072;
	Mon, 11 May 2015 23:11:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqq4mni3jjg.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268834>

On Mon, May 11, 2015 at 02:12:51PM -0700, Junio C Hamano wrote:
> Trevor Saunders <tbsaunde@tbsaunde.org> writes:
> > This also fixes an odd inconsistancy where if the first bad commit is a
> > trivial merge git bisect will only print the first line.
> > ---
> 
> Sign-off?

oops, forgot

> > -		printf("%s is the first bad commit\n", bisect_rev_hex);
> > +		puts("the first bad commit is");
> 
> s/the/The/, I would think.

yup

> > diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> > index 06b4868..bf50d20 100755
> > --- a/t/t6030-bisect-porcelain.sh
> > +++ b/t/t6030-bisect-porcelain.sh
> > @@ -26,6 +26,14 @@ add_line_into_file()
> >      git commit --quiet -m "$MSG" $_file
> >  }
> >  
> > +check_bisect_msg()
> > +{
> 
> Find this paragraph in Documentation/CodingGuidelines:
> 
>  - We prefer a space between the function name and the parentheses,
>    and no space inside the parentheses. The opening "{" should also
>    be on the same line.

yeah, I did it that way to be consistant with the near by
function add_lineinto_file, but I can change if that's prefered.

> > +	file=$1
> > +	hash=$2
> > +	grep "the first bad commit is" $file || return $?
> > +	grep $hash $file || return $?
> 
> Is it OK to have these strings anywhere in the $file?

Its not great, but the test seems to log multiple invokations of git
bisect into the same file, so there may be text about previous runs
before we are told which commit is bad.
