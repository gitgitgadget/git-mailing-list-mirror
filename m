From: Aristotle Pagaltzis <pagaltzis@gmx.de>
Subject: Re: Support various HTTP authentication methods
Date: Thu, 5 Feb 2009 00:25:55 +0100
Message-ID: <20090204232555.GA2358@klangraum.plasmasturm.org>
References: <1233556274-1354-1-git-send-email-gitster@pobox.com> <1233556274-1354-2-git-send-email-gitster@pobox.com> <1233556274-1354-3-git-send-email-gitster@pobox.com> <1233556274-1354-4-git-send-email-gitster@pobox.com> <20090204185109.GA31250@klangraum.plasmasturm.org> <alpine.DEB.1.10.0902042307540.3383@yvahk2.pbagnpgbe.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 00:27:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUr9g-0007Dq-6W
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 00:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbZBDX0N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Feb 2009 18:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752240AbZBDX0N
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 18:26:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:33223 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752131AbZBDX0M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 18:26:12 -0500
Received: (qmail invoked by alias); 04 Feb 2009 23:26:10 -0000
Received: from static-87-79-236-202.netcologne.de (EHLO klangraum) [87.79.236.202]
  by mail.gmx.net (mp008) with SMTP; 05 Feb 2009 00:26:10 +0100
X-Authenticated: #163624
X-Provags-ID: V01U2FsdGVkX1/2bLprmeD2tLfcdGHVaAMMp8UKY47Uc6ea0u1bl/
	ACJcBsAuXtuVwd
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0902042307540.3383@yvahk2.pbagnpgbe.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108464>

* Daniel Stenberg <daniel@haxx.se> [2009-02-04 23:15]:
> On Wed, 4 Feb 2009, Aristotle Pagaltzis wrote:
>> Does that have to do with something being missing in the
>> Digest support or is that operator error? If the latter, what
>> might be the culprit =E2=80=93 how do I diagnose it?
>
> Can you use curl the command line tool with Digest successfully
> against some of those URLs?

Yes, that works.

I have cross-checked the error and access log and here is what
happens =E2=80=93 I have marked the requests that are sent with correct
credentials with a `@` and those which are sent with mismatched
credentials with a `#`:

GET   /x.git/info/refs                                         : 401
GET @ /x.git/info/refs                                         : 200
GET # /x.git/HEAD                                              : 400
GET   /x.git/objects/7e/c6910c4d1733d575f955063fd52b2b0ae7ca5b : 401
GET @ /x.git/objects/7e/c6910c4d1733d575f955063fd52b2b0ae7ca5b : 404
GET @ /x.git/objects/info/http-alternates                      : 404
GET @ /x.git/objects/info/alternates                           : 404
GET   /x.git/objects/info/packs                                : 401
GET @ /x.git/objects/info/packs                                : 200
GET # /x.git/objects/pack/pack-a9bed5817173acdf0a2dc86ddaf36c4f0c7f9ea3=
=2Eidx : 400

Repeating the clone always yiels this exact sequence.

If I use `curl` manually to fetch those URIs, they work just fine.

> What libcurl version are you using?

    $ curl --version
    curl 7.16.2 (i686-pc-linux-gnu) libcurl/7.16.2 OpenSSL/0.9.8g
    zlib/1.2.3 libidn/1.5
    Protocols: tftp ftp telnet dict ldap http file https ftps
    Features: IDN IPv6 Largefile NTLM SSL libz

Regards,
--=20
Aristotle Pagaltzis // <http://plasmasturm.org/>
