From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] submodule: fix handling of superproject with
 relative origin URLs
Date: Sun, 20 May 2012 19:08:35 -0700
Message-ID: <7vfwau9tgc.fsf@alter.siamese.dyndns.org>
References: <1337468428-26155-1-git-send-email-jon.seymour@gmail.com>
 <1337468428-26155-2-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 21 04:08:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWI39-0000kg-PE
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 04:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255Ab2EUCIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 May 2012 22:08:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44273 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128Ab2EUCIh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2012 22:08:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E31480C8;
	Sun, 20 May 2012 22:08:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rIreKb++OdxlkpToi3ZhxzE2jjI=; b=RJn7rD
	VHRIFVC9s7a09zUjZHrqLUD78LGkrQU6SUoK2IWYMSlsTwba/++v5iJpjbF0m/T3
	pIm0lrMYoBH+twA0MhRETXJgUrINQ2hn5trtj5bmPiiqfoICyjK96xhT4/Qv1SCh
	yZFi9M96nHuQXbT/uHrpT+sGdt6the2BN1SvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v2+7/dbq2ax0M44WL32/8X+1F5WVDkbU
	7slAaz5ZU9ZvVOKLfU98Ez2/a8yqJTF92APMwElppNN5WX54ZFA534lI4LXZ7ZM7
	/abBJtjsN9MOjtHaVXByuatCb4K3/nCkTpAK6/E4/mQPhoNV2Fckq8pD2uI9hdiX
	qNfxYCFjycE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 257ED80C5;
	Sun, 20 May 2012 22:08:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A744B80C3; Sun, 20 May 2012
 22:08:36 -0400 (EDT)
In-Reply-To: <1337468428-26155-2-git-send-email-jon.seymour@gmail.com> (Jon
 Seymour's message of "Sun, 20 May 2012 09:00:28 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DFFF4FDE-A2E9-11E1-87A8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198077>

Jon Seymour <jon.seymour@gmail.com> writes:

> Prior to this change, an operation such as git submodule add, init or
> sync produced the wrong result when the origin URL of the superproject
> was itself a relative URL.

If you say you are "fixing" something in the title, it is already known to
the reader that a broken behaviour exists in the code without the patch in
question.  Instead of spending four useless words "Prior to this change",
could "the wrong result" be clarified with either saying "wrong in what
way" and/or "because of this and that reason"?

In the case of this patch, you explain "because..." part in the second
paragraph (which is good), so

	An operation such as A and B does this when it should do that
	instead.

stated in the present tense, as a statement of the fact, is sufficient.
"does this instead of that, which is wrong" is a lot more important.

> Note that superproject relative origin URLs of the form foo/bar
> are still not handled correctly.

I am not sure what the use case of such a layout is.  A project that has a
"bar" repository as its superproject (or its one of submodules for that
matter) may advertise that the other repository lives at ../bar.git, so
that when these two projects are served at a random hosting service, such
a cross-project pointer does not have to be rewritten as long as their
relative location at the hosting service remains the same.  But what does
it mean to say a related "foo" project lives in foo/bar.git directory
relative to one project in the first place?  Does the project's $GIT_DIR/
have a "foo" directory next to its "refs" and "objects"?  Probably I am
missing what you are trying to achieve.  Puzzled.
