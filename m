From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC 06/11] Add support for mark references as path names
Date: Mon, 27 Jul 2009 07:12:00 -0700
Message-ID: <20090727141200.GJ11191@spearce.org>
References: <1248656659-21415-1-git-send-email-johan@herland.net> <1248656659-21415-7-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, barkalow@iabervon.org, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jul 27 16:12:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVQvy-0003Lm-Nl
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 16:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbZG0OMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 10:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbZG0OMA
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 10:12:00 -0400
Received: from george.spearce.org ([209.20.77.23]:41911 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbZG0OMA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 10:12:00 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 77E31381FD; Mon, 27 Jul 2009 14:12:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1248656659-21415-7-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124168>

Johan Herland <johan@herland.net> wrote:
> When using a mark reference as a path name, the mark reference will be
> expanded to the 40-byte hex version of the object name associated with the
> mark. This is useful e.g. when importing notes objects (where the filenames
> in a notes tree are the object names of the annotated objects).
> 
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  Documentation/git-fast-import.txt |    9 +++++++--
>  fast-import.c                     |   11 +++++++++--
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index c2f483a..bbc8b78 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -487,12 +487,17 @@ in octal.  Git only supports the following modes:
>  
>  In both formats `<path>` is the complete path of the file to be added
>  (if not already existing) or modified (if already existing).
> +`<path>` may also be a mark reference (`:<idnum>`) set by a prior
> +command, which will expand to a full 40-byte SHA-1 of the Git object
> +associated with the mark. This is useful e.g. when importing commit
> +notes (the filenames in a notes commit are the object names of the
> +annotated commits).
>  
>  A `<path>` string must use UNIX-style directory separators (forward
>  slash `/`), may contain any byte other than `LF`, and must not
> -start with double quote (`"`).
> +start with double quote (`"`) or colon (`:`).

I'm worried about changing the path rules here.  Previously writing
a path as :1 was legal and produced a file named ":1" in the top
level directory of the repository.  Now it will create a file that
matches a mark.

I think you need to find another back door, something that the
language wouldn't have considered as valid previously.
  
-- 
Shawn.
