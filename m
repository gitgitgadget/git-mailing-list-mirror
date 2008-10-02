From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: [PATCH v2] Teach git diff about Objective-C syntax
Date: Thu, 2 Oct 2008 11:40:14 +0100
Message-ID: <57518fd10810020340t15d9441av521b7ef088ea09ca@mail.gmail.com>
References: <57518fd10809171630v97485aalcc5089f96082c0fc@mail.gmail.com>
	 <1222818394-11547-1-git-send-email-jon.delStrother@bestbefore.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Andreas Ericsson" <ae@op5.se>,
	"Jonathan del Strother" <jon.delStrother@bestbefore.tv>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 12:41:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlLch-0005tJ-Ir
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 12:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbYJBKkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 06:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753204AbYJBKkR
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 06:40:17 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:55378 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794AbYJBKkP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 06:40:15 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1032510wfd.4
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 03:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=GUBBkz5VbawlMMw4kzYZFd3tVUuy2IkTLUk4yA+1B98=;
        b=DreeFBYaNV3e+fMb2Rx9uZ3sWKc8ykDAiGLV+vvgfmS8MZRxvV0JdohjKzkhK4Tqmg
         OhlQpVGYmdZFEReMmjldcdU5aS64VXdGbIRADcZVF4qvtYdf/3zhZ2tgnsJrSMUnQeuz
         h4KnfSeqxDpBIOKRuFLl3Lht3wl/5kwblywv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=ZFniXqM3Jd/ZNpx3OxgsyAjHrm+nO8WCJlpg9SWiBP7hibdW7WqgM4NISBnYN9t1Jz
         EhPLHCZI7vv37EhM1FGc8Ulg6V3v710Hd5/5XxZR2iqgx+nQQ2oukp2TkMGrCVg3IhT4
         UqNwWS/KaGaMa3Bd+Qu5xrOZADJeLV0ps3Yos=
Received: by 10.142.107.1 with SMTP id f1mr3807232wfc.267.1222944014494;
        Thu, 02 Oct 2008 03:40:14 -0700 (PDT)
Received: by 10.143.6.3 with HTTP; Thu, 2 Oct 2008 03:40:14 -0700 (PDT)
In-Reply-To: <1222818394-11547-1-git-send-email-jon.delStrother@bestbefore.tv>
Content-Disposition: inline
X-Google-Sender-Auth: 8410267818c77393
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97311>

On Wed, Oct 1, 2008 at 12:46 AM, Jonathan del Strother
<jon.delStrother@bestbefore.tv> wrote:
> Add support for recognition of Objective-C class & instance methods, C functions, and class implementation/interfaces.
>
> Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
> ---
> This version is much the same, but rebuilt on top of 1883a0d3b to use the extended regexp stuff, and it doesn't attempt to tidy up other patterns.
>
>  Documentation/gitattributes.txt |    2 ++
>  diff.c                          |   10 ++++++++++
>  2 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 2ae771f..2694559 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -315,6 +315,8 @@ patterns are available:
>
>  - `java` suitable for source code in the Java language.
>
> +- `objc` suitable for source code in the Objective-C language.
> +
>  - `pascal` suitable for source code in the Pascal/Delphi language.
>
>  - `php` suitable for source code in the PHP language.
> diff --git a/diff.c b/diff.c
> index b001d7b..3694602 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1429,6 +1429,16 @@ static const struct funcname_pattern_entry builtin_funcname_pattern[] = {
>          "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
>          "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$",
>          REG_EXTENDED },
> +       { "objc",
> +         /* Negate C statements that can look like functions */
> +         "!^[ \t]*(do|for|if|else|return|switch|while)\n"
> +         /* Objective-C methods */
> +         "^[ \t]*([-+][ \t]*\\([ \t]*[A-Za-z_][A-Za-z_0-9* \t]*\\)[ \t]*[A-Za-z_].*)$\n"
> +         /* C functions */
> +         "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$\n"
> +         /* Objective-C class/protocol definitions */
> +         "^(@(implementation|interface|protocol)[ \t].*)$",
> +         REG_EXTENDED },
>        { "pascal",
>          "^((procedure|function|constructor|destructor|interface|"
>                "implementation|initialization|finalization)[ \t]*.*)$"
> --


Given Brandon's "strip newline (and cr) from line before pattern
matching" patch, the objective C line could be changed to
"^[ \t]*([-+][ \t]*\\([ \t]*[A-Za-z_][A-Za-z_0-9* \t]*\\)[
\t]*[A-Za-z_][A-Za-z_0-9:{()*& \t]*)$\n"
to be more specific about what's allowed to occur on a method line.
Depends how often we really care about getting the funcname right -
for instance, do we want to deal with cases like :

-(void)doStuff:(NSString*)foo {    // TODO : This is a %@^$#@ method
name, change it.

?   I suspect the additional complexity that would be added to the
regex isn't worth the small gain - any thoughts?
