From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
Date: Mon, 14 Jan 2013 22:22:48 -0800
Message-ID: <7vpq1755jb.fsf@alter.siamese.dyndns.org>
References: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com>
 <7vliby98r7.fsf@alter.siamese.dyndns.org> <4836187.09xoy3kJnj@blacky>
 <CAN8TAOv0Cm8CgiJSweFtRzOqO78OtNKa4G+x7z6M5Bt+odUmiQ@mail.gmail.com>
 <50F40316.7010308@drmicha.warpmail.net>
 <7v1udnbmyz.fsf@alter.siamese.dyndns.org>
 <1D472234-A0A5-4F02-878D-D05DEE995FCD@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Sascha Cunz <sascha-ml@babbelbox.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jardel Weyrich <jweyrich@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 07:23:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzvV-00019b-9e
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 07:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998Ab3AOGWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 01:22:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33026 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758Ab3AOGWv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 01:22:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3817077D4;
	Tue, 15 Jan 2013 01:22:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ssWmEWqWM8YXV0bzXTwNh9xiB4E=; b=fQy7da
	UB3Ed80uElRk7cOczUWLtqiCzFJ5RXUkBzD2HlPvLVF3wFSgcuOjMa/F/9QuXwt+
	YpW4MCLuVYzGgme6n6ZTqP5FHGwa0NHgjFCq/Ur3TMsjFMdpTjq84Bjdsam9zg6F
	A7UV8ofjYJ4XaFtGHn1Jf8NfQbzAX6mFBT1BM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ktGnwtjm3o3/HBH5jR8m49kkE2/VrJ7G
	DSCbAPojoyfuFbcM/hidorbcOxLrsqAGjZFFFgzZ1zGUhn3gyHgVOZiAye7S1YSJ
	CzjGykn3Pi8xOMgWG5ENFYb9DvCokjnX4K49YslFmaaLhFlPqk86b/+ZwxJmaiiK
	fa30Zmcb2Qw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D01A77D3;
	Tue, 15 Jan 2013 01:22:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8912577D2; Tue, 15 Jan 2013
 01:22:49 -0500 (EST)
In-Reply-To: <1D472234-A0A5-4F02-878D-D05DEE995FCD@gmail.com> (Jardel
 Weyrich's message of "Tue, 15 Jan 2013 03:20:53 -0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC2571D0-5EDB-11E2-8D71-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213598>

Jardel Weyrich <jweyrich@gmail.com> writes:

> If you allow me, I'd like you to forget about the concepts for a minute, and focus on the user experience.
> Imagine a simple hypothetical scenario in which the user wants to push to 2 distinct repositories. He already has cloned the repo from the 1st repository, thus (theoretically) all he needs to do, is to add a new repository for push. He then uses `remote set-url --add --push <2nd-repo>` (which I personally thought would suffice). However, if he tries to push a new commit to this remote, it would be pushed _only_ to the 2nd-repo.

The primary reason behind push-url was that

 (1) usually you push to and fetch from the same, so no pushUrl is
     ever needed, just a single Url will do (this is often true for
     cvs/svn style shared repository workflow); and

 (2) sometimes you want to fetch from one place and push to another
     (this is often true for "fetch from upstream, push to my own
     and ask upstream to pull from it" workflow), and in that case
     you want pushUrl in addition to Url.  Most importantly, in this
     case, you do *NOT* want to push to Url.  You only push to
     pushUrl.

Setting *one* pushURL is a way to say "That URL I fetch from is
*not* the place I want to push (I may not even be able to push
there); when I say 'push', push there instead".  Your proposed
semantics will make it impossible to arrange such an asymmetric
setting.
