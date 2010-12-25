From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v7 1/9] gitweb: Go to DONE_REQUEST rather than DONE_GITWEB in die_error
Date: Sat, 25 Dec 2010 23:14:21 +0100
Message-ID: <201012252314.22541.jnareb@gmail.com>
References: <20101222234843.7998.87068.stgit@localhost.localdomain> <20101222235459.7998.43333.stgit@localhost.localdomain> <20101223015540.GA14585@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 25 23:14:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWcO6-0002vt-KK
	for gcvg-git-2@lo.gmane.org; Sat, 25 Dec 2010 23:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695Ab0LYWOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Dec 2010 17:14:37 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51935 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab0LYWOh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Dec 2010 17:14:37 -0500
Received: by fxm20 with SMTP id 20so8466824fxm.19
        for <git@vger.kernel.org>; Sat, 25 Dec 2010 14:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=/RjnBCKmCVVC1EPXkc//8DA9ZjnUyRo9brbv8X9FpVY=;
        b=Kl2U3GeL/JHyy3LIQJHixTKlWFmZzfhdz1dTKY6/Kmpr5P5aMvOH93LlbYKEqBX/Ot
         KzileJBLsCSnywh4682RL9xp8JZ6GbXL21oAjYBxujEEFZDfyBEFBLuEgvtkAw/CDjDW
         vjBoVOMCFFfUs7vuf9rGLniWkCejmab9nqAQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BC5sFHCrlWpanYn7Ay9ZR1VGZo8TCCg0yUOXX7EQZOsXPTDeuImOvmwFxWJuXs+yqZ
         lBEfcagbMv8rDa3OLNyGKhm0HDnUbkKJJ8URO+/dyvkV7E/bXvR4J79soz+gdEQIBGqK
         UJ/mDh6aK1iaTChPEFLYj5a92zuAoVe6bmOjo=
Received: by 10.223.83.197 with SMTP id g5mr11596217fal.52.1293315275655;
        Sat, 25 Dec 2010 14:14:35 -0800 (PST)
Received: from [192.168.1.13] (abwd176.neoplus.adsl.tpnet.pl [83.8.227.176])
        by mx.google.com with ESMTPS id n2sm2615520fam.4.2010.12.25.14.14.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Dec 2010 14:14:33 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20101223015540.GA14585@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164182>

On Thu, 23 Dec 2010, Jonathan Nieder wrote:
> Jakub Narebski wrote:
> 
> > End the request after die_error finishes, rather than exiting gitweb
> > instance
> [...]
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -1169,6 +1169,7 @@ sub run {
> >  
> >  		run_request();
> >  
> > +	DONE_REQUEST:
> >  		$post_dispatch_hook->()
> >  			if $post_dispatch_hook;
> >  		$first_request = 0;
> > @@ -3767,7 +3768,7 @@ EOF
> 
> [side note: the "@@ EOF" line above would say "@@ sub die_error {" if
> userdiff.c had perl support and gitattributes used it.]

Hmmm, I thought that git has Perl-specific diff driver (xfuncname), but
I see that it doesn't.  The default funcname works quite well for Perl
code... with exception of here-documents (or rather their ending).

BTW. do you know how such perl support should look like?

> >  	print "</div>\n";
> >  
> >  	git_footer_html();
> > -	goto DONE_GITWEB
> > +	goto DONE_REQUEST
> >  		unless ($opts{'-error_handler'});
> 
> This seems to remove the last user of the DONE_GITWEB label.  Why not
> delete the label, too?

Well, actually this patch is in this series only for the label ;-)

Anyway, I can simply drop this patch, and have next one in series
(adding exception-based error handling, making die_error work like
'die') delete DONE_GITWEB label...

> When die_error is called by CGI::Carp (via handle_errors_html), it
> does not rearm the error handler afaict.  Previously that did not
> matter because die_error kills gitweb; now should it be set up
> again?

Thanks, I missed this (but after examining it turns out to be a 
non-issue).  That will teach me to leave code outside of run() 
subroutine; one of reasons behind creating c2394fe (gitweb: Put all 
per-connection code in run() subroutine, 2010-05-07) was to clarify 
code flow.

A note: using set_message inside handle_errors_html was necessary 
because if there was a fatal error in die_error, then 
handle_errors_html would be called recursively - this was fixed in 
CGI.pm 3.45, but we cannot rely on this; we cannot rely on having new 
enough version of CGI::Carp that supports set_die_handler either.

But actually handle_errors_html gets called only from fatalsToBrowser,
which in turn gets called from CGI::Carp::die... which ends calling
CODE::die (aka realdie), which ends CGI process anyway.

That is why die_error ends with

	goto DONE_GITWEB
		unless ($opts{'-error_handler'});

i.e. it doesn't goto DONE_GITWEB nor DONE_REQUEST if called from
handle_errors_html anyway.

> die_error gets called when server load is too high; I wonder whether
> it is right to go back for another request in that case.

If client (web browser) are requesting connection, we have to tell it
something anyway.  Note that each request might serve different client.
But when the die_error(503, "The load average on the server is too 
high") doesn't generate load by itself, all should be all right.

> 
> A broken per-request (or other) configuration could potentially leave
> a gitweb process in a broken state, and until now the state would be
> reset on the first error.  I wonder if escape valve would be needed
> --- e.g., does the CGI harness take care of starting a new gitweb
> process after every couple hundred requests or so?

'die $@ if $@' would call CORE::die, which means it would end gitweb
process.

For CGI server it doesn't matter anyway, as for each request the process
is respawned anyway (together with respawning Perl interpreter), and I
think that ModPerl::Registry and FastCGI servers monitor process that it
is to serve requests, and respawn it if/when it dies.
 
> Aside from those (minor) worries, this patch seems like a good idea.
 
Thanks a lot for your comments.

-- 
Jakub Narebski
Poland
