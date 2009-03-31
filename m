From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: strbuf name conflict on Mac OS
Date: Tue, 31 Mar 2009 22:24:45 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0903312222440.6616@intel-tinevez-2-302>
References: <E5D92A5D-B2CC-44CE-B117-0BB88C0E663E@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 22:26:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LokXO-000885-5C
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 22:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbZCaUYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 16:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753369AbZCaUYt
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 16:24:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:35514 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753599AbZCaUYs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 16:24:48 -0400
Received: (qmail invoked by alias); 31 Mar 2009 20:24:45 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp049) with SMTP; 31 Mar 2009 22:24:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19IKoB3EGlIfl640VuZuJ5x2ECnbkdd5/Xe6m9BCZ
	kCRKzMUbLVrh8a
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <E5D92A5D-B2CC-44CE-B117-0BB88C0E663E@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115309>

Hi,

On Tue, 31 Mar 2009, Joshua Juran wrote:

> Apple's OpenTransport.h from Universal Interfaces 3.4.2 defines its own struct
> strbuf, with which git's collides.
> 
> Since OpenTransport.h also defines some POSIX constants (such as O_NONBLOCK)
> as enums, it's necessary to include OpenTransport.h from fcntl.h (and other
> affected headers) so as to control the order in which the definitions appear
> in the translation unit.
> 
> This is the minimal patch:
> 
> 
> diff --git a/strbuf.h b/strbuf.h
> index 89bd36e..b8f380e 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -40,6 +40,8 @@
> 
> #include <assert.h>
> 
> +#define strbuf git_strbuf
> +
> extern char strbuf_slopbuf[];
> struct strbuf {
>        size_t alloc;

How about this instead?

-- snip --
diff --git a/Makefile b/Makefile
index 32d6782..370c2d9 100644
--- a/Makefile
+++ b/Makefile
@@ -659,6 +659,7 @@ ifeq ($(uname_S),SCO_SV)
 	TAR = gtar
 endif
 ifeq ($(uname_S),Darwin)
+	BASIC_CFLAGS += -Dstrbuf=git_strbuf
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	ifeq ($(shell expr "$(uname_R)" : '[15678]\.'),2)
-- snap --

No need to let other platforms (and the C source) suffer...

Ciao,
Dscho
