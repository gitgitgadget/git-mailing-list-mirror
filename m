From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug with multiple mv's and diff output
Date: Tue, 12 Apr 2011 13:45:16 -0700
Message-ID: <7v4o63p5b7.fsf@alter.siamese.dyndns.org>
References: <BANLkTin2FpQQ1qEZ41VArsRYZre9=U6SKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kent Leonard <kleonard@accurev.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 22:45:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9kSp-00062K-Og
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 22:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757299Ab1DLUp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 16:45:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43567 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757195Ab1DLUpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 16:45:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 085C34742;
	Tue, 12 Apr 2011 16:47:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ygL6+Fz8ONHkZggmiGmA2dFJ9JI=; b=ACwUMg
	yfs6ckdgVWPJ1KAchO/5Q2SZrsrDSIiqtZf+4dFGLFm6EbSjAHmsxrzY1XWTWzws
	HNzhbkE6/jjhM/3uTj7byatiPRtKcAQMZbdaYGJzRJ4j/iNqbLUS51s5ABiO6iDv
	0GRfEbf/WbsQ8zi5I8cC9W9U3uam7bmUZAINU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cmKjHzTPhWWUnlTIidMDctW33ec8/cbz
	6oEkKFMzP8DTYHLQ1XVUZkIWx2M3q71Yj8e6EU1nDjbLtbsDjPJxBbEGQ1+3KmsR
	MClCVoFDILI/euQ2EMYZ6jy1qt+3TywL0j6u6uhb7W7tjJFohq2tq8qdnrD+SlUq
	R4ahnTyF/TU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D77444740;
	Tue, 12 Apr 2011 16:47:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C85E8473C; Tue, 12 Apr 2011
 16:47:15 -0400 (EDT)
In-Reply-To: <BANLkTin2FpQQ1qEZ41VArsRYZre9=U6SKA@mail.gmail.com> (Kent
 Leonard's message of "Tue, 12 Apr 2011 13:58:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E8B10A0-6546-11E0-85C1-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171418>

Kent Leonard <kleonard@accurev.com> writes:

> When I do this in repo with files a and b:
>   git mv b c
>   git mv a b
>   git commit -m shuffle
>   git diff --summary master^ master
>
> I get output:
>   delete mode 100644 a
>   create mode 100644 c
> Which does not indicate that the contents of b changed.

Isn't that because --summary is only about tree-structural changes?  If b
was in preimage and b still is in postimage, as far as b is concerned that
path stayed in the tree across the change, and there is nothing to report.

> "git diff --raw" shows more complete information.

Try something more sensible like "--summary --stat" instead of "--summary"
alone, perhaps?
