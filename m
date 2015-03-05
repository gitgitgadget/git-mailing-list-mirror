From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/3]More diffs for commit/status
Date: Thu, 05 Mar 2015 12:27:53 -0800
Message-ID: <xmqqfv9j2nqu.fsf@gitster.dls.corp.google.com>
References: <xmqqr3t479ey.fsf@gitster.dls.corp.google.com>
	<cover.1425564336.git.git@drmicha.warpmail.net>
	<xmqqtwxz2qmb.fsf@gitster.dls.corp.google.com>
	<xmqqlhjb2obv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 05 21:28:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTcNF-000398-La
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 21:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbbCEU15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 15:27:57 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752983AbbCEU14 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 15:27:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7932D3E7D8;
	Thu,  5 Mar 2015 15:27:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R4XqUI6PgzYuptrKJy52QQFMLMs=; b=P+vuhp
	NFcvCtaj/GDI2h+ZHVYp3VNTfYopYpJ4wSSZlfg3O0izIwJRVWU/3z9nm+WLYcnO
	IJwaMq6nbAePXLrE+1tp8kFTo2LC+YtXFabank/byBzPooNOg54GD+vVoiAj6R0W
	GxQ3dryzBoz2ItZszD1mGNl7MpWMkl2UWTHfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N//SqZnMGU/qnAkh4vZlsJG6AZwdanzP
	XjrRq3DE1aKQyk/TUTrrd+K41ha87qLktHBtYun89b12mRvxykCwLnYByOQvWz9N
	URSxYir45+FRwFmoXZ1ynOmFOfFymxlmH2U09X91vdOWzgaKb1vs+yHCSfHYb1bx
	4tseGumkIbg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 715CC3E7D6;
	Thu,  5 Mar 2015 15:27:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E0EA83E7D5;
	Thu,  5 Mar 2015 15:27:54 -0500 (EST)
In-Reply-To: <xmqqlhjb2obv.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 05 Mar 2015 12:15:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1AB18B74-C376-11E4-B6D4-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264864>

Junio C Hamano <gitster@pobox.com> writes:

> Extending this line of thought further.
> 
> If I am reading your patch 3/3 right, "status -v -v" shows the
> header when there are patches to be shown for the category.  I am
> not sure if that is the most helpful way for the users, when either
> c/i xor i/w diffs is missing.
> ...
> So, my recommendation for "status -v -v" would be:

Taking the conclusion part of what I said back.  I think the exact
same reasoning will lead to a much simpler and more concise output
by (1) using exactly the same logic you have in 3/3 to decide when
to show or not show the headers and (2) adding the ^-{50}$ separator
only before the second header that is shown before the changes left
in the working tree.

Then, 1-a) will show the same output as "status -v", 1-b) will start
as the same as "status -v", followed by a visually significant
separator followed by diff, 2-a) will be empty, and 2-b) will start
with a visually significant and unusual separator line before the
diff.  That would make 1-a) and 2-b) visually very distinct and
reduce the chance of confusion.

The updated outline for "status -v -v" would be:

     if (there are changes to be committed) {
         show "to be committed" header;
         show c/i diff;
     }
     if (there are changes left in the working tree) {
         show "left in the working tree" with -{50} header;
         show i/w diff;
     }

Thanks.
