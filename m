From: Vineet Kumar <vineet@doorstop.net>
Subject: Re: [PATCH] Allow shell scripts to run with non-Bash /bin/sh
Date: Sat, 22 Sep 2007 00:34:46 -0700
Message-ID: <20070922073446.GA3903@doorstop.net>
References: <20070921214346.GF97288@void.codelabs.ru> <7vlkazh1ji.fsf@gitster.siamese.dyndns.org> <20070921214346.GF97288@void.codelabs.ru> <7v8x6zinjf.fsf@gitster.siamese.dyndns.org> <20070922035434.GA99140@void.codelabs.ru> <86tzpnwdha.fsf@lola.quinscape.zz> <7vd4wbgp9t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 22 10:28:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZ0Lf-0001dX-FM
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 10:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbXIVI2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 04:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbXIVI2S
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 04:28:18 -0400
Received: from doorstop.net ([69.55.226.61]:39700 "EHLO philo.doorstop.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752422AbXIVI2R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 04:28:17 -0400
X-Greylist: delayed 3208 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Sep 2007 04:28:17 EDT
Received: from vineet by philo.doorstop.net with local (Exim 4.63)
	(envelope-from <vineet@doorstop.net>)
	id 1IYzVm-00012t-PN
	for git@vger.kernel.org; Sat, 22 Sep 2007 00:34:46 -0700
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vd4wbgp9t.fsf@gitster.siamese.dyndns.org>
X-Request-PGP: http://www.doorstop.net/gpgkey.asc
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58920>

* Junio C Hamano (gitster@pobox.com) [070921 23:58]:
> David Kastrup <dak@gnu.org> writes:
> 
> > Eygene Ryabinkin <rea-git@codelabs.ru> writes:
> >
> >>> That is, what does the shell say if you do this?
> >>> 
> >>> 	case Ultra in
> >>>         Super)
> >>>         	false ;;
> >>> 	Hyper)
> >>>         	true ;;
> >>> 	esac &&
> >>>         echo case returned ok
> >>
> >> It says 'case returned ok', so I will try to understand why it
> >> works here and does not work in the 'while' construct.
> >
> > What you actually need to do is
> >
> > false
> > case Ultra in
> >    Super)
> >    	false ;;
> > Hyper)
> >    	true ;;
> > esac && echo case returned ok
> 
> AHHHHHH.
> 
> Is "case" supposed to be transparent?

That doesn't seem to be the case (no pun intended) on either bash or
dash.  Here's what I tested on bash (apologies for the long lines; these
are verbatim pastes from my shell):

vineet@sprocket:~$ false
vineet@sprocket:~$ case Super in Super) echo super ; false ;; Hyper) echo hyper ; true ;; esac && echo case returned ok
super
vineet@sprocket:~$ false
vineet@sprocket:~$ case Hyper in Super) echo super ; false ;; Hyper) echo hyper ; true ;; esac && echo case returned ok
hyper
case returned ok
vineet@sprocket:~$ false
vineet@sprocket:~$ case Ultra in Super) echo super ; false ;; Hyper) echo hyper ; true ;; esac && echo case returned ok
case returned ok
vineet@sprocket:~$ 


and on dash:

vineet@sprocket:~$ dash
$ false
$ case Super in Super) echo super ; false ;; Hyper) echo hyper ; true ;; esac && echo case returned ok
super
$ false
$ case Hyper in Super) echo super ; false ;; Hyper) echo hyper ; true ;; esac && echo case returned ok
hyper
case returned ok
$ false
$ case Ultra in Super) echo super ; false ;; Hyper) echo hyper ; true ;; esac && echo case returned ok
case returned ok
$ 


So it seems like a "case" statement isn't special; it returns a status
like any other statement.


Vineet
-- 
http://www.doorstop.net/
