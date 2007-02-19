From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Numeric constants as strings
Date: Mon, 19 Feb 2007 10:54:58 +0000
Message-ID: <200702191055.00203.andyparkins@gmail.com>
References: <200702190916.35813.andyparkins@gmail.com> <20070219094955.GE30030@spearce.org> <vpq1wkm31q4.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 19 11:55:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ6Az-0001Id-DG
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 11:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbXBSKzJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 05:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbXBSKzJ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 05:55:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:52992 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069AbXBSKzH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 05:55:07 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2389626nfa
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 02:55:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=f2C1hpvOriVz/LujfLaMt+7kr66KE6tTvy1UWWut8fXAfYNWv/uNoAaOmiVKeY6wXRnUqOn+Yr37q245qrd3NXvHy/XgTNVpMoZHD2CTxgJKP2hkoQ1Jr8pjU5NJLgDUC0AYy//YG5FWG7CCkl4H6QvzjVfaTHmT4/sjkw1uYiA=
Received: by 10.49.42.5 with SMTP id u5mr5589449nfj.1171882505951;
        Mon, 19 Feb 2007 02:55:05 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id m15sm25892591nfc.2007.02.19.02.55.01;
        Mon, 19 Feb 2007 02:55:02 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <vpq1wkm31q4.fsf@olympe.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40117>

On Monday 2007 February 19 10:01, Matthieu Moy wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > I did not even realize that was legal C...  Now if the 40 was in
> > quotes (e.g. "40") then the concatenate rule would apply and we
> > would get a nice argument to printf.
>
> I suppose the solution is to use #HASH_WIDTH_ASCII to tell the
> preprocessor to put the quotes around HASH_WIDTH_ASCII.

I'm afraid that only works when you're token pasting parameters in a #define 
macro.

For example:

 #define macro(x) "foo" #x "baz"

Then, macro(bar) expands to "foo" "bar" "baz".  However, the following does 
not work:

 #define BAR bar
 #define macro "foo" #BAR "baz"
 
This is because BAR is not a macro parameter.  I've also tried it indirectly:

 #define BAR bar
 #define MAKESTRING(x) #x
 #define macro "foo" MAKESTRING(BAR) "baz"

But this expands to "foo" "BAR" "baz".  Also wrong.  Equally, using # anywhere 
but during a #define doesn't work, so I can't simply write

 printf( "%-" #HASH_WIDTH_ASCII "s", string );

Woe is me. :-(


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
