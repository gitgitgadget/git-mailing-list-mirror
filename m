From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Add --contains flag to git tag
Date: Thu, 22 Jan 2009 17:18:37 -0800
Message-ID: <7v1vuu6cr6.fsf@gitster.siamese.dyndns.org>
References: <1232671630-19683-1-git-send-email-goulding@vivisimo.com>
 <1232671630-19683-2-git-send-email-goulding@vivisimo.com>
 <497913EE.9040608@vivisimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jake Goulding <goulding@vivisimo.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 02:20:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQAiq-0004Pz-DW
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 02:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761381AbZAWBSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 20:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761330AbZAWBSo
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 20:18:44 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761381AbZAWBSn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 20:18:43 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 83B7993B29;
	Thu, 22 Jan 2009 20:18:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4CE5293B26; Thu,
 22 Jan 2009 20:18:38 -0500 (EST)
In-Reply-To: <497913EE.9040608@vivisimo.com> (Jake Goulding's message of
 "Thu, 22 Jan 2009 19:48:46 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C5D30D82-E8EB-11DD-A7B2-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106818>

Jake Goulding <goulding@vivisimo.com> writes:

> @@ -34,7 +35,6 @@ static int show_reference(const char *refname, const
> unsigned char *sha1,
>  			  int flag, void *cb_data)
>  {
>  	struct tag_filter *filter = cb_data;
> -
>  	if (!fnmatch(filter->pattern, refname, 0)) {
>  		int i;
>  		unsigned long size;

Here you can see a long line wrapped.

What does this hunk have to do with adding --contains option anyway?

> @@ -42,6 +42,18 @@ static int show_reference(const char *refname, const
> unsigned char *sha1,
>  		char *buf, *sp, *eol;
>  		size_t len;
>
> +		if (filter->with_commit) {
> +			struct commit *commit;
> +
> +			commit = lookup_commit_reference_gently(sha1, 1);
> +			if (!commit) {
> +				error("tag '%s' does not point at a commit", refname);
> +				return 0;

Drop this error() call, and just return silently.  A tag that does not
point at a commit is not an error at all.
