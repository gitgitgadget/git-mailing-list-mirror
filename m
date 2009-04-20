From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3.5 04/12] send-email: Verification for --smtp-server and --smpt-server-port
Date: Sun, 19 Apr 2009 22:49:29 -0500
Message-ID: <49ebf405.0609c00a.797d.ffffac3e@mx.google.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
 <7vzlecnlsh.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 06:04:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvkkV-0001AF-FE
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 06:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbZDTEDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 00:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbZDTEDT
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 00:03:19 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:39698 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbZDTEDS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 00:03:18 -0400
Received: by an-out-0708.google.com with SMTP id d40so745567and.1
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 21:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:cc:date
         :subject:in-reply-to:references;
        bh=rlwz+YapW8/uOMWG6BGpjDJ6EeJSkgYV4QW/bEaNzBE=;
        b=fQgB0eAZi6xll2Og1hi/I8WCmmKF7ObP0sudYznxUy+ay2SJzwPS2jKxOCq2rK7IY8
         QCe04dZrroBZPocNEGrmZQiRQpEODKwJDUUOvh+u58iOfO7gkgd+g5Hz+WvZWpsNWm8a
         Cq5A6sW6BSbC2WPOr6YrtsOQnumrMP0J9coZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:cc:date:subject:in-reply-to:references;
        b=vxrwMrFdk0AF+uL6Z1XJQDu5awFXtyYdz8I8DF5/ET8MMx4YqMeZ7rpgUgIuQrCzCS
         QlpA5nxhUwYXfLCgoZSbn6bbzgB9DoYwAb5mtQkvYrOcx2+Qji7Za4bl1oTBzTInpUqI
         NrCMQfSVuYz6+EY4NT3skxDlGx63t92pIpRg4=
Received: by 10.100.153.4 with SMTP id a4mr2211882ane.4.1240200197414;
        Sun, 19 Apr 2009 21:03:17 -0700 (PDT)
Received: from gmail.com (97-116-107-50.mpls.qwest.net [97.116.107.50])
        by mx.google.com with ESMTPS id 6sm5556574ywi.49.2009.04.19.21.03.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Apr 2009 21:03:17 -0700 (PDT)
In-Reply-To: <7vzlecm4lg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116932>

On Sun, Apr 19, 2009 at 20:42, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Witten <mfwitten@gmail.com> writes:
> ...
>> Now, the 'host:port' server URI form is handled regardless of the
>> documentation deficiencies of Net::SMTP{,::SSL}.
>
> You said that in 01/12, too but I do not think there is any problem with
> Perl documentation.
>
> My installed copy of /usr/share/perl/5.10.0/Net/SMTP.pm has this:
>
>    B<Host> - SMTP host to connect to. It may be a single scalar, as defined for
>    the C<PeerAddr> option in L<IO::Socket::INET>, or a reference to
>    an array with hosts to try in turn. The L</host> method will return the value
>    which was used to connect to the host.
>
> and of course PeerAddr allows host:port.
>
> Please stop placing a false blame on others.  I think it is you who lack
> ability to read the documentation correctly in this particular case.

Take a look again at my commit message for 01/12:

	The 'host:port' form of argument for --smtp-server was only
	working for SSL connections, because the SSL connection code
	was relying on undocumented behavior of Net::SMTP::SSL (really,
	undocumented behavior of Net::SMTP's new method)...

Clearly my beef is with Net::SMTP--->::SSL<---

I touch upon this in the commit message for 06/12:

	The code could even be simplified further, because Net::SMTP{,::SSL}
	both take the PORT variable in their new methods (which, as of this
	commit, are actually the same method). Moreover, both take a server
	URI of the form 'host:port' that trumps any value passed to PORT.

	Unfortunately, none of this is documented publicly, so it isn't
	exploited out of purity.

Net::SMTP doesn't document the PORT key, even though it's the one that
implements the constructor for both Net::SMTP and Net::SMTP::SSL. Also,
Net::SMTP:SSL doesn't document whether PORT shadows the ':port' in any
'host:port' input.

So... I remain resolved in my stance: The documentation is poor and
"--smtp-server host:port" only worked because the code relies on the
undocumented behavior of the ':port' taking precedence of over any
PORT specification. 

> I think you just did not read the documentation carefully enough in this
> case.

Actually, I think I read it too carefully and thought about it too much.

On Sun, Apr 19, 2009 at 21:38, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Please stop placing a false blame on others.  I think it is you who lack
>> ability to read the documentation correctly in this particular case.
>
> Sorry, this came out stronger than I intended.

That's OK. I tend to sound harsher than I want as well.

> Your ability has never been an issue (otherwise there wouldn't have been
> this patch series).

I appreciate that remark; I'm admittedly not important, but I hope that
I'm at least useful.

Now let's get back to work!

Sincerely,
Michael Witten
