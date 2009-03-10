From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFH Patch 2/2] http_init(): Fix config file parsing
Date: Tue, 10 Mar 2009 12:07:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903101206440.14295@intel-tinevez-2-302>
References: <7vfxhmce67.fsf@gitster.siamese.dyndns.org> <76718490903092005n66bca743t67eb7f0ff830d9d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-714814996-1236683277=:14295"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 12:09:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward2.uio.no ([129.240.10.71])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgzq8-0006b8-GW
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 12:09:40 +0100
Received: from exim by mail-out2.uio.no with local-bsmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Lgzon-0002FW-7e
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 12:08:17 +0100
Received: from mail-mx1.uio.no ([129.240.10.29])
	by mail-out2.uio.no with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Lgzom-0002E8-WB
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 12:08:17 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx1.uio.no with esmtp  (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Lgzok-0005Ll-2G
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 12:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbZCJLID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 07:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754382AbZCJLID
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 07:08:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:37602 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754463AbZCJLIB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 07:08:01 -0400
Received: (qmail invoked by alias); 10 Mar 2009 11:07:57 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 10 Mar 2009 12:07:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+hm7kDEA+hS50620iUsJm5GFhu9oYBeAmABJqtje
	TMYAzU7T+f7it4
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <76718490903092005n66bca743t67eb7f0ff830d9d7@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3, uiobl=NO, uiouri=NO)
X-UiO-Scanned: E0ADDEBE5712577857A4824CB2A6F9BCF7C77994
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 200 minaction 2 bait 0 mail/h: 25 total 2137237 max/h 849 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112803>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-714814996-1236683277=:14295
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 9 Mar 2009, Jay Soffian wrote:

> On Mon, Mar 9, 2009 at 10:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> > @@ -241,14 +221,18 @@ void http_init(struct remote *remote)
> >        if (getenv("GIT_SSL_NO_VERIFY"))
> >                curl_ssl_verify = 0;
> >
> > -       ssl_cert = getenv("GIT_SSL_CERT");
> > +       if (getenv("GIT_SSL_CERT"))
> > +               ssl_cert = getenv("GIT_SSL_CERT");
> >  #if LIBCURL_VERSION_NUM >= 0x070902
> > -       ssl_key = getenv("GIT_SSL_KEY");
> > +       if (getenv("GIT_SSL_KEY"))
> > +               ssl_key = getenv("GIT_SSL_KEY");
> >  #endif
> >  #if LIBCURL_VERSION_NUM >= 0x070908
> > -       ssl_capath = getenv("GIT_SSL_CAPATH");
> > +       if (getenv("GIT_SSL_CAPATH"))
> > +               ssl_capath = getenv("GIT_SSL_CAPATH");
> >  #endif
> > -       ssl_cainfo = getenv("GIT_SSL_CAINFO");
> > +       if (getenv("GIT_SSL_CAINFO"))
> > +               ssl_cainfo = getenv("GIT_SSL_CAINFO");
> 
> Would these be a little cleaner with a temporary variable. e.g.
> 
> char *value;
> 
> if ((value = getenv("GIT_SSL_CERT")))
>     ssl_cert = value;

Nah, you should go the full nine yards right away:

static void set_from_env(const char **variable, const char *name)
{
	const char *value = getenv(name);
	if (value)
		*variable = value;
}

Ciao,
Dscho

--8323329-714814996-1236683277=:14295--
