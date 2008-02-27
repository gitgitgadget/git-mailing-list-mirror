From: Mike Hommey <mh@glandium.org>
Subject: Re: FW: git via http protocol _and_ a proxy using NTLM
	authentication -- git 1.5.4.2 & curl 7.18.0
Date: Wed, 27 Feb 2008 08:29:52 +0100
Organization: glandium.org
Message-ID: <20080227072952.GA27806@glandium.org>
References: <AA28F077645B324881335614E4F7C428034C01@win-ex01.bench.com> <20080227072012.GA23423@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ken.Fuchs@bench.com
X-From: git-owner@vger.kernel.org Wed Feb 27 08:27:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUGhN-0001ww-Iu
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 08:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072AbYB0H0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 02:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754237AbYB0H0t
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 02:26:49 -0500
Received: from vuizook.err.no ([85.19.215.103]:47505 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755645AbYB0H0s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 02:26:48 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JUGgb-0002zp-3N; Wed, 27 Feb 2008 08:26:47 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JUGjg-0007PT-7m; Wed, 27 Feb 2008 08:29:52 +0100
Content-Disposition: inline
In-Reply-To: <20080227072012.GA23423@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75206>

On Wed, Feb 27, 2008 at 08:20:12AM +0100, Mike Hommey wrote:
> On Tue, Feb 26, 2008 at 05:46:21PM -0600, Ken.Fuchs@bench.com wrote:
> > > Well, the CURLOPT_PROXY is set in transport.c as well which 
> > > your patch didn't address.
> > 
> > Thanks, I just did a similar patch to transport.c:
> > 
> > $ diff -u ../git-1.5.4.2/transport.c.orig \
> >           ../git-1.5.4.2/transport.c
> > @@ -456,7 +456,8 @@
> >         if (transport->remote->http_proxy)
> >                 curl_easy_setopt(slot->curl, CURLOPT_PROXY,
> >                                  transport->remote->http_proxy);
> > -
> > +       curl_easy_setopt(slot->curl, CURLOPT_PROXYAUTH,
> > (long)CURLAUTH_NTLM);
> > +       curl_easy_setopt(slot->curl, CURLOPT_PROXYUSERPWD,
> > "<user-id>:<password>");
> >         if (start_active_slot(slot)) {
> >                 run_active_slot(slot);
> >                 if (results.curl_result != CURLE_OK) {
> > $
> 
> Starting with curl 7.14.1, you're supposed to be able to use the
> http://user:pass@proxy/ syntax, though I'm not sure it deals well with
> NTLM domains. You can probably leave CURLOPT_PROXYUSERPWD out if you
> set your proxy url correctly.
> 
> As for CURLOPT_PROXYAUTH, it would be better to set it from another
> config.

Or we should set it to CURLOPT_AUTHANY by default.

Mike
