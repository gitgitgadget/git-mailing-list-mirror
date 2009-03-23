From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] builtin-fast-export.c: fix crash on tagged trees
Date: Sun, 22 Mar 2009 17:39:59 -0700
Message-ID: <7vab7d9in4.fsf@gitster.siamese.dyndns.org>
References: <1237758620-6116-1-git-send-email-kusmabite@gmail.com>
 <1237758620-6116-2-git-send-email-kusmabite@gmail.com>
 <1237758620-6116-3-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 01:41:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlYEY-0000B8-NS
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 01:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756753AbZCWAkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 20:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756843AbZCWAkL
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 20:40:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45491 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756824AbZCWAkK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 20:40:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9E46EA4F11;
	Sun, 22 Mar 2009 20:40:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 68C4FA4F10; Sun,
 22 Mar 2009 20:40:04 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2906F08C-1743-11DE-9451-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114215>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> If a tag object points to a tree (or another unhandled type), the commit-
> pointer is left uninitialized and later dereferenced. This patch adds a default
> case to the switch that issues a warning and skips the object.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>  builtin-fast-export.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-fast-export.c b/builtin-fast-export.c
> index 02bad1f..c3ce320 100644
> --- a/builtin-fast-export.c
> +++ b/builtin-fast-export.c
> @@ -375,6 +375,10 @@ static void get_tags_and_duplicates(struct object_array *pending,
>  			case OBJ_BLOB:
>  				handle_object(tag->object.sha1);
>  				continue;
> +			default: /* OBJ_TAG (nested tags) is already handled */

The comment is good but only if you make this the last patch that comes
after the one that actually fixes the tag-to-tag (currently 4/4), no?

> +				warning("Tag points to object of unexpected type %s, skipping.",
> +				        typename(tag->object.type));
> +				continue;
>  			}
>  			break;
>  		default:
> -- 
> 1.6.2.1.226.gcb2dd
