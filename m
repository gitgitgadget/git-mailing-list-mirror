From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn test suite failures due to Subversion race
Date: Mon, 12 Feb 2007 19:21:37 -0800
Message-ID: <20070213032137.GA28534@localdomain>
References: <45CFDFDE.8080907@uwaterloo.ca> <20070212103822.GA21413@localdomain> <45D1239C.4040706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Spang <mcspang@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 04:21:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGoEg-0005iY-BV
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 04:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030632AbXBMDVj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 22:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030636AbXBMDVj
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 22:21:39 -0500
Received: from hand.yhbt.net ([66.150.188.102]:56923 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030632AbXBMDVj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 22:21:39 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 7D15A7DC094;
	Mon, 12 Feb 2007 19:21:37 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 12 Feb 2007 19:21:37 -0800
Content-Disposition: inline
In-Reply-To: <45D1239C.4040706@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39486>

Michael Spang <mcspang@gmail.com> wrote:
> I've prepared a somewhat cleaner patch that solves the problem without
> using sleep. It increases the modification time by one second
> immediately prior to each commit. I added calls everywhere I think the
> problem could potentially occur.
> 
> I've had no failures with the patch (without it, they are quite frequent).

Thanks for the patch.  Just one portability nit below, otherwise:
Acked-by: Eric Wong <normalperson@yhbt.net>

> +poke() {
> +	touch -r "$1" -d +1sec "$1"
> +}

I'm not sure that -d is portable.  However,

  perl -e '@x = stat($ARGV[0]); utime($x[8], $x[9] + 1, $ARGV[0])' "$1"

should work on any platform git-svn runs on.

-- 
Eric Wong
