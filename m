From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Use work tree to determine if it supports symlinks
Date: Fri, 27 Jul 2012 14:55:49 -0700
Message-ID: <7vobn0zx5m.fsf@alter.siamese.dyndns.org>
References: <17699041.7b2cBoDgE0@mephista>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sascha Cunz <Sascha-ML@babbelbox.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 23:56:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SusVz-0001ya-NK
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 23:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506Ab2G0Vzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 17:55:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479Ab2G0Vzw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 17:55:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6C809D6D;
	Fri, 27 Jul 2012 17:55:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P6ULOvh6r3sFedXqHGtMEdF20CQ=; b=Y3zamr
	dI/LfAuO+7EnDUJlJ6c4dNAHd/sQtMlUG/wyFbFVL4Aymj+Gemf+Mqb6LLn+zfhv
	OIeDFKLgSU1qF1B1pYGiuypo8frFkdBJidZel1Bj3PgnInjjHJK51DmoaSNQOw2R
	eNKaJ6dYrBI4c3YO3m4QSDR8wgpTAoXLxOuhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aE6trbxnjzsKI4vf5POk/9Uv0POPibd9
	TCsnUe1dM0axl35qcKQ6ihDn5JzknMSFJt6P2UNSGK0ecnzl7ceIFtA6k2fU5poz
	1w9c6wQvvjeSyvNLoQOltL+3y+VxP3NPvP+yZx8XoatSkcb0sLfBmI+Z2CXKF/w8
	pb9TVn++VjM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B29E39D6C;
	Fri, 27 Jul 2012 17:55:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 150C19D6B; Fri, 27 Jul 2012
 17:55:50 -0400 (EDT)
In-Reply-To: <17699041.7b2cBoDgE0@mephista> (Sascha Cunz's message of "Fri,
 27 Jul 2012 23:39:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D4AF40FE-D835-11E1-92D5-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202381>

Sascha Cunz <Sascha-ML@babbelbox.org> writes:

> From 3f449e719b924929f1f8ca9b5eff83f17bc64c60 Mon Sep 17 00:00:00 2001
> From: Sascha Cunz <Sascha@BabbelBox.org>
> Date: Fri, 27 Jul 2012 22:54:56 +0200
> Subject: [PATCH] Use work tree to determine if it supports symlinks
>
> When creating a new repository, we check some capabilities of the
> underlying file system(s). We check the file system for its case
> sensitivity and the ability to create symbolic links.
>
> Before this patch the .git-dir was used for this check, while the
> comments in code clearly state to test on the work tree.

That is simply because a layout that has .git and its containing
directory (i.e. the working tree) on a separate filesystem when we
run "git init" is not supported, and more importantly, we do not
want to step outside ".git", which is the simplest and safest way to
avoid touching the end-user data that sits in the working tree.

The code comment is about checking the filesystem that houses both
the working tree and ".git"; if the user later wants to turn .git
into a separate mount point, or if the user wants to use GIT_DIR and
GIT_WORK_TREE to create a funny layout, the user should know how to
muck with ".git/config" to adjust to the peculiarity.
