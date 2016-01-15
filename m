From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: git subtree split gets confused on removed and readded directory
Date: Fri, 15 Jan 2016 15:44:19 -0800
Message-ID: <xmqq4meeflws.fsf@gitster.mtv.corp.google.com>
References: <56991CFC.7060705@ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Marcus Brinkmann <marcus.brinkmann@ruhr-uni-bochum.de>
To: Dave Ware <davidw@realtimegenomics.com>,
	"David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Sat Jan 16 00:44:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKE2d-0004JP-Fe
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jan 2016 00:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517AbcAOXoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 18:44:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56081 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753500AbcAOXoW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 18:44:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F3A333C8C0;
	Fri, 15 Jan 2016 18:44:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JRZGA36/WANYFMOyiuU9D949fAc=; b=I7RgT+
	bZZ6gEMIrCAiQ7hDxJftZP7DjbzMUO4ghDqU4JRbixmcZ3UTha3cVPICCxxAwQBj
	QLDoEma9DyX3nE+FanjkgWctj20+pPYnpBgIgxETX1yL4Lc8dput8ey3WWfyKxHG
	G7nakb1aGCsPY/vcJ8SR5+hz9WusRG5NCE2g0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dpOE+iKIy0rhasu9cwEKOT32m+KqGNPk
	FMsWO/wZZu2+kMmgUUo4ZJtJfedaBcQ1ofhq1DSndqRChD26S/tuwdaHLu4plhhV
	V/gxOeSMxAL+0/R/HCPllW9WRoyojiRT2Jtd+DgcQsvK6zgvri3i8mcCX8btxGwx
	Xtr+zJnJw8o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA3743C8BF;
	Fri, 15 Jan 2016 18:44:20 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 64B3C3C8BE;
	Fri, 15 Jan 2016 18:44:20 -0500 (EST)
In-Reply-To: <56991CFC.7060705@ruhr-uni-bochum.de> (Marcus Brinkmann's message
	of "Fri, 15 Jan 2016 17:23:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E5EE1564-BBE1-11E5-972C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284236>

Marcus Brinkmann <marcus.brinkmann@ruhr-uni-bochum.de> writes:

> I made a simple test repository showing the problem here:
> https://github.com/lambdafu/git-subtree-split-test
>
> After creating the master branch, I created the split/bar branch like this:
>
> $ git subtree split -P bar -b split/bar
>
> The resulting history is confused by the directory "bar" which was
> added, removed and then re-added again.  The recent history up to adding
> the directory the second time is fine.  But then it seems to loose track
> and add the parent of that commit up to the initial commit in the history.
>
> I'd expect that the parent of the readding commit is an empty tree
> commit (which removed the last files in the directory), and that before
> that are commits that reflect the initial creation of that directory
> with its files, but rewritten as a subtree, of course.

Thanks for a report.

David, does this ring a bell?

Dave, does your fix "subtree split" we saw recently on the list

    http://article.gmane.org/gmane.comp.version-control.git/284125

help this?
