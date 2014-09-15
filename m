From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/2] check-headers: add header usage checks for .c files
Date: Mon, 15 Sep 2014 12:49:16 -0700
Message-ID: <20140915194915.GA1740@gmail.com>
References: <1410680445-84593-1-git-send-email-davvid@gmail.com>
 <xmqqk35466e1.fsf@gitster.dls.corp.google.com>
 <xmqqfvfs66ad.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 21:49:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTcHG-0001ER-M8
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 21:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756544AbaIOTtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 15:49:23 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:64080 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799AbaIOTtU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 15:49:20 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so6833386pdj.8
        for <git@vger.kernel.org>; Mon, 15 Sep 2014 12:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7BZ0er2TXPBeNIpx9JFN333ckU6XArhLH8mMjUn2lmA=;
        b=vFdnPVbUzP/pACjeXl9o5T6ir6RaTTefcAN6qztjyA6iHB3TuY716nMcJmrkTM2iXe
         oXgJThipC5SOjVjAOWIPlQxguzSV7n2MYdL/7DXo5K6N6y0Wkdua6l43g0IRbXgg0w7+
         mXNi0m53sBiXSa2HC4dDtKBRJb0jsXk+Nzrtaq28+Qfvelwk/C5oELJDzZtcCMrKUxgm
         nHUKzfqOirx/H13IGtIEjkf8bbVTxT2jw1kIIAaBzdSxy+G2stXVL+GTyQ/YbQko4JzI
         DSLvAY4mle6q7qjbE7BmxMpkOHmoLT3zhWqAAdtyOA68kLnzu+4jwyV/Kz0jq3O1J4Mm
         xuuA==
X-Received: by 10.66.158.130 with SMTP id wu2mr41991516pab.59.1410810560474;
        Mon, 15 Sep 2014 12:49:20 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id j13sm12150090pbq.42.2014.09.15.12.49.19
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Sep 2014 12:49:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqfvfs66ad.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257077>

On Mon, Sep 15, 2014 at 12:19:06PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > David Aguilar <davvid@gmail.com> writes:
> >
> >> Teach check-header.sh to ensure that the first included header in .c
> >> files is either git-compat-util.h, builtin.h, or cache.h.
> >>
> >> Ensure that common-cmds.h is only included by help.c.
> >>
> >> Move the logic into functions so that we can skip parts of the check.
> >>
> >> Signed-off-by: David Aguilar <davvid@gmail.com>
> >> ---
> >> This depends on my previous patch that adds check-header.sh.
> >> ...
> >> +check_headers () {
> >> +	for header in *.h ewah/*.h vcs-svn/*.h xdiff/*.h
> >> +	do
> >> +		check_header "$header"
> >
> > Hmmmm, doesn't check_header run "$@" as a command?
> 
> Taking the previous two together, perhaps

Thanks, yes, that's better.


>  check-headers.sh | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/check-headers.sh b/check-headers.sh
> index 7f25e7a..526381e 100755
> --- a/check-headers.sh
> +++ b/check-headers.sh
> @@ -20,6 +20,7 @@ maybe_exit () {
>  
>  check_header () {
>  	header="$1"
> +	shift
>  	case "$header" in
>  	common-cmds.h)
>  		# should only be included by help.c, not checked
> @@ -38,15 +39,17 @@ check_header () {
>  check_headers () {
>  	for header in *.h ewah/*.h vcs-svn/*.h xdiff/*.h
>  	do
> -		check_header "$header"
> +		check_header "$header" "$@"
>  	done
>  }
>  
>  check_header_usage () {
> -	first=$(grep '^#include' "$1" |
> -		head -n1 |
> -		sed -e 's,#include ",,' -e 's,"$,,')
> -
> +	first=$( 
> +		sed -n -e '/^#include/{
> +			s/#include ["<]\(.*\)".*/\1/p
> +			q
> +		}' "$1"
> +	)
>  	case "$first" in
>  	cache.h|builtin.h|git-compat-util.h)
>  		# happy

-- 
David
