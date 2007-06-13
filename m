From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] gitview: Fix the blame interface.
Date: Tue, 12 Jun 2007 21:58:00 -0700
Message-ID: <7vmyz4h2nb.fsf@assigned-by-dhcp.pobox.com>
References: <11816697213806-git-send-email-aneesh.kumar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 06:58:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyKvt-0003NQ-Bh
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 06:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbXFME6E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 00:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbXFME6D
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 00:58:03 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:62394 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbXFME6B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 00:58:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070613045801.XZTM4247.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 Jun 2007 00:58:01 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Asy01X0021kojtg0000000; Wed, 13 Jun 2007 00:58:00 -0400
In-Reply-To: <11816697213806-git-send-email-aneesh.kumar@gmail.com> (Aneesh
	Kumar K. V.'s message of "Tue, 12 Jun 2007 23:05:20 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50013>

"Aneesh Kumar K.V" <aneesh.kumar@gmail.com> writes:

> @@ -401,7 +402,11 @@ class AnnotateWindow(object):
>  	def data_ready(self, source, condition):
>  		while (1):
>  			try :
> -				buffer = source.read(8192)
> +				# A simple readline doesn't work
> +				# a readline bug ??
> +				buffer=""
> +				buffer = source.read(100)
> +

Are you sure about the first assignment?

> @@ -419,7 +432,8 @@ class AnnotateWindow(object):
>  					m = annotate_line.match(buff)
>  					if not m:
>  						continue
> -					filename = m.group(2)
> +					else:
> +						filename = m.group(2)
>  				else:
>  					self.commit_sha1 = m.group(1)
>  					self.source_line = int(m.group(2))

The script is in contrib/ so I probably shouldn't be nitpicking,
but for this particular hunk, I think (1) this is a no-op
change, and (2) the original is easier to read.
