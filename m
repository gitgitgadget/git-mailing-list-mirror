From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening a file
Date: Fri, 08 Feb 2008 12:09:46 -0800
Message-ID: <7vhcgjjjlh.fsf@gitster.siamese.dyndns.org>
References: <20080208174654.2e9e679c@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:10:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNZYi-0002pm-MC
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 21:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932938AbYBHUKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 15:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932882AbYBHUKF
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 15:10:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932670AbYBHUKD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 15:10:03 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 166384414;
	Fri,  8 Feb 2008 15:09:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 85A734412;
	Fri,  8 Feb 2008 15:09:53 -0500 (EST)
In-Reply-To: <20080208174654.2e9e679c@pc09.procura.nl> (H. Merijn Brand's
	message of "Fri, 8 Feb 2008 17:46:54 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73130>

"H.Merijn Brand" <h.m.brand@xs4all.nl> writes:

> HP-UX allows directories to be opened with fopen (path, "r"), which
> will cause some translations that expect to read files, read dirs
> instead. This patch makes sure the two fopen () calls in remote.c
> only open the file if it is a file.

> +static FILE *open_file(char *full_path)
> +{
> +       struct stat st_buf;
> +       if (stat(full_path, &st_buf) || !S_ISREG(st_buf.st_mode))
> +               return NULL;
> +       return (fopen(full_path, "r"));
> +}

Can we make this a platform specific "compat" hack?

It is not fair to force stat() overhead to ports on platforms
that fails fopen() on directories, as I doubt we would ever want
from directory using fopen() anyway.
