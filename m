From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: git-diff-tree does not use alternate objects for submodules
Date: Mon, 14 May 2012 19:51:26 +0200
Message-ID: <20120514175125.GD58058@book.hvoigt.net>
References: <CAGHpTBLfbMU1WevW6XnY_N2BnfwPZ0_6jJDf45rCkVjWGwA9xg@mail.gmail.com> <7v1umuznuj.fsf@alter.siamese.dyndns.org> <20120509215815.GC74366@book.hvoigt.net> <7v1umtq9pm.fsf@alter.siamese.dyndns.org> <7vwr4lotjl.fsf@alter.siamese.dyndns.org> <20120513172301.GA58961@book.hvoigt.net> <7v7gweiu7b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Orgad and Raizel Shaneh <orgads@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 14 19:51:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STzQk-0005sf-4J
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 19:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757351Ab2ENRv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 13:51:28 -0400
Received: from t2784.greatnet.de ([83.133.105.219]:40238 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755197Ab2ENRv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 13:51:27 -0400
Received: (qmail 2872 invoked from network); 14 May 2012 17:51:26 -0000
Received: from localhost (127.0.0.1)
  by darksea.de with SMTP; 14 May 2012 17:51:26 -0000
Content-Disposition: inline
In-Reply-To: <7v7gweiu7b.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197792>

Hi,

On Mon, May 14, 2012 at 09:49:28AM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > Here is the simplest approach I could think of (not sure if its maybe
> > too simple). On first sight it seems to work (even if I exchange the
> > absolute path in alternates with a relative one.
> 
> Conceptually looks very sound and trivially correct as long as the
> objets_directory.buf is always absolute path (I didn't check, and I do not
> offhand know if read_info_alternates() was designed to work when called
> with a relative path in relative_base).

It looks quite so:

In read_info_alternates() the alternates file underneath the passed
relative_base is opened. It then passes it on to link_alt_odb_entries()
which itself passes it unmodified to link_alt_odb_entry().

link_alt_odb_entry() uses realpath to combine relative entries with
relative_base before recursively passing the entry to
read_info_alternates().

For entries with absolute path relative_base does not seem to be
relevant.

Cheers Heiko
