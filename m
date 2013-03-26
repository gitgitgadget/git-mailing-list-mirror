From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2] difftool: don't overwrite modified files
Date: Tue, 26 Mar 2013 21:01:42 +0000
Message-ID: <20130326210141.GL2286@serenity.lan>
References: <cover.1364045138.git.john@keeping.me.uk>
 <e44349728c07d8ae22d4b73527b1d124b49cc4a9.1364045138.git.john@keeping.me.uk>
 <7vd2up4bo7.fsf@alter.siamese.dyndns.org>
 <20130324123620.GA2286@serenity.lan>
 <CAJELnLEhcY4Oc-EB=Mi7PKBQQF+EiVpW_dNH6G-abjZj0MAdNw@mail.gmail.com>
 <20130324151557.GB2286@serenity.lan>
 <514FFFC7.3090004@viscovery.net>
 <20130325104219.GD2286@serenity.lan>
 <20130325214430.GG2286@serenity.lan>
 <CAJELnLFxEa6v39ocVD+VLj9b86HhURsnFa+UKc+r3xYPLStSNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Matt McClure <matthewlmcclure@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 22:02:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKb0o-0004zM-28
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 22:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320Ab3CZVB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 17:01:58 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:60083 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab3CZVB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 17:01:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 3FEE9161E41A;
	Tue, 26 Mar 2013 21:01:55 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fXnlos-gK5y2; Tue, 26 Mar 2013 21:01:54 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 629FD161E040;
	Tue, 26 Mar 2013 21:01:43 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAJELnLFxEa6v39ocVD+VLj9b86HhURsnFa+UKc+r3xYPLStSNw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219207>

On Tue, Mar 26, 2013 at 04:52:02PM -0400, Matt McClure wrote:
> On Mon, Mar 25, 2013 at 5:44 PM, John Keeping <john@keeping.me.uk> wrote:
> > Instead of copying unconditionally when the files differ, create and
> > index from the working tree files and only copy the temporary file back
> > if it was modified and the working tree file was not.  If both files
> > have been modified, print a warning and exit with an error.
> 
> When there's a conflict, does difftool save both conflicting files? Or
> only the working tree copy? I think it should preserve both copies on
> disk.

It preserves both copies - the "clean the temporary directory" step is
just skipped.

This isn't ideal since the temporary copy will be under a temporary
directory somewhere but is better than the current behaviour.  It might
be nice to move the temporary file back with an extension so that the
files are at least near each other but I don't think that's needed in
the first version of this change.
