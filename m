From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v7 1/9] connect: document why we sometimes call get_port
 after get_host_and_port
Date: Tue, 24 May 2016 06:50:16 +0900
Message-ID: <20160523215016.GA20618@glandium.org>
References: <20160521231732.4888-1-mh@glandium.org>
 <20160521231732.4888-2-mh@glandium.org>
 <399331a6-dadb-c318-b0e0-c83e0f81ecb0@web.de>
 <20160522080316.GA19790@glandium.org>
 <574287B9.4090307@web.de>
 <xmqqwpmk797y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?iso-8859-15?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 23:50:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4xkK-0004b8-7B
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 23:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbcEWVuk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2016 17:50:40 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:57570 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752633AbcEWVuj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 17:50:39 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1b4xjs-0005Oy-Iw; Tue, 24 May 2016 06:50:16 +0900
Content-Disposition: inline
In-Reply-To: <xmqqwpmk797y.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295401>

On Mon, May 23, 2016 at 02:30:57PM -0700, Junio C Hamano wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>=20
> >>>>   			get_host_and_port(&ssh_host, &port);
> >>>>   +			/* get_host_and_port may not return a port
> >>>> even when
> >>>> +			 * there is one: In the [host:port]:path case,
> >>>> +			 * get_host_and_port is called with "[host:port]" and
> >>>> +			 * returns "host:port" and NULL.
> >>>> +			 * In that specific case, we still need to split the
> >>>> +			 * port. */
> >>> Is it worth to mention that this case is "still supported legacy"=
 ?
> >> If it's worth mentioning anywhere, it seems to me it would start w=
ith
> >> urls.txt?
> >>
> >> Mike
> >>
> > I don't know.
> > urls.txt is for Git users, and connect.c is for Git developers.
> > urls.txt does not mention that Git follows any RFC when parsing the
> > URLS', it doesn't claim to be 100% compliant.
> > Even if it makes sense to do so, as many user simply expect Git to =
accept
> > RFC compliant URL's, and it makes the development easier, if there =
is
> > an already
> > written specification, that describes all the details.
> > The parser is not 100% RFC compliant, one example:
> > - old-style usgage like "git clone [host:222]:~/path/to/repo are su=
pported

"This parser handles the urls described in urls.txt" is about as much a=
s
there is to say IMHO.

> Is it an option to fix get_host_and_port() so that it returns what
> the caller expects even when it is given "[host:port]"?  When the
> caller passes other forms like "host:port", it expects to get "host"
> and "port" parsed out into two variables.  Why can't the caller
> expect to see the same happen when feeding "[host:port]" to the
> function?

After this series, there's only one use of get_host_and_port(). As well
as one use of host_end() and get_port(). They become implementation
details of the parse_connect_url function. And as I mentioned in the
cover letter this round, parse_connect_url could be further modified to
avoid the kind of back-and-forth that's going on between these
functions. But I'd rather leave that for later.

Mike
