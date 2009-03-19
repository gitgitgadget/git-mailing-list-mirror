From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Produce a nicer output in case of sha1_object_info
 failures in ls-tree -l
Date: Thu, 19 Mar 2009 14:55:56 -0700
Message-ID: <7v4oxp89eb.fsf@gitster.siamese.dyndns.org>
References: <20090319203002.GA31014@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:59:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkQGN-0001LC-Lr
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 22:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760150AbZCSV4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 17:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759560AbZCSV4I
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 17:56:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50810 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760873AbZCSV4H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 17:56:07 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E6CE1A3E63;
	Thu, 19 Mar 2009 17:56:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B06D6A3E62; Thu,
 19 Mar 2009 17:56:00 -0400 (EDT)
In-Reply-To: <20090319203002.GA31014@blimp.localdomain> (Alex Riesen's
 message of "Thu, 19 Mar 2009 21:30:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BE7B7A4A-14D0-11DE-AA4A-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113841>

Alex Riesen <raa.lkml@gmail.com> writes:

> Initialize the size with 0. The error message is already printed
> by sha1_object_info itself. Otherwise the uninitialized size is
> printed, which does not make any sense at all.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
>  builtin-ls-tree.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
> index fca4631..a8cdafb 100644
> --- a/builtin-ls-tree.c
> +++ b/builtin-ls-tree.c
> @@ -60,7 +60,6 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
>  {
>  	int retval = 0;
>  	const char *type = blob_type;
> -	unsigned long size;
>  
>  	if (S_ISGITLINK(mode)) {
>  		/*
> @@ -91,6 +90,7 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
>  	if (!(ls_options & LS_NAME_ONLY)) {
>  		if (ls_options & LS_SHOW_SIZE) {
>  			if (!strcmp(type, blob_type)) {
> +				unsigned long size = 0;
>  				sha1_object_info(sha1, &size);
>  				printf("%06o %s %s %7lu\t", mode, type,
>  				       abbrev ? find_unique_abbrev(sha1, abbrev)

Hmm, shouldn't you be checking the return value from sha1_object_info()
and skipping the printf() altogether instead?
