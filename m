From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] find_unique_abbrev(): honor caller-supplied "len" better
Date: Thu, 10 Mar 2011 19:09:31 -0800
Message-ID: <7vei6e1hg4.fsf@alter.siamese.dyndns.org>
References: <E1PBKT9-0004Uk-Sm@tytso-glaptop> <20101028075631.GA7690@elte.hu>
 <AANLkTi=8SbOZizWpxLg=Bgp7atdgr8MsR6tnRDYr1+eW@mail.gmail.com>
 <20101028163854.GA15450@elte.hu>
 <AANLkTin62vAwJxcsrFk6Yn7Q6tzr-D=EmKKwPazuAJ11@mail.gmail.com>
 <7veiba9ev2.fsf@alter.siamese.dyndns.org>
 <7vhbba38mm.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTimH9=OWD4+dPsdYaL2VPdDkTsUG_N3GBf168XqD@mail.gmail.com>
 <7vzkp21ocm.fsf@alter.siamese.dyndns.org>
 <AANLkTikPxSspRFQWke4=u55cmmHw8NsyizeH2gL1kD0y@mail.gmail.com>
 <7vmxl21lwr.fsf@alter.siamese.dyndns.org>
 <AANLkTinHCsyN4TLBAxzxOn_QAK67VkT1pLgcu7XB0JCD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Namhyung Kim <namhyung@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 11 04:09:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxsjf-0008PL-EJ
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 04:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514Ab1CKDJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 22:09:45 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab1CKDJo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 22:09:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BF04E4CD8;
	Thu, 10 Mar 2011 22:11:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fvenbLow/ZhYQ4mP7LVQ3Ox+11M=; b=Gccj9J
	/zN+oOWYfk2vD9YZFQQ2rUEefNrsoX28YZHjL8oPFGr3aWtwwLCfzdF/ECpqtTua
	gerNKEvzlcjGJ/dTW827h82hrz7fePL2IkjPqfhGKe+y/cigK2Pn30FKSTO9uD7o
	KO6cW4ra8YoNyrev3gkgJkF9HUscC94fLrSDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ixhIt/6rgwbOjgLHf7YjA0r60ckLdJcg
	nmnhNCsAj+w7ioq5TxqGWr/EOLl47WbjDojDpI8yYWn+msoF5LXn2QsAOMRSh8gD
	u4Zq5L9juKW0LU1zEidzJxSLpzOiFGAxyzhMHCedpk3bcbVTcU+oAEqq+rEoUW9v
	JNJUqM7aH1Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8CAC84CD5;
	Thu, 10 Mar 2011 22:11:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3C5094CD4; Thu, 10 Mar 2011
 22:11:01 -0500 (EST)
In-Reply-To: <AANLkTinHCsyN4TLBAxzxOn_QAK67VkT1pLgcu7XB0JCD@mail.gmail.com>
 (Linus Torvalds's message of "Thu, 10 Mar 2011 18:21:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3520D4A2-4B8D-11E0-B887-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168880>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> But it is somewhat expensive to calculate "max current uniqueness", so
> I would suggest ditching the whole notion of "how many extra numbers
> do I need for futureproofing", and go for just setting the absolute
> value of DEFAULT_ABBREV.

Thanks; apparently our mails crossed...

I suspect that in a sane repository with set of reasonably packed objects,
we can cheaply get a rough estimate of the number of objects to about an
order of magnitude (e.g. "likely to have 10k to 100k objects"), and we
might able to come up with a way to automatically raise the default
length.
